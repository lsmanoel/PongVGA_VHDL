library ieee;
use ieee.std_logic_1164.all;

entity simpleDebouncer is
	generic(
		CLOCK_50_divider: INTEGER := 50000000;
		delay: integer:=100;
		defaultState: std_logic:='1');
	port(
		CLOCK_50: IN STD_LOGIC;
		buttonIN: in STD_LOGIC;
		buttonOUT: out STD_LOGIC);
end;

architecture simpleDebouncer_ARCH of simpleDebouncer is
	signal buttonAux: STD_LOGIC:='0';
	signal buttonPressed: STD_LOGIC:='0';
	constant countMax: integer:= ((CLOCK_50_divider/1000)*delay)-1;
begin
	buttonAux<= buttonIn WHEN defaultState= '0' ELSE (NOT buttonIn);
	PROCESS (CLOCK_50) VARIABLE counter : INTEGER RANGE 0 TO countMax := 0;
	BEGIN 
		IF (CLOCK_50'EVENT AND CLOCK_50='1') THEN 
			IF (buttonPressed= '0' AND buttonAux= '1') THEN        --Primeiravezpressionado 
				buttonPressed<= '1'; 
				counter := 0;
			ELSIF (buttonPressed= '1' AND buttonAux= '1') THEN --Aindapressionado 
				counter := 0; 
			ELSIF (buttonPressed= '1' AND buttonAux= '0') THEN --Botãoé liberadoouumatrepidaçãoocorreu 
				IF (counter < countMax) THEN 
					counter := counter + 1; 
				ELSE 
					counter := 0; 
					buttonPressed<= '0'; 
				END IF; 
			END IF; 
		END IF; 
	END PROCESS; 
	buttonOut<= buttonPressed WHEN defaultState= '0' ELSE (NOT buttonPressed); 
END;
	