--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:50:09 02/19/2014
-- Design Name:   
-- Module Name:   E:/DSD2/Lab2 GenMult/GenericMultiplier/Testbench.vhd
-- Project Name:  GenericMultiplier
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GenericMultiplier
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
library STD;
use STD.textio.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_textio.all;
use ieee.std_logic_arith.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Testbench IS
END Testbench;
 
ARCHITECTURE behavior OF Testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GenericMultiplier
    PORT(
         X : IN  std_logic_vector(7 downto 0);
         Y : IN  std_logic_vector(7 downto 0);
         P : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(7 downto 0);
   signal Y : std_logic_vector(7 downto 0);

 	--Outputs
   signal P : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
	file		INPUT	: text open READ_MODE is "tb_data.txt"; 	--file to write

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GenericMultiplier 
			
			PORT MAP (
          X => X,
          Y => Y,
          P => P
        );

   -- Stimulus process
   stim_proc: process
	variable outline 		: line;								--line number
	variable x_in,y_in 	: std_logic_vector(7 downto 0);
	variable p_out			: std_logic_vector(15 downto 0);
   begin		
      -- hold reset state for 100 ns.
      readline(INPUT,outline);
		for n in 0 to 65535 loop
		
		hread(outline,x_in);
		hread(outline,y_in);
		hread(outline,p_out);
		X <= x_in;
		Y <= y_in;
		
		
		readline(INPUT,outline);
		
		wait for 200 ns;	
		
		assert (P = p_out)report "Assert Failed" severity error;
		--    wait for <clock>_period*10;

      -- insert stimulus here 

      end loop;
   end process;

END;
