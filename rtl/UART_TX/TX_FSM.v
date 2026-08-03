`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2026 03:30:02 PM
// Design Name: 
// Module Name: TX_FSM
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
module TX_FSM(
    input  wire       CLK,
    input  wire       RST,
    input  wire       DATA_VALID,
    input  wire       PAR_EN,
    input  wire       ser_done,
    input  wire [5:0] Prescale,
    output reg        load,
    output reg        shift_en,
    output reg [1:0]  mux_sel,
    output wire       busy
);
// FSM states
    localparam [2:0]IDLE=3'b000,
               START=3'b001,
               DATA=3'b010,
               PARITY=3'b011,
               STOP=3'b100;
    // current and next states           
      reg[2:0]current_state , next_state ;
      //for mux_sel
     localparam START_SEL  = 2'b00;
      localparam DATA_SEL   = 2'b01;
      localparam PARITY_SEL = 2'b10;
      localparam STOP_SEL   = 2'b11; 

    //------------------------------------------------------------
    // Baud-rate tick generator.
    // Without this, every state (and every shift) advances once
    // per CLK instead of once per bit period, so the whole frame
    // blasts out far faster than the RX (which divides by
    // Prescale) can sample it -> RX just reads idle '1' for the
    // rest of the frame.
    //------------------------------------------------------------
    reg [5:0] baud_cnt;
    wire      tick;

    assign tick = (baud_cnt == (Prescale - 1'b1));

    always @(posedge CLK or negedge RST)
    begin
        if(!RST)
            baud_cnt <= 6'd0;
        else if(current_state == IDLE)
            baud_cnt <= 6'd0;
        else if(tick)
            baud_cnt <= 6'd0;
        else
            baud_cnt <= baud_cnt + 1'b1;
    end

    always @(posedge CLK or negedge RST)
    begin
        if(!RST)
            current_state <= IDLE;
        else if(current_state == IDLE || tick)
            current_state <= next_state;
    end
    always @(*) begin
    
        next_state = current_state;
    
        case (current_state)
    
            IDLE: begin
                if (DATA_VALID)
                    next_state = START;
            end
    
            START: begin
                next_state = DATA;
            end
    
            DATA: begin
                if (ser_done) begin
                    if (PAR_EN)
                        next_state = PARITY;
                    else
                        next_state = STOP;
                end
            end
    
            PARITY: begin
                next_state = STOP;
            end
    
            STOP: begin
                next_state = IDLE;
            end
    
            default: begin
                next_state = IDLE;
            end
    
        endcase
    
    end
always @(*) begin
    
        load     = 1'b0;
        shift_en = 1'b0;
        mux_sel  = STOP_SEL;
    
        case(current_state)
    IDLE:begin 
    //Default
    end
    START:begin
    load=1'b1;
    mux_sel=START_SEL;
    end
    DATA:begin 
        shift_en = tick;
        mux_sel  = DATA_SEL;
     end
   PARITY: begin
         mux_sel = PARITY_SEL;
     end
     
     STOP: begin
         mux_sel = STOP_SEL;
     end
    
        endcase
    
    end   
     assign busy = (current_state != IDLE);
endmodule
