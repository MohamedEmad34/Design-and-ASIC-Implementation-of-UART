`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 11:33:24 AM
// Design Name: 
// Module Name: parity_calc
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



module parity_calc #(
    parameter WIDTH = 8
)(
    input  wire             CLK,
    input  wire             RST,
    input  wire             load,
    input  wire             odd_parity,
    input  wire [WIDTH-1:0] DATA,

    output  reg            parity
);
reg [WIDTH-1:0] DATA_V;
always@(posedge CLK or negedge RST)
begin
if(!RST)
DATA_V<={WIDTH{1'b0}};
else if(load)
DATA_V<=DATA;
end

always@(*)
begin
if(odd_parity)
parity=~^DATA_V;
else
parity=^DATA_V;


end
endmodule

