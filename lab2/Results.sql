use `sportscompetitions`;

SET  @num := 0;
UPDATE Results SET Result_Id = @num := (@num+1);
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE Results AUTO_INCREMENT = 1;
DROP TABLE Results;
CREATE TABLE Results
(
	Result_Id INT NOT NULL AUTO_INCREMENT,
	EnemyTeam_Id int NOT NULL,
    Team_Id int NOT NULL,				 
	DateOfCompetition_Id INT NOT NULL,   
    Result SET('Win','Lose','Draw'),
    PRIMARY KEY (Result_Id),
    CONSTRAINT EnemyTeam_NAME
    FOREIGN KEY (EnemyTeam_Id) REFERENCES Сommands(Command_Id),
    CONSTRAINT Team_Id
    FOREIGN KEY(Team_Id) REFERENCES Сommands(Command_Id),
    CONSTRAINT DateOfCompetition
    FOREIGN KEY (DateOfCompetition_Id) REFERENCES DateOfCompetition(DateOfCompetition_Id)
);

ALTER TABLE Results AUTO_INCREMENT = 1;



INSERT INTO Results (EnemyTeam_Id,Team_Id,DateOfCompetition_Id,Result)
VALUES

(4,6,2,'Lose'),
(5,1,4,'Draw'),
(6,7,3,'Win'),
(7,2,5,'Lose'),
(2,3,7,'Win'),
(8,9,9,'Lose'),
(10,11,8,'Win'),
(9,11,10,'Win'),
(2,6,2,'Win'),
(2,1,8,'lose'),
(6,2,8,'Win'),
(5,2,8,'Win'),
(9,2,11,'Lose'),
(3,1,15,'Win'),
(12,2,15,'Win'),
(1,6,6,'lose'),
(8,1,13,'Win'),
(11,10,14,'Draw'),
(7,9,15,'Win'),
(2,12,14,'lose'),
(12,3,9,'Draw');



select * from Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
AND Сommands.Command_Id IN (EnemyTeam_Id)
AND Country_Name_Team = Сountries.Country_Name
AND DateOfCompetition.id_Sport = TypeSport.id_Sport;

delete from Results where Result_Id =13 ;


SELECT * FROM Results;

DELETE FROM Results WHERE Result_Id =1;

/* Знайти всі країни, де проводилися Олімпійські ігри після вказаного року. */
SELECT DateOfCompetition.Country_Name , NAME_Sport ,DateOfCompetition.Rang_Competition, DateEvent FROM Сountries,TypeSport,DateOfCompetition
WHERE DateOfCompetition.DateOfCompetition_Id IN
((SELECT  DateOfCompetition_Id FROM DateOfCompetition WHERE   Rang_Competition = 'Олімпійські_ігри' AND DateOfCompetition.DateEvent > '2027-06-16'))
AND   DateOfCompetition.id_Sport = TypeSport.id_Sport
AND   Сountries.Country_Name = DateOfCompetition.Country_Name;
/*-------------------*/

/* Знайти всіх суперників зазначеної команди в змаганнях заданого рангу */ 
SELECT Team_Id,Command_Name as EnemyTeam,NAME_Sport,DateOfCompetition.Rang_Competition,DateEvent  FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE Team_Id = (SELECT Command_Id FROM Сommands WHERE Command_Name = "Navi")
AND DateOfCompetition.DateOfCompetition_Id  IN ((SELECT  DateOfCompetition_Id FROM DateOfCompetition WHERE   Rang_Competition = 'Чемпіонат_Європи'))
AND DateOfCompetition.id_Sport = TypeSport.id_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
and EnemyTeam_Id = Сommands.Command_Id
AND Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id;
/*-------------------*/

