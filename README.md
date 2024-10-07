# 4_bit_NanoProcessor - Lab 9 & 10 (Group 31)

## Overview

The lab task was to build a 4bit processor using Xilinx Vivado(VHDL), simulate the process and test the build on a Basys3 board. Our workflow for the project is given below.

1. Brainstorm the idea using given [guide.](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/Lab%209-10%20_%20Microprocessor.pdf)
1. Creating the project timeline.
1. Assigning tasks.
1. Coding, testing and simulation.
1. Assembling units.
1. Testing on the board.
1. Brainstorming for implementing extra features.

## Features
- 8 4 - bit registers
- 8 12 - bit instructions
- 8 instructions can be stored
- 7 Segment Display Unit
- 4 bit signed binary LED output
- Overflow and Zero Flags
- ALU with ADD, SUB and comparator functions

## Highlevel Architectural Design

Following is the highlevel design architecture of the 4bit nanoprocessor implementation.

![Schematic](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/Schematic_NanoProcessor_4.jpg)

## Optimization
- The basic version of nanoprocessor consumes 32 LUTs, 455 FFs, and 0.075W power.

![Power Consumption of Basic NanoProcessor](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/Power_Consumption_NanoProcessor_basic.png)

- The advanced version of nanoprocessor consumes 39 LUTs, 45 FFs, and 0.081W power.

![Power Consumption of NanoProcessor with more outputs and comparator function](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/Power_Consumption_NanoProcessor_Advanced.png)

- Only key difference between basic and advanced designs is the comparator. It involves if conditions and outputs to 3 LEDs. This drastically increased 32 LUT count to 39. 
 - We noted that including 7 Segment Display inside NanoProcessor.vhd increases no.of outputs related and involves more busses resulting increased LUT count. Therefore, we connected Clock, 7 Segment Display and NanoProcessor in a higher level of hierachy.

## Overcoming Obstracles
#### 1. Instruction Decoder is not working 
> Initially, we coded the instruction decoder using if else statements and we couldn't simulate the unit seperately. Because of it, whole system didn't simulate properly. After, we unit tested each untested component and one problem was with instruction decoder. Nested if conditions were poorly written and simulation outputs were undefined. We simplified the whole logic removing if else conditions. After few attempts, unit test was successful.

#### 2.  Logic error in the NEG function
> NEG statements inputs a register address, negates it and stores in the same address. In our Add/ Sub unit, we input a sub_flag which enables subtraction in the add/ sub unit. Mux_A was linking the given register address and Mux_B was linking '0' to the add/ sub unit. This equals to (output = R_A - 0) which results R_A. But, we need (-R_A). After several highlevel ideas to redesign the whole add/ sub unit, we found an logical answer to the problem. "Commutative law of addition". Swapping the links from Mux_A and Mux_B to add/ sub unit doesn't change the addition(R_A + r_B = R_B + R_A), but changes negation(0 - R_A = -R_A). No change of overall design implemented. This improved the system performance drastically.

#### 3. Undefined Registers(D FlipFlops) -> Undefined NanoProcessor Outputs.
> After a considerable amount of time, we managed to unit test each element, wire them using signals, and complete the system. TestBench files were created to simulate the nano processor finally. To check the functionality we linked all the registers as output. But, though clock and reset inputs worked, no outpus were visible. The problem was not initializing D FlipFlops in registers. So, We initialized D FlipFlops using reset signal and simulation was successful.

#### 4. FPGA Board refuses to connect.
> New Microsoft Defender has cool features. But, slows process of amateur developers. Our barrier was Memory Integrity feature. It prevents external devices to read/ write our computer. This resulted in serious errors in Vivado to not to identify board. Few google searches rectified the error.

PS : During the project, we met with many more obstracles. But, most of them were able to debug using error, warning messages given in the log. 

## Future Improvements
Following is the highlevel design schematic of the proposed 8bit nano processor.

![Advanced NanoProcessor](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/Advanced_NanoProcessor_8bit.png) 

- ALU includes add/ sub, div/ mod, multiplication, increment/ decrement and comparator functions
- Includes 17 bit instructions. Program rom can store 16 instructions
- 7 segment display
- 8 LED output
- Overflow, Zero, Parity, Negative flags

