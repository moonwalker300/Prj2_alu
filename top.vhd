----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:23:00 10/17/2016 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( Clk : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           InputSW : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0);
			  OutputST : out  STD_LOGIC_VECTOR (1 downto 0)
			);
end top;

architecture structual of top is
	component statemachine
		port( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC; 
           InputSW : in  STD_LOGIC_VECTOR (15 downto 0);
			  OptA : out  STD_LOGIC_VECTOR (15 downto 0); 
			  OptB : out  STD_LOGIC_VECTOR (15 downto 0); 
			  OptOp : out  STD_LOGIC_VECTOR (3 downto 0); --Êä³ö²Ù×÷Âë
			  OutST : out STD_LOGIC_VECTOR (1 downto 0)   
		); end component;
	component alu
		port( Op : in  STD_LOGIC_VECTOR (3 downto 0);
				 OptA : in  STD_LOGIC_VECTOR (15 downto 0);
				 OptB : in  STD_LOGIC_VECTOR (15 downto 0);
			    ST   : in  STD_LOGIC_VECTOR (1 downto 0);
             Fout : out  STD_LOGIC_VECTOR (15 downto 0);
             flag : out  STD_LOGIC_VECTOR (3 downto 0)); --(3:CF, 2:ZF, 1:SF, 0:OF)
		end component;
	component selOutput
		port(ST : in  STD_LOGIC_VECTOR (1 downto 0);
           Fout : in  STD_LOGIC_VECTOR (15 downto 0);
           flag : in  STD_LOGIC_VECTOR (3 downto 0);
           OpA : in  STD_LOGIC_VECTOR (15 downto 0);
           OpB : in  STD_LOGIC_VECTOR (15 downto 0);
           Export : out  STD_LOGIC_VECTOR (15 downto 0));
		end component;
	signal sA, sB, sFout: STD_LOGIC_VECTOR (15 downto 0);
	signal sOp, sflag: STD_LOGIC_VECTOR (3 downto 0);
	signal sST : STD_LOGIC_VECTOR (1 downto 0);
begin
	u1 : statemachine port map(Clk=>Clk, Rst=>RST, InputSW=>InputSW, OptA=>sA, OptB=>sB, OptOp=>sOp, OutST=>sST);
	u2 : alu port map(Op=>sOp, OptA=>sA, OptB=>sB, ST=>ssT, Fout=>sFout, flag=>sflag);
	u3 : selOutput port map(ST=>sSt, Fout=>sFout, flag=>sflag, OpA=>sA, OpB=>sB, Export=>Output);
	OutputST <= sST;
end structual;

