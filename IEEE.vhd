----------------------------------------------------------------------------------
-- Implementa��o de Somador e Sutrator em Ponto Flutuante de Precis�o Simples
-- Apenas um exemplo comportamental, n�o  representa a melhor forma de 
--               implementa��o e controle do hardware gerado
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;



entity projIEEE is
    Port ( x : in  	STD_LOGIC_VECTOR (31 downto 0);
           y : in  	STD_LOGIC_VECTOR (31 downto 0);
			  t : in  	STD_LOGIC; --1-soma, 0-subtracao
           z : out  STD_LOGIC_VECTOR (31 downto 0);
			  saidaSinal : out  STD_LOGIC;
			  saidaExpoente: out STD_LOGIC_VECTOR (7 downto 0);
			  saidaMantissa : out  STD_LOGIC_VECTOR (22 downto 0));
end projIEEE;



architecture Behavioral of projIEEE is

begin

	process(x,y,t)
		variable x_mantissa 	: STD_LOGIC_VECTOR (31 downto 0);
		variable x_expoente 	: STD_LOGIC_VECTOR (7 downto 0);
		variable x_sinal 		: STD_LOGIC;

		variable y_mantissa 	: STD_LOGIC_VECTOR (31 downto 0);
		variable y_expoente 	: STD_LOGIC_VECTOR (7 downto 0);
		variable y_sinal 		: STD_LOGIC;

		variable z_mantissa 	: STD_LOGIC_VECTOR (22 downto 0);
		variable z_expoente 	: STD_LOGIC_VECTOR (7 downto 0);
		variable z_sinal 		: STD_LOGIC;

		variable aux_shift 	: STD_LOGIC_VECTOR (7 downto 0);
		variable aux_cur   	: STD_LOGIC_VECTOR (7 downto 0);
		
		variable aux_mantissa	: STD_LOGIC_VECTOR (31 downto 0);
   begin

		--o x ser� sempre o de maior expoente
		if (x(30 downto 23) < y(30 downto 23)) then
			x_mantissa 	:= '1' & y(22 downto 0) & "00000000";
			x_expoente 	:= y(30 downto 23);
			x_sinal 		:= y(31);
			
			y_mantissa 	:= '1' & x(22 downto 0) & "00000000";
			y_expoente 	:= x(30 downto 23);
			y_sinal 		:= x(31);
		else
			x_mantissa 	:= '1' & x(22 downto 0) & "00000000";
			x_expoente 	:= x(30 downto 23);
			x_sinal 		:= x(31);
			
			y_mantissa 	:= '1' & y(22 downto 0) & "00000000";
			y_expoente 	:= y(30 downto 23);
			y_sinal 		:= y(31);
		end if;


		--faz shift no n�mero menor
		aux_cur := (others => '0');
		aux_shift := x_expoente - y_expoente;
		while (aux_cur < aux_shift) loop
			y_mantissa := '0' & y_mantissa(31 downto 1);
			aux_cur := aux_cur + 1;
		end loop;

		
		--calcula a mantissa
		aux_mantissa := (others => '0');
		
		
		if (t = '1') then --soma
			--se forem iguais soma (para soma)
			if (x_sinal = y_sinal) then
				aux_mantissa := (x_mantissa + y_mantissa);
			else --se n�o, subtrair
				aux_mantissa := (x_mantissa - y_mantissa);
			end if;
		else --subtracao
			if (x_sinal = y_sinal) then
				aux_mantissa := (x_mantissa - y_mantissa);
			else
				aux_mantissa := (x_mantissa + y_mantissa);
			end if;
		end if;
		
		
		--coloca o sinal da maior no retorno
		z_sinal := x_sinal;
		
		
		--coloca o expoente do maior no retorno
		z_expoente := x_expoente;
		
		
		--normaliza o resultado
		for i in 0 to 31 loop
			if not (aux_mantissa(31) = '1') then
				aux_mantissa := aux_mantissa(30 downto 0) & '0';
				z_expoente  := z_expoente - 1;
			end if;
		end loop;
		z_mantissa := aux_mantissa(31 downto 9);
		
		
			
		--coloca os resultados na saida
		z(22 downto 0)  <= z_mantissa;
		z(30 downto 23) <= z_expoente;
		z(31)				 <= z_sinal;
		
		--coloca os resultados por partes na saida
		saidaMantissa <= z_mantissa;
		saidaExpoente <= z_expoente;
		saidaSinal <= z_sinal;
		

   end process;
	
end Behavioral;