
DROP TABLE DateOfCompetition;
CREATE TABLE DateOfCompetition
(
	DateOfCompetition_Id SERIAL NOT NULL PRIMARY KEY,
    Rang_Competition VARCHAR(20)[] NOT NULL, 
	check (Rang_Competition <@ ARRAY['Олімпійські_ігри', 'Чемпіонат_світу', 'Чемпіонат_Європи']::varchar[]),
    SportId INT NOT NULL,
    Country_NAME  VARCHAR(40) NOT NULL,
    DateEvent DATE,
    FOREIGN KEY(SportId) REFERENCES TypeSport(id_Sport),
	CONSTRAINT  Country
    FOREIGN KEY(Country_NAME) REFERENCES Сountries(Country_Name)
);
INSERT INTO DateOfCompetition(DateEvent,Rang_Competition,SportId,Country_NAME)
VALUES
('2021-3-14','{Олімпійські_ігри}',1,'Belarus'),
('2022-6-3','{Чемпіонат_світу}',2,'America'),
('2023-5-6','{Чемпіонат_Європи}',3,'Mexico'),
('2023-6-12','{Чемпіонат_світу}',5,'France'),
('2024-5-28','{Чемпіонат_Європи}',7,'Sweden'),
('2026.10.31','{Чемпіонат_світу}',8,'Brazil'),
('2030.10.11','{Чемпіонат_Європи}',10,'Netherlands'),
('2027.5.16','{Олімпійські_ігри}',12,'Ukraine'),
('2029.6.17','{Олімпійські_ігри}',4,'Belarus'),
('2030.5.26','{Чемпіонат_Європи}',11,'South Korea'),
('2027.7.31','{Чемпіонат_Європи}',1,'Ukraine'),
('2032.10.11','{Олімпійські_ігри}',8,'Ukraine'),
('2027.10.15','{Чемпіонат_світу}',2,'Mexico'),
('2029.5.15','{Чемпіонат_світу}',8,'Netherlands'),
('2031.6.21','{Чемпіонат_світу}',3,'Ukraine');


SELECT *
FROM DATEOFCOMPETITION;




CREATE TABLE DateOfCompetition_history(LIKE DateOfCompetition)



ALTER TABLE DateOfCompetition_history ADD  start_date timestamp, ADD end_date timestamp;

drop function history_insert();
CREATE OR REPLACE FUNCTION history_insert() RETURNS trigger as $$
BEGIN
	EXECUTE format('INSERT INTO %I SELECT($1).*,current_timestamp, NULL', 
				  	TG_TABLE_NAME || '_history')/* ($1).* це ми будемо все передавати запис NEW*/
	USING NEW;
	
	RETURN NEW;	
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION history_delete() RETURNS trigger as $$
BEGIN
	EXECUTE format('UPDATE %I SET end_date = current_timestamp WHERE DateOfCompetition_Id = $1 AND end_date IS NULL',
				   	TG_TABLE_NAME || '_history')
	USING OLD.DateOfCompetition_Id;
			
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER DateOfCompetition_history_update
AFTER INSERT OR UPDATE ON DateOfCompetition
FOR EACH ROW EXECUTE PROCEDURE history_insert();

/**/

CREATE TRIGGER DateOfCompetition_history_delete
AFTER UPDATE OR DELETE ON DateOfCompetition
FOR EACH ROW EXECUTE PROCEDURE history_delete();

--коли я буду обновляти дані то в таблиці result Тоже будуть обновлятися

INSERT INTO DateOfCompetition(DateEvent,Rang_Competition,SportId,Country_NAME)
VALUES ('2021.6.11','{Чемпіонат_світу}',5,'Ukraine');


INSERT INTO DateOfCompetition(DateEvent,Rang_Competition,SportId,Country_NAME)
VALUES ('2011.6.11','{Чемпіонат_світу}',8,'Mexico');


select now();

--2021-04-07 06:52:39.325278+00


INSERT INTO DateOfCompetition(DateOfCompetition_Id,DateEvent,Rang_Competition,SportId,Country_NAME)
VALUES(16,'2011.6.23','{Чемпіонат_світу}',6,'Brazil'),(18,'2016.6.11','{Чемпіонат_світу}',8,'Belarus')
ON CONFLICT(DateOfCompetition_Id) DO UPDATE SET  DateEvent = EXCLUDED.DateEvent
, Rang_Competition = EXCLUDED.Rang_Competition , SportId = EXCLUDED.SportId , Country_NAME = EXCLUDED.Country_NAME;

DELETE FROM DateOfCompetition WHERE DateOfCompetition_Id = 17;



SELECT * FROM DateOfCompetition_history ORDER BY DateOfCompetition_Id, start_date




