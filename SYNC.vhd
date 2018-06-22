library ieee;
use ieee.std_logic_1164.all;
use work.my.all;

ENTITY SYNC IS
	GENERIC (CLOCK_50_divider: INTEGER := 50000000); -- 50MHz
	PORT(
		CLK: IN STD_LOGIC;
		HSYNC: OUT STD_LOGIC;
		VSYNC: OUT STD_LOGIC;
		R: OUT STD_LOGIC;
		G: OUT STD_LOGIC;
		B: OUT STD_LOGIC;
		KEYS: IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END SYNC;


ARCHITECTURE MAIN OF SYNC IS
-----800x600 @ 72 Hz pixel clock 108 MHz
	
	SIGNAL sqPos_X: INTEGER RANGE 0 TO 1040:=600;
	SIGNAL sqPos_Y: INTEGER RANGE 0 TO 1040:=300;
	SIGNAL sqSpin_X, sqSpin_Y: STD_LOGIC:='0';
	SIGNAL speed: INTEGER RANGE 4 TO 10:=4;
	SIGNAL playerPos_X: INTEGER RANGE 0 TO 1040:=600;
	SIGNAL playerPos_Y: INTEGER RANGE 0 TO 1040:=650;
	SIGNAL Xsize1, Ysize1, Sqsize1: INTEGER RANGE 0 TO 1040; 
	SIGNAL dirX1, dirY1, trig, keySig2, keySig3: STD_LOGIC:='0';
	SIGNAL DRAW: STD_LOGIC_VECTOR(10 downto 1):="0000000000";
	SIGNAL HPOS: INTEGER RANGE 0 TO 1040:=0;
	SIGNAL VPOS: INTEGER RANGE 0 TO 666:=0;
	SIGNAL obsPos_X, obsPos_Y, obsXSize, obsYSize, obsSpeed: obsArray;
	SIGNAL texto: CHARACTER;
	SIGNAL textoCursor_X: INTEGER RANGE 0 TO 1040:=600;
	SIGNAL textoCursor_Y: INTEGER RANGE 0 TO 1040:=300;
	SIGNAL texto_size: INTEGER RANGE 0 TO 600:=300;
BEGIN
	simpleDebouncerChannelkeys2: WORK.simpleDebouncer
		GENERIC MAP(CLOCK_50_divider)
		PORT MAP(
			CLK,
			KEYS(2),
			keySig2
		);
	simpleDebouncerChannelkeys3: WORK.simpleDebouncer
		GENERIC MAP(CLOCK_50_divider)
		PORT MAP(
			CLK,
			KEYS(3),
			keySig3
		);	
	Xsize1<=100;
	Ysize1<=10;
	Sqsize1<=10;
	dirY1<=trig;
	Ret(HPOS, VPOS, playerPos_X, playerPos_Y, Xsize1, Ysize1, DRAW(1));
	sq(HPOS, VPOS, sqPos_X, sqPos_Y, Sqsize1, DRAW(2));
	
	obsXSize(1)<=100; obsYSize(1)<=10; obsPos_Y(1)<=550;
	obsXSize(2)<=110; obsYSize(2)<=10; obsPos_Y(2)<=500;
	obsXSize(3)<=120; obsYSize(3)<=10; obsPos_Y(3)<=460;
	obsXSize(4)<=130; obsYSize(4)<=10; obsPos_Y(4)<=420;
	obsXSize(5)<=140; obsYSize(5)<=10; obsPos_Y(5)<=390;
	obsXSize(6)<=150; obsYSize(6)<=10; obsPos_Y(6)<=350;
	obsXSize(7)<=160; obsYSize(7)<=10; obsPos_Y(7)<=150;
	
	obstaculo(HPOS, VPOS, obsPos_X(1), obsPos_Y(1), obsXSize(1), obsYSize(1), DRAW(3));
	obstaculo(HPOS, VPOS, obsPos_X(2), obsPos_Y(2), obsXSize(2), obsYSize(2), DRAW(4));
	obstaculo(HPOS, VPOS, obsPos_X(3), obsPos_Y(3), obsXSize(3), obsYSize(3), DRAW(5));
	obstaculo(HPOS, VPOS, obsPos_X(4), obsPos_Y(4), obsXSize(4), obsYSize(4), DRAW(6));
	obstaculo(HPOS, VPOS, obsPos_X(5), obsPos_Y(5), obsXSize(5), obsYSize(5), DRAW(7));
	obstaculo(HPOS, VPOS, obsPos_X(6), obsPos_Y(6), obsXSize(6), obsYSize(6), DRAW(8));
	obstaculo(HPOS, VPOS, obsPos_X(7), obsPos_Y(7), obsXSize(7), obsYSize(7), DRAW(9));
	
	PROCESS(keySig2, keySig3)
	BEGIN
		IF(keySig2'event and keySig2='0')THEN
			speed<=speed+1;
			IF (speed>10)THEN
				speed<=4;
			END IF;
		ELSIF(keySig3'event and keySig3='0')THEN
--			speed<=speed-1;
--			IF (speed>10)THEN
--				speed<=10;
--			END IF;
		END IF;
	END PROCESS;
		
	PROCESS(CLK)
		VARIABLE count, count1, count2, count3, count4, count5, count6, count7: INTEGER RANGE 0 TO CLOCK_50_divider;
	BEGIN
		IF(CLK'EVENT AND CLK='1')THEN
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			count  := count  + 1;
			count1 := count1 + 1;
			count2 := count2 + 1;
			count3 := count3 + 1;
			count4 := count4 + 1;
			count5 := count5 + 1;
			count6 := count6 + 1;
			count6 := count6 + 1;
			--Deslocamento obs:
			IF (count1=CLOCK_50_divider/obsSpeed(1)) THEN
				obsPos_X(1)<=obsPos_X(1)+1;
				count1 := 0;
			END IF;
			IF (count2=CLOCK_50_divider/obsSpeed(2)) THEN
				obsPos_X(2)<=obsPos_X(2)+1;
				count2 := 0;
			END IF;
			IF (count3=CLOCK_50_divider/obsSpeed(3)) THEN
				obsPos_X(3)<=obsPos_X(3)+1;
				count3 := 0;
			END IF;
			IF (count4=CLOCK_50_divider/obsSpeed(4)) THEN
				obsPos_X(4)<=obsPos_X(4)+1;
				count4 := 0;
			END IF;
			IF (count5=CLOCK_50_divider/obsSpeed(5)) THEN
				obsPos_X(5)<=obsPos_X(5)+1;
				count5 := 0;
			END IF;
			IF (count6=CLOCK_50_divider/obsSpeed(6)) THEN
				obsPos_X(6)<=obsPos_X(6)+1;
				count6 := 0;
			END IF;
			IF (count7=CLOCK_50_divider/obsSpeed(7)) THEN
				obsPos_X(7)<=obsPos_X(7)+1;
				count7 := 0;
			END IF;
			--Deslocamento bola:
			IF (count=CLOCK_50_divider/(speed*100)) THEN
				IF(sqSpin_X='1')THEN
					sqPos_X<=sqPos_X+1;
				ELSE 
					sqPos_X<=sqPos_X-1;
				END IF;
				IF(sqSpin_Y='1')THEN
					sqPos_Y<=sqPos_Y+1;
				ELSE 
					sqPos_Y<=sqPos_Y-1;
				END IF;
				count := 0;
			END IF;

			--Printer
			IF(DRAW(9)='1')THEN
				R<='0';
				G<='1';
				B<='0';
			ELSIF (DRAW(2)='1')THEN
				R<='1';
				G<='1';
				B<='0';
			ELSIF (DRAW(3)='1')THEN
				R<='1';
				G<='1';
				B<='0';
			ELSIF (DRAW(4)='1')THEN
				R<='0';
				G<='1';
				B<='0';
			ELSIF (DRAW(5)='1')THEN
				R<='0';
				G<='1';
				B<='0';
			ELSIF (DRAW(6)='1')THEN
				R<='0';
				G<='1';
				B<='0';
			ELSIF (DRAW(7)='1')THEN
				R<='0';
				G<='1';
				B<='0';
			ELSIF (DRAW(8)='1')THEN
				R<='0';
				G<='1';
				B<='0';
			ELSIF (DRAW(1)='1')THEN
				R<='1';
				G<='0';
				B<='1';
			ELSE
				IF(trig='1')THEN--Damage: Tela vermelha
					IF(sqPos_Y<600)THEN
						trig<='0';
					END IF;
					R<='1';
					G<='0';
					B<='0';
				ELSE
					R<='0';
					G<='0';
					B<='0';
				END IF;
			END IF;
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
			IF(HPOS<1040)THEN
				HPOS<=HPOS+1;
			ELSE
				--48.076923076923 kHz
				HPOS<=0;
				
				IF(VPOS<666)THEN
					VPOS<=VPOS+1;
				ELSE
					VPOS<=0;
				--************************************
					--72 Hz
					--Colisão de Borda:
					IF(sqPos_X<240)THEN
						sqSpin_X <= '1';
					ElSIF(sqPos_X>1040-Sqsize1)THEN
						sqSpin_X <= '0';
					END IF;
					IF(sqPos_Y<66)THEN
						sqSpin_Y <= '1';
					ELSIF(sqPos_Y>666-Sqsize1)THEN
						sqSpin_Y <= '0';
						trig<='1';
					END IF;
					

			
					--Colisão:
					IF(sqPos_Y > playerPos_Y-Ysize1-6 and playerPos_X-Sqsize1 < sqPos_X and sqPos_X < playerPos_X+Xsize1)THEN
						sqSpin_Y <= '0';
					END IF;
					
					--Controle:			
					IF(KEYS(0)='0')THEN
						playerPos_X<=playerPos_X-5;
						IF(playerPos_X<=240)THEN
							playerPos_X<=240;
						END IF;
					END IF;
					IF(KEYS(1)='0')THEN
						playerPos_X<=playerPos_X+5;
						IF(playerPos_X>=1040-Xsize1)THEN
							playerPos_X<=1040-Xsize1;
						END IF;
					END IF;
				--************************************		
				END IF;
			END IF;
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++				
			IF((HPOS>0 AND HPOS<240) OR (VPOS>0 AND VPOS<66))THEN---Região Escura
				R<='0';
				G<='0';
				B<='0';
			END IF;
			IF(HPOS>56 AND HPOS<176)THEN----HSYNC
				HSYNC<='0';
			ELSE
				HSYNC<='1';
			END IF;
			IF(VPOS>0 AND VPOS<43)THEN---vsync
				VSYNC<='0';
			ELSE
				VSYNC<='1';
			END IF;
		END IF;
	END PROCESS;
END MAIN;