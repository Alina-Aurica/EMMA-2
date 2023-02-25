----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 11:37:13 PM
-- Design Name: 
-- Module Name: Emma_2_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Emma_2_tb is
--  Port ( );
end Emma_2_tb;

architecture Behavioral of Emma_2_tb is

signal Clk : STD_LOGIC := '0';
signal Btn : STD_LOGIC_VECTOR (1 downto 0) := "00";
signal AdrInstr : STD_LOGIC_VECTOR (15 downto 0 ):= (others=>'0');
signal Instruction :  STD_LOGIC_VECTOR (31 downto 0) := (others=>'0');
signal Data : STD_LOGIC_VECTOR (31 downto 0) := (others=>'0');
signal ZeroFlag, NegFlag : STD_LOGIC:='0';

constant CLK_PERIOD : TIME := 10 ns;

begin

DUT: entity WORK.Emma_2 port map (Clk, Btn, AdrInstr, Instruction, Data, ZeroFlag, NegFlag);

gen_clk: 
    process
    begin
        Clk <= '0';
        wait for (CLK_PERIOD/2);
        
        Clk <= '1';
        wait for (CLK_PERIOD/2);
    end process gen_clk; 

    
gen_vect_test: 
    process 
    begin
        --wait for 100 ns;
        
        --Btn <= "10";
        --wait for CLK_PERIOD;
        
        Btn <= "01";
        wait for CLK_PERIOD;
        
        wait;
    end process;



end Behavioral;
