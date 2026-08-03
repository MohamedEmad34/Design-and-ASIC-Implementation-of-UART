
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2026 02:43:53 PM
// Design Name: 
// Module Name: UART_TX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_TX #(parameter DATA_WIDTH=8)(

input           CLK,
input           RST,

input  [7:0]    P_DATA,
input           DATA_VALID,

input           PAR_EN,
input           PAR_TYP,

input  [5:0]    Prescale,

output          TX_OUT,
output          BUSY

);
wire serial_data;
wire parity_bit;
wire ser_done;

wire load;
wire shift_en;
wire [1:0] mux_sel;
serializer #(
    .WIDTH(8),
    .CNT_WIDTH(3)
) u_serializer (

    .CLK           (CLK),
    .RST           (RST),

    .load          (load),
    .shift_en      (shift_en),

    .parallel_data (P_DATA),

    .serial_out    (serial_data),
    .ser_done     (ser_done)

);
TX_FSM u_fsm (

    .CLK        (CLK),
    .RST        (RST),

    .DATA_VALID (DATA_VALID),
    .PAR_EN     (PAR_EN),
    .ser_done   (ser_done),
    .Prescale   (Prescale),

    .load       (load),
    .shift_en   (shift_en),
    .mux_sel    (mux_sel),
    .busy       (BUSY)

);
parity_calc #(

    .WIDTH(8)

) u_parity (

    .CLK        (CLK),
    .RST        (RST),

    .load       (load),
    .odd_parity (PAR_TYP),

    .DATA       (P_DATA),

    .parity     (parity_bit)

);
mux u_mux (

    .serial_data (serial_data),
    .parity_bit  (parity_bit),
    .mux_sel     (mux_sel),

    .tx_out      (TX_OUT)

);
endmodule
