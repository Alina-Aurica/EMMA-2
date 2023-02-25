----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 09:16:00 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is -- pe GIT foloseste si un Clk
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(15 downto 0);
           Mc : in STD_LOGIC_VECTOR(0 to 7);
           Accumulator : out STD_LOGIC_VECTOR(15 downto 0);
           CC0 : out STD_LOGIC;
           CC1 : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal func: STD_LOGIC_VECTOR(0 to 3);
signal ALURez : STD_LOGIC_VECTOR(15 downto 0);

begin

func <= Mc(4 to 7);

process(func, A, B, ALURez)
begin
    case func is
        when "0000" => ALURez <= A + B; -- add
        when "0001" => ALURez <= A - B; -- sub
        when "0010" => ALURez <= A and B; -- and
        when "0011" => ALURez <= A or B; -- or
        when "0100" => ALURez <= A xor B; -- xor
        when "0101" => ALURez <= B(14 downto 0) & '0'; -- sll B
        when "0110" => ALURez <= '0' & B(15 downto 1); -- srl B
        when "0111" => ALURez <= B(0) & B(15 downto 1); -- sra B
        when "1000" => ALURez <= A; -- load
        when others => ALURez <= (others => '0');
     end case;
     
      -- rez = 0
     case ALURez is
        when X"0000" => CC0 <= '1';
        when others => CC0 <= '0';
     end case;
        
        -- rez < 0
     case ALURez(15) is
        when '1' => CC1 <= '1';
        when '0' => CC1 <= '0';
        when others => CC1 <= '0';
     end case;
     
end process;

Accumulator <= ALURez;

end Behavioral;
