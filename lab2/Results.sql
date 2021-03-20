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
("Bears","Navi",'2027-05-16','Win');

SELECT Result_Id,Team_NAME,EnemyTeam_NAME,Result,DateOfCompetition.Competition_Name,DateEvent FROM Results,Сountries,Сommands,DateOfCompetition,TypeOfCompetition
WHERE	 
DateOfCompetition.Competition_Name =TypeOfCompetition.Competition_Name
AND Сountries.Country_Name = Сommands.Country_Name_Team
and EnemyTeam_NAME = Command_Name
AND DateOfCompetition.DateEvent = DateOfCompetition_Event;


SELECT * FROM Results;

DELETE FROM Results WHERE Result_Id =4;

/* Знайти всі країни, де проводилися Олімпійські ігри після вказаного року. */
SELECT DateOfCompetition.Country_Name , TypeOfCompetition.Competition_Name , DateEvent FROM Сountries,TypeOfCompetition,DateOfCompetition
WHERE TypeOfCompetition.Competition_Name = "Олімпійські ігри"
AND   DateOfCompetition.Competition_Name =TypeOfCompetition.Competition_Name
AND   Сountries.Country_Name = DateOfCompetition.Country_Name
AND DateEvent > '2022-05-12';
/*-------------------*/

/* Знайти всіх суперників зазначеної команди в змаганнях заданого рангу */ 
SELECT Team_NAME,EnemyTeam_NAME,TypeOfCompetition.Competition_Name,DateEvent FROM Сountries, Results,TypeOfCompetition,Сommands,DateOfCompetition
WHERE Team_NAME = "Navi"  # вказую що айді команди переможця = якомусь значеню
AND TypeOfCompetition.Competition_Name = "Чемпіонати світу"
AND DateOfCompetition.DateEvent = '2027-05-16'
AND Results.DateOfCompetition_Event = DateOfCompetition.DateEvent
AND DateOfCompetition.Country_Name = Сountries.Country_Name
AND Team_NAME = Сommands.Command_Name;
/*-------------------*/

/*Знайти інформацію про змагання, в яких брали участь команди зазначеної країни.*/
SELECT Team_NAME,EnemyTeam_NAME,TypeOfCompetition.Competition_Name,DateEvent,Result
 FROM Сountries,TypeOfCompetition,Сommands,DateOfCompetition,Results
WHERE 
Country_Name_Team = "Ukraine" AND  
Results.DateOfCompetition_Event = DateOfCompetition.DateEvent
AND TypeOfCompetition.Competition_Name = DateOfCompetition.Competition_Name
AND DateOfCompetition.Country_Name = Сountries.Country_Name
AND EnemyTeam_NAME  =  Сommands.Command_Name
group by Result_Id;
/*-------------------*/


/* Знайти країну, де проводилося максимальне число змагань за вказаний період. */
SELECT Team_NAME,EnemyTeam_NAME,TypeOfCompetition.Competition_Name,DateEvent,Result,Сountries.Country_Name
FROM Сountries
INNER JOIN Сommands 		 
INNER JOIN Results 			 ON  EnemyTeam_NAME = Command_Name
INNER JOIN DateOfCompetition ON  DateOfCompetition.DateEvent = DateOfCompetition_Event and DateOfCompetition.Country_Name = Сountries.Country_Name
INNER JOIN TypeOfCompetition ON TypeOfCompetition.Competition_Name = DateOfCompetition.Competition_Name
WHERE DateOfCompetition.DateEvent  BETWEEN '2023-05-06' AND '2030-05-26';
 


/*-------------------*/


SELECT Team_NAME,EnemyTeam_NAME,TypeOfCompetition.Competition_Name,DateEvent,Result
FROM Сountries
INNER JOIN Сommands 		 
INNER JOIN Results 			 ON  EnemyTeam_NAME = Command_Name
INNER JOIN DateOfCompetition ON  DateOfCompetition.DateEvent = DateOfCompetition_Event and DateOfCompetition.Country_Name = Сountries.Country_Name
INNER JOIN TypeOfCompetition ON TypeOfCompetition.Competition_Name = DateOfCompetition.Competition_Name
AND DateOfCompetition.Country_Name = (SELECT DateOfCompetition.Country_Name FROM DateOfCompetition WHERE (SELECT MAX((SELECT COUNT(DateOfCompetition.Country_Name )FROM DateOfCompetition))FROM DateOfCompetition) LIMIT 1)
WHERE DateOfCompetition.DateEvent  BETWEEN '2023-05-06' AND '2030-05-26';



SELECT Command_Name,Country_Name,Competition_Name,DateEvent,EnemyTeam_Id,Team_Id,Result FROM Results,Сommands,DateOfCompetition,TypeOfCompetition,Сountries
WHERE 
EnemyTeam_Id = Сommands.Command_Id AND Team_Id = Сommands.Command_Id; 









