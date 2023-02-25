----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 01:39:54 PM
-- Design Name: 
-- Module Name: Emma_2 - Behavioral
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

entity Emma_2 is
    Port ( Clk : in STD_LOGIC;
           Btn : in STD_LOGIC_VECTOR (1 downto 0);
           AdrInstr : out STD_LOGIC_VECTOR (15 downto 0);
           Instruction : out STD_LOGIC_VECTOR (31 downto 0);
           Data : out STD_LOGIC_VECTOR (31 downto 0);
           ZeroFlag : out STD_LOGIC;
           NegFlag : out STD_LOGIC);
end Emma_2;

architecture Behavioral of Emma_2 is

--MPG
signal En : STD_LOGIC := '1'; 
signal Rst: STD_LOGIC := '0';

--IM
signal Address: STD_LOGIC_VECTOR (15 downto 0);
signal Instr: STD_LOGIC_VECTOR (31 downto 0) := (others=>'0');

--MU
signal InMPC: STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal InBus1_1, InBus2_1: STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');
signal Mc_out: STD_LOGIC_VECTOR (0 to 31) := (others=>'0'); --microcode

--MPC
signal AdrMc: STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

--DM
signal InBus1_3: STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');

--REG
signal RA1, RA2, WA: STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal InBus1_2, InBus2_2: STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');

--ALU
signal ACC: STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');
signal CC0, CC1: STD_LOGIC := '0';

--BUS
signal Bus1, Bus2: STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');

begin

--butoane pentru Rst si En
--MPG1: entity WORK.MPG port map (Clk, btn(0), En); 
--MPG2: entity WORK.MPG port map (Clk, btn(1), Rst);

IM: entity WORK.Instruction_memory port map (Address, Instr);

PC: entity WORK.PC port map (Clk, Rst, En, Mc_out(7), CC0, CC1, Mc_out(12 to 15), Bus2, Address);

MU: entity WORK.Microcode_Unit port map (Instr, Mc_out(0 to 7), AdrMc, WA, RA1, RA2, InBus1_1, InBus2_1, InMPC, Mc_out);

MPC: entity WORK.MPC port map (Clk, Rst, Mc_out(7), CC0, CC1, Mc_out(8 to 11), inMPC, AdrMc);

DM: entity WORK.Data_memory port map (Clk, Mc_out(20 to 23), Bus2, Bus1, InBus1_3);

REG: entity WORK.Registers port map (Clk, Mc_out(16 to 19), RA1, RA2, WA, ACC, InBus1_2, InBus2_2);

ALU: entity WORK.ALU port map (Bus1, Bus2, Mc_out(24 to 31), ACC, CC0, CC1);


 -- BUS1
B1: process(Clk, InBus1_1, InBus1_2, InBus1_3)
    begin
         if(Mc_out(1)='1') then
           Bus1 <= InBus1_1;
         elsif(Mc_out(18)='1') then
           Bus1 <= InBus1_2;  
         elsif(Mc_out(23)='1') then
           Bus1 <= InBus1_3;  
         end if;
    end process;
    
    -- BUS2
B2: process(Clk, InBus2_1, InBus2_2, ACC)
    begin
         if(Mc_out(0) = '1' or Mc_out(2) = '1') then
               Bus2 <= InBus2_1;
         elsif(Mc_out(19) = '1') then
           Bus2 <= InBus2_2;  
         elsif(Mc_out(27) = '1') then
           Bus2 <= ACC;  
         end if;
    end process;
    
--Output
    AdrInstr <= Address;
    Instruction <= Instr;
    Data <= x"0000" & ACC ;
    ZeroFlag <= CC0;
    NegFlag <= CC1;

end Behavioral;