## Assembly programs(with machine code) running in the ROM

- Factorial of 3
```sh
        "100010000011", -- 0 -- MOVI R1, 3
        "100100000001", -- 1 -- MOVI R2, 1
        "010100000000", -- 2 -- NEG R2
        "001110010000", -- 3 -- ADD R7, R1
        "000010100000", -- 4 -- ADD R1, R2
        "110010000111", -- 5 -- JZR R1, 7 
        "110000000011", -- 6 -- JZR R0, 3
        "110000000000"  -- 7 -- END
```
- Factorial of 3(Alternate Program)
```sh
            
        "100010000001", -- 0 -- MOVI R1, 1
        "100100000010", -- 1 -- MOVI R1, 2
        "100110000011", -- 2 -- MOVI R1, 3
        "001110010000", -- 3 -- ADD R7, R1
        "001110100000", -- 4 -- ADD R7, R2
        "001110110000", -- 5 -- ADD R7, R3
        "101110000000", -- 6 -- MOVI R7, 0
        "110000000000"  -- 7 -- JRZ R0, 0        
```

- Decrementing from 10 by 1.
```sh
        "101110001010", -- 0 -- MOVI R7, 10
        "100100000001", -- 1 -- MOVI R2, 1
        "010100000000", -- 2 -- NEG R2
        "001110100000", -- 3 -- ADD R7, R2
        "111110000111", -- 4 -- JZR R7, 7
        "110000000011", -- 5 -- JZR R0, 3
        "111110000111", -- 6 -- JZR R1, 7 
        "110000000000"  -- 7 -- END
```

## VHDL codes of the design

Following codes are in a hierachy from 1 to 3. Level 1 are independent sources. Each above level is built upon below levels.

### LEVEL 01

- Half Adder
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity HA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Carry : out STD_LOGIC;
           Sum : out STD_LOGIC);
end HA;

architecture Behavioral of HA is

begin
    Sum <= A XOR B;
    Carry <= A AND B;

end Behavioral;
```

- LUT_16_7(7 Segment Display)
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity LUT_16_7 is
  Port (I : in STD_LOGIC_VECTOR (3 downto 0);
        D : out STD_LOGIC_VECTOR (6 downto 0) );
end LUT_16_7;

architecture Behavioral of LUT_16_7 is
  type rom_type is array (0 to 15) of STD_LOGIC_VECTOR(6 downto 0);
    signal sevenSegment_ROM : rom_type :=(
      "1000000",-- 0
      "1111001",-- 1
      "0100100",-- 2
      "0110000",-- 3
      "0011001",-- 4
      "0010010",-- 5
      "0000010",-- 6
      "1111000",-- 7
      "0000000",-- 8
      "0010000",-- 9
      "0001000",-- a
      "0000011",-- b
      "1000110",-- c
      "0100001",-- d
      "0000110",-- e
      "0001110" -- f
        );  

begin
  D <= sevenSegment_ROM(to_integer(unsigned(I)));
end Behavioral;
```
- LUT_12_8(Program Rom)
```sh
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
 
-- Factorial of 3
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
--           "100110000011",   -- 2 -- MOVI R1, 3
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
```
- Multiplexer_2_3
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2_3 is
    Port ( I_0 : in STD_LOGIC_VECTOR (2 downto 0);
           I_1 : in STD_LOGIC_VECTOR (2 downto 0);
           Selector : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0));
end Mux_2_3;

architecture Behavioral of Mux_2_3 is

begin
    with Selector select Q <=
        I_0 when '0',
        I_1 when '1',
        (others => 'U') when others;

end Behavioral;
```

- Multiplexer_2_4
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2_4 is
    Port ( I_0 : in STD_LOGIC_VECTOR (3 downto 0);
           I_1 : in STD_LOGIC_VECTOR (3 downto 0);
           Selector : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_2_4;

architecture Behavioral of Mux_2_4 is

begin
  with Selector select Q <=
    I_0 when '0',
    I_1 when '1',
    (others => 'U') when others;


end Behavioral;
```

