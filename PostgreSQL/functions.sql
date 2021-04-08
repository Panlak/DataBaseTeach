CREATE TABLE TableFunctTeach (aro FLOAT);	


DROP FUNCTION fill();
DROP FUNCTION do_commit();
DROP FUNCTION fill(integer); --коли в функції є параметр його тоже потрібно писати 
--1 ФУНКЦІЯ
CREATE FUNCTION fill() RETURNS void AS $$
INSERT INTO TableFunctTeach
	SELECT random() FROM generate_series(1,3);
	$$ LANGUAGE SQL;
------	------	------	
--2 ФУНКЦІЯ	
CREATE FUNCTION fill() RETURNS bigint AS $$
INSERT INTO TableFunctTeach
	SELECT random() FROM generate_series(1,3);
	SELECT count(*) FROM TableFunctTeach$$ LANGUAGE SQL;	
------	------	------	
--3 ФУНКЦІЯ	
CREATE FUNCTION fill() RETURNS bigint AS $$
TRUNCATE TableFunctTeach;
INSERT INTO TableFunctTeach
	SELECT random() FROM generate_series(1,3);
	SELECT count(*) FROM TableFunctTeach$$ LANGUAGE SQL;	
------	------	------	



--4 ФУНКЦІЯ	
CREATE FUNCTION do_commit() RETURNS void AS $$
COMMIT;
$$ LANGUAGE SQL;
------	------	------
--4 ФУНКЦІЯ error
-- заборонені команди керування  транзакціями (BEGIN,COMMIT, ROLLBACK і так далі), до версії 10.0 по відео зара скоріше можна
-- нетранзакціонні команди такі як (VACUUM,CREATE INDEX);
SELECT 	do_commit();
/*ERROR:  COMMIT is not allowed in a SQL function
CONTEXT:  SQL function "do_commit" during startup
SQL state: 0A000*/

--5 ФУНКЦІЯ	
CREATE FUNCTION fill(nrows integer) RETURNS bigint AS $$
TRUNCATE TableFunctTeach;
INSERT INTO TableFunctTeach
	SELECT random() FROM generate_series(1,nrows);
SELECT count(*) FROM TableFunctTeach;
$$LANGUAGE SQL;	
------	------	------

--6 ФУНКЦІЯ

CREATE FUNCTION fill(nrows IN integer,result OUT bigint) AS $$
TRUNCATE TableFunctTeach;
INSERT INTO TableFunctTeach
	SELECT random() FROM generate_series(1,nrows);
SELECT count(*) FROM TableFunctTeach;
$$LANGUAGE SQL;	

------	------	------

--7 ФУНКЦІЯ

CREATE FUNCTION fill(nrows INOUT integer) AS $$
TRUNCATE TableFunctTeach;
INSERT INTO TableFunctTeach
SELECT random() FROM generate_series(1,nrows);
SELECT count(*)::integer FROM TableFunctTeach;
$$LANGUAGE SQL;	

------	------	------


--8 ФУНКЦІЯ
CREATE FUNCTION fill(nrows INOUT integer,avarage OUT float) AS $$
TRUNCATE TableFunctTeach;
INSERT INTO TableFunctTeach
SELECT random() FROM generate_series(1,nrows);
SELECT count(*)::integer,avg(aro) FROM TableFunctTeach;
$$LANGUAGE SQL;	
------	------	------

--функція пошуку max min з двох чисел
--є така функція greatest але ми її зробимо самі
CREATE FUNCTION maximum(a integer,b integer) RETURNS integer AS $$
SELECT CASE WHEN a>b THEN a ELSE b END;
$$ LANGUAGE SQL;

--9 ФУНКЦІЯ
CREATE FUNCTION maximum(a anyelement,b anyelement, c anyelement default null)
RETURNS anyelement AS $$
	SELECT CASE
			WHEN c is NULL THEN
			x
			ELSE
				CASE WHEN x > c  THEN x ELSE c END
			END
	FROM (
	SELECT CASE WHEN a > b THEN a ELSE b END) max2(x);
$$ LANGUAGE SQL;

------	------	------
select maximum(10,20,30);


SELECT 	fill(5);


DROP TABLE TableFunctTeach;
SELECT * FROM TableFunctTeach;
------	------	------
------	------	------
------	------	------
------	------	------


DROP TABLE S ;
CREATE TABLE S (N integer);

INSERT INTO S  VALUES(1),(2),(3);

CREATE FUNCTION cnt() RETURNS bigint AS $$
SELECT count(*) FROM s;
$$ LANGUAGE SQL;

SELECT pg_sleep(1);
INSERT INTO S VALUES(4);
SELECT (SELECT count(*) FROM s), cnt(), pg_sleep(1) FROM generate_series(1,4);



















