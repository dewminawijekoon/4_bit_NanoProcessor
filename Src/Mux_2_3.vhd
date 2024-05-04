----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 09:31:12 AM
-- Design Name: 
-- Module Name: Mux_2_3 - Behavioral
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

entity Mux_2_3 is
    Port ( I_0 : in STD_LOGIC_VECTOR (2 downto 0);
           I_1 : in STD_LOGIC_VECTOR (2 downto 0);
           Selector : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0));
end Mux_2_3;

architecture Behavioral of Mux_2_3 is

begin
    with Selector select Q <=
        I_0 when '0',
        I_1 when '1',
        (others => 'U') when others;

end Behavioral;
