----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:11:30 10/21/2016 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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
library IEEE;----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:08:22 10/17/2016 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( 
			  Clk : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Input : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0);
           outst : out  STD_LOGIC_VECTOR (1 downto 0)); --(3:CF, 2:ZF, 1:SF, 0:OF)
end alu;

architecture Behavioral of alu is
	signal st: STD_LOGIC_VECTOR (1 downto 0);
begin
	process (Clk, RST)
	variable tmpA, tmpB, tmpC, res: STD_LOGIC_VECTOR (15 downto 0);
	variable tmpFlag, Op : STD_LOGIC_VECTOR (3 downto 0);
	variable tmpInt : Integer;
	begin
	   if(RST = '0') then
			st <= "00";
			res := "0000000000000000";
			Output <= res;
		elsif(Clk'event and Clk = '1')then
			if (st = "00")then
				st <= "01";
				tmpA := Input;
				Output <= Input;
			elsif (st = "01") then
				st <= "10";
				tmpB := Input;
				Output <= Input;
			elsif (ST = "10") then
				Op := Input(3 downto 0);
				case Op is
					when "0000" => --?車﹞“
						res := tmpA + tmpB;
						if (res < tmpA) then
							tmpFlag(3) := '1';
						else
							tmpFlag(3) := '0';
						end if;
						if (res = "0000000000000000") then
							tmpFlag(2) := '1';
						else
							tmpFlag(2) := '0';
						end if;
						tmpFlag(1) := res(15);
						
						if (((tmpA(15)='0') and (tmpB(15)='0') and (res(15)='1')) or ((tmpA(15)='1') and (tmpB(15)='1') and (res(15)='0'))) then
							tmpFlag(0) := '1';
						else
							tmpFlag(0) := '0';
						end if;
					when "0001" => --??﹞“
						tmpC := (not tmpB) + "000000000000001";
						res := tmpA + tmpC;
						if (tmpA < tmpB) then
							tmpFlag(3) := '1';
						else
							tmpFlag(3) := '0';
						end if;
						if (res = "0000000000000000") then
							tmpFlag(2) := '1';
						else
							tmpFlag(2) := '0';
						end if;
						tmpFlag(1) := res(15);
						
						if (((tmpA(15)='0') and (tmpC(15)='0') and (res(15)='1')) or ((tmpA(15)='1') and (tmpC(15)='1') and (res(15)='0'))) then
							tmpFlag(0) := '1';
						else
							tmpFlag(0) := '0';
						end if;
					when others =>
						case Op is
							when "0010" => res := tmpA and tmpB; --and
							when "0011" => res := tmpA or tmpB; --or
							when "0100" => res := tmpA xor tmpB; --xor
							when "0101" => res := not tmpA; --not
							when "0110" => --???-℅車辰?
								if (tmpB >= "0000000000010000") then
									res := "0000000000000000";
								else
									tmpInt := conv_integer(tmpB);
									res := "0000000000000000";
									res(15 downto tmpInt) := tmpA(15 - tmpInt downto 0);
								end if;
							when "0111" => --???-車辰辰?
								if (tmpB >= "0000000000010000") then
									res := "0000000000000000";
								else
									tmpInt := conv_integer(tmpB);
									res := "0000000000000000";
									res(15 - tmpInt downto 0) := tmpA(15 downto tmpInt);
								end if;
							when "1000" => --??那y車辰辰?
								if (tmpB >= "0000000000010000") then
									if (tmpA(15) = '0') then
										res := "0000000000000000";
									else
										res := "1111111111111111";
									end if;
								else
									tmpInt := conv_integer(tmpB);
									if (tmpA(15)='0') then
										res := "0000000000000000";
									else
										res := "1111111111111111";
									end if;
									res(15 - tmpInt downto 0) := tmpA(15 downto tmpInt);
								end if;
							when others => --?-?﹞℅車辰?
								tmpC(3 downto 0) := tmpB(3 downto 0);
								tmpC(15 downto 4) := "000000000000";
								tmpInt := conv_integer(tmpC);
								res(15 downto tmpInt) := tmpA(15 - tmpInt downto 0);
								res(tmpInt - 1 downto 0) := tmpA(15 downto 15 - tmpInt + 1);
						end case;
						tmpFlag(3) := '0';
						if (res="0000000000000000") then
							tmpFlag(2) := '1';
						else
							tmpFlag(2) := '0';
						end if;
						tmpFlag(1) := res(15);
						tmpFlag(0) := '0';
					end case;
					st <= "11";
					Output <= res;
				else
					Output(15 downto 4) <= "000000000000";
					Output(3 downto 0) <= tmpFlag;
					st <= "00";
				end if;
		end if;
		outst <= st;
	end process;

end Behavioral;

