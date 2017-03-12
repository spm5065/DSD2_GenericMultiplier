----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:13:27 02/17/2014 
-- Design Name: 
-- Module Name:    Testgen - Behavioral 
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
library STD;
use STD.textio.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_textio.all;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Testgen is
end Testgen;

architecture Behavioral of Testgen is
file		outfile	: text open write_mode is "tb_data.txt"; 	--file to write
signal hi:std_logic:='0';
begin

	process
		
		variable outline 	: line;								--line number
		variable product 	: std_logic_vector(15 downto 0);
--		variable x			: std_logic_vector(7 downto 0);
--		variable Y			: std_logic_vector(7 downto 0);
		begin
		for i in 0 to 255 loop								
			for j in 0 to 255 loop
				hwrite(outline, conv_std_logic_vector(i,8));
				write(outline,' ');
				hwrite(outline, conv_std_logic_vector(j,8));
				write(outline,' ');
				hwrite(outline, conv_std_logic_vector(i*j,16));
				writeline(outfile,outline);
			end loop;
		end loop;	
		writeline(outfile,outline);
	wait;
end process;	
end Behavioral;

