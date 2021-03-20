use `sportscompetitions`;

SET  @num := 0;
UPDATE Results SET Result_Id = @num := (@num+1);
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE Results AUTO_INCREMENT = 1;
DROP TABLE Results;
CREATE TABLE Results
(
	Result_Id INT NOT NULL AUTO_INCREMENT,
	EnemyTeam_NAME VARCHAR(40) NOT NULL,
    Team_NAME VARCHAR(40) NOT NULL,				 
	DateOfCompetition_Event DATE NOT NULL,   
    Result SET('Win','Lose','Draw'),
    PRIMARY KEY (Result_Id),
    CONSTRAINT EnemyTeam_NAME
    FOREIGN KEY (EnemyTeam_NAME) REFERENCES Сommands(Command_Name),
    CONSTRAINT Team_Id
    FOREIGN KEY(Team_NAME) REFERENCES Сommands(Command_Name),
    CONSTRAINT DateOfCompetition
    FOREIGN KEY (DateOfCompetition_Event) REFERENCES DateOfCompetition(DateEvent)
);

ALTER TABLE Results AUTO_INCREMENT = 1;

DELETE FROM Results WHERE Result_Id = 11;

INSERT INTO Results (EnemyTeam_NAME,Team_NAME,DateOfCompetition_Event,Result)
VALUES

("Stars","Penguins",'2022-06-03','Lose'),
("Bears","TeamSpirit",'2023-06-12','Draw'),
("Penguins","liquid",'2023-05-06','Win'),
("liquid","Navi",'2024-05-28','Lose'),
("Navi","Dynamo",'2030-10-11','Win'),
("Bannermen","Outliers",'2029-06-17','Lose'),
("Titans","Vikings",'2027-05-16','Win'),
("Outliers","Vikings",'2030-05-26','Win'),
("Navi","Penguins",'2022-06-03','Win'),
("Navi","TeamSpirit",'2027-05-16','lose'),
("Penguins","Navi",'2027-05-16','Win'),
("Bears","Navi",'2027-05-16','Win'),
("Outliers","Navi",'2027.7.31','Lose'),
("Dynamo","TeamSpirit",'2032.10.11','Win'),
("Avengers","Navi",'2032.10.11','Win'),
("TeamSpirit","Penguins",'2026.10.31','lose'),
("Bannermen","TeamSpirit",'2027.10.15','Win'),
("Vikings","Titans",'2029.5.15','Draw'),
("liquid","Outliers",'2031.6.21','Win'),
("Navi","Avengers",'2027.10.15','lose'),
("Avengers","Dynamo",'2029-06-17','Draw');
SELECT *
FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE	 
DateOfCompetition.Type_Sport = TypeSport.NAME_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
AND  EnemyTeam_NAME = Command_Name
AND  DateOfCompetition.DateEvent = DateOfCompetition_Event ;


SELECT * FROM Results;

DELETE FROM Results WHERE Result_Id =18;

/* Знайти всі країни, де проводилися Олімпійські ігри після вказаного року. */
SELECT DateOfCompetition.Country_Name , NAME_Sport ,DateOfCompetition.Rang_Competition, DateEvent FROM Сountries,TypeSport,DateOfCompetition
WHERE DateOfCompetition.Rang_Competition = 'Олімпійські_ігри'
AND   DateOfCompetition.Type_Sport =TypeSport.NAME_Sport
AND   Сountries.Country_Name = DateOfCompetition.Country_Name
AND DateEvent > '2027-06-16';
/*-------------------*/

/* Знайти всіх суперників зазначеної команди в змаганнях заданого рангу */ 
SELECT Team_NAME,EnemyTeam_NAME,NAME_Sport,DateOfCompetition.Rang_Competition,DateEvent  FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE Team_NAME = "Navi"  
AND DateOfCompetition.Rang_Competition = 'Чемпіонат_Європи'

AND DateOfCompetition.Type_Sport =TypeSport.NAME_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
and EnemyTeam_NAME = Command_Name
AND DateOfCompetition.DateEvent = DateOfCompetition_Event;
/*-------------------*/

/*Знайти інформацію про змагання, в яких брали участь команди зазначеної країни.*/
SELECT  *
FROM Results
INNER JOIN DateOfCompetition ON DateOfCompetition.DateEvent = DateOfCompetition_Event
INNER JOIN TypeSport ON DateOfCompetition.Type_Sport = TypeSport.NAME_Sport
INNER JOIN Сountries ON DateOfCompetition.Country_Name = Сountries.Country_Name
INNER JOIN Сommands on Country_Name_Team  = "Ukraine"  and  Command_Name in (Team_NAME,EnemyTeam_NAME )
and EnemyTeam_NAME = Command_Name
AND Team_NAME IN ((SELECT Command_Name FROM Сommands WHERE Country_Name_Team  = "Ukraine"))
;
/*-------------------*/


