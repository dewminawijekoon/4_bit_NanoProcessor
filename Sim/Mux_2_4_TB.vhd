----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 09:58:00 AM
-- Design Name: 
-- Module Name: Mux_2_4_TB - Behavioral
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

entity Mux_2_4_TB is
--  Port ( );
end Mux_2_4_TB;

architecture Behavioral of Mux_2_4_TB is
component Mux_2_4
port(I_0 : in STD_LOGIC_VECTOR (3 downto 0);
     I_1 : in STD_LOGIC_VECTOR (3 downto 0);
     Selector : in STD_LOGIC;
     Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal I_0, I_1, Q : STD_LOGIC_VECTOR(3 downto 0);
signal Selector : STD_LOGIC;

begin
UUT: Mux_2_4
Port Map(
    I_0 => I_0,
    I_1 => I_1,
    Selector => Selector,
    Q => Q
    );
    
    process 
     begin
         I_0 <= "0001";
         I_1 <= "0100";
         Selector <= '1';
         wait for 500ns;
         
         Selector <= '0'; 
         wait;
    end process;    


end Behavioral;
