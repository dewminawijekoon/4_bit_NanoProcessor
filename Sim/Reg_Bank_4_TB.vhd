----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 10:30:58 AM
-- Design Name: 
-- Module Name: Reg_Bank_4_TB - Behavioral
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

entity Reg_Bank_4_TB is
--  Port ( );
end Reg_Bank_4_TB;

architecture Behavioral of Reg_Bank_4_TB is
component Reg_bank_4
    port(
        R_B_En : in STD_LOGIC;
        Clk : in STD_LOGIC;
        R_En : in STD_LOGIC_VECTOR (2 downto 0);
        Reset : in STD_LOGIC;
        R_Input : in STD_LOGIC_VECTOR (3 downto 0);
        R_0 : out STD_LOGIC_VECTOR (3 downto 0);
        R_1 : out STD_LOGIC_VECTOR (3 downto 0);
        R_2 : out STD_LOGIC_VECTOR (3 downto 0);
        R_3 : out STD_LOGIC_VECTOR (3 downto 0);
        R_4 : out STD_LOGIC_VECTOR (3 downto 0);
        R_5 : out STD_LOGIC_VECTOR (3 downto 0);
        R_6 : out STD_LOGIC_VECTOR (3 downto 0);
        R_7 : out STD_LOGIC_VECTOR (3 downto 0)
        );    
end component;

signal R_Input : STD_LOGIC_VECTOR(3 downto 0);
signal clk, Reset, R_B_En : STD_LOGIC := '0';
signal R_En : STD_LOGIC_VECTOR(2 downto 0);
signal R_0, R_1, R_2, R_3, R_4, R_5, R_6, R_7 : STD_LOGIC_VECTOR(3 downto 0);

begin
UUT: Reg_Bank_4
port map(
    R_B_En => R_B_En,
    Clk => Clk,
    R_En => R_En,
    Reset => Reset,
    R_Input => R_Input,
    R_0 => R_0,
    R_1 => R_1,
    R_2 => R_2,
    R_3 => R_3,
    R_4 => R_4,
    R_5 => R_5,
    R_6 => R_6,
    R_7 => R_7
    );

    process 
    begin
        wait for 5ns;
        Clk <= NOT(Clk);
    end process;
    
    process
    begin
    reset <= '1';
    wait for 5ns;
    reset <= '0';
    
    -- Index Number : 220708 = 0001 1011 0000 0010 0100
    R_B_En <= '1';
    R_En <= "000";
    wait for 5ns;
    R_Input <= "0001";    --1 R_0 is hardcoded to 0000
    wait for 100ns;
    
    R_En <= "001";
    wait for 5ns;
    R_Input <= "1011";    --b
    wait for 100ns;
    
    R_B_En <= '0';
    R_En <= "010";
    wait for 5ns;
    R_Input <= "0000";    --0
    wait for 100ns;
    
    R_En <= "011";
    wait for 5ns;
    R_Input <= "0010";    --2
    wait for 100ns;
    
    R_En <= "100";
    wait for 5ns;
    R_Input <= "0100";    --4
    wait for 100ns;
    
    R_B_En <= '1';
    R_En <= "101";
    wait for 5ns;
    R_Input <= "1000";    --8
    wait for 100ns;
    
    R_En <= "110";
    wait for 5ns;
    R_Input <= "0100";    --4
    wait for 100ns;
    
    R_En <= "111";
    wait for 5ns;
    R_Input <= "1100";    --C
    wait for 100ns;
    reset <= '1';
    wait;
        
    end process;


end Behavioral;
