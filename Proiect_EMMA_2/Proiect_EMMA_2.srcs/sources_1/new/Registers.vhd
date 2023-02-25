----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 12:57:41 PM
-- Design Name: 
-- Module Name: Registers - Behavioral
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

entity Registers is
    Port ( Clk : in STD_LOGIC;
           Mc : in STD_LOGIC_VECTOR (0 to 3);
           ReadAddress1 : in STD_LOGIC_VECTOR (3 downto 0);
           ReadAddress2 : in STD_LOGIC_VECTOR (3 downto 0);
           WriteAddress : in STD_LOGIC_VECTOR (3 downto 0);
           WriteData : in STD_LOGIC_VECTOR (15 downto 0);
           InBus1 : out STD_LOGIC_VECTOR (15 downto 0);
           InBus2 : out STD_LOGIC_VECTOR (15 downto 0));
end Registers;

architecture Behavioral of Registers is

type reg is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal reg_file : reg := (
    X"0000", X"0001", X"0002", X"0003",
    X"0004",X"0005",X"0006",X"0007",
    X"0008",X"0009",X"000A",X"000B",
    X"000C",X"000D",X"000E",X"000F",
    others => x"0000");

signal RegWrite: STD_LOGIC_VECTOR (0 to 1) := "00";
signal Out1, Out2: STD_LOGIC := '0';


begin

    RegWrite <= Mc(0 to 1);
    Out1 <= Mc(2);
    Out2 <= Mc(3);
    
    --read from reg
    InBus1 <= reg_file(conv_integer(ReadAddress1)) when Out1='1' else (others => '0'); --rs
    InBus2 <= reg_file(conv_integer(ReadAddress2)) when Out2='1' else (others => '0'); --rt
    
    --write in reg
    process(Clk)            
    begin
        if rising_edge(Clk) and RegWrite="01" then
            reg_file(conv_integer(WriteAddress)) <= WriteData;        
        end if;
    end process;    

end Behavioral;
