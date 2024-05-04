----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 07:32:27 AM
-- Design Name: 
-- Module Name: Instruction_Decoder_12_TB - Behavioral
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

entity Instruction_Decoder_12_TB is
--  Port ( );
end Instruction_Decoder_12_TB;

architecture Behavioral of Instruction_Decoder_12_TB is
component Instruction_Decoder_12
Port( I : in STD_LOGIC_VECTOR (11 downto 0);
           R_jmp_Checker : in STD_LOGIC_VECTOR (3 downto 0);
           R_Enabler : out STD_LOGIC_VECTOR (2 downto 0);
           R_A_Selector : out STD_LOGIC_VECTOR (2 downto 0);
           R_B_Selector : out STD_LOGIC_VECTOR (2 downto 0);
           Load_Selector : out STD_LOGIC;
           Add_Sub_Selector : out STD_LOGIC;
           Jmp_Flag : out STD_LOGIC;
           Jmp_Address : out STD_LOGIC_VECTOR (2 downto 0);
           R_Bank_Enabler : out STD_LOGIC;
           Imd_Val : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal I : STD_LOGIC_VECTOR(11 downto 0);
signal R_Jmp_Checker, Imd_Val : STD_LOGIC_VECTOR(3 downto 0);
signal R_Enabler, R_A_Selector, R_B_Selector, Jmp_Address : STD_LOGIC_VECTOR(2 downto 0);
signal Load_Selector, Add_Sub_Selector, Jmp_Flag, R_Bank_Enabler: STD_LOGIC;

begin
UUT : Instruction_Decoder_12
PORT MAP(
    I => I,
    R_Jmp_Checker => R_Jmp_Checker,
    Imd_Val => Imd_Val,
    R_Enabler => R_Enabler,
    R_A_Selector => R_A_Selector,
    R_B_Selector => R_B_Selector,
    jmp_Address => Jmp_Address,
    Load_Selector => Load_Selector,
    Add_Sub_Selector => Add_Sub_Selector,
    Jmp_Flag => Jmp_Flag,
    R_Bank_Enabler => R_Bank_Enabler
    );
    
process
 
begin 
    R_Jmp_Checker <= "0000";
    I <= "100100000001"; -- 1 -- MOVI R2, 1
    wait for 100ns;
    
    R_Jmp_Checker <= "0111";
    I <= "010100000000"; -- 2 -- NEG R2
    wait for 100ns;
        
    R_Jmp_Checker <= "0111";
    I <= "001110010000"; -- 3 -- ADD R7, R1
    wait for 100ns;
    
    R_Jmp_Checker <= "0000";
    I <= "110000000000"; -- 4 -- JZR R0, 3
    wait for 100ns;
          
end process; 

end Behavioral;
