----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2024 10:54:19 AM
-- Design Name: 
-- Module Name: FA - Behavioral
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

entity FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Carry_in : in STD_LOGIC;
           Sum : out STD_LOGIC;
           Carry_out : out STD_LOGIC);
end FA;

architecture Behavioral of FA is

component HA
    PORT( 
        A, B : in STD_LOGIC;
        Sum, Carry : out STD_LOGIC);
end component;

signal HA_0_Sum, HA_0_Carry, HA_1_Sum, HA_1_Carry : STD_LOGIC;  

begin
HA_0 : HA
    PORT MAP(
        A => A,
        B => B,
        Sum => HA_0_Sum,
        Carry => HA_0_Carry
    );
    
HA_1 : HA
    PORT MAP(
        A => HA_0_Sum,
        B => Carry_in,
        Sum => HA_1_Sum,
        Carry => HA_1_Carry
     );    
     
Carry_out <= HA_0_Carry OR HA_1_Carry;
Sum <= HA_1_Sum;

end Behavioral;
