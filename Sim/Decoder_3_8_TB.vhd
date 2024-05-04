----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 10:12:03 AM
-- Design Name: 
-- Module Name: Decoder_3_8_TB - Behavioral
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

entity Decoder_3_8_TB is
--  Port ( );
end Decoder_3_8_TB;

architecture Behavioral of Decoder_3_8_TB is
component Decoder_3_8
port(
    D : in STD_LOGIC_VECTOR (2 downto 0);
    En : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

signal D : STD_LOGIC_VECTOR(2 downto 0);
signal Q : STD_LOGIC_VECTOR(7 downto 0);
signal En : STD_LOGIC;

begin
UUT: Decoder_3_8
port map(
    D => D,
    Q => Q,
    En => En
    );
    
process
    begin
    En <= '1';
    D <= "001";
    wait for 100ns;
    
    En <= '1';
    D <= "010";
    wait for 100ns;

    En <= '0';
    D <= "001";
    wait for 100ns;  
end process;

end Behavioral;
