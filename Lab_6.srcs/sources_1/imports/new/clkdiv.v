`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2023 01:10:09 PM
// Design Name: 
// Module Name: clkdiv
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


module clkdiv(
    input clk,
    input reset,
    output rf_clk,
    output time_clk
);    

    reg refresh;
    reg time_clock;
    reg[16:0] rf;
    reg[30:0] COUNT;
    assign time_clk = time_clock;
    assign rf_clk = refresh;


always @(posedge clk)
    begin
        if(rf <100000)
            begin
                rf<= rf + 1;
            end
        else begin
            refresh <= ~refresh;
            rf <= 0;
        end
     end
     
always @(posedge clk)
    begin
        if(COUNT<1000000)
            begin
                COUNT <= COUNT + 1;
            end
        else begin
            time_clock <= ~time_clock;
            COUNT <= 0;
        end
     end  
endmodule
