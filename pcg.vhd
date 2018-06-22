library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

PACKAGE MY IS
	TYPE obsArray IS ARRAY (0 TO 14) OF INTEGER RANGE 1 TO 800;
	PROCEDURE Ret(
		SIGNAL Xcur, Ycur, Xpos, Ypos, Xsize, Ysize:IN INTEGER;
		SIGNAL DRAW: OUT STD_LOGIC);
	PROCEDURE sq(
		SIGNAL Xcur, Ycur, Xpos, Ypos, Sqsize:IN INTEGER;
		SIGNAL DRAW: OUT STD_LOGIC);
	PROCEDURE obstaculo(
		SIGNAL Xcur, Ycur, Xpos, Ypos, Xsize, Ysize:IN INTEGER;
		SIGNAL DRAW: OUT STD_LOGIC);
	PROCEDURE printf(
		SIGNAL texto: CHARACTER;
		SIGNAL textoCursor_X: INTEGER RANGE 0 TO 1040;
		SIGNAL textoCursor_Y: INTEGER RANGE 0 TO 1040;
		SIGNAL texto_size: INTEGER RANGE 0 TO 600;
		SIGNAL DRAW: OUT STD_LOGIC);
END MY;
	
PACKAGE BODY MY IS
	PROCEDURE Ret(
		SIGNAL Xcur, Ycur, Xpos, Ypos, Xsize, Ysize:IN INTEGER;
		SIGNAL DRAW: OUT STD_LOGIC) IS
	BEGIN
		IF(Xcur>Xpos AND Xcur<(Xpos+Xsize) AND Ycur>Ypos AND Ycur<(Ypos+Ysize))THEN
			DRAW<='1';
		ELSE
			DRAW<='0';
		END IF;	 
	END Ret;
	
	PROCEDURE obstaculo(
		SIGNAL Xcur, Ycur, Xpos, Ypos, Xsize, Ysize:IN INTEGER;
		SIGNAL DRAW: OUT STD_LOGIC) IS
	BEGIN
		IF(Xcur<Xpos AND Xcur>(Xpos+Xsize) AND Ycur>Ypos AND Ycur<(Ypos+Ysize))THEN
			DRAW<='1';
		ELSE
			DRAW<='0';
		END IF;	 
	END obstaculo;
	
	PROCEDURE sq(
		SIGNAL Xcur, Ycur, Xpos, Ypos, Sqsize:IN INTEGER;
		SIGNAL DRAW: OUT STD_LOGIC) IS
	BEGIN
		IF(Xcur>Xpos AND Xcur<(Xpos+Sqsize) AND Ycur>Ypos AND Ycur<(Ypos+Sqsize))THEN
			DRAW<='1';
		ELSE
			DRAW<='0';
		END IF;	 
	END sq;
	
	PROCEDURE printf(
		SIGNAL texto: CHARACTER;
		SIGNAL textoCursor_X: INTEGER RANGE 0 TO 1040;
		SIGNAL textoCursor_Y: INTEGER RANGE 0 TO 1040;
		SIGNAL texto_size: INTEGER RANGE 0 TO 600;
		SIGNAL DRAW: OUT STD_LOGIC) IS
	BEGIN
--		IF()THEN
--			DRAW<='1';
--		ELSE
--			DRAW<='0';
--		END IF;	 
	END printf;
END MY;