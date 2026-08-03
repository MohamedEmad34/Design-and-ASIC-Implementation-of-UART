`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 02:07:58 PM
// Design Name: 
// Module Name: start_check
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


module start_check(

    input  wire CLK,
    input  wire RST,
    input  wire Enable,
    input  wire sampled_bit,
    output reg  strt_glitch

);
always @(posedge CLK or negedge RST)
begin
    if(!RST)
        strt_glitch <= 1'b0;

    else if(Enable)
        strt_glitch <= sampled_bit;
     else
     strt_glitch<=1'b0;
end
endmodule
