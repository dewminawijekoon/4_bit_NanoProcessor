----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 12:32:28 PM
-- Design Name: 
-- Module Name: NanoProcessor_TB - Behavioral
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

entity NanoProcessor_TB is
--  Port ( );
end NanoProcessor_TB;

architecture Behavioral of NanoProcessor_TB is
component NanoProcessor
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Q_0 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_1 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_2 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_3 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_4 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_5 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_6 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_7 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal Clk : STD_LOGIC := '0';
signal Reset, Overflow, Zero : STD_LOGIC := '0';
signal Q_0, Q_1, Q_2, Q_3, Q_4, Q_5, Q_6, Q_7 : STD_LOGIC_VECTOR (3 downto 0);

begin
UUT : NanoProcessor 
Port Map(
    Clk => Clk,
    Reset => Reset,
    Overflow => Overflow,
    Zero => Zero,
    Q_0 => Q_0,
    Q_1 => Q_1,
    Q_2 => Q_2,
    Q_3 => Q_3,
    Q_4 => Q_4,
    Q_5 => Q_5,
    Q_6 => Q_6,
    Q_7 => Q_7
    );

    process 
    begin
        wait for 5ns;
        Clk <= NOT(Clk);
    end process;
    
    process
    begin
    Reset <= '1';
    wait for 20ns;
        
    Reset <= '0';
    wait;
    end process;

end Behavioral;
