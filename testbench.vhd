--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:10:17 10/18/2016
-- Design Name:   
-- Module Name:   E:/ISE/alu/testbench.vhd
-- Project Name:  alu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         Clk : IN  std_logic;
         RST : IN  std_logic;
         InputSW : IN  std_logic_vector(15 downto 0);
         Output : OUT  std_logic_vector(15 downto 0);
			OutputST : out  STD_LOGIC_VECTOR (1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal RST : std_logic := '0';
   signal InputSW : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(15 downto 0);
	signal OutputST : std_logic_vector(1 downto 0);
   -- Clock period definitions
   constant Clk_period : time := 10 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          Clk => Clk,
          RST => RST,
          InputSW => InputSW,
          Output => Output,
			 OutputST => OutputST
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		InputSW <= "0000000000000100";
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
		Clk <= '0';
		InputSW <= "0000000000001000";
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
		Clk <= '0';
		InputSW <= "0000000000000000";
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
		Clk <= '0';
		InputSW <= "1000000011101000";
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '0';
      wait for 1 ms;	
		RST <= '1';
      wait for 1 ms;
		RST <= '0';
		wait for 1000 ms;
      -- insert stimulus here 

      wait;
   end process;

END;
