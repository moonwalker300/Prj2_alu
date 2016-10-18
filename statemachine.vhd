----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:56:32 10/17/2016 
-- Design Name: 
-- Module Name:    statemachine - Behavioral 
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

entity statemachine is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC; 
           InputSW : in  STD_LOGIC_VECTOR (15 downto 0);
			  OptA : out  STD_LOGIC_VECTOR (15 downto 0);
			  OptB : out  STD_LOGIC_VECTOR (15 downto 0);
			  OptOp : out  STD_LOGIC_VECTOR (3 downto 0);
			  OutST : out STD_LOGIC_VECTOR (1 downto 0)
			);
end statemachine;

architecture Behavioral of statemachine is
	type FSM_ST is (IA, IB, IOP, OFLAG);
	signal current_state, next_state : FSM_ST;
begin
	process (Rst, Clk)
	begin
		if (Rst = '1') then current_state <= IA;
		elsif (Clk = '1' and Clk'event) then
			current_state <= next_state;
		end if;
	end process;
	
	process (current_state)
	begin
		case current_state is
			when IA => OptA <= InputSw; OptOp <= "1111"; next_state <= IB; OutST <= "00";
			when IB => OptB <= InputSw; OptOp <= "1111"; next_state <= IOP; OutST <= "01";
			when IOP => OptOp <= InputSw(3 downto 0); next_state <= OFLAG; OutST <= "10";
			when OFLAG => next_state <= IA; OutST <= "11";
			when others => next_state <= IA;
		end case;
	end process;
		

end Behavioral;

