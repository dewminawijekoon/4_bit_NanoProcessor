----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2024 09:20:23 AM
-- Design Name: 
-- Module Name: Slow_Clk - Behavioral
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

entity Slow_Clk is
  Port (Clk_In : in STD_LOGIC;
        Clk_Out : out STD_LOGIC );
end Slow_Clk;

architecture Behavioral of Slow_Clk is

signal Count : integer := 1;
signal Clk_Status : STD_LOGIC := '0';

begin
    process (Clk_In) begin
    if (rising_edge(Clk_In)) then
        Count <= Count + 1;
        if (Count = 50000000 ) then -- Count 500000000 cycles to get a reasonable clock cycle.
            Clk_Status <= not Clk_Status;
            Clk_Out <= Clk_Status;
            Count <= 1;
        end if;
    end if;
end process;


end Behavioral;
