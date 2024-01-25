`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2023 01:16:30 PM
// Design Name: 
// Module Name: timer
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


module timer(
    input clk,
    input reset,
    output reg[3:0] display_0,
    output reg[3:0] display_1,
    output reg[3:0] display_2,
    output reg[3:0] display_3
    );
    
    reg[8:0] counter = 1'd9999;         //this puts the counter to 9999 so when the timer is called we will have the inital vaule
    reg Start_Stop;
    
    always @(*) begin
        if(Start_Stop == 1 && reset == 1)   //if both the Start_Stop and Reset are high than we can store 9's since we have not started yet
            begin
                display_0 <= 1'd9;
                display_1 <= 1'd9;
                display_2 <= 1'd9;
                display_3 <= 1'd9;
            end
            else if(Start_Stop == 1)        //if start_Stop is high than stop the count and store the current values
            begin
                display_0 <= display_0;
                display_1 <= display_1;
                display_2 <= display_2;
                display_3 <= display_3;
            end
            else if(Start_Stop != 1)    //if start_stop is not high than we can start/continue the countdown timer and begin counting
            begin
                if(display_0 == 9)      //display 0 is set to 9, start decrementing
                    begin
                        display_0 <= 0; //if we hit 0 than a carry over has occurred and we can start the next sig fig
                        if(display_1 == 9)  //display_ 1 is set to 9, start decrementing
                            begin
                            display_1 <= 0; //display_1 has hit 0 so a carry over has occured, again start decrementing next sig fig
                            if(display_2 == 9)      //display_2 has been initiated so start decrementing
                                begin       
                                display_2 <= 0;     //display_2 has hit zero, therefore start decrementing next sig fig
                                if(display_3 == 9) //start decremeting counter 
                                    display_3 <= 0; //zero has hit therefore we have hit the end
                                    else
                                    display_3 <= display_3 -1;      //decrement
                            end else
                              display_2 <= display_2 -1;        //decrement
                         end else
                            display_1 <= display_1 -1;      //decrement
                     end else   
                        display_0 <= display_0 -1;      //decrement
              end
          end                  
endmodule