/*Знайти інформацію про змагання, в яких брали участь команди зазначеної країни.*/
SELECT  EnemyTeam_Id,Team_Id,DateOfCompetition.Country_Name AS CompetitionCountry,DateOfCompetition.DateEvent
FROM Results
INNER JOIN DateOfCompetition ON Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
INNER JOIN TypeSport ON DateOfCompetition.id_Sport = TypeSport.id_Sport
INNER JOIN Сountries ON DateOfCompetition.Country_Name =  Сountries.Country_Name
INNER JOIN 
Сommands on Command_Id IN ((SELECT Command_Id FROM Сommands WHERE Country_Name_Team  = "Ukraine"))
AND EnemyTeam_Id = Command_Id
AND Team_Id IN ((SELECT Command_Id FROM Сommands WHERE Country_Name_Team  = "Ukraine"));
/*-------------------*/


/* Знайти країну, де проводилося максимальне число змагань за вказаний період. */

SELECT (SELECT MAX(fas.count) 
FROM
DateOfCompetition,(SELECT COUNT(DateOfCompetition.Country_Name)   as count 
FROM (((( Сountries
INNER JOIN Сommands )	 
INNER JOIN Results 			 ON  EnemyTeam_Id = Command_Id)
INNER JOIN DateOfCompetition ON  results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id and DateOfCompetition.Country_Name =  Сountries.Country_Name
AND  DateOfCompetition.DateOfCompetition_Id IN ((SELECT DateOfCompetition_Id FROM  DateOfCompetition WHERE DateEvent  BETWEEN '2023-05-06' AND '2027-05-26' ))))
INNER JOIN TypeSport ON DateOfCompetition.id_Sport = TypeSport.id_Sport 

group by DateOfCompetition.Country_Name )as fas )AS Max;        


(SELECT COUNT(DateOfCompetition.Country_Name)   as count 
FROM (((( Сountries
INNER JOIN Сommands )	 
INNER JOIN Results 			 ON  EnemyTeam_Id = Command_Id)
INNER JOIN DateOfCompetition ON  results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id and DateOfCompetition.Country_Name =  Сountries.Country_Name
AND  DateOfCompetition.DateOfCompetition_Id IN ((SELECT DateOfCompetition_Id FROM  DateOfCompetition WHERE DateEvent  BETWEEN '2023-05-06' AND '2027-05-26' ))))
INNER JOIN TypeSport ON DateOfCompetition.id_Sport = TypeSport.id_Sport 
group by DateOfCompetition.Country_Name );


SELECT DateOfCompetition.Country_Name,COUNT(DateOfCompetition.Country_Name)  as count 
FROM Сountries
INNER JOIN Сommands
INNER JOIN Results 			 ON  EnemyTeam_Id = Command_Id
INNER JOIN DateOfCompetition ON  results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id 
AND  DateOfCompetition.DateOfCompetition_Id IN ((SELECT DateOfCompetition_Id FROM  DateOfCompetition 
WHERE DateEvent  BETWEEN '2023-05-06' AND '2030-05-26' ))and DateOfCompetition.Country_Name =  Сountries.Country_Name
INNER JOIN TypeSport ON DateOfCompetition.id_Sport = TypeSport.id_Sport
group by results.DateOfCompetition_Id
HAVING GetMaxCount()  = count;        
	
DROP FUNCTION   GetMaxCount;     
DELIMITER $$
CREATE FUNCTION GetMaxCount()
RETURNS int(7)
DETERMINISTIC
BEGIN
	DECLARE max_value int(7);
   SET max_value =(SELECT MAX(result.fas) 
    
FROM  (SELECT count(DateOfCompetition.Country_Name)  as fas, DateOfCompetition.Country_Name
FROM ((((Сountries
INNER JOIN Сommands)
INNER JOIN Results 			 ON  EnemyTeam_Id = Command_Id)
INNER JOIN DateOfCompetition ON  results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id 
AND  DateOfCompetition.DateOfCompetition_Id IN ((SELECT DateOfCompetition_Id FROM  DateOfCompetition 
WHERE DateEvent  BETWEEN '2023-05-06' AND '2030-05-26' ))and DateOfCompetition.Country_Name =  Сountries.Country_Name) 
INNER JOIN TypeSport ON DateOfCompetition.id_Sport = TypeSport.id_Sport
) group by results.DateOfCompetition_Id) as result) ;
	RETURN (max_value);
