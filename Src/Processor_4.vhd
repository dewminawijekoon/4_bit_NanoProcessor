----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 03:52:54 PM
-- Design Name: 
-- Module Name: Processor_4 - Behavioral
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

entity Processor_4 is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (3 downto 0);
           Seg_7_Display : out STD_LOGIC_VECTOR (6 downto 0);
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Anode : out STD_LOGIC_VECTOR (3 downto 0));
end Processor_4;

architecture Behavioral of Processor_4 is
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

component Slow_Clk
  Port (Clk_In : in STD_LOGIC;
        Clk_Out : out STD_LOGIC );
end component;

component LUT_16_7
  Port (I : in STD_LOGIC_VECTOR (3 downto 0);
        D : out STD_LOGIC_VECTOR (6 downto 0) );
end component;

signal Clk_Signal : STD_LOGIC;
signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : STD_LOGIC_VECTOR(3 downto 0);

begin

Slow_Clk_0 : Slow_Clk
port map(
    Clk_In => Clk,
    Clk_out => Clk_Signal
    );
    
    
NanoProcessor_0 : NanoProcessor
port map(
    Clk => Clk_Signal,
    Reset => Reset,
    Overflow => Overflow,
    Zero => Zero,
    Q_0 => Q0,
    Q_1 => Q1,
    Q_2 => Q2,
    Q_3 => Q3,
    Q_4 => Q4,
    Q_5 => Q5,
    Q_6 => Q6,
    Q_7 => Q7
    );


Seg_7 : LUT_16_7
port map(
    I => Q7,
    D => Seg_7_Display
    );
    
Anode <= "1110";
LED <= Q7;



end Behavioral;
