create_project prj_ip {} -part xc7z020clg400-1 -force
set_property ip_repo_paths {../../} [current_fileset]

# Add HDL source files to project
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_SimpleDualPortRAM_generic.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator1.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_1.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_1.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator2.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_2.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_2.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_3_1.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator3.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_3.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_3.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator4.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_4.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_4.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_5_1.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator5.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_5.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_5.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator6.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_6.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_6.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_7_1.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block1.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator7.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_7.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_7.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator8.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_8.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_8.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_9_1.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block2.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator9.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_9.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_1_block.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_RADIX2FFT_bitNatural.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_FFT.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_src_FFT_512_IP.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_reset_sync.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_dut.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_SimpleDualPortRAM_generic.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_fifo_data_OUT.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_SimpleDualPortRAM_singlebit.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_fifo_TLAST_OUT.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_axi4_stream_master.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_fifo_data.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_axi4_stream_slave.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_addr_decoder.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_axi_lite_module.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2_axi_lite.v}
add_files -norecurse {../hdl/FFT_512_I_ip_stream_2x2.v}
set_property top FFT_512_I_ip_stream_2x2 [get_filesets sources_1]
set_property top FFT_512_I_ip_stream_2x2 [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# Package IP from project
ipx::package_project -root_dir {../} -force

# Set IP properties
set_property name FFT_512_I_ip_stream_2x2 [ipx::current_core]
set_property display_name FFT_512_I_ip_stream_2x2 [ipx::current_core]
set_property version {1.0} [ipx::current_core]
set_property library {ip} [ipx::current_core]
set Families [split [lsort -uniq [get_property C_FAMILY [get_parts]]]]
set IPSupportedFamily {}
foreach family $Families {append IPSupportedFamily "{$family} {Production} "}
set_property supported_families $IPSupportedFamily [ipx::current_core]
set_property taxonomy {{/HDL Coder Generated IP}} [ipx::current_core]
set_property description {HDL Coder generated IP} [ipx::current_core]
set_property core_revision 2114837920 [ipx::current_core]

# Add HDL source files to IP
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SimpleDualPortRAM_generic.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SimpleDualPortRAM_generic.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SimpleDualPortRAM_generic.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SimpleDualPortRAM_generic.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator1.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator1.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_1.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_1.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_1.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_1.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator2.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator2.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator2.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator2.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_2.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_2.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_2.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_2.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_2.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_2.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_2.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_2.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_3_1.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_3_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_3_1.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_3_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator3.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator3.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator3.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator3.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_3.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_3.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_3.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_3.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_3.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_3.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_3.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_3.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator4.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator4.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator4.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator4.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_4.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_4.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_4.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_4.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_4.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_4.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_4.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_4.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_5_1.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_5_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_5_1.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_5_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator5.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator5.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator5.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator5.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_5.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_5.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_5.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_5.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_5.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_5.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_5.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_5.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator6.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator6.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator6.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator6.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_6.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_6.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_6.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_6.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_6.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_6.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_6.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_6.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_7_1.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_7_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_7_1.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_7_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block1.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block1.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator7.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator7.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator7.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator7.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_7.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_7.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_7.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_7.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_7.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_7.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_7.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_7.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator8.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator8.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator8.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator8.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_8.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_8.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_8.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF2_8.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_8.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_8.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_8.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_8.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_9_1.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_9_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_9_1.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_TWDLROM_9_1.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block2.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block2.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block2.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_Complex4Multiply_block2.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator9.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator9.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator9.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_SDFCommutator9.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_9.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_9.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_9.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_SDF1_9.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_1_block.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_1_block.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_1_block.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX22FFT_CTRL1_1_block.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX2FFT_bitNatural.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX2FFT_bitNatural.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_RADIX2FFT_bitNatural.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_RADIX2FFT_bitNatural.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_FFT.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_FFT.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_FFT.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_FFT.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_FFT_512_IP.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_FFT_512_IP.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_src_FFT_512_IP.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_src_FFT_512_IP.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_reset_sync.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_reset_sync.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_reset_sync.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_reset_sync.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_dut.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_dut.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_dut.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_dut.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_SimpleDualPortRAM_generic.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_SimpleDualPortRAM_generic.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_SimpleDualPortRAM_generic.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_SimpleDualPortRAM_generic.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_fifo_data_OUT.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_fifo_data_OUT.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_fifo_data_OUT.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_fifo_data_OUT.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_SimpleDualPortRAM_singlebit.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_SimpleDualPortRAM_singlebit.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_SimpleDualPortRAM_singlebit.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_SimpleDualPortRAM_singlebit.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_fifo_TLAST_OUT.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_fifo_TLAST_OUT.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_fifo_TLAST_OUT.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_fifo_TLAST_OUT.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_axi4_stream_master.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_axi4_stream_master.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_axi4_stream_master.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_axi4_stream_master.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_fifo_data.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_fifo_data.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_fifo_data.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_fifo_data.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_axi4_stream_slave.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_axi4_stream_slave.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_axi4_stream_slave.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_axi4_stream_slave.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_addr_decoder.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_addr_decoder.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_addr_decoder.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_addr_decoder.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_axi_lite_module.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_axi_lite_module.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_axi_lite_module.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_axi_lite_module.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_axi_lite.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_axi_lite.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2_axi_lite.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2_axi_lite.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2.v} [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2.v} -of_objects [ipx::get_file_groups xilinx_anylanguagesynthesis -of_objects [ipx::current_core]]]
ipx::add_file {hdl/FFT_512_I_ip_stream_2x2.v} [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]
set_property type {{verilogSource}} [ipx::get_files {hdl/FFT_512_I_ip_stream_2x2.v} -of_objects [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of_objects [ipx::current_core]]]

