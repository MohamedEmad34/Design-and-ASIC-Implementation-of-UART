############################################################
# Library Setup
############################################################

set_app_var search_path [list \
../RTL \
/home/standard_cell_libraries/NangateOpenCellLibrary_PDKv1_3_v2010_12/lib/Front_End/Liberty/NLDM
]

set_app_var target_library "NangateOpenCellLibrary_ss0p95vn40c.db"

set_app_var link_library "* $target_library"

############################################################
# Top Design
############################################################

set TOP UART_TOP

############################################################
# Working Library
############################################################
sh rm -rf work
sh mkdir -p work
define_design_lib WORK -path work
#-----------------------------------------------------------
# Read RTL Files
#-----------------------------------------------------------
analyze -format verilog {

../RTL/UART_TOP.v

../RTL/UART_TX.v
../RTL/UART_RX.v

../RTL/TX_FSM.v
../RTL/uart_rx_fsm.v

../RTL/serializer.v
../RTL/deserializer.v

../RTL/parity_calc.v
../RTL/parity_check.v

../RTL/start_check.v
../RTL/stop_check.v

../RTL/data_sampling.v

../RTL/edge_bit_counter.v

../RTL/mux.v

}

#-----------------------------------------------------------
# Elaborate Design
#-----------------------------------------------------------
elaborate $TOP

#-----------------------------------------------------------
# Link Design
#-----------------------------------------------------------
link

#-----------------------------------------------------------
# Read Constraints
#-----------------------------------------------------------
read_sdc constraints/UART.sdc

#-----------------------------------------------------------
# Check Design
#-----------------------------------------------------------
check_design

#-----------------------------------------------------------
# Compile
#-----------------------------------------------------------
compile_ultra

#-----------------------------------------------------------
# Reports
#-----------------------------------------------------------
report_area > reports/area.rpt

report_timing > reports/timing.rpt

report_power > reports/power.rpt

report_qor > reports/qor.rpt

report_constraint -all_violators > reports/constraint.rpt
report_cell > reports/cell.rpt

report_reference > reports/reference.rpt
write_sdc netlist/UART_TOP_syn.sdc

#-----------------------------------------------------------
# Write Netlist
#-----------------------------------------------------------
write -format verilog -hierarchy -output netlist/UART_TOP_netlist.v

#-----------------------------------------------------------
# Write DDC
#-----------------------------------------------------------
write_file -format ddc -hierarchy -output netlist/UART_TOP.ddc

#-----------------------------------------------------------
# Finish
#-----------------------------------------------------------
quit

