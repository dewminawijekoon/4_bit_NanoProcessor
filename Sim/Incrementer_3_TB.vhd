----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2024 10:07:02 PM
-- Design Name: 
-- Module Name: Incrementer_3_TB - Behavioral
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

entity Incrementer_3_TB is
--  Port ( );
end Incrementer_3_TB;

architecture Behavioral of Incrementer_3_TB is

component Incrementer_3 is
  Port (D : in STD_LOGIC_VECTOR (2 downto 0);
        Q : out STD_LOGIC_VECTOR (2 downto 0));
        
end component;

signal d,q : std_logic_vector (2 downto 0);

begin
UUT : Incrementer_3
    port map (
        D => d,
        Q => q);
        
process
begin

D <= "000";
wait for 100ns;

D <= "001";
wait;

end process;
 
end Behavioral;
