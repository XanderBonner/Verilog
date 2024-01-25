@echo off
REM ****************************************************************************
REM Vivado (TM) v2023.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Wed Nov 29 16:28:23 -0600 2023
REM SW Build 3865809 on Sun May  7 15:05:29 MDT 2023
REM
REM IP Build 3864474 on Sun May  7 20:36:21 MDT 2023
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim time_multiplexing_main_behav -key {Behavioral:sim_1:Functional:time_multiplexing_main} -tclbatch time_multiplexing_main.tcl -log simulate.log"
call xsim  time_multiplexing_main_behav -key {Behavioral:sim_1:Functional:time_multiplexing_main} -tclbatch time_multiplexing_main.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
