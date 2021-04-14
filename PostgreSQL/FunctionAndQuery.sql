select Command_Name,
SUM(
CASE 
WHEN Сommands.Command_Id IN (Team_Id) 
AND Results.Result_Id IN((SELECT Result_Id FROM Results WHERE FightResult = '{Win}'))THEN 1  
WHEN Сommands.Command_Id IN (EnemyTeam_Id) 
AND Results.Result_Id IN((SELECT Result_Id FROM Results WHERE FightResult = '{Lose}'))THEN 1  
ELSE 0 END) AS Wins
from Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
AND Сommands.Command_Id IN (EnemyTeam_Id,Team_Id)
AND Country_Name_Team = Сountries.Country_Name
AND DateOfCompetition.SportId = TypeSport.id_Sport GROUP BY Command_Name
HAVING  maxWins() =SUM(
CASE 
WHEN Сommands.Command_Id IN (Team_Id) 
AND Results.Result_Id IN((SELECT Result_Id FROM Results WHERE FightResult = '{Win}'))THEN 1  
WHEN Сommands.Command_Id IN (EnemyTeam_Id) 
AND Results.Result_Id IN((SELECT Result_Id FROM Results WHERE FightResult = '{Lose}'))THEN 1  
ELSE 0 END) ;


CREATE OR REPLACE FUNCTION maxWins() RETURNS bigint AS $$
DECLARE
max_value bigint;
BEGIN
max_value = (SELECT MAX(Counts.wins)				 
FROM (select SUM(CASE WHEN Сommands.Command_Id IN (Team_Id) AND Results.Result_Id IN((SELECT Result_Id FROM Results WHERE FightResult = '{Win}'))THEN 1  
WHEN Сommands.Command_Id IN (EnemyTeam_Id) AND Results.Result_Id IN((SELECT Result_Id FROM Results WHERE FightResult = '{Lose}'))THEN 1  ELSE 0 END)
as wins
from Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
AND Сommands.Command_Id IN (EnemyTeam_Id,Team_Id)
AND Country_Name_Team = Сountries.Country_Name
AND DateOfCompetition.SportId = TypeSport.id_Sport GROUP BY Command_Name) AS Counts);
RETURN max_value;
END;
$$ LANGUAGE plpgsql;
SELECT maxWins();









DROP FUNCTION  maxWins();
CREATE OR REPLACE FUNCTION maxWins() RETURNS bigint AS $$
DECLARE
max_value bigint;
BEGIN
max_value = (SELECT MAX(CountWin) FROM Prizez);
RETURN max_value;
END;
$$ LANGUAGE plpgsql;
SELECT maxWins();


DROP FUNCTION  NoWin();
CREATE OR REPLACE FUNCTION NoWin() RETURNS bigint AS $$
DECLARE
max_value bigint;
BEGIN
max_value = (SELECT MIN(CountWin) FROM Prizez);
RETURN max_value;
END;
$$ LANGUAGE plpgsql;
SELECT NoWin();

DROP FUNCTION MaxLoses();
CREATE OR REPLACE FUNCTION MaxLoses() RETURNS bigint AS $$
DECLARE
max_value bigint;
BEGIN
max_value = (SELECT MAX(CountLose) FROM Prizez);
RETURN max_value;
END;
$$ LANGUAGE plpgsql;
SELECT MaxLoses();



DROP FUNCTION NoLoses();
CREATE OR REPLACE FUNCTION NoLoses() RETURNS bigint AS $$
DECLARE
max_value bigint;
BEGIN
max_value = (SELECT Min(CountLose) FROM Prizez);
RETURN max_value;
END;
$$ LANGUAGE plpgsql;
SELECT NoLoses();


CREATE  OR REPLACE FUNCTION MaxprocentWin() RETURNS bigint AS $$
DECLARE
max_value bigint;
BEGIN
max_value = (SELECT max(Procent) FROM Prizez);
RETURN max_value;
END;
$$ LANGUAGE plpgsql;


