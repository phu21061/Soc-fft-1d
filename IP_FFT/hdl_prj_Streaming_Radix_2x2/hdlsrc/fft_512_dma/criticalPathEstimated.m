open_system('gm_fft_512_dma');
cs.HiliteType = 'user2';
cs.ForegroundColor = 'black';
cs.BackgroundColor = 'lightblue';
set_param(0, 'HiliteAncestorsData', cs);
hilite_system('gm_fft_512_dma/FFT_512_IP/HDL Counter', 'user2');
annotate_port('gm_fft_512_dma/FFT_512_IP/HDL Counter', 0, 1, 'cp : 3.259 ns');
