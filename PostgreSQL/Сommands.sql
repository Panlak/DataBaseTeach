
DROP TABLE Сommands;
TRUNCATE TABLE Сommands;
CREATE TABLE Сommands
(
	Command_Id SERIAL NOT NULL PRIMARY KEY,
    Command_Name VARCHAR(40) NOT NULL,
	Earnings bigint NOT NULL ,
    Country_Name_Team VARCHAR(40) NOT NULL,
    CONSTRAINT Сountry 
    FOREIGN KEY(Country_Name_Team) REFERENCES Сountries(Country_Name)
    
);
INSERT INTO Сommands (Command_Name,Country_Name_Team,Earnings)
VALUES
('TeamSpirit','Rusia',0),
('Navi','Ukraine',0),
('Dynamo','Ukraine',0),
('Stars','Romania',0),
('Bears','Canada',0),
('Penguins','France',0),
('liquid','America',0),
('Bannermen','Turkey',0),
('Outliers','Canada',0),
('Titans','Slovenia',0),
('Vikings','Netherlands',0),
('Avengers','Ukraine',0);

UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 6;


SELECT * FROM Сommands;

DROP TRIGGER emp_audit ON Results
DROP FUNCTION process_emp_audit;


CREATE OR REPLACE FUNCTION process_emp_audit () RETURNS TRIGGER AS $$
    BEGIN
	IF(TG_OP = 'INSERT') THEN
	if(NEW.FightResult = '{Win}') then
		if((select Earnings from Сommands where Сommands.Command_Id =  NEW.Team_Id)= 0 )then
			UPDATE Сommands
				SET Earnings = new.Prize where Сommands.Command_Id =  NEW.Team_Id;
		else 
			UPDATE Сommands
			SET Earnings = Earnings+new.Prize where Сommands.Command_Id =  NEW.Team_Id;
		end if;
	else
	if((NEW.FightResult = '{Lose}')) then
	if((select Earnings from Сommands where Сommands.Command_Id =  NEW.Team_Id)= 0 )then
			UPDATE Сommands
				SET Earnings = new.Prize where Сommands.Command_Id =  NEW.Team_Id;
		else 
			UPDATE Сommands
			SET Earnings = Earnings+new.Prize where Сommands.Command_Id =  NEW.Team_Id;
		end if;
	end if;
	END IF;	
	IF(TG_OP = 'UPDATE') THEN
	UPDATE Сommands
	SET Earnings = new.Prize
	WHERE Сommands.Command_Id =  NEW.EnemyTeam_Id;
	end if;
	IF(TG_OP='DELETE') THEN
	UPDATE Сommands
	SET Earnings =NEW.Prize
	WHERE Сommands.Command_Id =  NEW.EnemyTeam_Id;
	end if;
	RETURN NULL;
	end if;
    END;
$$ LANGUAGE plpgsql;
			
CREATE TRIGGER emp_audit
AFTER INSERT OR UPDATE  OR DELETE ON Results
    FOR EACH ROW EXECUTE PROCEDURE process_emp_audit ();	
	
	
	
	
	
	
	
DROP TRIGGER trig_copy ON Сommands;
	
CREATE TRIGGER trig_copy
     AFTER INSERT ON Сommands VALUE(Earnings)
     FOR EACH ROW
     EXECUTE PROCEDURE earnings();

SELECT * FROM Сommands;








