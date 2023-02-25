----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2022 09:38:42 AM
-- Design Name: 
-- Module Name: Instruction_memory - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_memory is
    Port ( Address : in STD_LOGIC_VECTOR (15 downto 0); --adresa este pe 16 biti 
           Instruction : out STD_LOGIC_VECTOR (31 downto 0)); --instructiunile sunt pe 32 de biti
end Instruction_memory;

architecture Behavioral of Instruction_memory is

type Rom_type is array(0 to 255) of STD_LOGIC_VECTOR (31 downto 0);
signal ROM : Rom_type := (
    b"00001001_0011_0001_0010_0000_0000_0000", --add $3,$1,$2
    b"00001001_0100_0000_0001_0000_0000_0000", --add $4,$1,$0
    b"00000000_0000_0000_0000_0000_0000_0100", --jump 4
    b"00001001_0100_0001_0010_0000_0000_0000", --add $4,$1,$2
    --b"00000010_0000_0011_0000_0000_0000_0011", --bqez $3 Literal
    b"00001011_0111_0001_0100_0000_0000_0000", --sub $7,$4,$1
    b"00001001_0100_0000_0001_0000_0000_0000", --add $4,$1,$0
    b"00001101_0111_0010_0001_0000_0000_0000", --and $7 $2 $1 
    b"00001001_0011_0001_0010_0000_0000_0000", --add $3,$1,$2
    b"00001001_0100_0000_0001_0000_0000_0000", --add $4,$1,$0
    b"00000111_0000_0011_0000_0000_0000_0000", --store $3 6(Address) --9
    --b"00000100_1001_0000_0000_0000_0000_0000", --ld $9 6(Address) --10
    --b"00000100_1001_0000_0000_0000_0000_0000", --ld $9 6(Address) --11
    others => x"0000_0000"); 

begin

Instruction <= ROM(conv_integer(Address));

end Behavioral;
