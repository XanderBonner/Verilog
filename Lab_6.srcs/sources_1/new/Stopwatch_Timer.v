`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2023 01:04:18 PM
// Design Name: 
// Module Name: Stopwatch_Timer
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


module Stopwatch_Timer(
input reset,
input clk,
input Start_Stop,
input[7:0] sw,
input[1:0] mode,
output reg[3:0] display_3, //left digit
output reg[3:0] display_2, //mid left
output reg[3:0] display_1, //mid right
output reg[3:0] display_0, //right digit
output dp
);

reg Start_Stop_grab;        //captures vaule of Start_Stop
reg strstp = 1;             //register that controls Start_Stop
reg done;                   //flag used to indicate stopwatch has stop counting
reg idle = 1;               //flag used for idle state

assign dp = 1'b0;

always @(posedge clk) begin         //captures Start_Stop signal on falling edge 
    Start_Stop_grab <= Start_Stop;
    if(Start_Stop_grab && !Start_Stop)
        strstp<=~strstp;
end

always @ (posedge clk) begin

//Mode 1//
    if(mode == 2'b00) begin
        if(strstp == 1 && reset == 1)   //when both strstp and reset is high than we need to reset counters
            begin   
                display_0<=0;      //counter 0
                display_1<=0;      //counter 0
                display_2<=0;      //counter 0
                display_3<=0;      //counter 0
                done = 0;
            end
            
            //if strstp is high and reset is not zero than we need to store the current count 
            else if(strstp == 1 && reset!= 0)
                begin
                display_0<=0;      //display 0 stored
                display_1<=0;      //display 1 stored
                display_2<=0;      //display 2 stored
                display_3<=0;      //display 3 stored
                end
            
         //if srtstp is not high and done is not high than we need to increment the counters, which involves carry-over for each digit
            else if(~strstp && ~done)  //checks to see if stopwatch has stop, if not than the count is not complete
                begin
                    if(display_0 == 9) begin        //start from least signicant digit to most, so display_0 needs to be counted from 0-9
                        display_0 <= 0;             //if we hit 0 than we need to move onto display 1 since we've carried over.
                        if(display_1 == 9) begin    //move to next digit, or second sig, count until 9
                            display_1 <= 0;         //if we hit 0 than we have carried over, trigger display_2
                                if(display_2 == 9) begin    //move to next digit, or third sig
                                    display_2 <= 0;         //if we hit 0, than we have carried over, trigger display_3
                                        if(display_3 == 9) begin    //count until we have hit 9, once we hit 9 than we have hit the limit allowed by our counter so all digits carry over to 0.
                                        display_2 <= 9;
                                        display_1 <= 9;
                                        display_0 <= 9;
                                        done = 1;       //flag saying we've hit roll over
                                        end else
                                            display_3 <= display_3 + 1;     //increment
                                    end else
                                        display_2 <= display_2 + 1;         //increment
                                end else
                                    display_1 <= display_1 + 1;             //increment
                             end else
                                display_0 <= display_0 + 1;                 //increment
                            end
                       end
                

 //Mode 2//
    else if(mode == 2'b01) begin
        if(strstp == 1 && reset == 0 && idle == 1)   //if strstp and idle are high and reset is low than reset display 0 & 1 to zero and then display 2 & 3 to swithces 
            begin   
                display_0<=0;      //counter is 0
                display_1<=0;      //counter is 0
                display_2<=sw[3:0];      //counter is 0
                display_3<=sw[7:4];      //counter is 0
                done = 0;
            end
            
         //if strstp is high and reset is high than store the current count into the displays 
         if(strstp == 1 && reset == 1)
            begin
                //now we need to store the current count
                display_0<=0;      //display 0 counter is now stored
                display_1<=0;      //1 counter is now stored
                display_2<=sw[3:0];      //2 counter is now stored
                display_3<=sw[7:4];      //3 counter is now stored
                done = 0;     //not finished
                idle = 1;     //stopwatch is in idle state and not currenly counting
                end
          
          //if strstp is high and reset is not zero than we are idling but not activley counting so we need to store the current state into displays 
          else if(strstp == 1 && reset != 0)
            begin
                display_0<= display_0;      //store current state
                display_1<= display_1;      //store current state
                display_2<= display_2;      //store current state  
                display_3<= display_3;      //store current state
                idle = 1;
            end
             
         //if the strstp is not high and the reset is also not high than we need to start the stopwatch and increment counters
            else if(strstp != 1 && reset != 1)
                begin
                idle = 0;   //set idle to zero because we are currently counting
                    if(display_0 == 9) begin            //start incrementing counter until we get to 9 
                        display_0 <= 0;                 //if we get to 0 then we have rolled over and we need to set display to zero and initiate next sig fig
                        if(display_1 == 9) begin        //start incrementing counter until we get to 9
                            display_1 <= 0;             //we got to 0 so we have rolled over, set to 0 and move to next sig fig
                                if(display_2 == 9) begin    //start incrementing counter
                                    display_2 <= 0;         //carried over, set to 0 and move to next
                                        if(display_3 == 9) begin        //if display_3 is set to 9 than we have reached the end and we can set all to 9999 to show we've reached the end
                                        display_2 <= 9;                 //set to 9
                                        display_1 <= 9;                 //set to 9
                                        display_0 <= 9;                 //set to 9
                                        done = 1;              //if we get to 9999 than we have reached the end and the done flag can be set 1
                                        end else
                                            display_3 <= display_3 + 1; //increment most sig fig
                                    end else
                                        display_2 <= display_2 + 1;     //increment display 2
                                end else
                                    display_1 <= display_1 + 1;         //increment display 1
                             end else
                                display_0 <= display_0 + 1;             //increment display 0 or least sig fig
                            end
                       end      

//Mode 3//
else if(mode == 2'b10) begin
    if(strstp == 1 && reset == 1)       //if both strstp and rest are high than set all displays to 9
        begin
            display_0<=9;      //display 0 set to 9
            display_1<=9;      //display 1 set to 9
            display_2<=9;      //display 2 set to 9
            display_3<=9;      //display 3 set to 9
        end 
        
     else if(strstp == 1 && reset!= 0)  //if strstp is set to high and reset is not zero than store current count
        begin
            //store current count
            display_0 <= display_0;     //display 0 is stored to current vaule
            display_1 <= display_1;     //display 1 is stored to current vaule
            display_2 <= display_2;     //display 2 is stored to current vaule
            display_3 <= display_3;     //display 3 is stored to current vaule    
        end
        
    else if(strstp != 1 && done == 0)   //if strstp is not set to high and done is 0 than we need to decrement counters and start counting down
    begin
        
        if(display_0 == 0) begin        //start decrementing display counter until we hit 0
            display_0 <= 9;             //if we have hit 9 than we have carried over and we can move onto next sig fig
            if(display_1 == 0) begin    //decrement counter until 0
                display_1 <= 9;         //if we hit 9 than we have carried over and move on to next fig
                    if(display_2 == 0) begin        // start decrementing until 0
                        display_2 <= 9;             //carry over ocurred now move onto next sig fig
                        if(display_3 == 0)begin     //start decrementing final sig fig, if we hit 0 than we have hit the end of 0000 
                            display_0 <= 0;         //set to 0, end
                            display_1 <= 0;         //set to 0, end
                            display_2 <= 0;         //set to 0, end
                            display_3 <= 0;         //set to 0, end
                            done = 1;               //set done flag to 0
                        end else
                        display_3 <= display_3 - 1; //decrement counter
                    end else
                    display_2 <= display_2 - 1;     //decrement counter
                 end else
                 display_1 <= display_1 -1; //decrement counter
              end else      
              display_0 <= display_0 - 1;  //decrement counter
              end
        end
        
//Mode 4//
else if(mode == 2'b11) begin
    if(strstp == 1 && reset == 0 && idle == 1) begin    //if strstp is high and idle is high and reset is 0 than reset counters to begin
        display_0 <= 0;     //set display 0 to 0
        display_1 <= 0;     //set display 1 to 0
        display_2 <= sw[3:0];   //set display 2 to switches 3:0
        display_3 <= sw[7:4];   //set display 3 to swtiches 3:0
    end
    else if(strstp == 1 && reset != 0) begin    //if strstp is high and reset is not 0 than store current count because we are idling
        //store previous count
        display_0 <= display_0;     //store display 0
        display_1 <= display_1;     //store display 1
        display_2 <= display_2;     //store display 2
        display_3 <= display_3;     //store display 3
        idle = 1;       //set idle to high because we still counting but not currently counting
    end
    
        else if(strstp != 1 && done == 0)   //if strstp is not set to high and done is 0 than we need to decrement counters and start counting down
    begin  
        if(display_0 == 0) begin        //start decrementing display counter until we hit 0
            display_0 <= 9;             //if we have hit 9 than we have carried over and we can move onto next sig fig
            if(display_1 == 0) begin    //decrement counter until 0
                display_1 <= 9;         //if we hit 9 than we have carried over and move on to next fig
                    if(display_2 == 0) begin        // start decrementing until 0
                        display_2 <= 9;             //carry over ocurred now move onto next sig fig
                        if(display_3 == 0)begin     //start decrementing final sig fig, if we hit 0 than we have hit the end of 0000 
                            display_0 <= 0;         //set to 0, end
                            display_1 <= 0;         //set to 0, end
                            display_2 <= 0;         //set to 0, end
                            display_3 <= 0;         //set to 0, end
                            done = 1;               //set done flag to 0
                        end else
                        display_3 <= display_3 - 1; //decrement counter
                    end else
                    display_2 <= display_2 - 1;     //decrement counter
                 end else
                 display_1 <= display_1 -1; //decrement counter
              end else      
              display_0 <= display_0 - 1;  //decrement counter
              end
        end
    end    

endmodule
