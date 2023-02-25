----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2022 08:06:50 AM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is

signal A : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal B : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal Mc : STD_LOGIC_VECTOR(0 to 7) := x"00";
signal Accumulator : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal CC0 : STD_LOGIC := '0';
signal CC1 : STD_LOGIC := '0';

begin

DUT: entity WORK.ALU port map (A, B, Mc, Accumulator, CC0, CC1);

gen_vect_test: 
   process
		--variable VecTest1 : STD_LOGIC_VECTOR(15 downto 0); -- vector de test
 		--variable VecTest2 : STD_LOGIC_VECTOR(15 downto 0);
 		variable RezCorect : STD_LOGIC_VECTOR(17 downto 0);
 		variable NrErori : INTEGER := 0; 
	begin
        wait for 100 ns;
            A <= CONV_STD_LOGIC_VECTOR(4, 16);
            B <= CONV_STD_LOGIC_VECTOR(8, 16);
            Mc(4 to 7) <= "0001";
        wait for 10 ns;
--            A <=  x"1234";
--            B <= x"5654";
--            Mc(5 to 7) <= "001";
--        wait for 10 ns;
       
        RezCorect := "0" & "0" & CONV_STD_LOGIC_VECTOR(12, 16);
                         
        if((CC0 & CC1 & Accumulator) /= RezCorect) then
             report "Rezultat asteptat (" & 
             STD_LOGIC'image (RezCorect(17)) &
             STD_LOGIC'image (RezCorect(16)) &
             STD_LOGIC'image (RezCorect(15)) &
             STD_LOGIC'image (RezCorect(14)) &
             STD_LOGIC'image (RezCorect(13)) &
             STD_LOGIC'image (RezCorect(12)) &
             STD_LOGIC'image (RezCorect(11)) &
             STD_LOGIC'image (RezCorect(10)) &
             STD_LOGIC'image (RezCorect(9)) &
             STD_LOGIC'image (RezCorect(8)) &
             STD_LOGIC'image (RezCorect(7)) &
             STD_LOGIC'image (RezCorect(6)) &
             STD_LOGIC'image (RezCorect(5)) &
             STD_LOGIC'image (RezCorect(4)) &
             STD_LOGIC'image (RezCorect(3)) &             
             STD_LOGIC'image (RezCorect(2)) &
             STD_LOGIC'image (RezCorect(1)) &
             STD_LOGIC'image (RezCorect(0)) &
             ") /= Valoare obtinuta (" &
             STD_LOGIC'image (CC0) & 
             STD_LOGIC'image (CC1) & 
             STD_LOGIC'image (Accumulator(15)) & 
             STD_LOGIC'image (Accumulator(14)) & 
             STD_LOGIC'image (Accumulator(13)) & 
             STD_LOGIC'image (Accumulator(12)) & 
             STD_LOGIC'image (Accumulator(11)) & 
             STD_LOGIC'image (Accumulator(10)) & 
             STD_LOGIC'image (Accumulator(9)) & 
             STD_LOGIC'image (Accumulator(8)) & 
             STD_LOGIC'image (Accumulator(7)) & 
             STD_LOGIC'image (Accumulator(6)) & 
             STD_LOGIC'image (Accumulator(5)) & 
             STD_LOGIC'image (Accumulator(4)) & 
             STD_LOGIC'image (Accumulator(3)) & 
             STD_LOGIC'image (Accumulator(2)) & 
             STD_LOGIC'image (Accumulator(1)) & 
             STD_LOGIC'image (Accumulator(0)) & 
             ") la t = " & TIME'image (now)
             severity ERROR;
             NrErori := NrErori + 1;
		end if;
		wait for 10 ns;
		
		report "Testare terminata cu " &
        INTEGER'image (NrErori) & " erori";
        wait;
end process;




end Behavioral;
