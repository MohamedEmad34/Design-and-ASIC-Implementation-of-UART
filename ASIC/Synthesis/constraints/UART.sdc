 ############################################################
# UART_TOP Constraints
############################################################

#-----------------------------------------------------------
# Clock Definition
#-----------------------------------------------------------
create_clock \
-name CLK \
-period 10 \
-waveform {0 5} \
[get_ports CLK]

#-----------------------------------------------------------
# Clock Uncertainty
#-----------------------------------------------------------
set_clock_uncertainty 0.2 [get_clocks CLK]

#-----------------------------------------------------------
# Clock Transition
#-----------------------------------------------------------
set_clock_transition 0.1 [get_clocks CLK]

#-----------------------------------------------------------
# Input Delay
#-----------------------------------------------------------
set_input_delay 2 \
-clock CLK \
[get_ports {RST PAR_EN PAR_TYP TX_DATA_VALID}]

set_input_delay 2 \
-clock CLK \
[get_ports TX_P_DATA[*]]

set_input_delay 2 \
-clock CLK \
[get_ports Prescale[*]]

#-----------------------------------------------------------
# Output Delay
#-----------------------------------------------------------
set_output_delay 2 \
-clock CLK \
[get_ports RX_P_DATA[*]]

set_output_delay 2 \
-clock CLK \
[get_ports {RX_DATA_VALID PARITY_ERROR FRAMING_ERROR TX_BUSY}]
