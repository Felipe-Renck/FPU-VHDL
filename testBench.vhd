--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:05:43 11/25/2016
-- Design Name:   
-- Module Name:   C:/Users/Felipe/Documents/Arquitetura de Computadores/FPU-VHDL/testbench.vhd
-- Project Name:  ProjIEEE
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: projIEEE
-- 
-- Dependencies:
-- 
----------------------------------------------------------------------------------
--------------------------------------Testbench-----------------------------------
-- Implementação de Somador e Sutrator em Ponto Flutuante de Precisão Simples
-- Apenas um exemplo comportamental, não  representa a melhor forma de 
--               implementação e controle do hardware gerado
----------------------------------------------------------------------------------
LIBRARY ieee;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT projIEEE
    PORT(
         x : IN  std_logic_vector(31 downto 0);
         y : IN  std_logic_vector(31 downto 0);
         t : IN  std_logic;
         z : OUT  std_logic_vector(31 downto 0);
         saidaSinal : OUT  std_logic;
         saidaExpoente : OUT  std_logic_vector(7 downto 0);
         saidaMantissa : OUT  std_logic_vector(22 downto 0)
        );
    END COMPONENT;
    

   --Entradas já setadas
	signal clk : std_logic := '0';
	--Entrada x = 9.75
   signal x : std_logic_vector(31 downto 0) := "01000001000111000000000000000000" ;
	--Entrada y = 0.5625
   signal y : std_logic_vector(31 downto 0) := "00111111000100000000000000000000" ;
   signal t : std_logic := '0';

 	--Saídas 
   signal z : std_logic_vector(31 downto 0);
   signal saidaSinal : std_logic;
   signal saidaExpoente : std_logic_vector(7 downto 0);
   signal saidaMantissa : std_logic_vector(22 downto 0);
 
	--constante do período do clock
   constant clk_period : time := 10 ns;
 
BEGIN
 
	--Port map entre o component e os sinais 
   uut: projIEEE PORT MAP (
          x => x,
          y => y,
          t => t,
          z => z,
          saidaSinal => saidaSinal,
          saidaExpoente => saidaExpoente,
          saidaMantissa => saidaMantissa
        );

   -- Gerencia o clock
	process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

	--Process
   stim_proc: process
   begin		
      -- Espera e segura o estado por  100 ns.	
      wait for clk_period*10;
		t<= '1'; --Troca a operação para subtração
		wait for clk_period*10;
		--Troca os valores
		x<="11000001000111000000000000000000"; --Entrada x = -9.75
		y<="10111111000100000000000000000000";--Entrada y = -0.5625
		t<='0';
		wait for clk_period*10;
		t<= '1';
      wait;
   end process;

END;
