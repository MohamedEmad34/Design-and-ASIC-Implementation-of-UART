`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/28/2026 06:03:54 PM
// Design Name: 
// Module Name: edge_bit_counter
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


module edge_bit_counter(

    input  wire       CLK,
    input  wire       RST,
    input  wire       enable,
    input  wire [5:0] Prescale,

    output reg  [5:0] edge_count,
    output reg  [3:0] bit_count

);

wire edge_done;

assign edge_done = (edge_count == (Prescale - 1'b1));

always @(posedge CLK or negedge RST)
begin

    if(!RST)
    begin
        edge_count <= 6'd0;
        bit_count  <= 4'd0;
    end

    else if(!enable)
    begin
        edge_count <= 6'd0;
        bit_count  <= 4'd0;
    end

    else if(edge_done)
    begin
        edge_count <= 6'd0;
        bit_count  <= bit_count + 1'b1;
    end

    else
    begin
        edge_count <= edge_count + 1'b1;
    end

end
endmodule
