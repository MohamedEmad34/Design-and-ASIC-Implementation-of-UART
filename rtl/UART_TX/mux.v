`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 11:55:31 AM
// Design Name: 
// Module Name: mux
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


module mux(

    input  wire       serial_data,
    input  wire       parity_bit,
    input  wire [1:0] mux_sel,

    output reg        tx_out

);
localparam START_SEL  = 2'b00;
localparam DATA_SEL   = 2'b01;
localparam PARITY_SEL = 2'b10;
localparam STOP_SEL   = 2'b11;
always @(*) begin
    case(mux_sel)

        START_SEL: tx_out = 1'b0;

       DATA_SEL: tx_out = serial_data;

        PARITY_SEL: tx_out = parity_bit;

       STOP_SEL: tx_out = 1'b1;

        default: tx_out = 1'b1;

    endcase
end
endmodule