- Multiplexer_8_4
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_8_4 is
    Port ( I_0 : in STD_LOGIC_VECTOR (3 downto 0);
           I_1 : in STD_LOGIC_VECTOR (3 downto 0);
           I_2 : in STD_LOGIC_VECTOR (3 downto 0);
           I_3 : in STD_LOGIC_VECTOR (3 downto 0);
           I_4 : in STD_LOGIC_VECTOR (3 downto 0);
           I_5 : in STD_LOGIC_VECTOR (3 downto 0);
           I_6 : in STD_LOGIC_VECTOR (3 downto 0);
           I_7 : in STD_LOGIC_VECTOR (3 downto 0);
           Selector : in STD_LOGIC_VECTOR (2 downto 0);
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_8_4;

architecture Behavioral of Mux_8_4 is
    
begin
    with Selector select
        Q <= I_0 when "000",
             I_1 when "001",
             I_2 when "010",
             I_3 when "011",
             I_4 when "100",
             I_5 when "101",
             I_6 when "110",
             I_7 when "111",
            (others => 'U') when others;


end Behavioral;
```

- Slow Clock
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
```

- Decoder_3_8
```sh
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
```
- Instruction Decoder
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
```

- Program Counter_3
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
```
- 4 bit Register
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg_4 is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           En : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end Reg_4;

architecture Behavioral of Reg_4 is


begin
    process(Clk) begin
        if(rising_edge(Clk)) then
            if Reset = '1' then
                Q <= "0000";
            elsif En = '1' then
                Q <= D;
            end if;
        end if;
    end process;


end Behavioral;
```

### LEVEL 02
- Full Adder
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Carry_in : in STD_LOGIC;
           Sum : out STD_LOGIC;
           Carry_out : out STD_LOGIC);
end FA;

architecture Behavioral of FA is

component HA
    PORT( 
        A, B : in STD_LOGIC;
        Sum, Carry : out STD_LOGIC);
end component;

signal HA_0_Sum, HA_0_Carry, HA_1_Sum, HA_1_Carry : STD_LOGIC;  

begin
HA_0 : HA
    PORT MAP(
        A => A,
        B => B,
        Sum => HA_0_Sum,
        Carry => HA_0_Carry
    );
    
HA_1 : HA
    PORT MAP(
        A => HA_0_Sum,
        B => Carry_in,
        Sum => HA_1_Sum,
        Carry => HA_1_Carry
     );    
     
Carry_out <= HA_0_Carry OR HA_1_Carry;
Sum <= HA_1_Sum;

end Behavioral;
```

- Register Bank 
```sh 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
```
### LEVEL 03
- Add/ Sub Unit
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
```

- Incrementer
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Incrementer_3 is
  Port (D : in STD_LOGIC_VECTOR (2 downto 0);
        Q : out STD_LOGIC_VECTOR (2 downto 0));
        --Carry_Out : out STD_LOGIC);
        
end Incrementer_3;

architecture Behavioral of Incrementer_3 is

component FA
    Port(
        A: in STD_LOGIC;
        B: in STD_LOGIC;
        Carry_In : in STD_LOGIC;
        Sum : out STD_LOGIC;
        Carry_Out : out STD_LOGIC);
end component;

signal FA_0_Carry, FA_1_Carry : STD_LOGIC;

begin

FA_0 : FA
    port map(
    A => D(0),
    B => '1',
    Carry_In => '0', -- Set ground to '0'
    Sum => Q(0),
    Carry_Out => FA_0_Carry);
    
FA_1 : FA
    port map(
    A => D(1),
    B => '0',
    Carry_In => FA_0_Carry,
    Sum => Q(1),
    Carry_Out => FA_1_Carry);
    
FA_2 : FA
    port map(
    A => D(2),
    B => '0',
    Carry_In => FA_1_Carry,
    Sum => Q(2)--,
    --Carry_Out => Carry_Out);
    );
end Behavioral;
```

### LEVEL 04
- NanoProcessor
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
```
### LEVEL 05
- Processor_Overall
```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processor_4 is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (3 downto 0);
           Seg_7_Display : out STD_LOGIC_VECTOR (6 downto 0);
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Anode : out STD_LOGIC_VECTOR (3 downto 0));
end Processor_4;

