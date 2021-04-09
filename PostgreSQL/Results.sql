DROP TABLE Results;
TRUNCATE TABLE Results;

CREATE TABLE Results
(
	Result_Id SERIAL NOT NULL PRIMARY KEY,
	EnemyTeam_Id int NOT NULL,
    Team_Id int NOT NULL,				 
	DateOfCompetition_Id INT NOT NULL,
    FightResult VARCHAR(20)[] NOT NULL
	check (FightResult <@ ARRAY['Win', 'Lose', 'Draw']::varchar[]),
	Prize bigint ,
    CONSTRAINT EnemyTeam_NAME
    FOREIGN KEY (EnemyTeam_Id) REFERENCES Сommands(Command_Id),
    CONSTRAINT Team_Id
    FOREIGN KEY(Team_Id) REFERENCES Сommands(Command_Id),
    CONSTRAINT DateOfCompetition
    FOREIGN KEY (DateOfCompetition_Id) REFERENCES DateOfCompetition(DateOfCompetition_Id)
);
TRUNCATE TABLE Results RESTART IDENTITY;
INSERT INTO Results (EnemyTeam_Id,Team_Id,DateOfCompetition_Id,FightResult,Prize)
VALUES
(4,6,2,'{Lose}',20000),
(5,1,4,'{Draw}',40000),
(6,7,3,'{Win}',70000),
(7,2,5,'{Lose}',1000000),
(2,3,7,'{Win}',10000),
(8,9,9,'{Lose}',50000),
(10,11,8,'{Win}',20000),
(9,11,10,'{Win}',1000),
(2,6,2,'{Win}',200),
(2,1,8,'{Lose}',500),
(6,2,8,'{Win}',2000000),
(5,2,8,'{Win}',150000),
(9,2,11,'{Lose}',67000),
(3,1,15,'{Win}',86000),
(12,2,15,'{Win}',124000),
(1,6,6,'{Lose}',21000),
(8,1,13,'{Win}',1000),
(11,10,14,'{Draw}',35000),
(7,9,15,'{Win}',3200),
(2,12,14,'{Lose}',15000),
(12,3,9,'{Draw}',150000);

UPDATE Results SET Prize = 1000 WHERE Result_Id = 2;
DELETE from Results where Result_Id = 3;
SELECT * FROM Results;

INSERT INTO Results (EnemyTeam_Id,Team_Id,DateOfCompetition_Id,FightResult,Prize)
VALUES(11,3,2,'{Draw}',21000)





select Result_Id,EnemyTeam_Id,Team_Id,NAME_Sport,Rang_Competition,DateOfCompetition.DateOfCompetition_Id,FightResult from Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
AND Сommands.Command_Id IN (EnemyTeam_Id)
AND Country_Name_Team = Сountries.Country_Name
AND DateOfCompetition.SportId = TypeSport.id_Sport;

------------------------------------------------------
DROP VIEW VWresults;
--------------------
CREATE VIEW VWresults AS
SELECT EnemyTeam_Id as EnemyTeam,Team_Id as TEAM,NAME_Sport as Sport,Rang_Competition,
DateOfCompetition.Country_NAME as CompetitionCountry,FightResult as Results,Prize 
FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id 
AND  DateOfCompetition.DateOfCompetition_Id IN((SELECT DateOfCompetition_Id FROM DateOfCompetition WHERE Rang_Competition = '{Чемпіонат_світу}'))
AND Сommands.Command_Id IN (Team_Id)
AND  Result_Id IN ((SELECT Result_Id FROM Results WHERE Prize > 20000))
AND Country_Name_Team = Сountries.Country_Name
AND DateOfCompetition.SportId = TypeSport.id_Sport
UNION
SELECT EnemyTeam_Id as EnemyTeam,Team_Id as TEAM,NAME_Sport as Sport,Rang_Competition,
DateOfCompetition.Country_NAME as CompetitionCountry,FightResult as Results,Prize 
FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id 
AND  DateOfCompetition.DateOfCompetition_Id IN((SELECT DateOfCompetition_Id FROM DateOfCompetition WHERE Rang_Competition = '{Чемпіонат_Європи}'))
AND  Result_Id IN ((SELECT Result_Id FROM Results WHERE Prize > 20000))
AND Сommands.Command_Id IN (Team_Id)
AND Country_Name_Team = Сountries.Country_Name
AND DateOfCompetition.SportId = TypeSport.id_Sport;
------------------------------------------------------


------------------------------------------------------
DROP VIEW Prizez;
CREATE 
VIEW Prizez as
SELECT Prize FROM  Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
AND Сommands.Command_Id IN (EnemyTeam_Id)
AND Country_Name_Team = Сountries.Country_Name
AND DateOfCompetition.SportId = TypeSport.id_Sport;
------------------------------------------------------
SELECT * FROM Prizez;


SELECT * FROM VWresults;












	
SELECT * FROM VWresults WHERE Sport IN((SELECT TypeSport.NAME_Sport FROM TypeSport WHERE NAME_Sport = 'Легка атлетика'));
UNION




CREATE OR REPLACE FUNCTION describe() RETURNS trigger as $$ 
DECLARE
	rec record;
	str text :='';
BEGIN
	IF TG_LEVEL = 'ROW' THEN 
		CASE TG_OP 
			WHEN 'DELETE' THEN rec :=OLD; str := OLD ::text; 
			WHEN 'UPDATE' THEN rec :=NEW; str :=OLD || ' -> ' || NEW;
			WHEN 'INSERT' THEN rec :=NEW; str :=NEW::text;
		END CASE; 
	END IF;
	RAISE NOTICE '% % % %: %', TG_TABLE_NAME, TG_WHEN, TG_OP,TG_LEVEL,str; 
	RETURN rec;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Trigger_before_stmt
BEFORE INSERT OR UPDATE OR DELETE ON Results 
FOR EACH ROW EXECUTE PROCEDURE describe(); 

CREATE TRIGGER VWresults
AFTER INSERT OR UPDATE OR DELETE ON Results 
FOR EACH ROW EXECUTE PROCEDURE describe();




