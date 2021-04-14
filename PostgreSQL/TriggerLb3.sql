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
	
	
	
	
	
	
	
	
	
	
	
	
	