END $$
DELIMITER ;
SELECT GetMaxCount();
 
/*-------------------*/

/*Знайти всі країни, де проводилися Чемпіонати світу із зазначеного виду спорту*/
SELECT distinct Сountries.Country_Name,NAME_Sport,Rang_Competition
 FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
DateOfCompetition.DateOfCompetition_Id IN( (SELECT DateOfCompetition_Id FROM DateOfCompetition WHERE  Rang_Competition = 'Чемпіонат_світу'))
AND TypeSport.id_Sport = (SELECT id_Sport FROM TypeSport WHERE NAME_Sport = "CSGO")
AND DateOfCompetition.id_Sport = TypeSport.id_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
and EnemyTeam_Id = Command_Id
AND results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id;
/*-------------------*/

/*. Знайти всіх суперників зазначеної команди в змаганнях в заданому році*/
SELECT Command_Name AS EnemyTeam,Team_Id ,Result,DateOfCompetition.Rang_Competition,NAME_Sport,DateOfCompetition.DateEvent
FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE
Team_Id = (SELECT Command_Id FROM Сommands WHERE Command_Name = "Navi")
AND DateOfCompetition.DateOfCompetition_Id IN ((SELECT DateOfCompetition_Id FROM DateOfCompetition WHERE YEAR(DateEvent) = '2027'))
AND DateOfCompetition.id_Sport = TypeSport.id_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
AND EnemyTeam_Id = Сommands.Command_Id
AND results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id;
/*-------------------*/

/*Знайти всі команди, що брали участь в зазначених змаганнях в заданій країні. */
SELECT Result_Id,EnemyTeam_Id,Team_Id,Result,DateOfCompetition.Rang_Competition,NAME_Sport,DateOfCompetition.Country_Name as CompetitionCounry,DateOfCompetition.DateEvent
FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE	 
DateOfCompetition.DateOfCompetition_Id IN ((SELECT DateOfCompetition_Id FROM DateOfCompetition WHERE Rang_Competition in ('Олімпійські_ігри','Чемпіонат_світу')
AND DateOfCompetition.Country_Name = "Ukraine"))
AND DateOfCompetition.id_Sport = TypeSport.id_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
and EnemyTeam_Id = Сommands.Command_Id
AND results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
group by Result_Id;
/*-------------------*/

/*Знайти всі команди, які брали участь в змаганнях заданого рангу згруповані за видами спорту*/
SELECT Result_Id,EnemyTeam_Id,Team_Id,Result,DateOfCompetition.Rang_Competition,NAME_Sport,DateOfCompetition.Country_Name,DateOfCompetition.DateEvent
FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE	 
DateOfCompetition.DateOfCompetition_Id IN ((SELECT DateOfCompetition_Id FROM DateOfCompetition WHERE Rang_Competition = 'Олімпійські_ігри'))
AND DateOfCompetition.id_Sport = TypeSport.id_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
and EnemyTeam_Id = Сommands.Command_Id
AND results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
group by Result_Id
order by TypeSport.id_Sport;
/*-------------------*/



/*Знайти всі команди певної країни, у яких не було виграшів*/
SELECT Result_Id,EnemyTeam_Id,Team_Id,Result,DateOfCompetition.Rang_Competition,NAME_Sport,DateOfCompetition.Country_Name,DateOfCompetition.DateEvent
FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE
Result_Id IN ((SELECT Result_Id FROM Results WHERE Result != 'Win' ))
AND Command_Id IN ((SELECT Command_Id FROM Сommands WHERE Country_Name_Team  = "Ukraine"))
AND EnemyTeam_Id = Command_Id
AND Team_Id IN ((SELECT Command_Id FROM Сommands WHERE Country_Name_Team  = "Ukraine"))
AND DateOfCompetition.id_Sport = TypeSport.id_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
and EnemyTeam_Id = Сommands.Command_Id
AND results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id;
/*-------------------*/