# Add bus interfaces
ipx::remove_all_bus_interface [ipx::current_core]
ipx::remove_all_memory_map [ipx::current_core]
ipx::remove_all_address_space [ipx::current_core]
# AXI4_Lite Slave
ipx::add_bus_interface {AXI4_Lite} [ipx::current_core]
set_property abstraction_type_vlnv {xilinx.com:interface:aximm_rtl:1.0} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property bus_type_vlnv {xilinx.com:interface:aximm:1.0} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
ipx::add_port_map {AWADDR} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_AWADDR} [ipx::get_port_maps AWADDR -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {AWVALID} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_AWVALID} [ipx::get_port_maps AWVALID -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {WDATA} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_WDATA} [ipx::get_port_maps WDATA -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {WSTRB} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_WSTRB} [ipx::get_port_maps WSTRB -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {WVALID} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_WVALID} [ipx::get_port_maps WVALID -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {BREADY} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_BREADY} [ipx::get_port_maps BREADY -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {ARADDR} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_ARADDR} [ipx::get_port_maps ARADDR -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {ARVALID} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_ARVALID} [ipx::get_port_maps ARVALID -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {RREADY} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_RREADY} [ipx::get_port_maps RREADY -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {AWREADY} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_AWREADY} [ipx::get_port_maps AWREADY -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {WREADY} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_WREADY} [ipx::get_port_maps WREADY -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {BRESP} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_BRESP} [ipx::get_port_maps BRESP -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {BVALID} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_BVALID} [ipx::get_port_maps BVALID -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {ARREADY} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_ARREADY} [ipx::get_port_maps ARREADY -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {RDATA} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_RDATA} [ipx::get_port_maps RDATA -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {RRESP} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_RRESP} [ipx::get_port_maps RRESP -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_port_map {RVALID} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_RVALID} [ipx::get_port_maps RVALID -of_objects [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]]
ipx::add_bus_interface {AXI4_Lite_signal_clock} [ipx::current_core]
set_property abstraction_type_vlnv {xilinx.com:signal:clock_rtl:1.0} [ipx::get_bus_interfaces AXI4_Lite_signal_clock -of_objects [ipx::current_core]]
set_property bus_type_vlnv {xilinx.com:signal:clock:1.0} [ipx::get_bus_interfaces AXI4_Lite_signal_clock -of_objects [ipx::current_core]]
ipx::add_port_map {CLK} [ipx::get_bus_interfaces AXI4_Lite_signal_clock -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_ACLK} [ipx::get_port_maps CLK -of_objects [ipx::get_bus_interfaces AXI4_Lite_signal_clock -of_objects [ipx::current_core]]]
ipx::add_bus_interface {AXI4_Lite_signal_reset} [ipx::current_core]
set_property abstraction_type_vlnv {xilinx.com:signal:reset_rtl:1.0} [ipx::get_bus_interfaces AXI4_Lite_signal_reset -of_objects [ipx::current_core]]
set_property bus_type_vlnv {xilinx.com:signal:reset:1.0} [ipx::get_bus_interfaces AXI4_Lite_signal_reset -of_objects [ipx::current_core]]
ipx::add_port_map {RST} [ipx::get_bus_interfaces AXI4_Lite_signal_reset -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Lite_ARESETN} [ipx::get_port_maps RST -of_objects [ipx::get_bus_interfaces AXI4_Lite_signal_reset -of_objects [ipx::current_core]]]
ipx::add_bus_parameter {ASSOCIATED_BUSIF} [ipx::get_bus_interfaces AXI4_Lite_signal_clock -of_objects [ipx::current_core]]
set_property value {AXI4_Lite} [ipx::get_bus_parameters ASSOCIATED_BUSIF -of_objects [ipx::get_bus_interfaces AXI4_Lite_signal_clock -of_objects [ipx::current_core]]]
ipx::add_bus_parameter {ASSOCIATED_RESET} [ipx::get_bus_interfaces AXI4_Lite_signal_clock -of_objects [ipx::current_core]]
set_property value {AXI4_Lite_ARESETN} [ipx::get_bus_parameters ASSOCIATED_RESET -of_objects [ipx::get_bus_interfaces AXI4_Lite_signal_clock -of_objects [ipx::current_core]]]
ipx::add_bus_parameter {POLARITY} [ipx::get_bus_interfaces AXI4_Lite_signal_reset -of_objects [ipx::current_core]]
set_property value {ACTIVE_LOW} [ipx::get_bus_parameters POLARITY -of_objects [ipx::get_bus_interfaces AXI4_Lite_signal_reset -of_objects [ipx::current_core]]]
ipx::add_memory_map {AXI4_Lite} [ipx::current_core]
set_property slave_memory_map_ref {AXI4_Lite} [ipx::get_bus_interfaces AXI4_Lite -of_objects [ipx::current_core]]
ipx::add_address_block {reg0} [ipx::get_memory_maps AXI4_Lite -of_objects [ipx::current_core]]
set_property range {65536} [ipx::get_address_blocks reg0 -of_objects [ipx::get_memory_maps AXI4_Lite -of_objects [ipx::current_core]]]

