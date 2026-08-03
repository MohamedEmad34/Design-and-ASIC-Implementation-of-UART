`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 03:05:02 PM
// Design Name: 
// Module Name: stop_check
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

module stop_check(

    input  wire CLK,
    input  wire RST,

    input  wire Enable,

    input  wire sampled_bit,

    output reg stp_err

);
always @(posedge CLK or negedge RST)
begin

    if(!RST)
        stp_err <= 1'b0;

    else if(Enable)
        stp_err <= ~sampled_bit;

    else
        stp_err <= 1'b0;

end
endmodule
