----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2024 10:17:18 PM
-- Design Name: 
-- Module Name: Processor_4_TB - Behavioral
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

entity Processor_4_TB is
--  Port ( );
end Processor_4_TB;

architecture Behavioral of Processor_4_TB is

component Processor_4 is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (3 downto 0);
           Seg_7_Display : out STD_LOGIC_VECTOR (6 downto 0);
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Anode : out STD_LOGIC_VECTOR (3 downto 0);
           A_Equals_B : out STD_LOGIC;
           A_Less_Than_B : out STD_LOGIC;
           A_Greater_Than_B : out STD_LOGIC
           );
end component;

signal anode,led : std_logic_vector (3 downto 0);
signal overflow, zero, A_Equals_B, A_Less_Than_B, A_Greater_Than_B : std_logic;
signal Seg_7_Display : std_logic_vector (6 downto 0);
signal clk : STD_LOGIC := '0';
signal reset : STD_LOGIC := '1';

begin
UUT : Processor_4
    port map (
        Clk => clk,
        Reset => reset,
        LED => led,
        Seg_7_Display => Seg_7_Display,
        Overflow => overflow,
        Zero => zero,
        Anode => anode,
        A_Equals_B => A_Equals_B,
        A_Less_Than_B => A_Less_Than_B,
        A_Greater_Than_B => A_Greater_Than_B
        );
 
            process
            begin
                wait for 5ns;
                clk <= not(clk);
            end process;
            
            process
            begin
                wait for 110ns;
                reset <= '0';
                wait;
            end process;

end Behavioral;
