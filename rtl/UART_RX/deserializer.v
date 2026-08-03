`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 01:47:58 PM
// Design Name: 
// Module Name: deserializer
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


module deserializer #(
    parameter DATA_WIDTH = 8
)
(
    input  wire                    CLK,
    input  wire                    RST,
    input  wire                    deser_en,
    input  wire                    sampled_bit,
    input  wire [3:0]              bit_count,
    output reg [DATA_WIDTH-1:0]    P_DATA
);
always @(posedge CLK or negedge RST)
begin
    if(!RST)
        P_DATA <= 8'd0;

    else if(deser_en)
    begin
$display("WRITE bit=%0d sample=%b time=%0t", bit_count-1, sampled_bit, $time);
P_DATA[bit_count-1] <= sampled_bit;    end
end

endmodule
