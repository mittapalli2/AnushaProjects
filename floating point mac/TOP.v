`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2022 00:07:32
// Design Name: 
// Module Name: TOP
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


module TOP(Clock, Reset,SEG,AN,LED,PB);
    
    input Clock;
    input Reset;
    input PB;
    output [7:0] AN;
    output [7:0] SEG;
    output reg [15:0] LED;
    reg [15:0] val;
    reg CS,WE,OE;
    reg [3:0] Addr;
    reg [15:0] In;
    wire [15:0] Out;
    wire sclk;
    reg [1:0] cstate,nstate;
    reg we,re;
    //reg [15:0]din;
    wire [15:0]dout;
    wire f,e;
    wire [15:0]ACC_Result;
    
    //sfifo #(4,16) fifo (sclk,Reset,f,e,Out,dout,we,re);
    fpmac (dout,sclk,Reset,ACC_Result);
    sfifo fifo (sclk,Reset,we,Out,re,dout,f,e);
    Segment SEGM (Clock,Reset,val,AN,SEG);
    SRAM RAM (CS,WE,OE,In,Out,Addr);
    Clock_Div DIV (Clock, sclk);
    
    always @(posedge PB  or negedge Reset)
    begin
    if(Reset) begin  
    cstate <= 0;
    end
    else begin
    cstate <= nstate;
    end
    end
    
    always @ (*) begin
        case (cstate)
        0 : begin
        LED = 16'b0;
        val = 0;
        nstate = 1;
        end
        
        1: begin
        CS = 1'b0; WE = 1'b1; OE = 1'b0;
        LED = 16'd1;
        val = 16'hffff;
        nstate = 2;
        end
        
        2 : begin
        we =1;
        re = 0;
        LED = 16'd2;
        nstate = 3;
        val = Out;
        if(f) begin
        val = 16'h9999;
        end
        end
        3 : begin
        re =1;
        we =0;
        LED = 16'd3;
        val = dout;
        
        nstate = 0;
        if(e) begin
        val = ACC_Result;
        end
        end
        endcase 
        end
    always @(posedge sclk or negedge Reset) begin
    if(Reset) Addr <= 0;
    else if(cstate == 2) Addr <= Addr + 1;
    end
endmodule
