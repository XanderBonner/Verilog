`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2023 12:47:19 PM
// Design Name: 
// Module Name: stopwatch
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


module stopwatch(
    input reset,
    input slow_clk,
    input start_Stop,
    output reg[3:0] d3, //fourth digit or most left legit
    output reg[3:0] d2, //third digit
    output reg[3:0] d1, //second digit
    output reg[3:0] d0 //right digit
    );
    
    reg button;
    // reg star_Stop;
    // reg reset;
    
    
endmodule