# AXI4-Stream Master
ipx::add_bus_interface {AXI4_Stream_Master} [ipx::current_core]
set_property abstraction_type_vlnv {xilinx.com:interface:axis_rtl:1.0} [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]
set_property bus_type_vlnv {xilinx.com:interface:axis:1.0} [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]
set_property interface_mode {master} [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]
ipx::add_port_map {TREADY} [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Stream_Master_TREADY} [ipx::get_port_maps TREADY -of_objects [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]]
ipx::add_port_map {TDATA} [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Stream_Master_TDATA} [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]]
ipx::add_port_map {TVALID} [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Stream_Master_TVALID} [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]]
ipx::add_port_map {TLAST} [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Stream_Master_TLAST} [ipx::get_port_maps TLAST -of_objects [ipx::get_bus_interfaces AXI4_Stream_Master -of_objects [ipx::current_core]]]

# AXI4-Stream Slave
ipx::add_bus_interface {AXI4_Stream_Slave} [ipx::current_core]
set_property abstraction_type_vlnv {xilinx.com:interface:axis_rtl:1.0} [ipx::get_bus_interfaces AXI4_Stream_Slave -of_objects [ipx::current_core]]
set_property bus_type_vlnv {xilinx.com:interface:axis:1.0} [ipx::get_bus_interfaces AXI4_Stream_Slave -of_objects [ipx::current_core]]
set_property interface_mode {slave} [ipx::get_bus_interfaces AXI4_Stream_Slave -of_objects [ipx::current_core]]
ipx::add_port_map {TDATA} [ipx::get_bus_interfaces AXI4_Stream_Slave -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Stream_Slave_TDATA} [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces AXI4_Stream_Slave -of_objects [ipx::current_core]]]
ipx::add_port_map {TVALID} [ipx::get_bus_interfaces AXI4_Stream_Slave -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Stream_Slave_TVALID} [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces AXI4_Stream_Slave -of_objects [ipx::current_core]]]
ipx::add_port_map {TREADY} [ipx::get_bus_interfaces AXI4_Stream_Slave -of_objects [ipx::current_core]]
set_property physical_name {AXI4_Stream_Slave_TREADY} [ipx::get_port_maps TREADY -of_objects [ipx::get_bus_interfaces AXI4_Stream_Slave -of_objects [ipx::current_core]]]


