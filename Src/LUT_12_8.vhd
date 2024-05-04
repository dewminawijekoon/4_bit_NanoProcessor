----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 06:58:01 AM
-- Design Name: 
-- Module Name: LUT_12_8 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LUT_12_8 is
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           I : out STD_LOGIC_VECTOR (11 downto 0));
end LUT_12_8;

architecture Behavioral of LUT_12_8 is


--    type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
--        signal PROGRAM_ROM : rom_type := (
           -- "100010000011", -- 0 -- MOVI R1, 3
           -- "100100000001", -- 1 -- MOVI R2, 1
           -- "010100000000", -- 2 -- NEG R2
           -- "001110010000", -- 3 -- ADD R7, R1
           -- "000010100000", -- 4 -- ADD R1, R2
           -- "110010000111", -- 5 -- JZR R1, 7 
           -- "110000000011", -- 6 -- JZR R0, 3
            --"110000000000"  -- 7 -- END
            
--           "100010000001",   -- 0 -- MOVI R1, 1
--           "100100000010",   -- 1 -- MOVI R1, 2
--          "100110000011",   -- 2 -- MOVI R1, 3
--           "001110010000",   -- 3 -- ADD R7, R1
--           "001110100000",   -- 4 -- ADD R7, R2
--           "001110110000",   -- 5 -- ADD R7, R3
--           "101110000000",   -- 6 -- MOVI R7, 0
--           "110000000000"    -- 7 -- JRZ R0, 0            
--        );

---- Program that displays numbers by decrementing 10 by 1
type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
    signal PROGRAM_ROM : rom_type := (
        "101110001010", -- 0 -- MOVI R7, 10
        "100100000001", -- 1 -- MOVI R2, 1
        "010100000000", -- 2 -- NEG R2
        "001110100000", -- 3 -- ADD R7, R2
        "111110000111", -- 4 -- JZR R7, 7
        "110000000011", -- 5 -- JZR R0, 3
        "111110000111", -- 6 -- JZR R1, 7 
        "110000000000"  -- 7 -- END
   );   
     
begin
    I <= PROGRAM_ROM(to_integer(unsigned(D)));
end Behavioral;