architecture Behavioral of Processor_4 is
component NanoProcessor
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
end component;

component Slow_Clk
  Port (Clk_In : in STD_LOGIC;
        Clk_Out : out STD_LOGIC );
end component;

component LUT_16_7
  Port (I : in STD_LOGIC_VECTOR (3 downto 0);
        D : out STD_LOGIC_VECTOR (6 downto 0) );
end component;

signal Clk_Signal : STD_LOGIC;
signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : STD_LOGIC_VECTOR(3 downto 0);

begin

Slow_Clk_0 : Slow_Clk
port map(
    Clk_In => Clk,
    Clk_out => Clk_Signal
    );
    
    
NanoProcessor_0 : NanoProcessor
port map(
    Clk => Clk_Signal,
    Reset => Reset,
    Overflow => Overflow,
    Zero => Zero,
    Q_0 => Q0,
    Q_1 => Q1,
    Q_2 => Q2,
    Q_3 => Q3,
    Q_4 => Q4,
    Q_5 => Q5,
    Q_6 => Q6,
    Q_7 => Q7
    );


Seg_7 : LUT_16_7
port map(
    I => Q7,
    D => Seg_7_Display
    );
    
Anode <= "1110";
LED <= Q7;

end Behavioral;
```

## Simulation

- NanoProcessor

![NanoProcessor testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_NanoProcessor.png)

```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NanoProcessor_TB is
--  Port ( );
end NanoProcessor_TB;

architecture Behavioral of NanoProcessor_TB is
component NanoProcessor
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
end component;

signal Clk : STD_LOGIC := '0';
signal Reset, Overflow, Zero : STD_LOGIC := '0';
signal Q_0, Q_1, Q_2, Q_3, Q_4, Q_5, Q_6, Q_7 : STD_LOGIC_VECTOR (3 downto 0);

begin
UUT : NanoProcessor 
Port Map(
    Clk => Clk,
    Reset => Reset,
    Overflow => Overflow,
    Zero => Zero,
    Q_0 => Q_0,
    Q_1 => Q_1,
    Q_2 => Q_2,
    Q_3 => Q_3,
    Q_4 => Q_4,
    Q_5 => Q_5,
    Q_6 => Q_6,
    Q_7 => Q_7
    );

    process 
    begin
        wait for 5ns;
        Clk <= NOT(Clk);
    end process;
    
    process
    begin
    Reset <= '1';
    wait for 20ns;
        
    Reset <= '0';
    wait;
    end process;

end Behavioral;

```

- Program Counter

![Program Counter testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_PC_3.png)

```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_3_TB is
--  Port ( );
end PC_3_TB;

architecture Behavioral of PC_3_TB is

component PC_3
    Port(Clk : in STD_LOGIC;
         PC_In : in STD_LOGIC_VECTOR (2 downto 0);
         Reset : in STD_LOGIC;
         PC_Out : out STD_LOGIC_VECTOR (2 downto 0)); 
end component;

signal Clk : STD_LOGIC := '0';
signal Reset : STD_LOGIC;
signal PC_In, PC_Out : STD_LOGIC_VECTOR(2 downto 0);

begin
UUT : PC_3 
port map(
    Clk => Clk,
    PC_In => PC_In,
    Reset => Reset, 
    PC_Out => PC_Out 
    );

process 
    begin
        wait for 20ns;
        Clk <= NOT(Clk);
end process;
    
process 
    begin
        -- Index number : 220734 = 110 101 111 111 111 110
    Reset <= '1';
    wait for 100ns;
    
    Reset <='0';
    PC_in <= "110";
    wait for 200ns;
    
    PC_in <= "101";
    wait for 200ns;
    
    PC_in <= "111";
    wait for 200ns;
    
    Reset <= '1';
    PC_in <= "110";
    wait;
   
end process;

end Behavioral;
```

- Program Rom

![Program Rom testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_Program_Rom.png)

```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Rom_TB is
--  Port ( );
end Program_Rom_TB;

architecture Behavioral of Program_Rom_TB is
component LUT_12_8
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           I : out STD_LOGIC_VECTOR (11 downto 0));
end component;

signal d : std_logic_vector (2 downto 0);
signal i : std_logic_vector (11 downto 0);

