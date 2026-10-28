/*
 * FFT 512-point + AXI DMA (Simple mode, polling) - PYNQ-Z2 / Zynq-7000
 * Vitis Unified IDE 2026.1, standalone / ps7_cortexa9_0
 *
 * REQUIREMENTS:
 *   - Program the matching Vivado .bit on the board BEFORE running this app.
 *   - Verify DMA/FFT base addresses against your generated xparameters.h.
 *   - Both MM2S and S2MM must be enabled; no scatter-gather.
 *   - FFT must emit TLAST on its output at the final accepted sample.
 *   - Confirm complex word packing in HDL before interpreting FFT results.
 *
 * The first test is an impulse. It prints output words; it does NOT claim
 * mathematical correctness unless they are compared to MATLAB golden data.
 */

#include "xparameters.h"
#include "xaxidma.h"
#include "xaxidma_hw.h"
#include "xil_cache.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "xstatus.h"
#include "FFT_512_I_ip_stream_2x2_addr.h"

#define FFT_BASE_ADDR            ((UINTPTR)0x43C00000U) /* Verify in xparameters.h */
#define DMA_BASE_ADDR            ((UINTPTR)0x40400000U) /* Verify in xparameters.h */
#define FFT_SIZE                 512U
#define TRANSFER_BYTES           (FFT_SIZE * sizeof(u32))
#define DMA_TIMEOUT             30000000U
#define INPUT_IMPULSE           8192 /* signed 16-bit, safe diagnostic value */

/* Set to 1 if HDL interprets TDATA[15:0] as the real part.
 * Set to 0 if HDL interprets TDATA[31:16] as the real part.
 * This cannot be determined from the provided addr.h file.
 */
#define FFT_REAL_IN_LOW_16       1

static XAxiDma Dma;
static u32 TxBuffer[FFT_SIZE] __attribute__((aligned(64)));
static u32 RxBuffer[FFT_SIZE] __attribute__((aligned(64)));

static u32 pack_complex16(s16 real, s16 imag)
{
#if FFT_REAL_IN_LOW_16
    return ((u32)(u16)imag << 16) | (u32)(u16)real;
#else
    return ((u32)(u16)real << 16) | (u32)(u16)imag;
#endif
}

static void print_dma_status(void)
{
    u32 mm2s = XAxiDma_ReadReg(DMA_BASE_ADDR,
                                XAXIDMA_TX_OFFSET + XAXIDMA_SR_OFFSET);
    u32 s2mm = XAxiDma_ReadReg(DMA_BASE_ADDR,
                                XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET);
    xil_printf("MM2S_DMASR = 0x%08x\r\n", (unsigned)mm2s);
    xil_printf("S2MM_DMASR = 0x%08x\r\n", (unsigned)s2mm);
}

