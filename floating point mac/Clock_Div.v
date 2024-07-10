`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2022 00:09:48
// Design Name: 
// Module Name: Clock_Div
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


module Clock_Div(input clk, output reg sclk);
reg [32:0] clk_counter;

always @(posedge clk) begin 
    if (clk_counter == 25000000) 
        begin 
		  clk_counter <= 0;
		  sclk <= ~sclk; 
	    end else  
		  clk_counter <= clk_counter+1;
    end
endmodule

