----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2024 09:24:30 PM
-- Design Name: 
-- Module Name: Add_sub_4_0_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Add_sub_4_0_TB is
--  Port ( );
end Add_sub_4_0_TB;

architecture Behavioral of Add_sub_4_0_TB is

component Add_Sub_4 is
  Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
         B : in STD_LOGIC_VECTOR (3 downto 0);
         Neg : in STD_LOGIC;
         Sum : out STD_LOGIC_VECTOR (3 downto 0);
         Overflow : out STD_LOGIC;
         Zero : out STD_LOGIC);
end component;

signal a,b,sum : STD_LOGIC_VECTOR(3 downto 0);
Signal neg,overflow,zero : STD_LOGIC;

begin

UUT: Add_Sub_4
port map(
    A => a,
    B => b,
    Neg => neg,
    Sum => sum,
    Zero => zero,
    Overflow => overflow 
    );
    
process
begin

-- index numbers : 220131 (110101101111100011), 220185 (110101110000011001) 
-- 220708 (110101111000100100), 220734 (110101111000111110)

A <= "1101";
B <= "0110";
Neg <= '0';

wait for 100ns;

A <= "1111";
B <= "1000";
Neg <= '1';
wait for 100ns;

A <= "1101";
B <= "0111";
Neg <= '0';

wait for 100ns;

A <= "0000";
B <= "0110";
Neg <= '1';
wait for 100ns;

A <= "1101";
B <= "0111";
Neg <= '0';

wait for 100ns;

A <= "1000";
B <= "1001";
Neg <= '1';
wait for 100ns;

A <= "1101";
B <= "0111";
Neg <= '0';

wait for 100ns;

A <= "0000";
B <= "1111";
Neg <= '1';


wait;
end process;

end Behavioral;