# Add IP clock and reset definition
ipx::add_bus_interface {IPCORE_CLK} [ipx::current_core]
set_property abstraction_type_vlnv {xilinx.com:signal:clock_rtl:1.0} [ipx::get_bus_interfaces IPCORE_CLK -of_objects [ipx::current_core]]
set_property bus_type_vlnv {xilinx.com:signal:clock:1.0} [ipx::get_bus_interfaces IPCORE_CLK -of_objects [ipx::current_core]]
ipx::add_port_map {CLK} [ipx::get_bus_interfaces IPCORE_CLK -of_objects [ipx::current_core]]
set_property physical_name {IPCORE_CLK} [ipx::get_port_maps CLK -of_objects [ipx::get_bus_interfaces IPCORE_CLK -of_objects [ipx::current_core]]]
ipx::add_bus_interface {IPCORE_RESETN} [ipx::current_core]
set_property abstraction_type_vlnv {xilinx.com:signal:reset_rtl:1.0} [ipx::get_bus_interfaces IPCORE_RESETN -of_objects [ipx::current_core]]
set_property bus_type_vlnv {xilinx.com:signal:reset:1.0} [ipx::get_bus_interfaces IPCORE_RESETN -of_objects [ipx::current_core]]
ipx::add_port_map {RST} [ipx::get_bus_interfaces IPCORE_RESETN -of_objects [ipx::current_core]]
set_property physical_name {IPCORE_RESETN} [ipx::get_port_maps RST -of_objects [ipx::get_bus_interfaces IPCORE_RESETN -of_objects [ipx::current_core]]]
ipx::add_bus_parameter {ASSOCIATED_RESET} [ipx::get_bus_interfaces IPCORE_CLK -of_objects [ipx::current_core]]
set_property value {IPCORE_RESETN} [ipx::get_bus_parameters ASSOCIATED_RESET -of_objects [ipx::get_bus_interfaces IPCORE_CLK -of_objects [ipx::current_core]]]
ipx::add_bus_parameter {POLARITY} [ipx::get_bus_interfaces IPCORE_RESETN -of_objects [ipx::current_core]]
set_property value {ACTIVE_LOW} [ipx::get_bus_parameters POLARITY -of_objects [ipx::get_bus_interfaces IPCORE_RESETN -of_objects [ipx::current_core]]]
ipx::add_bus_parameter {ASSOCIATED_BUSIF} [ipx::get_bus_interfaces IPCORE_CLK -of_objects [ipx::current_core]]
set_property value {AXI4_Stream_Master:AXI4_Stream_Slave} [ipx::get_bus_parameters ASSOCIATED_BUSIF -of_objects [ipx::get_bus_interfaces IPCORE_CLK -of_objects [ipx::current_core]]]


# Add report files
ipx::add_file_group -type {product_guide} {} [ipx::current_core]
ipx::add_file {doc/doc_arch_axi4_Pipeline_Register.jpg} [ipx::get_file_groups xilinx_productguide -of_objects [ipx::current_core]]
set_property type {{image}} [ipx::get_files {doc/doc_arch_axi4_Pipeline_Register.jpg} -of_objects [ipx::get_file_groups xilinx_productguide -of_objects [ipx::current_core]]]
ipx::add_file {doc/doc_arch_axi4_lite_stream.jpg} [ipx::get_file_groups xilinx_productguide -of_objects [ipx::current_core]]
set_property type {{image}} [ipx::get_files {doc/doc_arch_axi4_lite_stream.jpg} -of_objects [ipx::get_file_groups xilinx_productguide -of_objects [ipx::current_core]]]
ipx::add_file {doc/free_running.jpg} [ipx::get_file_groups xilinx_productguide -of_objects [ipx::current_core]]
set_property type {{image}} [ipx::get_files {doc/free_running.jpg} -of_objects [ipx::get_file_groups xilinx_productguide -of_objects [ipx::current_core]]]
ipx::add_file {doc/fft_512_dma_ip_core_report.html} [ipx::get_file_groups xilinx_productguide -of_objects [ipx::current_core]]
set_property type {{html}} [ipx::get_files {doc/fft_512_dma_ip_core_report.html} -of_objects [ipx::get_file_groups xilinx_productguide -of_objects [ipx::current_core]]]

# Add C files
ipx::add_file_group -type {misc} {} [ipx::current_core]
ipx::add_file {include/FFT_512_I_ip_stream_2x2_addr.h} [ipx::get_file_groups xilinx_miscfiles -of_objects [ipx::current_core]]
set_property type {{cSource}} [ipx::get_files {include/FFT_512_I_ip_stream_2x2_addr.h} -of_objects [ipx::get_file_groups xilinx_miscfiles -of_objects [ipx::current_core]]]

# Package IP
ipx::create_xgui_files [ipx::current_core]
ipx::check_integrity -quiet [ipx::current_core]
ipx::save_core [ipx::current_core]
ipx::archive_core {../FFT_512_I_ip_stream_2x2_v1_0.zip} [ipx::current_core]
close_project
exit
