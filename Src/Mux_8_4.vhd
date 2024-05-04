----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2024 11:43:14 AM
-- Design Name: 
-- Module Name: Mux_8_4 - Behavioral
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

entity Mux_8_4 is
    Port ( I_0 : in STD_LOGIC_VECTOR (3 downto 0);
           I_1 : in STD_LOGIC_VECTOR (3 downto 0);
           I_2 : in STD_LOGIC_VECTOR (3 downto 0);
           I_3 : in STD_LOGIC_VECTOR (3 downto 0);
           I_4 : in STD_LOGIC_VECTOR (3 downto 0);
           I_5 : in STD_LOGIC_VECTOR (3 downto 0);
           I_6 : in STD_LOGIC_VECTOR (3 downto 0);
           I_7 : in STD_LOGIC_VECTOR (3 downto 0);
           Selector : in STD_LOGIC_VECTOR (2 downto 0);
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_8_4;

architecture Behavioral of Mux_8_4 is
    
begin
    with Selector select
        Q <= I_0 when "000",
             I_1 when "001",
             I_2 when "010",
             I_3 when "011",
             I_4 when "100",
             I_5 when "101",
             I_6 when "110",
             I_7 when "111",
            (others => 'U') when others;


end Behavioral;
