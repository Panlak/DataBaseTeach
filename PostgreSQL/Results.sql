DROP TABLE Results;
CREATE TABLE Results
(
	Result_Id SERIAL NOT NULL PRIMARY KEY,
	EnemyTeam_Id int NOT NULL,
    Team_Id int NOT NULL,				 
	DateOfCompetition_Id INT NOT NULL,   
    FightResult VARCHAR(20)[] NOT NULL
	check (FightResult <@ ARRAY['Win', 'Lose', 'Draw']::varchar[]),
    CONSTRAINT EnemyTeam_NAME
    FOREIGN KEY (EnemyTeam_Id) REFERENCES Сommands(Command_Id),
    CONSTRAINT Team_Id
    FOREIGN KEY(Team_Id) REFERENCES Сommands(Command_Id),
    CONSTRAINT DateOfCompetition
    FOREIGN KEY (DateOfCompetition_Id) REFERENCES DateOfCompetition(DateOfCompetition_Id)
);
INSERT INTO Results (EnemyTeam_Id,Team_Id,DateOfCompetition_Id,FightResult)
VALUES
(4,6,2,'{Lose}'),
(5,1,4,'{Draw}'),
(6,7,3,'{Win}'),
(7,2,5,'{Lose}'),
(2,3,7,'{Win}'),
(8,9,9,'{Lose}'),
(10,11,8,'{Win}'),
(9,11,10,'{Win}'),
(2,6,2,'{Win}'),
(2,1,8,'{Lose}'),
(6,2,8,'{Win}'),
(5,2,8,'{Win}'),
(9,2,11,'{Lose}'),
(3,1,15,'{Win}'),
(12,2,15,'{Win}'),
(1,6,6,'{Lose}'),
(8,1,13,'{Win}'),
(11,10,14,'{Draw}'),
(7,9,15,'{Win}'),
(2,12,14,'{Lose}'),
(12,3,9,'{Draw}');


SELECT * FROM Results;

select * from Results,Сountries,TypeSport,DateOfCompetition,Сommands
WHERE 
Results.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
AND Сommands.Command_Id IN (EnemyTeam_Id)
AND Country_Name_Team = Сountries.Country_Name
AND DateOfCompetition.SportId = TypeSport.id_Sport;