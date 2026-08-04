###################################################################

# Created by write_sdc on Sun Aug  4 02:18:09 2019

###################################################################
set sdc_version 1.9

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
create_clock [get_ports CLK]  -period 10  -waveform {0 5}
set_clock_uncertainty 0.2  [get_clocks CLK]
set_clock_transition -max -rise 0.1 [get_clocks CLK]
set_clock_transition -max -fall 0.1 [get_clocks CLK]
set_clock_transition -min -rise 0.1 [get_clocks CLK]
set_clock_transition -min -fall 0.1 [get_clocks CLK]
set_input_delay -clock CLK  2  [get_ports RST]
set_input_delay -clock CLK  2  [get_ports PAR_EN]
set_input_delay -clock CLK  2  [get_ports PAR_TYP]
set_input_delay -clock CLK  2  [get_ports TX_DATA_VALID]
set_input_delay -clock CLK  2  [get_ports {TX_P_DATA[7]}]
set_input_delay -clock CLK  2  [get_ports {TX_P_DATA[6]}]
set_input_delay -clock CLK  2  [get_ports {TX_P_DATA[5]}]
set_input_delay -clock CLK  2  [get_ports {TX_P_DATA[4]}]
set_input_delay -clock CLK  2  [get_ports {TX_P_DATA[3]}]
set_input_delay -clock CLK  2  [get_ports {TX_P_DATA[2]}]
set_input_delay -clock CLK  2  [get_ports {TX_P_DATA[1]}]
set_input_delay -clock CLK  2  [get_ports {TX_P_DATA[0]}]
set_input_delay -clock CLK  2  [get_ports {Prescale[5]}]
set_input_delay -clock CLK  2  [get_ports {Prescale[4]}]
set_input_delay -clock CLK  2  [get_ports {Prescale[3]}]
set_input_delay -clock CLK  2  [get_ports {Prescale[2]}]
set_input_delay -clock CLK  2  [get_ports {Prescale[1]}]
set_input_delay -clock CLK  2  [get_ports {Prescale[0]}]
set_output_delay -clock CLK  2  [get_ports {RX_P_DATA[7]}]
set_output_delay -clock CLK  2  [get_ports {RX_P_DATA[6]}]
set_output_delay -clock CLK  2  [get_ports {RX_P_DATA[5]}]
set_output_delay -clock CLK  2  [get_ports {RX_P_DATA[4]}]
set_output_delay -clock CLK  2  [get_ports {RX_P_DATA[3]}]
set_output_delay -clock CLK  2  [get_ports {RX_P_DATA[2]}]
set_output_delay -clock CLK  2  [get_ports {RX_P_DATA[1]}]
set_output_delay -clock CLK  2  [get_ports {RX_P_DATA[0]}]
set_output_delay -clock CLK  2  [get_ports RX_DATA_VALID]
set_output_delay -clock CLK  2  [get_ports PARITY_ERROR]
set_output_delay -clock CLK  2  [get_ports FRAMING_ERROR]
set_output_delay -clock CLK  2  [get_ports TX_BUSY]
