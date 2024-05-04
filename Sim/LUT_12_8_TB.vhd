----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 07:04:20 AM
-- Design Name: 
-- Module Name: LUT_12_8_TB - Behavioral
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

entity LUT_12_8_TB is
--  Port ( );
end LUT_12_8_TB;

architecture Behavioral of LUT_12_8_TB is
 
component LUT_12_8
    port(D : in STD_LOGIC_VECTOR (2 downto 0);
         I : out STD_LOGIC_VECTOR (11 downto 0));
end component;

signal D : STD_LOGIC_VECTOR(2 downto 0);
signal I : STD_LOGIC_VECTOR(11 downto 0);

begin
UUT : LUT_12_8
port map(
     D => D,
     I => I
     );
 
    process 
     begin
         -- Index number : 220185 = 110 101 110 010 111 001
         D <= "110";
         wait for 200ns;
         
         D <= "101";
         wait for 200ns;
             
         D <= "010";
         wait for 200ns;
                 
         D <= "111";
         wait;
    end process;    

end Behavioral;
