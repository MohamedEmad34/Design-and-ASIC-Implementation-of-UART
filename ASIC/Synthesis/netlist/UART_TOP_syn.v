
module UART_TOP ( CLK, RST, TX_P_DATA, TX_DATA_VALID, PAR_EN, PAR_TYP, 
        Prescale, RX_P_DATA, RX_DATA_VALID, PARITY_ERROR, FRAMING_ERROR, 
        TX_BUSY );
  input [7:0] TX_P_DATA;
  input [5:0] Prescale;
  output [7:0] RX_P_DATA;
  input CLK, RST, TX_DATA_VALID, PAR_EN, PAR_TYP;
  output RX_DATA_VALID, PARITY_ERROR, FRAMING_ERROR, TX_BUSY;
  wire   \u0_uart_tx/serial_data , \u0_uart_rx/strt_glitch ,
         \u0_uart_rx/bit_count[0] , \u0_uart_rx/bit_count[1] ,
         \u0_uart_rx/bit_count[2] , \u0_uart_rx/edge_count[0] ,
         \u0_uart_rx/edge_count[1] , \u0_uart_rx/edge_count[2] ,
         \u0_uart_rx/edge_count[3] , \u0_uart_rx/edge_count[4] ,
         \u0_uart_rx/edge_count[5] , \u0_uart_tx/u_serializer/bit_cnt[0] ,
         \u0_uart_tx/u_serializer/bit_cnt[1] ,
         \u0_uart_tx/u_serializer/bit_cnt[2] ,
         \u0_uart_tx/u_serializer/shift_reg[7] ,
         \u0_uart_tx/u_serializer/shift_reg[6] ,
         \u0_uart_tx/u_serializer/shift_reg[5] ,
         \u0_uart_tx/u_serializer/shift_reg[4] ,
         \u0_uart_tx/u_serializer/shift_reg[3] ,
         \u0_uart_tx/u_serializer/shift_reg[2] ,
         \u0_uart_tx/u_serializer/shift_reg[1] , \u0_uart_tx/u_fsm/N31 ,
         \u0_uart_tx/u_fsm/N30 , \u0_uart_tx/u_fsm/N29 ,
         \u0_uart_tx/u_fsm/N28 , \u0_uart_tx/u_fsm/N27 ,
         \u0_uart_tx/u_fsm/N26 , \u0_uart_tx/u_fsm/current_state[0] ,
         \u0_uart_tx/u_fsm/current_state[2] , \u0_uart_tx/u_fsm/baud_cnt[0] ,
         \u0_uart_tx/u_fsm/baud_cnt[1] , \u0_uart_tx/u_fsm/baud_cnt[2] ,
         \u0_uart_tx/u_fsm/baud_cnt[3] , \u0_uart_tx/u_fsm/baud_cnt[4] ,
         \u0_uart_tx/u_fsm/baud_cnt[5] , \u0_uart_tx/u_parity/DATA_V[0] ,
         \u0_uart_tx/u_parity/DATA_V[1] , \u0_uart_tx/u_parity/DATA_V[2] ,
         \u0_uart_tx/u_parity/DATA_V[3] , \u0_uart_tx/u_parity/DATA_V[4] ,
         \u0_uart_tx/u_parity/DATA_V[5] , \u0_uart_tx/u_parity/DATA_V[6] ,
         \u0_uart_tx/u_parity/DATA_V[7] , \u0_uart_rx/u0_edge_bit_counter/N29 ,
         \u0_uart_rx/u0_edge_bit_counter/N28 ,
         \u0_uart_rx/u0_edge_bit_counter/N27 ,
         \u0_uart_rx/u0_edge_bit_counter/N26 ,
         \u0_uart_rx/u0_edge_bit_counter/N25 ,
         \u0_uart_rx/u0_edge_bit_counter/N24 ,
         \u0_uart_rx/u0_data_sampling/samples[0] ,
         \u0_uart_rx/u0_data_sampling/samples[1] ,
         \u0_uart_rx/u0_data_sampling/samples[2] ,
         \u0_uart_rx/u0_start_check/N4 , \u0_uart_rx/u0_parity_check/N10 ,
         \u0_uart_rx/u0_stop_check/N5 ,
         \u0_uart_rx/u0_uart_rx_fsm/current_state[0] ,
         \u0_uart_rx/u0_uart_rx_fsm/current_state[2] , n18, n19, n20, n21, n22,
         n23, n24, n25, n40, n45, n50, n113, n115, n116, n117, n118, n119,
         n120, n121, n127, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n335, n336, n337, n338, n339, n340, n341, n342, n343, n344,
         n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, n355,
         n356, n357, n358, n359, n360, n361, n362, n363, n364, n365, n366,
         n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, n377,
         n378, n379, n380, n381, n382, n383, n384, n385, n386, n387, n388,
         n389, n390, n391, n392, n393, n394, n395, n396, n397, n398, n399;

  DFFR_X1 \u0_uart_tx/u_fsm/current_state_reg[2]  ( .D(n175), .CK(CLK), .RN(
        RST), .Q(\u0_uart_tx/u_fsm/current_state[2] ) );
  DFFS_X1 \u0_uart_tx/u_serializer/bit_cnt_reg[0]  ( .D(n127), .CK(CLK), .SN(
        RST), .Q(n202), .QN(\u0_uart_tx/u_serializer/bit_cnt[0] ) );
  DFFR_X1 \u0_uart_tx/u_serializer/bit_cnt_reg[1]  ( .D(n174), .CK(CLK), .RN(
        RST), .Q(\u0_uart_tx/u_serializer/bit_cnt[1] ), .QN(n195) );
  DFFR_X1 \u0_uart_tx/u_serializer/bit_cnt_reg[2]  ( .D(n178), .CK(CLK), .RN(
        RST), .Q(\u0_uart_tx/u_serializer/bit_cnt[2] ), .QN(n215) );
  DFFR_X1 \u0_uart_tx/u_fsm/current_state_reg[0]  ( .D(n176), .CK(CLK), .RN(
        RST), .Q(\u0_uart_tx/u_fsm/current_state[0] ), .QN(n189) );
  DFFS_X1 \u0_uart_tx/u_serializer/shift_reg_reg[7]  ( .D(n121), .CK(CLK), 
        .SN(RST), .QN(\u0_uart_tx/u_serializer/shift_reg[7] ) );
  DFFS_X1 \u0_uart_tx/u_serializer/shift_reg_reg[6]  ( .D(n113), .CK(CLK), 
        .SN(RST), .QN(\u0_uart_tx/u_serializer/shift_reg[6] ) );
  DFFS_X1 \u0_uart_tx/u_serializer/shift_reg_reg[5]  ( .D(n115), .CK(CLK), 
        .SN(RST), .QN(\u0_uart_tx/u_serializer/shift_reg[5] ) );
  DFFS_X1 \u0_uart_tx/u_serializer/shift_reg_reg[4]  ( .D(n116), .CK(CLK), 
        .SN(RST), .QN(\u0_uart_tx/u_serializer/shift_reg[4] ) );
  DFFS_X1 \u0_uart_tx/u_serializer/shift_reg_reg[3]  ( .D(n117), .CK(CLK), 
        .SN(RST), .QN(\u0_uart_tx/u_serializer/shift_reg[3] ) );
  DFFS_X1 \u0_uart_tx/u_serializer/shift_reg_reg[2]  ( .D(n118), .CK(CLK), 
        .SN(RST), .QN(\u0_uart_tx/u_serializer/shift_reg[2] ) );
  DFFS_X1 \u0_uart_tx/u_serializer/shift_reg_reg[1]  ( .D(n119), .CK(CLK), 
        .SN(RST), .QN(\u0_uart_tx/u_serializer/shift_reg[1] ) );
  DFFS_X1 \u0_uart_tx/u_serializer/shift_reg_reg[0]  ( .D(n120), .CK(CLK), 
        .SN(RST), .QN(\u0_uart_tx/serial_data ) );
  DFFR_X1 \u0_uart_tx/u_fsm/current_state_reg[1]  ( .D(n177), .CK(CLK), .RN(
        RST), .Q(n193), .QN(n40) );
  DFFR_X1 \u0_uart_tx/u_fsm/baud_cnt_reg[0]  ( .D(\u0_uart_tx/u_fsm/N26 ), 
        .CK(CLK), .RN(RST), .Q(\u0_uart_tx/u_fsm/baud_cnt[0] ), .QN(n187) );
  DFFR_X1 \u0_uart_tx/u_fsm/baud_cnt_reg[1]  ( .D(\u0_uart_tx/u_fsm/N27 ), 
        .CK(CLK), .RN(RST), .Q(\u0_uart_tx/u_fsm/baud_cnt[1] ), .QN(n203) );
  DFFR_X1 \u0_uart_tx/u_fsm/baud_cnt_reg[2]  ( .D(\u0_uart_tx/u_fsm/N28 ), 
        .CK(CLK), .RN(RST), .Q(\u0_uart_tx/u_fsm/baud_cnt[2] ), .QN(n200) );
  DFFR_X1 \u0_uart_tx/u_fsm/baud_cnt_reg[3]  ( .D(\u0_uart_tx/u_fsm/N29 ), 
        .CK(CLK), .RN(RST), .Q(\u0_uart_tx/u_fsm/baud_cnt[3] ), .QN(n204) );
  DFFR_X1 \u0_uart_tx/u_fsm/baud_cnt_reg[4]  ( .D(\u0_uart_tx/u_fsm/N30 ), 
        .CK(CLK), .RN(RST), .Q(\u0_uart_tx/u_fsm/baud_cnt[4] ), .QN(n199) );
  DFFR_X1 \u0_uart_tx/u_fsm/baud_cnt_reg[5]  ( .D(\u0_uart_tx/u_fsm/N31 ), 
        .CK(CLK), .RN(RST), .Q(\u0_uart_tx/u_fsm/baud_cnt[5] ), .QN(n205) );
  DFFR_X1 \u0_uart_tx/u_parity/DATA_V_reg[0]  ( .D(n25), .CK(CLK), .RN(RST), 
        .Q(\u0_uart_tx/u_parity/DATA_V[0] ), .QN(n214) );
  DFFR_X1 \u0_uart_tx/u_parity/DATA_V_reg[1]  ( .D(n24), .CK(CLK), .RN(RST), 
        .Q(\u0_uart_tx/u_parity/DATA_V[1] ), .QN(n209) );
  DFFR_X1 \u0_uart_tx/u_parity/DATA_V_reg[2]  ( .D(n23), .CK(CLK), .RN(RST), 
        .Q(\u0_uart_tx/u_parity/DATA_V[2] ), .QN(n213) );
  DFFR_X1 \u0_uart_tx/u_parity/DATA_V_reg[3]  ( .D(n22), .CK(CLK), .RN(RST), 
        .Q(\u0_uart_tx/u_parity/DATA_V[3] ), .QN(n208) );
  DFFR_X1 \u0_uart_tx/u_parity/DATA_V_reg[4]  ( .D(n21), .CK(CLK), .RN(RST), 
        .Q(\u0_uart_tx/u_parity/DATA_V[4] ), .QN(n212) );
  DFFR_X1 \u0_uart_tx/u_parity/DATA_V_reg[5]  ( .D(n20), .CK(CLK), .RN(RST), 
        .Q(\u0_uart_tx/u_parity/DATA_V[5] ), .QN(n207) );
  DFFR_X1 \u0_uart_tx/u_parity/DATA_V_reg[6]  ( .D(n19), .CK(CLK), .RN(RST), 
        .Q(\u0_uart_tx/u_parity/DATA_V[6] ), .QN(n210) );
  DFFR_X1 \u0_uart_tx/u_parity/DATA_V_reg[7]  ( .D(n18), .CK(CLK), .RN(RST), 
        .Q(\u0_uart_tx/u_parity/DATA_V[7] ), .QN(n211) );
  DFFR_X1 \u0_uart_rx/u0_uart_rx_fsm/current_state_reg[2]  ( .D(n183), .CK(CLK), .RN(RST), .Q(\u0_uart_rx/u0_uart_rx_fsm/current_state[2] ) );
  DFFR_X1 \u0_uart_rx/u0_edge_bit_counter/edge_count_reg[5]  ( .D(
        \u0_uart_rx/u0_edge_bit_counter/N29 ), .CK(CLK), .RN(RST), .Q(
        \u0_uart_rx/edge_count[5] ), .QN(n190) );
  DFFR_X1 \u0_uart_rx/u0_edge_bit_counter/edge_count_reg[4]  ( .D(
        \u0_uart_rx/u0_edge_bit_counter/N28 ), .CK(CLK), .RN(RST), .Q(
        \u0_uart_rx/edge_count[4] ), .QN(n191) );
  DFFR_X1 \u0_uart_rx/u0_edge_bit_counter/edge_count_reg[3]  ( .D(
        \u0_uart_rx/u0_edge_bit_counter/N27 ), .CK(CLK), .RN(RST), .Q(
        \u0_uart_rx/edge_count[3] ), .QN(n201) );
  DFFR_X1 \u0_uart_rx/u0_edge_bit_counter/edge_count_reg[2]  ( .D(
        \u0_uart_rx/u0_edge_bit_counter/N26 ), .CK(CLK), .RN(RST), .Q(
        \u0_uart_rx/edge_count[2] ), .QN(n198) );
  DFFR_X1 \u0_uart_rx/u0_edge_bit_counter/edge_count_reg[1]  ( .D(
        \u0_uart_rx/u0_edge_bit_counter/N25 ), .CK(CLK), .RN(RST), .Q(
        \u0_uart_rx/edge_count[1] ), .QN(n197) );
  DFFR_X1 \u0_uart_rx/u0_edge_bit_counter/edge_count_reg[0]  ( .D(
        \u0_uart_rx/u0_edge_bit_counter/N24 ), .CK(CLK), .RN(RST), .Q(
        \u0_uart_rx/edge_count[0] ), .QN(n186) );
  DFFS_X1 \u0_uart_rx/u0_data_sampling/samples_reg[2]  ( .D(n171), .CK(CLK), 
        .SN(RST), .Q(\u0_uart_rx/u0_data_sampling/samples[2] ) );
  DFFS_X1 \u0_uart_rx/u0_data_sampling/samples_reg[1]  ( .D(n172), .CK(CLK), 
        .SN(RST), .Q(\u0_uart_rx/u0_data_sampling/samples[1] ) );
  DFFR_X1 \u0_uart_rx/u0_edge_bit_counter/bit_count_reg[0]  ( .D(n182), .CK(
        CLK), .RN(RST), .Q(\u0_uart_rx/bit_count[0] ), .QN(n185) );
  DFFR_X1 \u0_uart_rx/u0_edge_bit_counter/bit_count_reg[1]  ( .D(n181), .CK(
        CLK), .RN(RST), .Q(\u0_uart_rx/bit_count[1] ), .QN(n194) );
  DFFR_X1 \u0_uart_rx/u0_edge_bit_counter/bit_count_reg[2]  ( .D(n180), .CK(
        CLK), .RN(RST), .Q(\u0_uart_rx/bit_count[2] ), .QN(n196) );
  DFFR_X1 \u0_uart_rx/u0_edge_bit_counter/bit_count_reg[3]  ( .D(n179), .CK(
        CLK), .RN(RST), .QN(n45) );
  DFFS_X1 \u0_uart_rx/u0_data_sampling/samples_reg[0]  ( .D(n173), .CK(CLK), 
        .SN(RST), .Q(\u0_uart_rx/u0_data_sampling/samples[0] ) );
  DFFR_X1 \u0_uart_rx/u0_start_check/strt_glitch_reg  ( .D(
        \u0_uart_rx/u0_start_check/N4 ), .CK(CLK), .RN(RST), .Q(
        \u0_uart_rx/strt_glitch ) );
  DFFR_X1 \u0_uart_rx/u0_uart_rx_fsm/current_state_reg[1]  ( .D(n170), .CK(CLK), .RN(RST), .Q(n192), .QN(n50) );
  DFFR_X1 \u0_uart_rx/u0_uart_rx_fsm/current_state_reg[0]  ( .D(n169), .CK(CLK), .RN(RST), .Q(\u0_uart_rx/u0_uart_rx_fsm/current_state[0] ), .QN(n184) );
  DFFR_X1 \u0_uart_rx/u0_deserializer/P_DATA_reg[7]  ( .D(n161), .CK(CLK), 
        .RN(RST), .Q(RX_P_DATA[7]), .QN(n188) );
  DFFR_X1 \u0_uart_rx/u0_deserializer/P_DATA_reg[6]  ( .D(n162), .CK(CLK), 
        .RN(RST), .Q(RX_P_DATA[6]), .QN(n206) );
  DFFR_X1 \u0_uart_rx/u0_deserializer/P_DATA_reg[5]  ( .D(n163), .CK(CLK), 
        .RN(RST), .Q(RX_P_DATA[5]) );
  DFFR_X1 \u0_uart_rx/u0_deserializer/P_DATA_reg[4]  ( .D(n164), .CK(CLK), 
        .RN(RST), .Q(RX_P_DATA[4]) );
  DFFR_X1 \u0_uart_rx/u0_deserializer/P_DATA_reg[3]  ( .D(n165), .CK(CLK), 
        .RN(RST), .Q(RX_P_DATA[3]) );
  DFFR_X1 \u0_uart_rx/u0_deserializer/P_DATA_reg[2]  ( .D(n166), .CK(CLK), 
        .RN(RST), .Q(RX_P_DATA[2]) );
  DFFR_X1 \u0_uart_rx/u0_deserializer/P_DATA_reg[1]  ( .D(n167), .CK(CLK), 
        .RN(RST), .Q(RX_P_DATA[1]) );
  DFFR_X1 \u0_uart_rx/u0_deserializer/P_DATA_reg[0]  ( .D(n168), .CK(CLK), 
        .RN(RST), .Q(RX_P_DATA[0]) );
  DFFR_X1 \u0_uart_rx/u0_parity_check/par_err_reg  ( .D(
        \u0_uart_rx/u0_parity_check/N10 ), .CK(CLK), .RN(RST), .Q(PARITY_ERROR) );
  DFFR_X1 \u0_uart_rx/u0_stop_check/stp_err_reg  ( .D(
        \u0_uart_rx/u0_stop_check/N5 ), .CK(CLK), .RN(RST), .Q(FRAMING_ERROR)
         );
  AOI222_X1 U182 ( .A1(\u0_uart_rx/u0_data_sampling/samples[0] ), .A2(
        \u0_uart_rx/u0_data_sampling/samples[1] ), .B1(
        \u0_uart_rx/u0_data_sampling/samples[0] ), .B2(
        \u0_uart_rx/u0_data_sampling/samples[2] ), .C1(
        \u0_uart_rx/u0_data_sampling/samples[1] ), .C2(
        \u0_uart_rx/u0_data_sampling/samples[2] ), .ZN(n358) );
  INV_X1 U183 ( .A(n278), .ZN(n286) );
  INV_X1 U184 ( .A(n383), .ZN(n388) );
  NOR2_X2 U185 ( .A1(n237), .A2(n193), .ZN(n399) );
  OR2_X1 U186 ( .A1(n189), .A2(\u0_uart_tx/u_fsm/current_state[2] ), .ZN(n237)
         );
  NAND2_X1 U187 ( .A1(\u0_uart_rx/u0_uart_rx_fsm/current_state[2] ), .A2(n50), 
        .ZN(n216) );
  NOR4_X1 U188 ( .A1(PARITY_ERROR), .A2(FRAMING_ERROR), .A3(n216), .A4(n184), 
        .ZN(RX_DATA_VALID) );
  NOR2_X1 U189 ( .A1(\u0_uart_tx/u_fsm/current_state[2] ), .A2(
        \u0_uart_tx/u_fsm/current_state[0] ), .ZN(n261) );
  NAND2_X1 U190 ( .A1(n40), .A2(n261), .ZN(TX_BUSY) );
  NOR3_X1 U191 ( .A1(Prescale[0]), .A2(Prescale[2]), .A3(Prescale[1]), .ZN(
        n217) );
  XNOR2_X1 U192 ( .A(Prescale[3]), .B(n217), .ZN(n260) );
  NOR3_X1 U193 ( .A1(Prescale[3]), .A2(Prescale[2]), .A3(Prescale[1]), .ZN(
        n293) );
  INV_X1 U194 ( .A(Prescale[0]), .ZN(n256) );
  NAND2_X1 U195 ( .A1(n293), .A2(n256), .ZN(n218) );
  NOR2_X1 U196 ( .A1(Prescale[4]), .A2(n218), .ZN(n226) );
  AOI21_X1 U197 ( .B1(Prescale[4]), .B2(n218), .A(n226), .ZN(n251) );
  XNOR2_X1 U198 ( .A(n226), .B(Prescale[5]), .ZN(n250) );
  OAI22_X1 U199 ( .A1(n251), .A2(\u0_uart_rx/edge_count[4] ), .B1(n250), .B2(
        \u0_uart_rx/edge_count[5] ), .ZN(n219) );
  AOI221_X1 U200 ( .B1(n251), .B2(\u0_uart_rx/edge_count[4] ), .C1(
        \u0_uart_rx/edge_count[5] ), .C2(n250), .A(n219), .ZN(n224) );
  NOR2_X1 U201 ( .A1(Prescale[0]), .A2(Prescale[1]), .ZN(n220) );
  AOI21_X1 U202 ( .B1(Prescale[1]), .B2(Prescale[0]), .A(n220), .ZN(n254) );
  XNOR2_X1 U203 ( .A(Prescale[2]), .B(n220), .ZN(n253) );
  AOI22_X1 U204 ( .A1(n254), .A2(\u0_uart_rx/edge_count[1] ), .B1(n253), .B2(
        \u0_uart_rx/edge_count[2] ), .ZN(n221) );
  OAI221_X1 U205 ( .B1(n254), .B2(\u0_uart_rx/edge_count[1] ), .C1(n253), .C2(
        \u0_uart_rx/edge_count[2] ), .A(n221), .ZN(n222) );
  AOI221_X1 U206 ( .B1(Prescale[0]), .B2(\u0_uart_rx/edge_count[0] ), .C1(n256), .C2(n186), .A(n222), .ZN(n223) );
  OAI211_X1 U207 ( .C1(n260), .C2(\u0_uart_rx/edge_count[3] ), .A(n224), .B(
        n223), .ZN(n225) );
  AOI21_X1 U208 ( .B1(n260), .B2(\u0_uart_rx/edge_count[3] ), .A(n225), .ZN(
        n241) );
  INV_X1 U209 ( .A(Prescale[5]), .ZN(n291) );
  NAND2_X1 U210 ( .A1(n226), .A2(n291), .ZN(n227) );
  NAND2_X1 U211 ( .A1(n241), .A2(n227), .ZN(n381) );
  NAND2_X1 U212 ( .A1(n185), .A2(n194), .ZN(n347) );
  NOR4_X1 U213 ( .A1(\u0_uart_rx/bit_count[2] ), .A2(n45), .A3(n381), .A4(n347), .ZN(n333) );
  NOR3_X1 U214 ( .A1(\u0_uart_rx/u0_uart_rx_fsm/current_state[0] ), .A2(
        \u0_uart_rx/u0_uart_rx_fsm/current_state[2] ), .A3(n50), .ZN(n346) );
  NAND2_X1 U215 ( .A1(n333), .A2(n346), .ZN(n357) );
  NAND3_X1 U216 ( .A1(\u0_uart_rx/u0_uart_rx_fsm/current_state[2] ), .A2(n50), 
        .A3(n184), .ZN(n380) );
  NOR2_X1 U217 ( .A1(\u0_uart_rx/u0_uart_rx_fsm/current_state[2] ), .A2(n50), 
        .ZN(n374) );
  OAI21_X1 U218 ( .B1(\u0_uart_rx/u0_uart_rx_fsm/current_state[2] ), .B2(n184), 
        .A(n380), .ZN(n240) );
  OAI22_X1 U219 ( .A1(n399), .A2(n261), .B1(
        \u0_uart_tx/u_fsm/current_state[0] ), .B2(n193), .ZN(n236) );
  XNOR2_X1 U220 ( .A(\u0_uart_tx/u_parity/DATA_V[2] ), .B(
        \u0_uart_tx/u_parity/DATA_V[3] ), .ZN(n234) );
  XOR2_X1 U221 ( .A(\u0_uart_tx/u_parity/DATA_V[7] ), .B(
        \u0_uart_tx/u_parity/DATA_V[6] ), .Z(n229) );
  XNOR2_X1 U222 ( .A(\u0_uart_tx/u_parity/DATA_V[4] ), .B(
        \u0_uart_tx/u_parity/DATA_V[5] ), .ZN(n228) );
  XNOR2_X1 U223 ( .A(n229), .B(n228), .ZN(n230) );
  XOR2_X1 U224 ( .A(n230), .B(PAR_TYP), .Z(n232) );
  XNOR2_X1 U225 ( .A(\u0_uart_tx/u_parity/DATA_V[0] ), .B(
        \u0_uart_tx/u_parity/DATA_V[1] ), .ZN(n231) );
  XNOR2_X1 U226 ( .A(n232), .B(n231), .ZN(n233) );
  XNOR2_X1 U227 ( .A(n234), .B(n233), .ZN(n235) );
  AOI222_X1 U228 ( .A1(n237), .A2(n236), .B1(n237), .B2(
        \u0_uart_tx/serial_data ), .C1(n236), .C2(n235), .ZN(n331) );
  NOR4_X1 U229 ( .A1(\u0_uart_rx/u0_uart_rx_fsm/current_state[0] ), .A2(
        \u0_uart_rx/u0_uart_rx_fsm/current_state[2] ), .A3(n192), .A4(n331), 
        .ZN(n238) );
  AOI21_X1 U230 ( .B1(n381), .B2(n240), .A(n238), .ZN(n340) );
  NAND3_X1 U231 ( .A1(\u0_uart_rx/u0_uart_rx_fsm/current_state[0] ), .A2(n374), 
        .A3(n340), .ZN(n239) );
  OAI211_X1 U232 ( .C1(PAR_EN), .C2(n357), .A(n380), .B(n239), .ZN(n183) );
  INV_X1 U233 ( .A(n241), .ZN(n242) );
  NOR2_X1 U234 ( .A1(n374), .A2(n240), .ZN(n317) );
  INV_X1 U235 ( .A(n317), .ZN(n298) );
  NAND2_X1 U236 ( .A1(n242), .A2(n298), .ZN(n364) );
  NAND2_X1 U237 ( .A1(n298), .A2(n241), .ZN(n244) );
  AOI22_X1 U238 ( .A1(\u0_uart_rx/bit_count[0] ), .A2(n364), .B1(n244), .B2(
        n185), .ZN(n182) );
  NAND2_X1 U239 ( .A1(\u0_uart_rx/bit_count[0] ), .A2(n194), .ZN(n350) );
  NAND2_X1 U240 ( .A1(\u0_uart_rx/bit_count[1] ), .A2(n185), .ZN(n352) );
  OAI222_X1 U241 ( .A1(n244), .A2(n350), .B1(n352), .B2(n317), .C1(n194), .C2(
        n364), .ZN(n181) );
  NAND2_X1 U242 ( .A1(\u0_uart_rx/bit_count[0] ), .A2(
        \u0_uart_rx/bit_count[1] ), .ZN(n356) );
  OAI21_X1 U243 ( .B1(n356), .B2(n242), .A(n298), .ZN(n243) );
  OR2_X1 U244 ( .A1(n356), .A2(n244), .ZN(n247) );
  AOI22_X1 U245 ( .A1(\u0_uart_rx/bit_count[2] ), .A2(n243), .B1(n247), .B2(
        n196), .ZN(n180) );
  OAI21_X1 U246 ( .B1(n244), .B2(\u0_uart_rx/bit_count[2] ), .A(n243), .ZN(
        n245) );
  INV_X1 U247 ( .A(n245), .ZN(n248) );
  NAND2_X1 U248 ( .A1(n45), .A2(\u0_uart_rx/bit_count[2] ), .ZN(n246) );
  OAI22_X1 U249 ( .A1(n45), .A2(n248), .B1(n247), .B2(n246), .ZN(n179) );
  OAI22_X1 U250 ( .A1(n251), .A2(\u0_uart_tx/u_fsm/baud_cnt[4] ), .B1(n250), 
        .B2(\u0_uart_tx/u_fsm/baud_cnt[5] ), .ZN(n249) );
  AOI221_X1 U251 ( .B1(n251), .B2(\u0_uart_tx/u_fsm/baud_cnt[4] ), .C1(
        \u0_uart_tx/u_fsm/baud_cnt[5] ), .C2(n250), .A(n249), .ZN(n258) );
  AOI22_X1 U252 ( .A1(n254), .A2(\u0_uart_tx/u_fsm/baud_cnt[1] ), .B1(n253), 
        .B2(\u0_uart_tx/u_fsm/baud_cnt[2] ), .ZN(n252) );
  OAI221_X1 U253 ( .B1(n254), .B2(\u0_uart_tx/u_fsm/baud_cnt[1] ), .C1(n253), 
        .C2(\u0_uart_tx/u_fsm/baud_cnt[2] ), .A(n252), .ZN(n255) );
  AOI221_X1 U254 ( .B1(Prescale[0]), .B2(\u0_uart_tx/u_fsm/baud_cnt[0] ), .C1(
        n256), .C2(n187), .A(n255), .ZN(n257) );
  OAI211_X1 U255 ( .C1(n260), .C2(\u0_uart_tx/u_fsm/baud_cnt[3] ), .A(n258), 
        .B(n257), .ZN(n259) );
  AOI21_X1 U256 ( .B1(n260), .B2(\u0_uart_tx/u_fsm/baud_cnt[3] ), .A(n259), 
        .ZN(n264) );
  AND2_X1 U257 ( .A1(n193), .A2(n261), .ZN(n267) );
  NAND2_X1 U258 ( .A1(n264), .A2(n267), .ZN(n278) );
  NAND3_X1 U259 ( .A1(\u0_uart_tx/u_serializer/bit_cnt[1] ), .A2(
        \u0_uart_tx/u_serializer/bit_cnt[0] ), .A3(
        \u0_uart_tx/u_serializer/bit_cnt[2] ), .ZN(n266) );
  NAND2_X1 U260 ( .A1(n286), .A2(n266), .ZN(n273) );
  NAND2_X1 U261 ( .A1(\u0_uart_tx/u_serializer/bit_cnt[1] ), .A2(
        \u0_uart_tx/u_serializer/bit_cnt[0] ), .ZN(n262) );
  OAI22_X1 U262 ( .A1(n399), .A2(n215), .B1(n273), .B2(n262), .ZN(n178) );
  INV_X1 U263 ( .A(TX_BUSY), .ZN(n263) );
  NOR2_X1 U264 ( .A1(n264), .A2(n263), .ZN(n383) );
  NOR2_X1 U265 ( .A1(TX_DATA_VALID), .A2(TX_BUSY), .ZN(n265) );
  AOI211_X1 U266 ( .C1(n267), .C2(n266), .A(n383), .B(n265), .ZN(n269) );
  INV_X1 U267 ( .A(n269), .ZN(n271) );
  INV_X1 U268 ( .A(n399), .ZN(n274) );
  NAND3_X1 U269 ( .A1(PAR_EN), .A2(n267), .A3(n269), .ZN(n268) );
  OAI221_X1 U270 ( .B1(n269), .B2(n40), .C1(n271), .C2(n274), .A(n268), .ZN(
        n177) );
  OAI221_X1 U271 ( .B1(n269), .B2(n189), .C1(n271), .C2(TX_BUSY), .A(n268), 
        .ZN(n176) );
  AOI211_X1 U272 ( .C1(n189), .C2(PAR_EN), .A(
        \u0_uart_tx/u_fsm/current_state[2] ), .B(n40), .ZN(n270) );
  OAI22_X1 U273 ( .A1(n271), .A2(n270), .B1(
        \u0_uart_tx/u_fsm/current_state[2] ), .B2(n269), .ZN(n272) );
  INV_X1 U274 ( .A(n272), .ZN(n175) );
  NAND2_X1 U275 ( .A1(n274), .A2(n273), .ZN(n276) );
  INV_X1 U276 ( .A(n276), .ZN(n275) );
  AOI22_X1 U277 ( .A1(\u0_uart_tx/u_serializer/bit_cnt[0] ), .A2(n275), .B1(
        n286), .B2(n202), .ZN(n127) );
  XOR2_X1 U278 ( .A(n195), .B(\u0_uart_tx/u_serializer/bit_cnt[0] ), .Z(n277)
         );
  OAI22_X1 U279 ( .A1(n278), .A2(n277), .B1(n195), .B2(n276), .ZN(n174) );
  NOR2_X1 U280 ( .A1(n399), .A2(n286), .ZN(n285) );
  AOI22_X1 U281 ( .A1(n399), .A2(TX_P_DATA[7]), .B1(n285), .B2(
        \u0_uart_tx/u_serializer/shift_reg[7] ), .ZN(n121) );
  AOI22_X1 U282 ( .A1(\u0_uart_tx/serial_data ), .A2(n285), .B1(n286), .B2(
        \u0_uart_tx/u_serializer/shift_reg[1] ), .ZN(n279) );
  NAND2_X1 U283 ( .A1(n399), .A2(TX_P_DATA[0]), .ZN(n398) );
  AND2_X1 U284 ( .A1(n279), .A2(n398), .ZN(n120) );
  AOI22_X1 U285 ( .A1(n286), .A2(\u0_uart_tx/u_serializer/shift_reg[2] ), .B1(
        n285), .B2(\u0_uart_tx/u_serializer/shift_reg[1] ), .ZN(n280) );
  NAND2_X1 U286 ( .A1(n399), .A2(TX_P_DATA[1]), .ZN(n397) );
  AND2_X1 U287 ( .A1(n280), .A2(n397), .ZN(n119) );
  AOI22_X1 U288 ( .A1(n286), .A2(\u0_uart_tx/u_serializer/shift_reg[3] ), .B1(
        n285), .B2(\u0_uart_tx/u_serializer/shift_reg[2] ), .ZN(n281) );
  NAND2_X1 U289 ( .A1(n399), .A2(TX_P_DATA[2]), .ZN(n396) );
  AND2_X1 U290 ( .A1(n281), .A2(n396), .ZN(n118) );
  AOI22_X1 U291 ( .A1(n286), .A2(\u0_uart_tx/u_serializer/shift_reg[4] ), .B1(
        n285), .B2(\u0_uart_tx/u_serializer/shift_reg[3] ), .ZN(n282) );
  NAND2_X1 U292 ( .A1(n399), .A2(TX_P_DATA[3]), .ZN(n395) );
  AND2_X1 U293 ( .A1(n282), .A2(n395), .ZN(n117) );
  AOI22_X1 U294 ( .A1(n286), .A2(\u0_uart_tx/u_serializer/shift_reg[5] ), .B1(
        n285), .B2(\u0_uart_tx/u_serializer/shift_reg[4] ), .ZN(n283) );
  NAND2_X1 U295 ( .A1(n399), .A2(TX_P_DATA[4]), .ZN(n394) );
  AND2_X1 U296 ( .A1(n283), .A2(n394), .ZN(n116) );
  AOI22_X1 U297 ( .A1(n286), .A2(\u0_uart_tx/u_serializer/shift_reg[6] ), .B1(
        n285), .B2(\u0_uart_tx/u_serializer/shift_reg[5] ), .ZN(n284) );
  NAND2_X1 U298 ( .A1(n399), .A2(TX_P_DATA[5]), .ZN(n393) );
  AND2_X1 U299 ( .A1(n284), .A2(n393), .ZN(n115) );
  AOI22_X1 U300 ( .A1(n286), .A2(\u0_uart_tx/u_serializer/shift_reg[7] ), .B1(
        n285), .B2(\u0_uart_tx/u_serializer/shift_reg[6] ), .ZN(n287) );
  NAND2_X1 U301 ( .A1(n399), .A2(TX_P_DATA[6]), .ZN(n392) );
  AND2_X1 U302 ( .A1(n287), .A2(n392), .ZN(n113) );
  NOR2_X1 U303 ( .A1(Prescale[2]), .A2(Prescale[1]), .ZN(n289) );
  XOR2_X1 U304 ( .A(Prescale[3]), .B(\u0_uart_rx/edge_count[2] ), .Z(n314) );
  NAND2_X1 U305 ( .A1(Prescale[4]), .A2(\u0_uart_rx/edge_count[3] ), .ZN(n292)
         );
  OAI211_X1 U306 ( .C1(n292), .C2(Prescale[3]), .A(n314), .B(n289), .ZN(n288)
         );
  OAI21_X1 U307 ( .B1(n289), .B2(n314), .A(n288), .ZN(n301) );
  INV_X1 U308 ( .A(Prescale[2]), .ZN(n310) );
  AOI22_X1 U309 ( .A1(Prescale[2]), .A2(\u0_uart_rx/edge_count[1] ), .B1(n197), 
        .B2(n310), .ZN(n321) );
  INV_X1 U310 ( .A(Prescale[1]), .ZN(n309) );
  NAND2_X1 U311 ( .A1(\u0_uart_rx/edge_count[0] ), .A2(n309), .ZN(n318) );
  AOI22_X1 U312 ( .A1(n321), .A2(n318), .B1(\u0_uart_rx/edge_count[5] ), .B2(
        n191), .ZN(n300) );
  INV_X1 U313 ( .A(n293), .ZN(n290) );
  NOR2_X1 U314 ( .A1(Prescale[4]), .A2(n290), .ZN(n297) );
  OAI221_X1 U315 ( .B1(Prescale[5]), .B2(\u0_uart_rx/edge_count[5] ), .C1(n291), .C2(n191), .A(\u0_uart_rx/edge_count[3] ), .ZN(n296) );
  INV_X1 U316 ( .A(n297), .ZN(n295) );
  AOI22_X1 U317 ( .A1(Prescale[5]), .A2(n191), .B1(\u0_uart_rx/edge_count[4] ), 
        .B2(n291), .ZN(n322) );
  NAND2_X1 U318 ( .A1(n322), .A2(n190), .ZN(n304) );
  NOR2_X1 U319 ( .A1(\u0_uart_rx/edge_count[0] ), .A2(n309), .ZN(n305) );
  OAI21_X1 U320 ( .B1(Prescale[4]), .B2(\u0_uart_rx/edge_count[3] ), .A(n292), 
        .ZN(n316) );
  OAI22_X1 U321 ( .A1(n305), .A2(n321), .B1(n293), .B2(n316), .ZN(n294) );
  AOI221_X1 U322 ( .B1(n297), .B2(n296), .C1(n295), .C2(n304), .A(n294), .ZN(
        n299) );
  NAND4_X1 U323 ( .A1(n301), .A2(n300), .A3(n299), .A4(n298), .ZN(n303) );
  NAND2_X1 U324 ( .A1(n303), .A2(\u0_uart_rx/u0_data_sampling/samples[0] ), 
        .ZN(n302) );
  OAI21_X1 U325 ( .B1(n303), .B2(n331), .A(n302), .ZN(n173) );
  NOR4_X1 U326 ( .A1(n317), .A2(n321), .A3(n314), .A4(n304), .ZN(n306) );
  INV_X1 U327 ( .A(n305), .ZN(n320) );
  NAND4_X1 U328 ( .A1(n306), .A2(n316), .A3(n320), .A4(n318), .ZN(n308) );
  NAND2_X1 U329 ( .A1(n308), .A2(\u0_uart_rx/u0_data_sampling/samples[1] ), 
        .ZN(n307) );
  OAI21_X1 U330 ( .B1(n308), .B2(n331), .A(n307), .ZN(n172) );
  INV_X1 U331 ( .A(Prescale[3]), .ZN(n311) );
  NOR3_X1 U332 ( .A1(n311), .A2(n310), .A3(n309), .ZN(n315) );
  NAND2_X1 U333 ( .A1(Prescale[2]), .A2(Prescale[1]), .ZN(n313) );
  OAI22_X1 U334 ( .A1(n316), .A2(n315), .B1(n313), .B2(n314), .ZN(n312) );
  AOI221_X1 U335 ( .B1(n316), .B2(n315), .C1(n314), .C2(n313), .A(n312), .ZN(
        n329) );
  INV_X1 U336 ( .A(n321), .ZN(n319) );
  AOI221_X1 U337 ( .B1(n321), .B2(n320), .C1(n319), .C2(n318), .A(n317), .ZN(
        n328) );
  NAND4_X1 U338 ( .A1(Prescale[3]), .A2(Prescale[2]), .A3(Prescale[1]), .A4(
        Prescale[4]), .ZN(n323) );
  NAND3_X1 U339 ( .A1(n323), .A2(n190), .A3(n322), .ZN(n326) );
  AOI211_X1 U340 ( .C1(n190), .C2(Prescale[5]), .A(n323), .B(n322), .ZN(n324)
         );
  OAI21_X1 U341 ( .B1(n190), .B2(Prescale[5]), .A(n324), .ZN(n325) );
  NAND2_X1 U342 ( .A1(n326), .A2(n325), .ZN(n327) );
  NAND3_X1 U343 ( .A1(n329), .A2(n328), .A3(n327), .ZN(n332) );
  NAND2_X1 U344 ( .A1(n332), .A2(\u0_uart_rx/u0_data_sampling/samples[2] ), 
        .ZN(n330) );
  OAI21_X1 U345 ( .B1(n332), .B2(n331), .A(n330), .ZN(n171) );
  NOR3_X1 U346 ( .A1(\u0_uart_rx/u0_uart_rx_fsm/current_state[2] ), .A2(n184), 
        .A3(n192), .ZN(n379) );
  NAND2_X1 U347 ( .A1(n340), .A2(n379), .ZN(n337) );
  INV_X1 U348 ( .A(n357), .ZN(n359) );
  NAND2_X1 U349 ( .A1(n359), .A2(PAR_EN), .ZN(n338) );
  INV_X1 U350 ( .A(n340), .ZN(n335) );
  INV_X1 U351 ( .A(n333), .ZN(n334) );
  OAI221_X1 U352 ( .B1(n335), .B2(n346), .C1(n335), .C2(n334), .A(n192), .ZN(
        n336) );
  OAI211_X1 U353 ( .C1(\u0_uart_rx/strt_glitch ), .C2(n337), .A(n338), .B(n336), .ZN(n170) );
  NAND2_X1 U354 ( .A1(n184), .A2(n340), .ZN(n339) );
  OAI221_X1 U355 ( .B1(n184), .B2(n340), .C1(n339), .C2(n192), .A(n338), .ZN(
        n169) );
  INV_X1 U356 ( .A(n381), .ZN(n375) );
  NAND4_X1 U357 ( .A1(n45), .A2(n375), .A3(n346), .A4(n196), .ZN(n343) );
  OR2_X1 U358 ( .A1(n343), .A2(n358), .ZN(n345) );
  OAI21_X1 U359 ( .B1(n350), .B2(n343), .A(RX_P_DATA[0]), .ZN(n341) );
  OAI21_X1 U360 ( .B1(n350), .B2(n345), .A(n341), .ZN(n168) );
  OAI21_X1 U361 ( .B1(n352), .B2(n343), .A(RX_P_DATA[1]), .ZN(n342) );
  OAI21_X1 U362 ( .B1(n352), .B2(n345), .A(n342), .ZN(n167) );
  OAI21_X1 U363 ( .B1(n356), .B2(n343), .A(RX_P_DATA[2]), .ZN(n344) );
  OAI21_X1 U364 ( .B1(n356), .B2(n345), .A(n344), .ZN(n166) );
  INV_X1 U365 ( .A(n358), .ZN(n382) );
  NAND4_X1 U366 ( .A1(n375), .A2(n45), .A3(\u0_uart_rx/bit_count[2] ), .A4(
        n346), .ZN(n353) );
  NOR2_X1 U367 ( .A1(n347), .A2(n353), .ZN(n348) );
  MUX2_X1 U368 ( .A(RX_P_DATA[3]), .B(n382), .S(n348), .Z(n165) );
  OR2_X1 U369 ( .A1(n358), .A2(n353), .ZN(n355) );
  OAI21_X1 U370 ( .B1(n350), .B2(n353), .A(RX_P_DATA[4]), .ZN(n349) );
  OAI21_X1 U371 ( .B1(n350), .B2(n355), .A(n349), .ZN(n164) );
  OAI21_X1 U372 ( .B1(n352), .B2(n353), .A(RX_P_DATA[5]), .ZN(n351) );
  OAI21_X1 U373 ( .B1(n352), .B2(n355), .A(n351), .ZN(n163) );
  OAI21_X1 U374 ( .B1(n356), .B2(n353), .A(RX_P_DATA[6]), .ZN(n354) );
  OAI21_X1 U375 ( .B1(n356), .B2(n355), .A(n354), .ZN(n162) );
  AOI22_X1 U376 ( .A1(n359), .A2(n358), .B1(n188), .B2(n357), .ZN(n161) );
  NOR2_X1 U377 ( .A1(\u0_uart_rx/edge_count[0] ), .A2(n364), .ZN(
        \u0_uart_rx/u0_edge_bit_counter/N24 ) );
  AOI221_X1 U378 ( .B1(\u0_uart_rx/edge_count[1] ), .B2(
        \u0_uart_rx/edge_count[0] ), .C1(n197), .C2(n186), .A(n364), .ZN(
        \u0_uart_rx/u0_edge_bit_counter/N25 ) );
  NAND2_X1 U379 ( .A1(\u0_uart_rx/edge_count[1] ), .A2(
        \u0_uart_rx/edge_count[0] ), .ZN(n360) );
  NOR2_X1 U380 ( .A1(n198), .A2(n360), .ZN(n362) );
  AOI211_X1 U381 ( .C1(n198), .C2(n360), .A(n362), .B(n364), .ZN(
        \u0_uart_rx/u0_edge_bit_counter/N26 ) );
  INV_X1 U382 ( .A(n362), .ZN(n361) );
  AOI221_X1 U383 ( .B1(\u0_uart_rx/edge_count[3] ), .B2(n362), .C1(n201), .C2(
        n361), .A(n364), .ZN(\u0_uart_rx/u0_edge_bit_counter/N27 ) );
  NAND2_X1 U384 ( .A1(\u0_uart_rx/edge_count[3] ), .A2(n362), .ZN(n363) );
  NOR2_X1 U385 ( .A1(n191), .A2(n363), .ZN(n366) );
  AOI211_X1 U386 ( .C1(n191), .C2(n363), .A(n366), .B(n364), .ZN(
        \u0_uart_rx/u0_edge_bit_counter/N28 ) );
  INV_X1 U387 ( .A(n366), .ZN(n365) );
  AOI221_X1 U388 ( .B1(\u0_uart_rx/edge_count[5] ), .B2(n366), .C1(n190), .C2(
        n365), .A(n364), .ZN(\u0_uart_rx/u0_edge_bit_counter/N29 ) );
  XNOR2_X1 U389 ( .A(PAR_TYP), .B(RX_P_DATA[3]), .ZN(n373) );
  XNOR2_X1 U390 ( .A(RX_P_DATA[4]), .B(RX_P_DATA[5]), .ZN(n368) );
  AOI22_X1 U391 ( .A1(RX_P_DATA[6]), .A2(RX_P_DATA[7]), .B1(n188), .B2(n206), 
        .ZN(n367) );
  XNOR2_X1 U392 ( .A(n368), .B(n367), .ZN(n369) );
  XOR2_X1 U393 ( .A(n369), .B(RX_P_DATA[2]), .Z(n371) );
  XNOR2_X1 U394 ( .A(RX_P_DATA[0]), .B(RX_P_DATA[1]), .ZN(n370) );
  XNOR2_X1 U395 ( .A(n371), .B(n370), .ZN(n372) );
  XNOR2_X1 U396 ( .A(n373), .B(n372), .ZN(n378) );
  NAND2_X1 U397 ( .A1(\u0_uart_rx/u0_uart_rx_fsm/current_state[0] ), .A2(n374), 
        .ZN(n377) );
  OAI21_X1 U398 ( .B1(n378), .B2(n382), .A(n375), .ZN(n376) );
  AOI211_X1 U399 ( .C1(n378), .C2(n382), .A(n377), .B(n376), .ZN(
        \u0_uart_rx/u0_parity_check/N10 ) );
  AND2_X1 U400 ( .A1(n379), .A2(n382), .ZN(\u0_uart_rx/u0_start_check/N4 ) );
  NOR3_X1 U401 ( .A1(n382), .A2(n381), .A3(n380), .ZN(
        \u0_uart_rx/u0_stop_check/N5 ) );
  NOR2_X1 U402 ( .A1(\u0_uart_tx/u_fsm/baud_cnt[0] ), .A2(n388), .ZN(
        \u0_uart_tx/u_fsm/N26 ) );
  AOI221_X1 U403 ( .B1(\u0_uart_tx/u_fsm/baud_cnt[1] ), .B2(
        \u0_uart_tx/u_fsm/baud_cnt[0] ), .C1(n203), .C2(n187), .A(n388), .ZN(
        \u0_uart_tx/u_fsm/N27 ) );
  NAND2_X1 U404 ( .A1(\u0_uart_tx/u_fsm/baud_cnt[1] ), .A2(
        \u0_uart_tx/u_fsm/baud_cnt[0] ), .ZN(n384) );
  NOR2_X1 U405 ( .A1(n200), .A2(n384), .ZN(n386) );
  AOI211_X1 U406 ( .C1(n200), .C2(n384), .A(n386), .B(n388), .ZN(
        \u0_uart_tx/u_fsm/N28 ) );
  INV_X1 U407 ( .A(n386), .ZN(n385) );
  AOI221_X1 U408 ( .B1(\u0_uart_tx/u_fsm/baud_cnt[3] ), .B2(n386), .C1(n204), 
        .C2(n385), .A(n388), .ZN(\u0_uart_tx/u_fsm/N29 ) );
  NAND2_X1 U409 ( .A1(\u0_uart_tx/u_fsm/baud_cnt[3] ), .A2(n386), .ZN(n387) );
  NOR2_X1 U410 ( .A1(n199), .A2(n387), .ZN(n390) );
  AOI211_X1 U411 ( .C1(n199), .C2(n387), .A(n390), .B(n388), .ZN(
        \u0_uart_tx/u_fsm/N30 ) );
  INV_X1 U412 ( .A(n390), .ZN(n389) );
  AOI221_X1 U413 ( .B1(\u0_uart_tx/u_fsm/baud_cnt[5] ), .B2(n390), .C1(n205), 
        .C2(n389), .A(n388), .ZN(\u0_uart_tx/u_fsm/N31 ) );
  NAND2_X1 U414 ( .A1(n399), .A2(TX_P_DATA[7]), .ZN(n391) );
  OAI21_X1 U415 ( .B1(n399), .B2(n211), .A(n391), .ZN(n18) );
  OAI21_X1 U416 ( .B1(n399), .B2(n210), .A(n392), .ZN(n19) );
  OAI21_X1 U417 ( .B1(n399), .B2(n207), .A(n393), .ZN(n20) );
  OAI21_X1 U418 ( .B1(n399), .B2(n212), .A(n394), .ZN(n21) );
  OAI21_X1 U419 ( .B1(n399), .B2(n208), .A(n395), .ZN(n22) );
  OAI21_X1 U420 ( .B1(n399), .B2(n213), .A(n396), .ZN(n23) );
  OAI21_X1 U421 ( .B1(n399), .B2(n209), .A(n397), .ZN(n24) );
  OAI21_X1 U422 ( .B1(n399), .B2(n214), .A(n398), .ZN(n25) );
endmodule