static int init_dma(void)
{
    XAxiDma_Config *cfg;
    int rc;

/* AMD's 2026.1 standalone platforms may use SDT base-address lookup,
 * while legacy BSPs use device-ID lookup. Match the generated BSP.
 */
#ifdef SDT
    cfg = XAxiDma_LookupConfig(DMA_BASE_ADDR);
#else
#ifdef XPAR_AXIDMA_0_DEVICE_ID
    cfg = XAxiDma_LookupConfig(XPAR_AXIDMA_0_DEVICE_ID);
#else
    cfg = XAxiDma_LookupConfigBaseAddr(DMA_BASE_ADDR);
#endif
#endif
    if (cfg == NULL) {
        xil_printf("ERROR: AXI DMA config not found. Check BSP and address.\r\n");
        return XST_FAILURE;
    }

    rc = XAxiDma_CfgInitialize(&Dma, cfg);
    if (rc != XST_SUCCESS) {
        xil_printf("ERROR: XAxiDma_CfgInitialize = %d\r\n", rc);
        return XST_FAILURE;
    }
    if (XAxiDma_HasSg(&Dma)) {
        xil_printf("ERROR: DMA is in SG mode; this app requires Simple mode.\r\n");
        return XST_FAILURE;
    }

    XAxiDma_IntrDisable(&Dma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);
    XAxiDma_IntrDisable(&Dma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
    return XST_SUCCESS;
}

int main(void)
{
    u32 i, wait, ts, en, mm2s_sr, s2mm_sr;
    int rc;

    xil_printf("\r\n=== FFT-512 AXI DMA test (polling) ===\r\n");
    xil_printf("DMA base: 0x%08x, FFT base: 0x%08x\r\n",
               (unsigned)DMA_BASE_ADDR, (unsigned)FFT_BASE_ADDR);

    /* Read-only identification from the MATLAB-generated FFT IP. */
    ts = Xil_In32(FFT_BASE_ADDR + IPCore_Timestamp_FFT_512_I_ip_stream_2x2);
    xil_printf("FFT timestamp register: 0x%08x\r\n", (unsigned)ts);
    if (ts == 0xFFFFFFFFU) {
        xil_printf("ERROR: FFT AXI-Lite is not responding normally.\r\n");
        return XST_FAILURE;
    }

    rc = init_dma();
    if (rc != XST_SUCCESS) return XST_FAILURE;
    xil_printf("DMA initialized.\r\n");

    /* Impulse x[0] = 8192+j0, x[1..511] = 0. */
    for (i = 0; i < FFT_SIZE; ++i) {
        TxBuffer[i] = pack_complex16(0, 0);
        RxBuffer[i] = 0xDEADBEEFU;
    }
    TxBuffer[0] = pack_complex16((s16)INPUT_IMPULSE, 0);

    Xil_DCacheFlushRange((UINTPTR)TxBuffer, TRANSFER_BYTES);
    Xil_DCacheFlushRange((UINTPTR)RxBuffer, TRANSFER_BYTES);

    /* The generated addr.h says enable bit0=1. Hardware reset is provided
     * by the Processor System Reset block; no software reset is needed here.
     */
    Xil_Out32(FFT_BASE_ADDR + IPCore_Enable_FFT_512_I_ip_stream_2x2, 1U);
    en = Xil_In32(FFT_BASE_ADDR + IPCore_Enable_FFT_512_I_ip_stream_2x2);
    xil_printf("FFT enable register: 0x%08x\r\n", (unsigned)en);

    /* IMPORTANT: Arm receive first so that data has somewhere to go. */
    rc = XAxiDma_SimpleTransfer(&Dma, (UINTPTR)RxBuffer,
                                 TRANSFER_BYTES, XAXIDMA_DEVICE_TO_DMA);
    if (rc != XST_SUCCESS) {
        xil_printf("ERROR: S2MM submit failed: %d\r\n", rc);
        print_dma_status();
        return XST_FAILURE;
    }

    rc = XAxiDma_SimpleTransfer(&Dma, (UINTPTR)TxBuffer,
                                 TRANSFER_BYTES, XAXIDMA_DMA_TO_DEVICE);
    if (rc != XST_SUCCESS) {
        xil_printf("ERROR: MM2S submit failed: %d\r\n", rc);
        print_dma_status();
        return XST_FAILURE;
    }

    wait = DMA_TIMEOUT;
    while (XAxiDma_Busy(&Dma, XAXIDMA_DMA_TO_DEVICE) ||
           XAxiDma_Busy(&Dma, XAXIDMA_DEVICE_TO_DMA)) {
        if (--wait == 0U) {
            xil_printf("ERROR: DMA timeout. Check FFT TLAST, TVALID/TREADY, resets.\r\n");
            print_dma_status();
            return XST_FAILURE;
        }
    }

    print_dma_status();
    mm2s_sr = XAxiDma_ReadReg(DMA_BASE_ADDR,
                              XAXIDMA_TX_OFFSET + XAXIDMA_SR_OFFSET);
    s2mm_sr = XAxiDma_ReadReg(DMA_BASE_ADDR,
                              XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET);
    /* DMASR: bit1=Idle; bits [10:8] and [6:4] indicate DMA errors. */
    if (((mm2s_sr | s2mm_sr) & 0x00000770U) != 0U ||
        (mm2s_sr & 0x00000002U) == 0U ||
        (s2mm_sr & 0x00000002U) == 0U) {
        xil_printf("ERROR: DMA stopped without a clean idle/completion state.\r\n");
        return XST_FAILURE;
    }
    Xil_DCacheInvalidateRange((UINTPTR)RxBuffer, TRANSFER_BYTES);
    xil_printf("Both DMA channels completed. First 16 FFT output words:\r\n");
    for (i = 0; i < 16U; ++i) {
        xil_printf("Y[%03d] = 0x%08x\r\n", (int)i, (unsigned)RxBuffer[i]);
    }

    xil_printf("TEST FINISHED: transfer completed (compare all 512 bins to MATLAB).\r\n");
    return XST_SUCCESS;
}
