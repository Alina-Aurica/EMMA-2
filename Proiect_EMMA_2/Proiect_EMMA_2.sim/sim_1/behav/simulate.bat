@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim Emma_2_tb_behav -key {Behavioral:sim_1:Functional:Emma_2_tb} -tclbatch Emma_2_tb.tcl -view D:/Facultate/ANUL 3/ANUL 3 - Semestrul 1/SSC/Proiect/Proiect_EMMA_2/Emma_2_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
