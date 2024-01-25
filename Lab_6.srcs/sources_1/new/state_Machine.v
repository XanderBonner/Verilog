`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2023 01:17:14 PM
// Design Name: 
// Module Name: state_Machine
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


module state_Machine(
    input clk,
    input [1:0] mode,
    output [1:0] state
    );
    
    reg[1:0] state;
    reg[1:0] next;
    
//    always @(*) begin
//    if (mode == 2'b00)
//        next = 2'b00;
//    if(mode == 2'b01)
//        next = 2'b01;
//    if(mode == 2'b10)
//        next = 2'b10;
//    if(mode == 2'b11)
//        next = 2'b11;

//        case(state)
//            2'b00: next = 2'b01;
//            2'b01: next = 2'b10;
//            2'b10: next = 2'b11;
//            2'b11: next = 2'b00;
//         endcase
//    end
    
    always @(posedge clk) begin
        state <= mode;
    end
    
endmodule
