`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2026 05:27:26 PM
// Design Name: 
// Module Name: UART_RX
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


module UART_RX #(
    parameter DATA_WIDTH = 8
)(
    input  wire                  CLK,
    input  wire                  RST,
    input  wire                  RX_IN,
    input  wire                  parity_enable,
    input  wire                  parity_type,
    input  wire [5:0]            Prescale,

    output wire [DATA_WIDTH-1:0] P_DATA,
    output wire                  data_valid,
    output wire                  parity_error,
    output wire                  framing_error
);
//------------------------------------
// Internal Wires
//------------------------------------
 wire [3:0] bit_count;
   wire [5:0] edge_count;
   
   wire edge_bit_en;
   wire deser_en;
   wire dat_samp_en;
   wire strt_chk_en;
   wire par_chk_en;
   wire stp_chk_en;
   
   wire strt_glitch;
   wire par_err;
   wire stp_err;   
   wire sampled_bit;
//------------------------------------
   // Module Instantiations
   //------------------------------------
    edge_bit_counter u0_edge_bit_counter(
        .CLK(CLK),
        .RST(RST),
        .enable(edge_bit_en),
        .Prescale(Prescale),
        .edge_count(edge_count),
        .bit_count(bit_count)
    );
    
   
    data_sampling u0_data_sampling(
        .CLK(CLK),
        .RST(RST),
        .RX_IN(RX_IN),
        .enable(dat_samp_en),
        .Prescale(Prescale),
        .edge_count(edge_count),
        .sampled_bit(sampled_bit)
    );
    deserializer #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u0_deserializer(
        .CLK(CLK),
        .RST(RST),
        .deser_en(deser_en),
        .sampled_bit(sampled_bit),
        .bit_count(bit_count),
        .P_DATA(P_DATA)
    );
    start_check u0_start_check(
        .CLK(CLK),
        .RST(RST),
        .Enable(strt_chk_en),
        .sampled_bit(sampled_bit),
        .strt_glitch(strt_glitch)
    );
    parity_check #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u0_parity_check(
        .CLK(CLK),
        .RST(RST),
        .Enable(par_chk_en),
        .sampled_bit(sampled_bit),
        .P_DATA(P_DATA),
        .parity_type(parity_type),
        .par_err(par_err)
    );
    stop_check u0_stop_check(
        .CLK(CLK),
        .RST(RST),
        .Enable(stp_chk_en),
        .sampled_bit(sampled_bit),
        .stp_err(stp_err)
    );
    uart_rx_fsm #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u0_uart_rx_fsm(
        .CLK(CLK),
        .RST(RST),
        .S_DATA(RX_IN),
        .Prescale(Prescale),
        .bit_count(bit_count),
        .edge_count(edge_count),
        .parity_enable(parity_enable),
        .strt_glitch(strt_glitch),
        .par_err(par_err),
        .stp_err(stp_err),
    
        .edge_bit_en(edge_bit_en),
        .deser_en(deser_en),
        .dat_samp_en(dat_samp_en),
    
        .strt_chk_en(strt_chk_en),
        .par_chk_en(par_chk_en),
        .stp_chk_en(stp_chk_en),
    
        .data_valid(data_valid)
    );
    assign parity_error  = par_err;
    assign framing_error = stp_err;
endmodule