begin

UUT : LUT_12_8
    port map (
        D => d,
        I => i);
        
 process
 begin
    
    -- 220131 (110101101111100011), 220185 (110101110000011001) 
    -- 220708 (110101111000100100), 220734 (110101111000111110)
    wait for 100ns;
    d <= "110";
    
    wait for 100ns;
    d <= "011";
    
    wait for 100ns;
    d <= "110";    
    
    wait for 100ns;
    d <= "111";
    
    wait for 100ns;
    d <= "100";
    
    wait for 100ns;
    d <= "011";
    
    wait for 100ns;
    d <= "001";
    
    wait for 100ns;
    d <= "010";
    
    wait;
 end process;

end Behavioral;
```

- Instruction Decoder

![Instruction Decoder testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_Instruction_Decoder.png)

```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
```

- Register Bank

![Register Bank testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_Reg_Bank.png)

```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
```

- Add Sub Unit

![Add Sub Unit testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_Add_Sub_4.png)

```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Add_sub_4_0_TB is
--  Port ( );
end Add_sub_4_0_TB;

architecture Behavioral of Add_sub_4_0_TB is

component Add_Sub_4 is
  Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
         B : in STD_LOGIC_VECTOR (3 downto 0);
         Neg : in STD_LOGIC;
         Sum : out STD_LOGIC_VECTOR (3 downto 0);
         Overflow : out STD_LOGIC;
         Zero : out STD_LOGIC);
end component;

signal a,b,sum : STD_LOGIC_VECTOR(3 downto 0);
Signal neg,overflow,zero : STD_LOGIC;

begin

UUT: Add_Sub_4
port map(
    A => a,
    B => b,
    Neg => neg,
    Sum => sum,
    Zero => zero,
    Overflow => overflow 
    );
    
process
begin

-- index numbers : 220131 (110101101111100011), 220185 (110101110000011001) 
-- 220708 (110101111000100100), 220734 (110101111000111110)

A <= "1101";
B <= "0110";
Neg <= '0';

wait for 100ns;

A <= "1111";
B <= "1000";
Neg <= '1';
wait for 100ns;

A <= "1101";
B <= "0111";
Neg <= '0';

wait for 100ns;

A <= "0000";
B <= "0110";
Neg <= '1';
wait for 100ns;

A <= "1101";
B <= "0111";
Neg <= '0';

wait for 100ns;

A <= "1000";
B <= "1001";
Neg <= '1';
wait for 100ns;

A <= "1101";
B <= "0111";
Neg <= '0';

wait for 100ns;

A <= "0000";
B <= "1111";
Neg <= '1';


wait;
end process;

end Behavioral;

```

- Comparator

![Comparator testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_Comparator.png)

```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Compatator_TB is
--  Port ( );
end Compatator_TB;

architecture Behavioral of Compatator_TB is

component Comparator_4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           A_Equals_B : out STD_LOGIC;
           A_Greater_Than_B : out STD_LOGIC;
           A_Less_Than_B : out STD_LOGIC);
end component;

signal a,b : std_logic_vector (3 downto 0);
signal aeqb, agb, alb : std_logic;

begin
UUT : Comparator_4
    port map(
        A => a,
        B => b,
        A_Equals_B => aeqb,
        A_Greater_Than_B => agb,
        A_Less_Than_B => alb
    );
process

begin
A <= "0000";
B <= "0001";
WAIT FOR 100 ns;

A <= "0001";
B <= "0001";
WAIT FOR 100 ns;

A <= "1000";
B <= "0001";
WAIT;
end process;

end Behavioral;

```

- Incrementor

![Incrementor testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_Incrementor_3.png)

```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Incrementer_3_TB is
--  Port ( );
end Incrementer_3_TB;

architecture Behavioral of Incrementer_3_TB is

component Incrementer_3 is
  Port (D : in STD_LOGIC_VECTOR (2 downto 0);
        Q : out STD_LOGIC_VECTOR (2 downto 0));
        
end component;

signal d,q : std_logic_vector (2 downto 0);

begin
UUT : Incrementer_3
    port map (
        D => d,
        Q => q);
        
process
begin

