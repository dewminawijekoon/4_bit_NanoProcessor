----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 11:10:39 AM
-- Design Name: 
-- Module Name: NanoProcessor - Behavioral
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

entity NanoProcessor is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Q_0 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_1 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_2 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_3 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_4 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_5 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_6 : out STD_LOGIC_VECTOR (3 downto 0);
           Q_7 : out STD_LOGIC_VECTOR (3 downto 0));
end NanoProcessor;

architecture Behavioral of NanoProcessor is

component PC_3
  Port (Reset : in STD_LOGIC;
        Clk : in STD_LOGIC;
        PC_in : in STD_LOGIC_VECTOR (2 downto 0); 
        PC_Out : out STD_LOGIC_VECTOR (2 downto 0));
end component;
-- wires from mux_2_3 to PC and PC to PRom and Incrementer
signal Mux_2_3_to_PC, PC_to_PRom_and_Incrementer_3 : STD_LOGIC_VECTOR(2 downto 0);


--Load Selector
component LUT_12_8
port(D : in STD_LOGIC_VECTOR (2 downto 0);
     I : out STD_LOGIC_VECTOR (11 downto 0));
end component;
--Signal from Program rom to instruction decoder
signal PRom_to_IDecoder : STD_LOGIC_VECTOR(11 downto 0);


component Instruction_Decoder_12
port(I : in STD_LOGIC_VECTOR (11 downto 0);
     R_jmp_Checker : in STD_LOGIC_VECTOR (3 downto 0);
     R_Enabler : out STD_LOGIC_VECTOR (2 downto 0);
     R_A_Selector : out STD_LOGIC_VECTOR (2 downto 0);
     R_B_Selector : out STD_LOGIC_VECTOR (2 downto 0);
     Load_Selector : out STD_LOGIC;
     Add_Sub_Selector : out STD_LOGIC;
     Jmp_Flag : out STD_LOGIC;
     Jmp_Address : out STD_LOGIC_VECTOR (2 downto 0);
     R_Bank_Enabler : out STD_LOGIC;
     Imd_Val : out STD_LOGIC_VECTOR (3 downto 0)
        );
end component;


--Wire to enable each register and whole register bank.
signal Register_Enabler : STD_LOGIC_VECTOR(2 downto 0);
signal Register_Bank_Enabler : STD_LOGIC;
signal IDecoder_to_Mux_8_4_A, IDecoder_to_Mux_8_4_B : STD_LOGIC_VECTOR(2 downto 0);
--Flag to Load Selector
signal IDecoder_to_LSelector : STD_LOGIC;
--wire to input immediate value
signal Immediate_Value_to_LSelector : STD_LOGIC_VECTOR(3 downto 0);
--Add Sub Flag to AddSub Unit
signal Add_Sub_Flag : STD_LOGIC;
--Jump Flag to Mux_2_3 and address
signal Jump_Flag : STD_LOGIC;
signal Jump_Address : STD_LOGIC_VECTOR(2 downto 0);


