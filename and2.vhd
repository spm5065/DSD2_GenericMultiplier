library ieee;
use ieee.std_logic_1164.all;

 entity and2 is
    Port ( A : in std_logic;
           B : in std_logic;
           Y : out std_logic);
  end and2;
  
  architecture df of and2 is
      begin
          Y <= a and b after 3 ns;     
  end df;

