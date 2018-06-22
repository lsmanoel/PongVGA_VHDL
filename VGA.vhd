library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY VGA IS
	GENERIC (CLOCK_50_divider: INTEGER := 50000000);
	PORT(
		CLOCK_50: IN STD_LOGIC;
		VGA_HS,VGA_VS: OUT STD_LOGIC;
		SW: STD_LOGIC_VECTOR(1 downto 0):="00";
		KEY: STD_LOGIC_VECTOR(3 DOWNTO 0);
		VGA_R,VGA_B,VGA_G: OUT STD_LOGIC
	);
END VGA;


ARCHITECTURE MAIN OF VGA IS
	SIGNAL VGACLK,RESET:STD_LOGIC;
	COMPONENT SYNC IS
		GENERIC(CLOCK_50_divider: INTEGER);
		PORT(
			CLK: IN STD_LOGIC;
			HSYNC: OUT STD_LOGIC;
			VSYNC: OUT STD_LOGIC;
			R: OUT STD_LOGIC;
			G: OUT STD_LOGIC;
			B: OUT STD_LOGIC;
			KEYS: IN STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT SYNC;
	
BEGIN 
	C1: SYNC GENERIC MAP(CLOCK_50_divider)PORT MAP(CLOCK_50,VGA_HS,VGA_VS,VGA_R,VGA_G,VGA_B,KEY);
END MAIN;
 