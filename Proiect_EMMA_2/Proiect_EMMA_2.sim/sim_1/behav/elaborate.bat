@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 20d01fe14f6f4a63a58e22855fd108d7 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Emma_2_tb_behav xil_defaultlib.Emma_2_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
