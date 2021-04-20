-- Функції
-- Викликаються  в контексті виразу
-- не можуть керувати транзакціями
-- повертають результат (Зажди повертають результат)


-- Процедури
-- Викликаються оператором CALL
-- можуть керувати транзакціями (Не в всіх випадках)
-- можуть повератати результат (Можуть не повертати результат)
-- можуть повертати результат через параметри


--Процедури можна перезагружати так як в c# методи з допомогою вхідних параметрів


DROP TABLE t;

create table t 
(
	s float  
);
DROP PROCEDURE fill(nrows integer);

CREATE PROCEDURE fill(nrows integer)
AS $$
TRUNCATE t;
INSERT INTO t SELECT random() FROM generate_series(1,nrows);
$$	LANGUAGE sql;

CALL fill(nrows => 5);



CALL insert_data(1, 2);

--Процедури можуть так само мати INOUT параметри с допомогою яких процедура
-- може повертати значення OUT-параметри покащо не підтримуються


CREATE PROCEDURE fill(IN nrows integer , INOUT avarage float) -- який буде повертати середнє значення
AS $$
	TRUNCATE t;
	INSERT INTO t SELECT random() FROM generate_series(1,nrows);
	SELECT avg(s) FROM t; --як у функції
$$ LANGUAGE sql;	

CALL fill(5,NULL);/*Вхідне значення не використовується*/

SELECT s FROM t;

------------------------------------------------------------------------------------------------------



---------------------------------------------------
DROP PROCEDURE Sponsor(IN earning FLOAT ,IN IdCommand INT, INOUT CommandName VARCHAR, INOUT  Earnings FLOAT, INOUT Procent text)
-- 3 параметри для INOUT
-------------------------------------------------------

--Процедура яка виводе інформацію і обновляє інформацію в таблиці Сommands
CREATE PROCEDURE Sponsor(IN earning FLOAT ,IN IdCommand INT, INOUT CommandName VARCHAR, INOUT  Earnings FLOAT, INOUT ProcentWin text)
AS $$
	UPDATE Сommands SET Earnings = (SELECT Earnings FROM Сommands WHERE Command_Id =  IdCommand)  + earning WHERE Command_Id = IdCommand;
	SELECT Command_Name,Earnings,Procent as ProcentWin FROM Prizez WHERE  Command_Name = (SELECT Command_Name FROM Сommands 
																						 WHERE Command_Id = IdCommand); 
$$ LANGUAGE SQL;
CALL Sponsor(100.0,6,NULL,NULL,NULL)
-------------------------------------------------------
DROP PROCEDURE Sponsor(IN IdCommand int,INOUT CommandName VARCHAR, INOUT CountryName VARCHAR,INOUT Earnings FLOAT);
--------------------------------------------------------
CREATE PROCEDURE Sponsor(IN IdCommand int,INOUT CommandName VARCHAR, INOUT Earnings FLOAT,INOUT ProcentWin text)--перезагрузка процедури
AS $$
	SELECT Command_Name,Earnings,Procent as ProcentWin FROM Prizez WHERE  Command_Name = (SELECT Command_Name FROM Сommands 
																						 WHERE Command_Id = IdCommand); 
$$ LANGUAGE SQL;
CALL Sponsor(8,NULL,NULL,NULL)



SELECT * FROM Сommands;










