----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 10:05:11 AM
-- Design Name: 
-- Module Name: Decoder_3_8 - Behavioral
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

entity Decoder_3_8 is
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           En : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end Decoder_3_8;

architecture Behavioral of Decoder_3_8 is

begin
    process(D,En)
    begin
        if En = '1' then
            case D is
                when "000" =>
                    Q <= "00000001";
                when "001" =>
                    Q <= "00000010";
                when "010" =>
                    Q <= "00000100";
                when "011" =>
                    Q <= "00001000";
                when "100" =>
                    Q <= "00010000";
                when "101" =>
                    Q <= "00100000";
                when "110" =>
                    Q <= "01000000";
                when "111" =>
                    Q <= "10000000";
                when others =>
                    Q <= (others => '0');
            end case;
        else
            Q <= (others => '0');
        end if;
    end process;
end Behavioral;