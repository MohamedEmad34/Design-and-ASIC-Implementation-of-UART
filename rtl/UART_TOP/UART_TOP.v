`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/01/2026 01:11:44 PM
// Design Name: 
// Module Name: UART_TOP
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


module UART_TOP #(
    parameter DATA_WIDTH = 8
)
(
    input  wire                  CLK,
    input  wire                  RST,

    input  wire [DATA_WIDTH-1:0] TX_P_DATA,
    input  wire                  TX_DATA_VALID,

    input  wire                  PAR_EN,
    input  wire                  PAR_TYP,

    input  wire [5:0]            Prescale,

    output wire [DATA_WIDTH-1:0] RX_P_DATA,
    output wire                  RX_DATA_VALID,

    output wire                  PARITY_ERROR,
    output wire                  FRAMING_ERROR,
    output wire TX_BUSY
);
wire serial_line;
UART_TX #(
.DATA_WIDTH(DATA_WIDTH)
)
u0_uart_tx 
(
.CLK(CLK),
.RST(RST),
.P_DATA(TX_P_DATA),
.DATA_VALID(TX_DATA_VALID),
.PAR_EN(PAR_EN),
.PAR_TYP(PAR_TYP),
.Prescale(Prescale),
.TX_OUT(serial_line),
.BUSY(TX_BUSY)
);
UART_RX #(
.DATA_WIDTH(DATA_WIDTH)
)
u0_uart_rx
(
.CLK(CLK),
.RST(RST),
.RX_IN(serial_line),
.parity_enable(PAR_EN),
.parity_type(PAR_TYP),
.Prescale(Prescale),
.P_DATA(RX_P_DATA),
.data_valid(RX_DATA_VALID),
.parity_error(PARITY_ERROR),
.framing_error(FRAMING_ERROR)
);
endmodule
