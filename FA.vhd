-----------------
--Full Adder
library ieee;
use ieee.std_logic_1164.all;

entity FA is
        port (A         : in std_logic;
              B         : in std_logic;
              Cin       : in std_logic;
              Sum       : out std_logic;
              Cout      : Out std_logic);
end FA;


architecture df of FA is
  signal s_1, s_2, s_3 : std_logic:='0';
    begin
        Sum <= A xor B xor Cin;
        
        s_1 <= A and B;
        s_2 <= A and Cin;
        s_3 <= B and Cin;
        
        Cout <= s_1 or s_2 or s_3 after 8 ns;
end;
