# Automatically generated constaint file for FPGA Data Capture IP
# Add this file to your Vivado project
create_clock -period 30.000 -name tck -waveform {0.000 15.000} [get_nets -of_object [get_cells -hierarchical -filter {REF_NAME =~ hdlverifier_jtag_core}] -filter {NAME =~ */tck}]
