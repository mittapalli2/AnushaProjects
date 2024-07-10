`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 00:16:39
// Design Name: 
// Module Name: sfifo
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

module sfifo  (clk,rstn,wren,wrdata,rden,rddata,full,empty);
    
    parameter WIDTH = 16,PTR = 4,DEPTH = 16;
    input clk,rstn;
    input wren;
    input [WIDTH-1 : 0] wrdata;
    input rden;
    output [WIDTH-1 :0] rddata;
    output full;
    output empty;
    
    reg [PTR-1 : 0] wrptr;
    reg [PTR-1 : 0] rdptr;
    reg [DEPTH-1 : 0] entry_status;
    reg [WIDTH-1 :0] rddata;
    reg [WIDTH -1 :0 ] fifo [0:DEPTH-1];
    
    assign full = (entry_status == DEPTH);
    assign empty = (entry_status == 0);
    
//Write pointer control 
    always @(posedge clk or negedge rstn) begin
        if(rstn) wrptr <= 0;
            
        else begin
            if(wren) begin
                if(wrptr == DEPTH-1) wrptr <= 0;
                else wrptr <= wrptr + 1;
            end
        end
    end
 // Read pointer control
    always @(posedge clk or negedge rstn) begin
        if(rstn) rdptr <= 0;
        else begin
            if(rden) begin
                if(rdptr == DEPTH-1) rdptr <= 0;
                else rdptr <= rdptr + 1;
            end
        end
    end
 // Writing data into FIFO
 
    always @(posedge clk) begin
    
        if(wren & full ==0) fifo[wrptr] <= wrdata;
    
    end
 //Reading FIFO data   
    always @(posedge clk) begin
    
        if(rden & empty == 0) rddata <= fifo[rdptr];
    
    end
 
 // Calculationg FIFO full and empty locations   
    always @(posedge clk or negedge rstn) begin
        if(rstn) entry_status <= 0;
        else begin
            if(rden & !wren & entry_status != 0) entry_status <= entry_status - 1'b1;
            else if (!rden & wren & entry_status != DEPTH) entry_status <= entry_status + 1'b1;
        end
    end
endmodule
