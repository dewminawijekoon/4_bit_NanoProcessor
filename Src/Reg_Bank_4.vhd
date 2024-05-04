----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 10:26:06 AM
-- Design Name: 
-- Module Name: Reg_Bank_4 - Behavioral
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

entity Reg_Bank_4 is
    Port ( R_B_En : in STD_LOGIC;
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
           R_7 : out STD_LOGIC_VECTOR (3 downto 0));
end Reg_Bank_4;

architecture Behavioral of Reg_Bank_4 is

  component Decoder_3_8
    port (
      D : in STD_LOGIC_VECTOR (2 downto 0);
      En : in STD_LOGIC;
      Q : out STD_LOGIC_VECTOR (7 downto 0)
    );
  end component;

  component Reg_4 
    port ( 
      D : in STD_LOGIC_VECTOR (3 downto 0);
      Reset : in STD_LOGIC;
      En : in STD_LOGIC;
      Clk : in STD_LOGIC;
      Q : out STD_LOGIC_VECTOR (3 downto 0)
    );
  end component;
 
  signal R_Selector : STD_LOGIC_VECTOR(7 downto 0); 
   
begin

  Decoder_3_8_0 : Decoder_3_8
    port map (
      En => R_B_En,
      D => R_En,
      Q => R_Selector
    );

  Reg_4_0 : Reg_4
    port map (
      D => "0000",  -- Hardcode R0 to "0000"
      En => R_Selector(0),
      Reset => Reset,
      Clk => Clk,
      Q => R_0
    );
  
  Reg_4_1 : Reg_4
    port map (
      D => R_Input,
      En => R_Selector(1),
      Reset => Reset,
      Clk => Clk,
      Q => R_1
    );
  
  Reg_4_2 : Reg_4
    port map (
      D => R_Input,
      En => R_Selector(2),
      Reset => Reset,
      Clk => Clk,
      Q => R_2
    );
  
  Reg_4_3 : Reg_4
    port map (
      D => R_Input,
      En => R_Selector(3),
      Reset => Reset,
      Clk => Clk,
      Q => R_3
    );
  
  Reg_4_4 : Reg_4
    port map (
      D => R_Input,
      En => R_Selector(4),
      Reset => Reset,
      Clk => Clk,
      Q => R_4
    );
  
  Reg_4_5 : Reg_4
    port map (
      D => R_Input,
      En => R_Selector(5),
      Reset => Reset,
      Clk => Clk,
      Q => R_5
    );
  
  Reg_4_6 : Reg_4
    port map (
      D => R_Input,
      En => R_Selector(6),
      Reset => Reset,
      Clk => Clk,
      Q => R_6
    );
  
  Reg_4_7 : Reg_4
    port map (
      D => R_Input,
      En => R_Selector(7),
      Reset => Reset,
      Clk => Clk,
      Q => R_7
    );


end Behavioral;
