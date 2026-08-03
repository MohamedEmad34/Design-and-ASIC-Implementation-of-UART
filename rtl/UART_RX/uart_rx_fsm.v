`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 07:39:08 PM
// Design Name: 
// Module Name: uart_rx_fsm
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



module uart_rx_fsm #(
    parameter DATA_WIDTH = 8
)(
    input  wire       CLK,
    input  wire       RST,

    input  wire       S_DATA,

    input  wire [5:0] Prescale,

    input  wire [3:0] bit_count,
    input  wire [5:0] edge_count,

    input  wire       parity_enable,

    input  wire       strt_glitch,
    input  wire       par_err,
    input  wire       stp_err,

    output reg        edge_bit_en,
    output reg        deser_en,
    output reg        dat_samp_en,

    output reg        strt_chk_en,
    output reg        par_chk_en,
    output reg        stp_chk_en,

    output reg        data_valid
);

localparam IDLE      = 3'd0,
           START     = 3'd1,
           DATA      = 3'd2,
           PARITY    = 3'd3,
           STOP      = 3'd4,
           ERROR_CHK = 3'd5;

reg [2:0] current_state;
reg [2:0] next_state;

wire bit_done;

assign bit_done = (edge_count == (Prescale-1));

////////////////////////////////////////////////////////////
// State Register
////////////////////////////////////////////////////////////

always @(posedge CLK or negedge RST)
begin
    if(!RST)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

////////////////////////////////////////////////////////////
// Next State Logic
////////////////////////////////////////////////////////////

always @(*)
begin

    next_state = current_state;

    case(current_state)

    IDLE:
    begin
        if(!S_DATA)
            next_state = START;
    end

    START:
    begin
        if(bit_done)
        begin
            if(strt_glitch)
                next_state = IDLE;
            else
                next_state = DATA;
        end
    end

    DATA:
    begin
        if(bit_done && (bit_count == DATA_WIDTH))
        begin
            if(parity_enable)
                next_state = PARITY;
            else
                next_state = STOP;
        end
    end

    PARITY:
    begin
        if(bit_done)
            next_state = STOP;
    end

    STOP:
    begin
        if(bit_done)
            next_state = ERROR_CHK;
    end

    ERROR_CHK:
    begin
        next_state = IDLE;
    end

    default:
        next_state = IDLE;

    endcase

end

////////////////////////////////////////////////////////////
// Output Logic
////////////////////////////////////////////////////////////

always @(*)
begin

    edge_bit_en = 1'b0;
    dat_samp_en = 1'b0;
    deser_en    = 1'b0;
    strt_chk_en = 1'b0;
    par_chk_en  = 1'b0;
    stp_chk_en  = 1'b0;
    data_valid  = 1'b0;

    case(current_state)

    IDLE:
    begin
    end

    START:
    begin
        edge_bit_en = 1'b1;
        dat_samp_en = 1'b1;
        strt_chk_en = 1'b1;
    end

    DATA:
    begin
        edge_bit_en = 1'b1;
        dat_samp_en = 1'b1;

        // ???? ??????? ??? ????? ?? Bit
        if(bit_done)
            deser_en = 1'b1;
    end

    PARITY:
    begin
        edge_bit_en = 1'b1;
        dat_samp_en = 1'b1;

        if(bit_done)
            par_chk_en = 1'b1;
    end

    STOP:
    begin
        edge_bit_en = 1'b1;
        dat_samp_en = 1'b1;

        if(bit_done)
            stp_chk_en = 1'b1;
    end

    ERROR_CHK:
    begin
        if(!par_err && !stp_err)
            data_valid = 1'b1;
    end

    endcase

end
always @(posedge CLK)
begin
    $display("T=%0t STATE=%0d edge=%0d bit=%0d RX=%b",
              $time,
              current_state,
              edge_count,
              bit_count,
              S_DATA);
end

endmodule
