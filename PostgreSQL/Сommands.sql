
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

UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 1;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 2;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 3;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 4;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 5;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 6;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 7;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 8;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 9;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 10;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 11;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 12;
SELECT * FROM Сommands;

DROP TRIGGER emp_audit ON Results
DROP FUNCTION process_emp_audit;


CREATE OR REPLACE FUNCTION process_emp_audit () RETURNS TRIGGER AS $$
BEGIN
IF TG_LEVEL = 'ROW' THEN
	CASE TG_OP
		WHEN 'INSERT' THEN
			IF(NEW.FightResult = '{Win}') THEN
				if((select Earnings from Сommands where Сommands.Command_Id =  NEW.Team_Id)= 0 )then				
					UPDATE Сommands
						SET Earnings = Earnings + new.Prize where Сommands.Command_Id =  NEW.Team_Id;
				else
					UPDATE Сommands
						SET Earnings = Earnings+new.Prize where Сommands.Command_Id =  NEW.Team_Id;
				END IF;					
			ELSE IF ((NEW.FightResult = '{Lose}')) then
				IF((select Earnings from Сommands where Сommands.Command_Id =  NEW.Team_Id)= 0 )then
					UPDATE Сommands
						SET Earnings = Earnings + new.Prize where Сommands.Command_Id =  NEW.EnemyTeam_Id;
				ELSE 
					UPDATE Сommands
						SET Earnings = Earnings + new.Prize where Сommands.Command_Id =  NEW.EnemyTeam_Id;
				END IF;		
			ELSE			
				IF((select Earnings from Сommands where Сommands.Command_Id =  NEW.Team_Id)= 0 )then
					UPDATE Сommands
						SET Earnings = (new.Prize /2) where Сommands.Command_Id =  NEW.EnemyTeam_Id;
					UPDATE Сommands
						SET Earnings = (new.Prize /2) where Сommands.Command_Id =  NEW.Team_Id;
				ELSE
					UPDATE Сommands
						SET Earnings = Earnings +(new.Prize /2) where Сommands.Command_Id =  NEW.EnemyTeam_Id;
					UPDATE Сommands
						SET Earnings = Earnings +(new.Prize /2) where Сommands.Command_Id =  NEW.Team_Id;
				END IF;
			END IF;
			END IF;
WHEN 'UPDATE' THEN
-----------------------------------------------------------------------------------------------------
IF(NEW.FightResult = '{Win}') THEN
				UPDATE Сommands
					SET Earnings = new.Prize
						WHERE Сommands.Command_Id =  NEW.Team_Id;
			ELSE IF ((NEW.FightResult = '{Lose}')) then
				UPDATE Сommands
					SET Earnings = new.Prize
						WHERE Сommands.Command_Id =  NEW.EnemyTeam_Id;
			ELSE			
				UPDATE Сommands
					SET Earnings = (new.Prize /2) where Сommands.Command_Id =  NEW.Team_Id;
				UPDATE  Сommands
					SET Earnings = (new.Prize /2) where Сommands.Command_Id =  NEW.EnemyTeam_Id;
			END IF;
			END IF;
-----------------------------------------------------------------------------------------------------
WHEN 'DELETE' THEN
IF(old.FightResult = '{Win}') THEN
	UPDATE Сommands
		SET Earnings = Earnings - old.Prize
			WHERE Сommands.Command_Id =  old.Team_Id;
END IF;
IF ((old.FightResult = '{Lose}')) then
	UPDATE Сommands
		SET Earnings =  Earnings - old.Prize
			WHERE Сommands.Command_Id =  old.EnemyTeam_Id;
END IF;
IF ((old.FightResult = '{Draw}')) then
	UPDATE Сommands
		SET Earnings = Earnings -(OLD.Prize /2)
			WHERE Сommands.Command_Id =  old.Team_Id;
	UPDATE  Сommands
		SET Earnings = Earnings - (OLD.Prize /2) 
			WHERE Сommands.Command_Id =  old.EnemyTeam_Id;
	
END IF;						
END CASE; 
END IF;
RETURN NEW;
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








