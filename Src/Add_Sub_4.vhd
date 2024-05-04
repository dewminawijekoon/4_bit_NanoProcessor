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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Add_Sub_4 is
  Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
         B : in STD_LOGIC_VECTOR (3 downto 0);
         Neg : in STD_LOGIC;
         Sum : out STD_LOGIC_VECTOR (3 downto 0);
         Overflow : out STD_LOGIC;
         Zero : out STD_LOGIC);
end Add_Sub_4;

architecture Behavioral of Add_Sub_4 is
  component FA
  port (
      A, B, Carry_In: in STD_LOGIC;
      Sum, Carry_Out: out STD_LOGIC
  );
  end component;

  signal Carry_0 : STD_LOGIC;
  signal Carry_1 : STD_LOGIC;
  signal Carry_2 : STD_LOGIC;
  signal Carry_3 : STD_LOGIC;
  signal B_Neg : STD_LOGIC_VECTOR (3 downto 0);
  signal Sum_Out : STD_LOGIC_VECTOR (3 downto 0);
  
begin

  B_Neg(0) <=  B(0) XOR Neg;
  B_Neg(1) <=  B(1) XOR Neg;
  B_Neg(2) <=  B(2) XOR Neg;
  B_Neg(3) <=  B(3) XOR Neg;
    
  
  FA_0 : FA
    port map (
      A => A(0),
      B => B_Neg(0),
      Carry_In => Neg,
      Sum => Sum_Out(0),
      Carry_Out => Carry_0
    );
  
  FA_1 : FA
    port map (
      A => A(1),
      B => B_Neg(1),
      Carry_In => Carry_0,
      Sum => Sum_Out(1),
      Carry_Out => Carry_1
    );
  
  FA_2 : FA
    port map (
      A => A(2),
      B => B_Neg(2),
      Carry_In => Carry_1,
      Sum => Sum_Out(2),
      Carry_Out => Carry_2
    );  

  FA_3 : FA
    port map (
      A => A(3),
      B => B_Neg(3),
      Carry_In => Carry_2,
      Sum => Sum_Out(3),
      Carry_Out => Carry_3
    );
  
  Overflow <= Carry_3 XOR Carry_2;
  Zero <= NOT (Sum_Out(0) OR Sum_Out(1) OR Sum_Out(2) or Sum_Out(3));
  Sum <= Sum_Out;

end Behavioral;