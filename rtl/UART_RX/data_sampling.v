`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 11:01:05 AM
// Design Name: 
// Module Name: data_sampling
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


module data_sampling(

    input  wire       CLK,
    input  wire       RST,

    input  wire       RX_IN,
    input  wire       enable,

    input  wire [5:0] Prescale,
    input  wire [5:0] edge_count,

    output reg        sampled_bit

);

reg  [2:0] samples;

wire [5:0] half_edges;
wire [5:0] half_edges_p;
wire [5:0] half_edges_n;

assign half_edges   = (Prescale >> 1);
assign half_edges_p = half_edges + 1'b1;
assign half_edges_n = half_edges - 1'b1;

always @(posedge CLK or negedge RST)
begin
    if(!RST)
        samples <= 3'b111;

    else if(enable)
    begin
        if(edge_count == half_edges_n)
            samples[0] <= RX_IN;

        else if(edge_count == half_edges)
            samples[1] <= RX_IN;

        else if(edge_count == half_edges_p)
            samples[2] <= RX_IN;
    end
end

// Majority Voting
always @(*) begin
    sampled_bit = (samples[0] & samples[1]) |
                  (samples[0] & samples[2]) |
                  (samples[1] & samples[2]);
end


endmodule

