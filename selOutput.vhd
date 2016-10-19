----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:58:44 10/17/2016 
-- Design Name: 
-- Module Name:    selOutput - Behavioral 
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

entity selOutput is --四选一输出，根据状态机的状态
    Port ( ST : in  STD_LOGIC_VECTOR (1 downto 0);
           Fout : in  STD_LOGIC_VECTOR (15 downto 0);
           flag : in  STD_LOGIC_VECTOR (3 downto 0);
           OpA : in  STD_LOGIC_VECTOR (15 downto 0);
           OpB : in  STD_LOGIC_VECTOR (15 downto 0);
           Export : out  STD_LOGIC_VECTOR (15 downto 0));
end selOutput;

architecture Behavioral of selOutput is
begin
	process(ST, Fout, flag, OpA, OpB)
	begin
		case ST is
			when "00" =>	Export <= OpA;
			when "01" =>	Export <= OpB;
			when "10" =>	Export <= Fout;
			when others =>	
				Export(15 downto 4) <= "000000000000";
				Export(3 downto 0) <= flag;
		end case;
	end process;

end Behavioral;

