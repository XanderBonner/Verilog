`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2023 12:51:43 PM
// Design Name: 
// Module Name: mode_1
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


module mode_1(
    input clk,
    input reset,
    output reg[3:0] an,
    output reg[6:0] sseg
    );
    
    reg[18:0] ms_count;         //coiunter for generating 1 millisecond
    wire ms_enable;             //one second enabled for counting number
    reg[8:0] display_Num;       //display
    reg[3:0] LED_BCD;
    reg[20:0] refresh_Count;    //the first 19-bit for creating 190hz refresh rate
                                //the other 2-bit for vreating 4 led-activiating signals
    wire [1:0] LED_activating_Counter;
        //count 0  ->  1  ->  2  ->  3
   //activates LED0  LED1   LED3   LED4
    //and repeat
    
    //Slow 100Mhz clock in order to replicate time
    always @(posedge clk or posedge reset)
    begin
        if(reset==1)
            ms_count <= 0;
        else begin
            if(ms_count>=999999)
                ms_count <= 0;
            else
                ms_count <= ms_count + 1;
        end
     end
     
     
    assign ms_enable = (ms_count==999999)?1:0;
    
    always @(posedge clk or posedge reset)
    begin
        if(reset==1)
            display_Num <= 0;
        else if(ms_enable==1)
            display_Num <= display_Num + 1;
    end
    
    
    always @(posedge clk or posedge reset)
    begin
        if(reset==1)
            refresh_Count <= 0;
        else
            refresh_Count <= refresh_Count + 1;
    end
    
    assign LED_activating_counter = refresh_Count[20:19];
    
    //anode acitivating signals for 4 LED's
    //decoder to generate anode signals
    always @(*)
    begin
        case(LED_activating_counter)
            2'b00: begin
                an = 4'b0111;
                //activate LED1 and Deactive LED2, LED3, LED4
                LED_BCD = display_Num/1000;
                //the first digit of the 16-bit number
                end
            2'b01: begin
                an = 4'b1011;
                //activate LED2 and Deactive LED1, LED3, LED4
                LED_BCD = (display_Num % 1000)/100;
                //the second digit of the 16-bit number
                end
            2'b10: begin
                an = 4'b1101;
                LED_BCD = ((display_Num % 1000)%100)/10;
                end
            2'b11: begin
                an = 4'b1110;
                LED_BCD = ((display_Num % 1000)%100)%10;
                end
            endcase
      end
      
    //cathode patterns of the 7-segemtn LED display
    always @(*)
    begin
        case(LED_BCD)
            4'b0000: sseg = 7'b0000001; //0
            4'b0001: sseg = 7'b1001111; //1
            4'b0010: sseg = 7'b0010010; //2
            4'b0011: sseg = 7'b0000110; //3
            4'b0100: sseg = 7'b1001100; //4
            4'b0101: sseg = 7'b0100100; //5
            4'b0110: sseg = 7'b0100000; //6
            4'b0111: sseg = 7'b0001111; //7
            4'b1000: sseg = 7'b0000000; //8
            4'b1001: sseg = 7'b0000100; //9
            default: sseg = 7'b0000001; //0
            endcase
        end
endmodule
