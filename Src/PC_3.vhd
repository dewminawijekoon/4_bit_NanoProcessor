----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 06:33:44 AM
-- Design Name: 
-- Module Name: PC_3 - Behavioral
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

entity PC_3 is
    Port ( Clk : in STD_LOGIC;
           PC_In : in STD_LOGIC_VECTOR (2 downto 0);
           Reset : in STD_LOGIC;
           PC_Out : out STD_LOGIC_VECTOR (2 downto 0));
end PC_3;

architecture Behavioral of PC_3 is

begin

process(Clk, Reset, PC_In) begin
    if(Reset = '1') then
        PC_Out <= "000";
    elsif (rising_edge(Clk)) then
        PC_Out <= PC_In;
    end if;
end process;

end Behavioral;
