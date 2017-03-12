library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity GenericMultiplier is
  generic (N : integer := 8);
  port    (X : in   std_logic_vector(n-1  downto 0);
           Y : in   std_logic_vector(n-1  downto 0);
           P : out  std_logic_vector(2*n-1 downto 0));
  end GenericMultiplier;

architecture structual of GenericMultiplier is
  component FA
    port     (A         : in std_logic;
              B         : in std_logic;
              Cin       : in std_logic;
              Sum       : out std_logic;
              Cout      : Out std_logic);
  end component;  
    
  component HA
    port     (A         : in std_logic;
              B         : in std_logic;
              Sum       : out std_logic;
              Cout      : out std_logic);  
  end component;   
    
  component and2
    Port ( A : in std_logic;
           B : in std_logic;
           Y : out std_logic);
  end component; 

  type tProd is array (n-1 downto 0) of std_logic_vector(n-1 downto 0);
  signal sPartProd : tProd;
  type tSum is array (n-1 downto 1) of std_logic_vector(n-1 downto 0);
  signal sSum : tSum;
  type tCarry is array(n-1 downto 1) of std_logic_vector(n-1 downto 0);
  signal sCarry : tCarry;
  
  begin
		
		xcoord:  for first in  n-1 downto 0 generate
			test :		for second in n-1 downto 0 generate
		and2inst	:	 and2 port map( A => X(first), B => Y(second), Y => sPartProd(first)(second));
					end generate;
					end generate;
					
					
		HAstuff	:  for row in n-1 downto 0 generate
			HAstuff2:	for col in n-1 downto 0 generate
		HIfcheck:			if col=0 and row=1 generate--HAtopright
		HAGen	:					HA port map(A => sPartProd(row)(col),
															  B  => sPartProd(row - 1)(col + 1),
															  Sum => sSum(row)(col),
															  Cout => sCarry(row)(col));
								end generate;	
		labels:			   if(col = n-1 and row = 1) generate--HAtopleft
		HAGen2:					HA port map(A => sPartProd(row)(col),
															  B  => sCarry(row)(col-1),
															  Sum => sSum(row)(col),
															  Cout => sCarry(row)(col));
								end generate;
		halast:				if col=0 and row>1 generate--HAbotright
	 genlabel:	    			  HA port map(A => sPartProd(row)(col),
													  B  => sSum(row-1)(col+1),
													  Sum => sSum(row)(col),
													  Cout => sCarry(row)(col));
								end generate;
								
		labels2:	 		   if col>0 and col<n-1 generate--mid2
		iFSTUFF:					if(row = 1) generate--topmid2
		HAGen3:									FA port map(A   => sPartProd(row)(col),
																  B    => sPartProd(row - 1)(col + 1),
																  Cin  => sCarry(row)(col-1),
																  Sum  => sSum(row)(col),
																  Cout => sCarry(row)(col));
									end generate;	
		labels3:					if row>1 generate--rest mid 2
			FAgen:								FA port map(A   => sPartProd(row)(col),
																  B    => sSum(row - 1)(col + 1),
																  Cin  => sCarry(row)(col-1),
																  Sum  => sSum(row)(col),
																  Cout => sCarry(row)(col));
									end generate;	
								end generate;		
			Realyif:			if col = n-1 and row>1 generate
			FAgen2:					FA port map(A   => sPartProd(row)(col),
											  		   B    => sCarry(row-1)(col),
													   Cin  => sCarry(row)(col-1),
													   Sum  => sSum(row)(col),
													   Cout => sCarry(row)(col));
										
								end generate;
							end generate;
						end generate;

process(X,Y,sSum,sCarry,sPartProd)
begin
			for nbit in 2*n-1 downto 0 loop
				if nbit=0 then
					P(nbit) <= sPartProd(0)(0);
				elsif (nbit <= n-1) then
					P(nbit) <= sSum(nbit)(0);
				elsif ((nbit < 2*n-1) and (nbit > n-1)) then
					P(nbit) <= sSum(n-1)(nbit - (n - 1));
				elsif (nbit = 2*n-1) then
					P(nbit) <= sCarry(n-1)(n-1);
				end if;
			end loop;
		end process;
			
	end structual;