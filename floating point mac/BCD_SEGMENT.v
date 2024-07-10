`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2022 00:07:00
// Design Name: 
// Module Name: BCD_SEGMENT
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

module BCD_SEGMENT(input [3:0]value , output reg [7:0]display);
 always @(value) begin
	case(value)
	0 : display = 8'hC0;
	1 : display = 8'hF9;
	2 : display = 8'hA4;
	3 : display = 8'hB0;
	4 : display = 8'h99;
	5 : display = 8'h92;
	6 : display = 8'h82;
	7 : display = 8'hF8;
	8 : display = 8'h80;
	9 : display = 8'h90;
	10 : display = 8'h88;
	11 : display = 8'h83;
	12 : display = 8'hC6;
	13 : display = 8'hA1;
	14:  display = 8'h86;
	15 : display = 8'hBE;
	default display = 8'hFF;
	endcase
 end
endmodule
