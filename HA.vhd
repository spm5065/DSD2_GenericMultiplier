-----------------
--Half Adder
library ieee;
use ieee.std_logic_1164.all;

entity HA is
        port (A         : in std_logic;
              B         : in std_logic;
              Sum       : out std_logic;
              Cout      : out std_logic);
end HA;


architecture df of HA is
    begin
        Sum <= A xor B;
        Cout <= A and B after 4 ns;
end df;

