----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 01:08:49 PM
-- Design Name: 
-- Module Name: Microcode_Unit - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Microcode_Unit is
    Port ( IR : in STD_LOGIC_VECTOR (31 downto 0); --instruction reg, intrare de la IM
           Mc : in STD_LOGIC_VECTOR (0 to 7);
           AdrMC : in STD_LOGIC_VECTOR (7 downto 0);
           AdrD : out STD_LOGIC_VECTOR (3 downto 0);
           AdrSA : out STD_LOGIC_VECTOR (3 downto 0); --pentru A
           AdrSB : out STD_LOGIC_VECTOR (3 downto 0); --pentru B
           InBus1 : out STD_LOGIC_VECTOR (15 downto 0); --iesiri catre
           InBus2 : out STD_LOGIC_VECTOR (15 downto 0); --bus1 si bus2
           InMPC : out STD_LOGIC_VECTOR (7 downto 0); --intrarea in MPC
           Micro: out STD_LOGIC_VECTOR (31 downto 0)); --codul instructiunii
end Microcode_Unit;

architecture Behavioral of Microcode_Unit is

--microcode memory
type mem_type is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
signal Mc_memory : mem_type := (

    x"2003_0000", --0 JUMP
    x"0000_0000", --1 JREG
    x"210B_2001", --2 BEQZ
    x"1030_0000", --3 BNEG
    x"800D_4908", --4 LD
    x"0000_0000", --5 LDL
    x"0000_0000", --6 LDX
    x"800D_2700", --7 ST
    x"0000_0000", --8 STX
    x"000D_7000", --9 ADD
    x"0000_0000", --10 ADDL
    x"000D_7001", --11 SUB
    x"0000_0000", --12 SUBL
    x"000D_7002", --13 ANDD
    
    others => X"0000_0000");

--toate tipurile de op pe care le poate efectua
type op is (JUMP, JREG, BEQZ, BNEG, LD, LDL, LDX, ST, STX , ADD, ADDL, 
 SUB, SUBL, ANDD, ANDL, ORR, ORL, XORR, XORL, SLLS, SLLL, SRLS, SRLL,
 SRAA, SRAL, MUL, MULL, DIV, DIVL, OP1, OP2, STOP); 
 
signal stare : op := JUMP;

signal toBus1, toBus2, toMPC, toBus2Address : STD_LOGIC :='0';
signal Immediate : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0'); --instructiuni tip I
signal Address : STD_LOGIC_VECTOR(7 downto 0):= (others =>'0'); 

begin

    AdrD <= IR(23 downto 20); --WA (registru destinatie)
    AdrSA <= IR(19 downto 16); --RA1 
    AdrSB <= IR(15 downto 12); --RA2
    Immediate <= IR(15 downto 0);

    toBus2Address <= Mc(0);
    toBus1 <= Mc(1);
    toBus2 <= Mc(2);
    toMPC <= Mc(3);
    

    InBus1 <= Immediate when toBus1='1' else (others => '0'); --pentru a scrie in Bus1 Imm
    
    process(toBus2, toBus2Address)
    begin
        if toBus2 = '1' then
            InBus2 <= Immediate;
        elsif toBus2Address = '1' then
            InBus2 <= x"00" & Address;
        else
            InBus2 <= (others => '0');
        end if;
    end process;
    
    --InBus2 <= Immediate when toBus2='1' else (others => '0'); --pentru a scrie in Bus2 Imm
    --InBus2 <= (x"00" & Address) when toBus2Address = '1' else (others => '0'); --pentru a scrie in Bus2 Adrress
    InMPC <= Address when toMPC='1' else (others=>'0'); --pentru a scrie in MPC
    
--codificari op
process(IR)
begin
    case IR(31 downto 24) is

        when "00000000" =>  stare <= JUMP;
        when "00000001" =>  stare <= JREG;
        when "00000010" =>  stare <= BEQZ;
        when "00000011" =>  stare <= BNEG;
        when "00000100" =>  stare <= LD;
        when "00000101" =>  stare <= LDL;
        when "00000110" =>  stare <= LDX;
        when "00000111" =>  stare <= ST;
        when "00001000" =>  stare <= STX;
        when "00001001" =>  stare <= ADD;
        when "00001010" =>  stare <= ADDL;
        when "00001011" =>  stare <= SUB;
        when "00001100" =>  stare <= SUBL;
        when "00001101" =>  stare <= ANDD;
        when "00001110" =>  stare <= ANDL;
        when "00001111" =>  stare <= ORR;
        when "00010000" =>  stare <= ORL;
        when "00010001" =>  stare <= XORR;
        when "00010010" =>  stare <= XORL;
        when "00010011" =>  stare <= SLLS;
        when "00010100" =>  stare <= SLLL;
        when "00010101" =>  stare <= SRLS;
        when "00010110" =>  stare <= SRLL;
        when "00010111" =>  stare <= SRAA;
        when "00011000" =>  stare <= SRAL;
        when "00011001" =>  stare <= MUL;
        when "00011010" =>  stare <= MULL;
        when "00011011" =>  stare <= DIV;
        when "00011100" =>  stare <= DIVL;
        when "00011101" =>  stare <= OP1;
        when "00011110" =>  stare <= OP2;
        when "00011111" =>  stare <= STOP;
        when others => stare <= ADD;
 end case;
 end process Operation;

--formam codul de instructiuni
process(stare)
begin
    case stare is 
        when JUMP => Micro <= Mc_memory(0);
        when JREG => Micro <= Mc_memory(1);
        when  BEQZ => Micro <= Mc_memory(2);
        when  BNEG => Micro <= Mc_memory(3);
        when  LD => Micro <= Mc_memory(4); 
                    Address <= x"06";
        when  LDL => Micro <= Mc_memory(5);
        when  LDX => Micro <= Mc_memory(6);
        when  ST => Micro <= Mc_memory(7);
                    Address <= x"06";
        when  STX => Micro <= Mc_memory(8);
        when  ADD => Micro <= Mc_memory(9);
        when  ADDL => Micro <= Mc_memory(10);
        when  SUB => Micro <= Mc_memory(11);
        when  SUBL => Micro <= Mc_memory(12);
        when  ANDD => Micro <= Mc_memory(13);
        when  ANDL => Micro <= Mc_memory(14);
        when  ORR => Micro <= Mc_memory(15);
        when  ORL => Micro <= Mc_memory(16);
        when  XORR => Micro <= Mc_memory(17);
        when  XORL => Micro <= Mc_memory(18);
        when  SLLS => Micro <= Mc_memory(19);
        when  SLLL => Micro <= Mc_memory(20);
        when  SRLS => Micro <= Mc_memory(21);
        when  SRLL => Micro <= Mc_memory(22);
        when  SRAA => Micro <= Mc_memory(23);
        when  SRAL => Micro <= Mc_memory(24);
        when  MUL => Micro <= Mc_memory(25);
        when  MULL => Micro <= Mc_memory(26);
        when  DIV => Micro <= Mc_memory(27);
        when  DIVL => Micro <= Mc_memory(28);
        when  OP1 => Micro <= Mc_memory(29);
        when  OP2 => Micro <= Mc_memory(30);
        when  STOP => Micro <= Mc_memory(31);
		when others => Micro <= Mc_memory(to_integer(unsigned(AdrMc)));
	end case;
end process;

end Behavioral;