D <= "000";
wait for 100ns;

D <= "001";
wait;

end process;
 
end Behavioral;

```

- Multiplexer_2_4

![Multiplexer_2_4 testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_Mux_2_4.png)

```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2_4_TB is
--  Port ( );
end Mux_2_4_TB;

architecture Behavioral of Mux_2_4_TB is
component Mux_2_4
port(I_0 : in STD_LOGIC_VECTOR (3 downto 0);
     I_1 : in STD_LOGIC_VECTOR (3 downto 0);
     Selector : in STD_LOGIC;
     Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal I_0, I_1, Q : STD_LOGIC_VECTOR(3 downto 0);
signal Selector : STD_LOGIC;

begin
UUT: Mux_2_4
Port Map(
    I_0 => I_0,
    I_1 => I_1,
    Selector => Selector,
    Q => Q
    );
    
    process 
     begin
         I_0 <= "0001";
         I_1 <= "0100";
         Selector <= '1';
         wait for 500ns;
         
         Selector <= '0'; 
         wait;
    end process;    


end Behavioral;

```

- Multiplexer_2_3

![Multiplexer_2_3 testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_Mux_2_3.png)

```sh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2_3_TB is
--  Port ( );
end Mux_2_3_TB;

architecture Behavioral of Mux_2_3_TB is

component Mux_2_3
port(I_0 : in STD_LOGIC_VECTOR (2 downto 0);
     I_1 : in STD_LOGIC_VECTOR (2 downto 0);
     Selector : in STD_LOGIC;
     Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal I_0, I_1, Q : STD_LOGIC_VECTOR(2 downto 0);
signal Selector : STD_LOGIC;

begin
UUT: Mux_2_3
Port Map(
    I_0 => I_0,
    I_1 => I_1,
    Selector => Selector,
    Q => Q
    );
    
    process 
     begin
         I_0 <= "001";
         I_1 <= "010";
         Selector <= '1';
         wait for 500ns;
         
         Selector <= '0'; 
         wait;
    end process;    

end Behavioral;
```
- Multiplexer_8_4

![Multiplexer_8_4 testbench](https://github.com/dewminawijekoon/4_bit_NanoProcessor/blob/main/Data/TB_Mux_8_4.png)

```sh
ibrary IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_8_4_TB is
--  Port ( );
end Mux_8_4_TB;

architecture Behavioral of Mux_8_4_TB is

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

signal I_0, I_1, I_2, I_3, I_4, I_5, I_6, I_7, Q : STD_LOGIC_VECTOR(3 downto 0);
Signal Selector : STD_LOGIC_VECTOR(2 downto 0);

begin
UUT: Mux_8_4
port map(
    I_0 => I_0,
    I_1 => I_1,
    I_2 => I_2,
    I_3 => I_3,
    I_4 => I_4,
    I_5 => I_5,
    I_6 => I_6,
    I_7 => I_7,
    Selector => Selector,
    Q => Q 
    );

process
begin
    I_0 <= "0000";
    I_1 <= "0001";
    I_2 <= "0010";
    I_3 <= "0011";
    I_4 <= "0100";
    I_5 <= "0101";
    I_6 <= "0110";
    I_7 <= "0111";
    
    Selector <= "000";
    wait for 5ns;

    Selector <= "001";
    wait for 5ns;
    
     Selector <= "010";
    wait for 5ns;   
    
    Selector <= "011";
    wait for 5ns;
    
    Selector <= "100";
    wait;
        
end process;
end Behavioral;
```
## Conclusion

Project outlines the development of a 4-bit nanoprocessor using Xilinx Vivado (VHDL), emphasizing key features, optimization efforts, obstacle overcoming strategies, and future improvements. Through meticulous design and testing, the processor incorporates essential components such as registers, instructions, output units, flags, and an ALU. Optimization efforts focused on minimizing power consumption while accommodating additional features like comparators. Challenges such as logic errors and FPGA board connectivity issues were successfully addressed through systematic debugging. Future improvements include expanding to an 8-bit processor with advanced ALU functions and additional flags. Overall, the project demonstrates a structured approach to development, highlighting the importance of thorough testing, optimization, and continuous improvement in processor design.
