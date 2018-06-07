###################################################################

# Created by write_sdc on Sat Jun 29 22:22:28 2013

###################################################################
set sdc_version 1.8

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max slow -max_library slow\
                         -min fast -min_library fast
set_wire_load_model -name tsmc18_wl10 -library slow
set_max_area 1500000
create_clock [get_ports PI_clk]  -period 40  -waveform {20 40}
set_input_delay -clock PI_clk  -max 1  [get_ports all_inputs]
set_input_delay -clock PI_clk  -min 0.2  [get_ports all_inputs]
set_output_delay -clock PI_clk  -max 1  [get_ports all_outputs]
set_output_delay -clock PI_clk  -min 0.1  [get_ports all_outputs]
