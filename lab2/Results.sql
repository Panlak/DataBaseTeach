use `sportscompetitions`;



DROP TABLE Results;
CREATE TABLE Results
(
	Result_Id INT NOT NULL AUTO_INCREMENT,
	EnemyTeam_Id INT NOT NULL,			 # FOREIGN
    Team_Id INT NOT NULL,				 # FOREIGN
    DateOfCompetition_Id INT NOT NULL,   # FOREIGN
    Result SET('Win','Lose','Draw'),
    PRIMARY KEY (Result_Id),
    CONSTRAINT EnemyTeam_Id
    FOREIGN KEY (EnemyTeam_Id) REFERENCES Сommands(Command_Id),
    CONSTRAINT Team_Id
    FOREIGN KEY(Team_Id) REFERENCES Сommands(Command_Id),
    CONSTRAINT DateOfCompetition
    FOREIGN KEY (DateOfCompetition_Id) REFERENCES DateOfCompetition(DateOfCompetition_Id)
);


INSERT INTO Results (EnemyTeam_Id,Team_Id,DateOfCompetition_Id,Result)
VALUES(1,2,4,'Win');

SELECT * FROM Results;


/*----Під Великим питаннями--чому в Result --*/
SELECT Сommands.Command_Id,Command_Name,Country_Name,Competition_Name,DateEvent,Result FROM Results,Сommands,DateOfCompetition,TypeOfCompetition,Сountries
WHERE  
TypeOfCompetition.Competition_Id = 6 
AND  Results.DateOfCompetition_Id= DateOfCompetition.DateOfCompetition_Id
AND  (Сommands.Сountry_Team_Id = Сountries.Country_ID   OR   Сommands.Сountry_Team_Id = Сountries.Country_ID )
AND  (Сommands.Command_Id = Results.Team_Id   OR   Сommands.Command_Id = Results.EnemyTeam_Id );
/*-------------------*/


/* Знайти всі країни, де проводилися Олімпійські ігри після вказаного року. */
SELECT Country_Name , Competition_Name , DateEvent FROM Сountries,TypeOfCompetition,DateOfCompetition
WHERE TypeOfCompetition.Competition_Id = 6
AND DateOfCompetition.Competition_Id = TypeOfCompetition.Competition_Id
AND Сountries.Country_ID = DateOfCompetition.Country_ID
AND DateOfCompetition.DateEvent > '2023-05-12';
/*-------------------*/

/* Знайти всіх суперників зазначеної команди в змаганнях заданого рангу */




/*-------------------*/



SELECT Command_Name,Country_Name,Competition_Name,DateEvent,EnemyTeam_Id,Team_Id,Result FROM Results,Сommands,DateOfCompetition,TypeOfCompetition,Сountries
WHERE 
EnemyTeam_Id = Сommands.Command_Id AND Team_Id = Сommands.Command_Id; 









