DROP VIEW Prizez;
CREATE 
VIEW Prizez as
SELECT Command_Name,Earnings,CountWin ,CountLose,  
Concat(round(CountWin/(CountLose + CountWin),2),'%') AS procent FROM
(SELECT Command_Name,Сommands.Earnings as Earnings,SUM(CASE 												
WHEN Сommands.Command_Id IN (Team_Id) 
AND Results.Result_Id IN((SELECT Result_Id FROM Results WHERE FightResult = '{Win}'))THEN 1.0  
WHEN Сommands.Command_Id IN (EnemyTeam_Id) 
AND Results.Result_Id IN((SELECT Result_Id FROM Results WHERE FightResult = '{Lose}'))THEN 1.0  
ELSE 0.0 END) AS CountWin,
SUM(
CASE 
WHEN Сommands.Command_Id IN (Team_Id) 
AND Results.Result_Id IN((SELECT Result_Id FROM Results WHERE FightResult = '{Win}'))THEN 0.0  
WHEN Сommands.Command_Id IN (EnemyTeam_Id) 
AND Results.Result_Id IN((SELECT Result_Id FROM Results WHERE FightResult = '{Lose}'))THEN 0.0 
ELSE 1.0 END) AS CountLose
FROM  Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
AND Сommands.Command_Id IN (EnemyTeam_Id,Team_Id)
AND Country_Name_Team = Сountries.Country_Name
AND DateOfCompetition.SportId = TypeSport.id_Sport GROUP BY Command_Name,Earnings ORDER BY CountWin DESC) as Procent





SELECT * FROM Prizez;


SELECT Command_Name,CountWin,CountLose,Earnings,Procent  FROM Prizez WHERE  Procent   = MaxprocentWin();
SELECT Command_Name,CountWin,CountLose,Earnings,Procent  FROM Prizez WHERE  CountWin  = maxWins();
SELECT Command_Name,CountWin,CountLose,Earnings,Procent  FROM Prizez WHERE  CountLose = MaxLoses();
SELECT Command_Name,CountWin,CountLose,Earnings,Procent  FROM Prizez WHERE  CountLose = NoLoses();
SELECT Command_Name,CountWin,CountLose,Earnings,Procent  FROM Prizez WHERE  CountWin  = NoWin();
SELECT Command_Name,CountWin,CountLose,Earnings,Procent  FROM Prizez WHERE	Earnings  = MaxEarnings();	




DROP VIEW VWresults;
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


SELECT * FROM VWresults;

SELECT EnemyTeam,TEAM,Sport,Prize  FROM VWresults WHERE sport = 'CSGO';













