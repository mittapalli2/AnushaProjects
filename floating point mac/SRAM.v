`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2022 23:39:50
// Design Name: 
// Module Name: SRAM
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


module SRAM(CS,WE,OE,In,Out,Addr);

input CS,WE,OE;
input [15:0] In;
output [15:0] Out;
input [3:0] Addr;

reg [15:0] mem [15:0];

initial begin
mem[0] = 16'h0000;
    mem[1] = 16'h3c00;
    mem[2] = 16'h4000;
    mem[3] = 16'h4200;
    mem[4] = 16'h4400;
    mem[5] = 16'h4500;
    mem[6] = 16'h4600;
    mem[7] = 16'h4700;
    mem[8] = 16'h4800;
    mem[9] = 16'h4880;
    mem[10] = 16'h4900;
    mem[11] = 16'h4980;
    mem[12] = 16'h4a00;
    mem[13] = 16'h4a80;
    mem[14] = 16'h4b00;
    mem[15] = 16'h4b80;

end

assign Out = (!CS && WE && !OE)? mem[Addr] : 16'b0;

always @(*) begin

if(!CS && !WE && OE) mem[Addr] = In;

end
endmodule
