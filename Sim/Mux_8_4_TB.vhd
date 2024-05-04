----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 10:50:59 AM
-- Design Name: 
-- Module Name: Mux_8_4_TB - Behavioral
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

entity Mux_8_4_TB is
--  Port ( );
end Mux_8_4_TB;

architecture Behavioral of Mux_8_4_TB is

component Mux_8_4
port(I_0 : in STD_LOGIC_VECTOR (3 downto 0);
     I_1 : in STD_LOGIC_VECTOR (3 downto 0);
     I_2 : in STD_LOGIC_VECTOR (3 downto 0);
     I_3 : in STD_LOGIC_VECTOR (3 downto 0);
     I_4 : in STD_LOGIC_VECTOR (3 downto 0);
     I_5 : in STD_LOGIC_VECTOR (3 downto 0);
     I_6 : in STD_LOGIC_VECTOR (3 downto 0);
     I_7 : in STD_LOGIC_VECTOR (3 downto 0);
     Selector : in STD_LOGIC_VECTOR (2 downto 0);
     Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal I_0, I_1, I_2, I_3, I_4, I_5, I_6, I_7, Q : STD_LOGIC_VECTOR(3 downto 0);
Signal Selector : STD_LOGIC_VECTOR(2 downto 0);

begin
UUT: Mux_8_4
port map(
    I_0 => I_0,
    I_1 => I_1,
    I_2 => I_2,
    I_3 => I_3,
    I_4 => I_4,
    I_5 => I_5,
    I_6 => I_6,
    I_7 => I_7,
    Selector => Selector,
    Q => Q 
    );

process
begin
    I_0 <= "0000";
    I_1 <= "0001";
    I_2 <= "0010";
    I_3 <= "0011";
    I_4 <= "0100";
    I_5 <= "0101";
    I_6 <= "0110";
    I_7 <= "0111";
    
    Selector <= "000";
    wait for 5ns;

    Selector <= "001";
    wait for 5ns;
    
     Selector <= "010";
    wait for 5ns;   
    
    Selector <= "011";
    wait for 5ns;
    
    Selector <= "100";
    wait;
        
end process;


end Behavioral;