component Reg_Bank_4
      port(R_B_En : in STD_LOGIC;
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
end component;
--Wires from each register in register bank
signal R0, R1, R2, R3, R4, R5, R6, R7 : STD_LOGIC_VECTOR (3 downto 0);
signal LSelector_to_Reg_Bank : STD_LOGIC_VECTOR(3 downto 0);


component Mux_2_4
      port(I_0 : in STD_LOGIC_VECTOR (3 downto 0);
           I_1 : in STD_LOGIC_VECTOR (3 downto 0);
           Selector : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal Add_Sub_Sum_to_LSelector : STD_LOGIC_VECTOR (3 downto 0);


component Mux_8_4
      port(I_0 : in STD_LOGIC_VECTOR (3 downto 0);
           I_1 : in STD_LOGIC_VECTOR (3 downto 0);
           I_2 : in STD_LOGIC_VECTOR (3 downto 0);
           I_3 : in STD_LOGIC_VECTOR (3 downto 0);
           I_4 : in STD_LOGIC_VECTOR (3 downto 0);
           I_5 : in STD_LOGIC_VECTOR (3 downto 0);
           I_6 : in STD_LOGIC_VECTOR (3 downto 0);
           I_7 : in STD_LOGIC_VECTOR (3 downto 0);
           Selector : in STD_LOGIC_VECTOR (2 downto 0);
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--Wires to add/ sub unit
signal Mux_8_4_A_to_Add_Sub_Unit, Mux_8_4_B_to_Add_Sub_Unit :  STD_LOGIC_VECTOR (3 downto 0);


component Add_Sub_4
  Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
         B : in STD_LOGIC_VECTOR (3 downto 0);
         Neg : in STD_LOGIC;
         Sum : out STD_LOGIC_VECTOR (3 downto 0);
         Overflow : out STD_LOGIC;
         Zero : out STD_LOGIC);
end component;

component Incrementer_3
  Port (D : in STD_LOGIC_VECTOR (2 downto 0);
        Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;
--wire between incrementer and mux_2_3
signal Incrementer_to_Mux_2_3 : STD_LOGIC_VECTOR (2 downto 0);


component Mux_2_3
    Port ( I_0 : in STD_LOGIC_VECTOR (2 downto 0);
           I_1 : in STD_LOGIC_VECTOR (2 downto 0);
           Selector : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;


begin

PC_3_0 : PC_3
Port map(
    Reset => Reset,
    Clk => Clk,
    PC_In => Mux_2_3_to_PC,
    PC_Out => PC_to_PRom_and_Incrementer_3
    );
    
Program_Rom : LUT_12_8
Port map(
    D => PC_to_PRom_and_Incrementer_3,
    I => PRom_to_IDecoder
    );
    
Instruction_Decoder_12_0 : Instruction_Decoder_12
port map(
    I => PRom_to_IDecoder,
    R_Jmp_Checker => Mux_8_4_A_to_Add_Sub_Unit,
    R_Enabler => Register_Enabler,
    R_A_Selector => IDecoder_to_Mux_8_4_A,
    R_B_Selector => IDecoder_to_Mux_8_4_B,
    Load_Selector => IDecoder_to_LSelector,
    Add_Sub_Selector => Add_Sub_flag,
    Jmp_Flag => Jump_Flag,
    jmp_Address => Jump_Address,
    R_Bank_Enabler => Register_Bank_Enabler,
    Imd_Val => Immediate_Value_to_LSelector
    );
 
Reg_Bank_0 : Reg_Bank_4
port map(
    R_B_En => Register_Bank_Enabler,
    Clk => Clk,
    R_En => Register_Enabler,
    R_Input => LSelector_to_Reg_Bank,
    Reset => Reset,
    R_0 => R0,
    R_1 => R1,
    R_2 => R2,
    R_3 => R3,
    R_4 => R4,
    R_5 => R5,
    R_6 => R6,
    R_7 => R7   
    );

Load_Selector : Mux_2_4
port map(
    I_1 => Immediate_Value_to_LSelector,
    I_0 => Add_Sub_Sum_to_LSelector,
    Selector => IDecoder_to_LSelector,
    Q => LSelector_to_Reg_Bank
    );

Mux_8_4_A : Mux_8_4
port map(
    I_0 => R0,
    I_1 => R1,
    I_2 => R2,
    I_3 => R3,
    I_4 => R4,
    I_5 => R5,
    I_6 => R6,
    I_7 => R7,
    Selector => IDecoder_to_Mux_8_4_A,
    Q => Mux_8_4_A_to_Add_Sub_Unit   
    );
    
Mux_8_4_B : Mux_8_4
    port map(
        I_0 => R0,
        I_1 => R1,
        I_2 => R2,
        I_3 => R3,
        I_4 => R4,
        I_5 => R5,
        I_6 => R6,
        I_7 => R7,
        Selector => IDecoder_to_Mux_8_4_B,
        Q => Mux_8_4_B_to_Add_Sub_Unit   
        );
        
Add_Sub_4_0 : Add_Sub_4
port map(
    A => Mux_8_4_B_to_Add_Sub_Unit, -- swapped 
    B => Mux_8_4_A_to_Add_Sub_Unit,
    Neg => Add_Sub_flag,
    Sum => Add_Sub_Sum_to_LSelector,
    Overflow => Overflow,
    Zero => Zero
    );

Incrementer_3_0 : Incrementer_3
port map(
    D => PC_to_PRom_and_Incrementer_3,
    Q => Incrementer_to_Mux_2_3
    );

Mux_2_3_0 : Mux_2_3
port map(
     I_0 => Incrementer_to_Mux_2_3,
     I_1 => Jump_Address,
     Selector => Jump_Flag,
     Q => Mux_2_3_to_PC
    );

Q_0 <= R0;
Q_1 <= R1;
Q_2 <= R2;
Q_3 <= R3;
Q_4 <= R4;
Q_5 <= R5;
Q_6 <= R6;
Q_7 <= R7;


end Behavioral;
