--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:31:27 11/25/2016
-- Design Name:   
-- Module Name:   C:/Users/Felipe/Documents/Arquitetura de Computadores/FPU-VHDL/testBench.vhd
-- Project Name:  ProjIEEE
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: projIEEE
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
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.std_logic_textio.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testBench IS
END testBench;
 
ARCHITECTURE behavior OF testBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT projIEEE
    PORT(
         x : IN  std_logic_vector(31 downto 0);
         y : IN  std_logic_vector(31 downto 0);
         t : IN  std_logic;
         z : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(31 downto 0) := (others => '0');
   signal y : std_logic_vector(31 downto 0) := (others => '0');
   signal t : std_logic := '0';

 	--Outputs
   signal z : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: projIEEE PORT MAP (
          x => x,
          y => y,
          t => t,
          z => z
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		t <= '0';
		--conv_std_logic_vector(int valor , int tamanho);
		x <= conv_std_logic_vector(1.2, 32);
      y <= conv_std_logic_vector(1.2, 32);
		
		--x<= "00000000";

		wait for 100 ns;	
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
