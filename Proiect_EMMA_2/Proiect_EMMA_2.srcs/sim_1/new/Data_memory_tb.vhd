----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 10:52:41 PM
-- Design Name: 
-- Module Name: Data_memory_tb - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Data_memory_tb is
--  Port ( );
end Data_memory_tb;

architecture Behavioral of Data_memory_tb is

signal Clk : STD_LOGIC := '0';
signal Mc : STD_LOGIC_VECTOR(0 to 3) := (others => '0');
signal MAR_in : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal MBR_in : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal MBR_out : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

constant CLK_PERIOD : TIME := 10 ns;

begin

DUT: entity WORK.Data_memory port map (Clk, Mc, MAR_in, MBR_in, MBR_out);

gen_clk: process
         begin
           Clk <= '0';
           wait for (CLK_PERIOD/2);
           Clk <= '1';
           wait for (CLK_PERIOD/2);
        end process gen_clk; 

    
gen_vect_test: 
process 
begin
        --scriere
        Mc <= "0111";
        for i in 0 to 15 loop
           MAR_in <= conv_std_logic_vector(i,16);
           MBR_in <= conv_std_logic_vector(i,16);
           wait for CLK_PERIOD;
        end loop;
        
        --citire
        Mc <= "1001";
        for i in 0 to 15 loop
            MAR_in <= conv_std_logic_vector(i,16);
            wait for CLK_PERIOD;
        end loop;
        
        wait;
end process;



end Behavioral;
