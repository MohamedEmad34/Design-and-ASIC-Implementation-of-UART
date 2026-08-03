`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2026 10:48:59 AM
// Design Name: 
// Module Name: UART_TX_tb
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


module UART_TX_tb;

reg         CLK;
reg         RST;

reg  [7:0]  P_DATA;
reg         DATA_VALID;
reg         PAR_EN;
reg         PAR_TYP;

wire        TX_OUT;
wire        BUSY;
reg [10:0] frame;
integer i;
reg expected_parity;

UART_TX DUT (

    .CLK(CLK),
    .RST(RST),

    .P_DATA(P_DATA),
    .DATA_VALID(DATA_VALID),

    .PAR_EN(PAR_EN),
    .PAR_TYP(PAR_TYP),

    .TX_OUT(TX_OUT),
    .BUSY(BUSY)

);
// genration of clocks
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end



initial
begin

    reset_dut();
//----------------------------------------------------
    // Test Case 1 : No Parity
    //----------------------------------------------------
//    send_frame(8'hA5,0,0);
//----------------------------------------------------
//    // Test Case 2 : Even Parity
//    //----------------------------------------------------
//    send_frame(8'h55,1,0);
////----------------------------------------------------
//    // Test Case 3 : Odd Parity
//    //----------------------------------------------------
    send_frame(8'hF3,1,1);
////----------------------------------------------------
//    // Test Case 4 : Another Data
//    //----------------------------------------------------
//    send_frame(8'hAA,1,1);

    #80;

    $finish;

end







// task to control of sending frame
task send_frame;

input [7:0] data;
input       parity_en;
input       parity_type;

begin

    @(posedge CLK);

    P_DATA     = data;
    PAR_EN     = parity_en;
    PAR_TYP    = parity_type;

    DATA_VALID = 1'b1;

    @(posedge CLK);

    DATA_VALID = 1'b0;

    @(posedge BUSY);
    @(negedge BUSY);

    $display("--------------------------------");
    $display("Frame Sent Successfully");
    $display("Time = %0t", $time);
    $display("DATA = %h", data);
    $display("PAR_EN = %b", parity_en);
    $display("PAR_TYP = %b", parity_type);
    $display("--------------------------------");

end

endtask
// reset task
task reset_dut;
begin

    RST        = 1'b0;
    DATA_VALID = 1'b0;
    P_DATA     = 8'd0;
    PAR_EN     = 1'b0;
    PAR_TYP    = 1'b0;

    repeat(2) @(posedge CLK);

    RST = 1'b1;

    repeat(2) @(posedge CLK);

end
endtask
//function to calculate parity
function calc_parity;

    input [7:0] data;
    input parity_type;

    begin
        if(parity_type)
            calc_parity = ~^data;
        else
            calc_parity = ^data;
    end

endfunction


endmodule
