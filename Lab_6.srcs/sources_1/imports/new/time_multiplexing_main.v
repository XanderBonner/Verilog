`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2023 01:36:52 PM
// Design Name: 
// Module Name: time_multiplexing_main
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


module time_multiplexing_main(
    input clk,
    input reset,
    input Start_Stop,
    input [7:0] sw,
    input [1:0] mode,
    output [6:0] sseg,
    output [3:0] an
    );
    
    wire [6:0] in0, in1, in2, in3;
    wire rf_clk;
    wire time_clk;
    wire[3:0] display_0;    //least sig fig or right most
    wire[3:0] display_1;
    wire[3:0] display_2;
    wire[3:0] display_3;    //most sig or left most
    
    //Module Instantiation of hexto7segment module
    hexto7segment c1 (.x(display_0), .r(in0));
    hexto7segment c2 (.x(display_1), .r(in1));
    hexto7segment c3 (.x(display_2), .r(in2));
    hexto7segment c4 (.x(display_3), .r(in3));
    
    //Module instantiation of the clock divider
    clkdiv c5 (.clk(clk), .reset(reset), .rf_clk(rf_clk), .time_clk(time_clk));
    
    
    //Module instatiation of the Stopwatch_Timer
    Stopwatch_Timer c7(
        .clk(time_clk),
        .Start_Stop(Start_Stop),
        .reset(reset),
        .mode(mode),
        .sw(sw),
        .display_0(display_0),
        .display_1(display_1),
        .display_2(display_2),
        .display_3(display_3)
        );
    
    
    //Module instantiation of the multiplexer
    time_mux_state_machine c6(
        .clk(rf_clk),
        .reset(reset),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .an(an),
        .sseg(sseg));

endmodule
