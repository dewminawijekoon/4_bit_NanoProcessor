----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 06:39:15 AM
-- Design Name: 
-- Module Name: PC_3_TB - Behavioral
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

entity PC_3_TB is
--  Port ( );
end PC_3_TB;

architecture Behavioral of PC_3_TB is

component PC_3
    Port(Clk : in STD_LOGIC;
         PC_In : in STD_LOGIC_VECTOR (2 downto 0);
         Reset : in STD_LOGIC;
         PC_Out : out STD_LOGIC_VECTOR (2 downto 0)); 
end component;

signal Clk : STD_LOGIC := '0';
signal Reset : STD_LOGIC;
signal PC_In, PC_Out : STD_LOGIC_VECTOR(2 downto 0);

begin
UUT : PC_3 
port map(
    Clk => Clk,
    PC_In => PC_In,
    Reset => Reset, 
    PC_Out => PC_Out 
    );

process 
    begin
        wait for 20ns;
        Clk <= NOT(Clk);
end process;
    
process 
    begin
        -- Index number : 220734 = 110 101 111 111 111 110
    Reset <= '1';
    wait for 100ns;
    
    Reset <='0';
    PC_in <= "110";
    wait for 200ns;
    
    PC_in <= "101";
    wait for 200ns;
    
    PC_in <= "111";
    wait for 200ns;
    
    Reset <= '1';
    PC_in <= "110";
    wait;
   
end process;

end Behavioral;