/* Знайти країну, де проводилося максимальне число змагань за вказаний період. */
SELECT Сountries.Country_Name,count(DateOfCompetition.Country_Name) as Count_Competition 
FROM Сountries
INNER JOIN Сommands 		 
INNER JOIN Results 			 ON  EnemyTeam_NAME = Command_Name
INNER JOIN DateOfCompetition ON  DateOfCompetition.DateEvent = DateOfCompetition_Event and DateOfCompetition.Country_Name = Сountries.Country_Name
INNER JOIN TypeSport ON TypeSport.NAME_Sport = DateOfCompetition.Type_Sport
WHERE DateOfCompetition.DateEvent  BETWEEN '2023-05-06' AND '2030-05-26'
group by Сountries.Country_Name
order by Count_Competition desc limit 1;
/*-------------------*/

/*Знайти всі країни, де проводилися Чемпіонати світу із зазначеного виду спорту*/
SELECT distinct Сountries.Country_Name,NAME_Sport,Rang_Competition
 FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
DateOfCompetition.Rang_Competition = 'Чемпіонат_світу' and 
TypeSport.NAME_Sport = "CSGO"
AND DateOfCompetition.Type_Sport = TypeSport.NAME_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
and EnemyTeam_NAME = Command_Name
AND DateOfCompetition.DateEvent = DateOfCompetition_Event;
/*-------------------*/

/*. Знайти всіх суперників зазначеної команди в змаганнях в заданому році*/
SELECT EnemyTeam_NAME,Team_NAME,Result,DateOfCompetition.Rang_Competition,NAME_Sport,DateOfCompetition_Event
 FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE
Team_NAME = "Navi"
AND year(DateOfCompetition_Event) = '2027'
AND DateOfCompetition.Type_Sport = TypeSport.NAME_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
AND Command_Name = Team_NAME
AND DateOfCompetition.DateEvent = DateOfCompetition_Event;
/*-------------------*/

/*Знайти всі команди, що брали участь в зазначених змаганнях в заданій країні. */
SELECT EnemyTeam_NAME,Team_NAME,Result,DateOfCompetition.Rang_Competition,NAME_Sport,DateOfCompetition.Country_Name,DateOfCompetition_Event
FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE	 
DateOfCompetition.Rang_Competition in ('Олімпійські_ігри','Чемпіонат_світу')
AND DateOfCompetition.Country_Name = "Ukraine"
AND DateOfCompetition.Type_Sport =TypeSport.NAME_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
and EnemyTeam_NAME = Command_Name
AND DateOfCompetition.DateEvent = DateOfCompetition_Event;
/*-------------------*/

/*Знайти всі команди, які брали участь в змаганнях заданого рангу згруповані за видами спорту*/
SELECT Result_Id,EnemyTeam_NAME,Team_NAME,Result,DateOfCompetition.Rang_Competition,NAME_Sport,DateOfCompetition.Country_Name,DateOfCompetition_Event
 FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE	 
DateOfCompetition.Rang_Competition = 'Олімпійські_ігри'
AND DateOfCompetition.Type_Sport = TypeSport.NAME_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
and EnemyTeam_NAME = Command_Name
AND DateOfCompetition.DateEvent = DateOfCompetition_Event
group by TypeSport.NAME_Sport,Result_Id;
/*-------------------*/



/*Знайти всі команди певної країни, у яких не було виграшів*/
SELECT Result_Id,EnemyTeam_NAME,Team_NAME,Result,DateOfCompetition.Rang_Competition,NAME_Sport,DateOfCompetition.Country_Name,DateOfCompetition_Event
FROM Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE
Result != 'Win' 
AND Country_Name_Team  = "Ukraine"  and  Command_Name in (Team_NAME,EnemyTeam_NAME )
and EnemyTeam_NAME = Command_Name
AND Team_NAME IN ((SELECT Command_Name FROM Сommands WHERE Country_Name_Team  = "Ukraine"))
AND DateOfCompetition.Type_Sport = TypeSport.NAME_Sport
AND Сountries.Country_Name = DateOfCompetition.Country_Name
and EnemyTeam_NAME = Command_Name
AND DateOfCompetition.DateEvent = DateOfCompetition_Event;
/*-------------------*/

