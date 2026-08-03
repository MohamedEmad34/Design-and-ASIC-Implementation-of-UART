`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2026 10:31:55 AM
// Design Name: 
// Module Name: UART_RX_tb
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


module UART_RX_tb ;
    reg CLK;
    reg RST;
    reg RX_IN;
    reg parity_enable;
    reg parity_type;
    reg [5:0]Prescale;
    wire [7:0]P_DATA;
    wire data_valid;
    wire parity_error;
    wire framing_error;
    UART_RX DUT(
    .CLK(CLK),
    .RST(RST),
    .RX_IN(RX_IN),
    .parity_enable(parity_enable),
    .parity_type(parity_type),
    .Prescale(Prescale),
    .P_DATA(P_DATA),
    .data_valid(data_valid),
    .parity_error(parity_error),
    .framing_error(framing_error)    
    ); 
    initial
    begin
    CLK=0;
    RST=0;
    RX_IN = 1'b1;          // UART Idle
        parity_enable = 1'b0;
        parity_type   = 1'b0;
        Prescale      = 6'd8;  // ?? 16 ?? 32 ??? ??????
    #20 RST=1;
    #20;
    
//no parity frames
//send_frame(8'hA5,0,0,0,0);
//send_frame(8'h55,0,0,0,0);
//// even frames


//send_frame(8'h3C,1,0,0,0);
////odd frames
//send_frame(8'h96,1,1,0,0);
////parity error
//send_frame(8'hA5,1,0,1,0);
////framing error
//send_frame(8'hA5,0,0,0,1);
////framing and parity errors
send_frame(8'hA5,1,1,1,1);    
    #500;
    $finish;
    end
    
    always  #5 CLK=~CLK;
    task send_frame;
    
    input [7:0] data;
    input par_en;
    input par_typ;
    
    input inject_parity_error;
    input inject_framing_error;
    
    integer i;
    reg parity_bit;
    
    begin
      parity_enable = par_en;
      parity_type   = par_typ;
        // Idle
        RX_IN = 1'b1;
        repeat(Prescale) @(posedge CLK);
    
        // Start
        RX_IN = 1'b0;
        repeat(Prescale) @(posedge CLK);
    
        // Data
        for(i=0;i<8;i=i+1)
        begin
            RX_IN = data[i];
            repeat(Prescale) @(posedge CLK);
        end
    
        // Parity
        if(par_en)
        begin
    
            if(par_typ)
                parity_bit = ~^data;
            else
                parity_bit = ^data;
    
            // Inject Error
            if(inject_parity_error)
                parity_bit = ~parity_bit;
    
            RX_IN = parity_bit;
    
            repeat(Prescale) @(posedge CLK);
    
        end
    
        // Stop Bit
        if(inject_framing_error)
            RX_IN = 1'b0;
        else
            RX_IN = 1'b1;
    
        repeat(Prescale) @(posedge CLK);
    
        RX_IN = 1'b1;
    
    end
    
    endtask
    
endmodule

