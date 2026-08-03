`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 03:23:40 PM
// Design Name: 
// Module Name: parity_check
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


module parity_check #(
    parameter DATA_WIDTH=8
)(
    input wire CLK, 
    input wire RST,
    input wire Enable,
    input wire sampled_bit,
    input wire [DATA_WIDTH-1:0]P_DATA,
    input wire parity_type,
    output reg par_err 
    );
    wire expected_parity;
    
    assign expected_parity = calc_parity(P_DATA, parity_type);
    always @(posedge CLK or negedge RST)
    begin
    
        if(!RST)
            par_err <= 1'b0;
    
        else if(Enable)
            par_err <= (sampled_bit != expected_parity);
    
        else
            par_err <= 1'b0;
    
    end
    function calc_parity;
    
        input [DATA_WIDTH-1:0] data;
        input parity_type;
    
        begin
            if(parity_type)
                calc_parity = ~^data;   // Odd
            else
                calc_parity = ^data;    // Even
        end
    
    endfunction
endmodule
