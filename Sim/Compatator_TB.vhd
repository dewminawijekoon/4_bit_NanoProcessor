----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2024 08:29:26 AM
-- Design Name: 
-- Module Name: Compatator_TB - Behavioral
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

entity Compatator_TB is
--  Port ( );
end Compatator_TB;

architecture Behavioral of Compatator_TB is

component Comparator_4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           A_Equals_B : out STD_LOGIC;
           A_Greater_Than_B : out STD_LOGIC;
           A_Less_Than_B : out STD_LOGIC);
end component;

signal a,b : std_logic_vector (3 downto 0);
signal aeqb, agb, alb : std_logic;

begin
UUT : Comparator_4
    port map(
        A => a,
        B => b,
        A_Equals_B => aeqb,
        A_Greater_Than_B => agb,
        A_Less_Than_B => alb
    );
process

begin
A <= "0000";
B <= "0001";
WAIT FOR 100 ns;

A <= "0001";
B <= "0001";
WAIT FOR 100 ns;

A <= "1000";
B <= "0001";
WAIT;
end process;

end Behavioral;
