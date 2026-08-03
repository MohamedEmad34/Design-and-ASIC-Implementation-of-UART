`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 10:57:27 AM
// Design Name: 
// Module Name: serializer
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


module serializer #(
    parameter WIDTH = 8,
    parameter CNT_WIDTH = 3
)(
    input  wire                  CLK,
    input  wire                  RST,

    input  wire                  load,
    input  wire                  shift_en,

    input  wire [WIDTH-1:0]      parallel_data,

    output wire                  serial_out,
    output                    ser_done 
);
reg [WIDTH-1:0] shift_reg;

reg [CNT_WIDTH-1:0] bit_cnt;

//Register
always @(posedge CLK or negedge RST)
begin
    if(!RST)
        shift_reg <= {WIDTH{1'b0}};

    else if(load)
        shift_reg <= parallel_data;

    else if(shift_en)
        shift_reg <= shift_reg >> 1;
end

//Counter
always @(posedge CLK or negedge RST)
begin
if(!RST||load)
bit_cnt<={CNT_WIDTH{1'b0}};
else if(shift_en&&!ser_done )
bit_cnt<=bit_cnt+1;

end
assign ser_done = shift_en && (bit_cnt == WIDTH-1);
assign serial_out=shift_reg[0];

endmodule
