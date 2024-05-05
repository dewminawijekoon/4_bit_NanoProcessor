----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2024 09:50:35 PM
-- Design Name: 
-- Module Name: Program_Rom_TB - Behavioral
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

entity Program_Rom_TB is
--  Port ( );
end Program_Rom_TB;

architecture Behavioral of Program_Rom_TB is
component LUT_12_8
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           I : out STD_LOGIC_VECTOR (11 downto 0));
end component;

signal d : std_logic_vector (2 downto 0);
signal i : std_logic_vector (11 downto 0);

begin

UUT : LUT_12_8
    port map (
        D => d,
        I => i);
        
 process
 begin
    
    -- 220131 (110101101111100011), 220185 (110101110000011001) 
    -- 220708 (110101111000100100), 220734 (110101111000111110)
    wait for 100ns;
    d <= "110";
    
    wait for 100ns;
    d <= "011";
    
    wait for 100ns;
    d <= "110";    
    
    wait for 100ns;
    d <= "111";
    
    wait for 100ns;
    d <= "100";
    
    wait for 100ns;
    d <= "011";
    
    wait for 100ns;
    d <= "001";
    
    wait for 100ns;
    d <= "010";
    
    wait;
 end process;

end Behavioral;