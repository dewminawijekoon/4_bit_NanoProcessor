----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 07:29:32 AM
-- Design Name: 
-- Module Name: Instruction_Decoder_12 - Behavioral
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

entity Instruction_Decoder_12 is
    Port ( I : in STD_LOGIC_VECTOR (11 downto 0);
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
end Instruction_Decoder_12;

architecture Behavioral of Instruction_Decoder_12 is

begin

    Load_Selector <= I(11);
    Add_Sub_Selector <= I(10);
    
    R_Enabler <= I(9 downto 7);
    R_A_Selector <= I(9 downto 7);
    R_B_Selector <= I(6 downto 4);
    
    Imd_Val <= I(3 downto 0);
    
    Jmp_Flag <= NOT (R_Jmp_Checker(0) OR R_Jmp_Checker(1) OR R_Jmp_Checker(2) OR R_Jmp_Checker(3)) AND I(10) AND I(11);
    Jmp_Address <= I(2 downto 0);
    
    R_Bank_Enabler <= NOT(I(10) AND I(11));
  
end Behavioral;
