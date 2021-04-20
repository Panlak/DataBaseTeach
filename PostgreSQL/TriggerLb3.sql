DROP TRIGGER emp_audit ON Results
DROP FUNCTION process_emp_audit;


CREATE OR REPLACE FUNCTION Earnings() RETURNS TRIGGER AS $$
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
					SET Earnings =  Earnings-  (old.Prize /2) + (new.Prize /2) where Сommands.Command_Id  =  NEW.Team_Id;
				UPDATE  Сommands
					SET Earnings = Earnings - (old.Prize /2) + (new.Prize /2) where Сommands.Command_Id =  NEW.EnemyTeam_Id;
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
		SET Earnings = old.Earnings -(OLD.Prize /2)
			WHERE Сommands.Command_Id =  old.Team_Id;
	UPDATE  Сommands
		SET Earnings = old.Earnings - (OLD.Prize /2) 
			WHERE Сommands.Command_Id =  old.EnemyTeam_Id;
	
END IF;						
END CASE; 
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

			
CREATE TRIGGER emp_audit
AFTER INSERT OR UPDATE  OR DELETE ON Results
    FOR EACH ROW EXECUTE PROCEDURE Earnings ();
--------------------------------------------------------------------------	
	
/*Створюю тригер і історичну таблицю*/	

DROP TABLE Results_history;

DROP FUNCTION Results_history();

CREATE TABLE Results_history (LIKE Results) -- таблиця за строктурую так як Results

ALTER TABLE Results_history ADD  start_date timestamp, ADD end_date timestamp;

--Function Insert History and Update
CREATE OR REPLACE FUNCTION history_insert() RETURNS trigger as $$
BEGIN	
EXECUTE format('INSERT INTO %I SELECT($1).*,current_timestamp, NULL',
			   TG_TABLE_NAME || '_history')
USING NEW;
	
	RETURN NEW;	
END;
$$ LANGUAGE plpgsql;	
-- Тригер UPDATE OR UPDATE
CREATE TRIGGER Results_history_update
AFTER INSERT OR UPDATE ON Results
FOR EACH ROW EXECUTE PROCEDURE history_insert();	


--Function Insert History and DELETE
CREATE OR REPLACE FUNCTION history_delete() RETURNS trigger as $$
BEGIN
	EXECUTE format('UPDATE %I SET end_date = current_timestamp WHERE Result_Id = $1 AND end_date IS NULL',
				   	TG_TABLE_NAME || '_history')
	USING OLD.Result_Id;
			
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;
-- Тригер UPDATE OR DELETE
DROP TRIGGER Results_history_delete ON Results
CREATE TRIGGER Results_history_delete
AFTER UPDATE OR DELETE ON Results
FOR EACH ROW EXECUTE PROCEDURE history_delete();






DROP TRIGGER Results_history_update ON Results
CREATE TRIGGER Results_history_update
AFTER INSERT OR UPDATE ON Results
FOR EACH ROW EXECUTE PROCEDURE history_insert();	
		
		
		

	
	
	
	
	
	
	