DROP TABLE Results;
TRUNCATE TABLE Results;

CREATE TABLE Results
(
	Result_Id SERIAL NOT NULL PRIMARY KEY,
	EnemyTeam_Id int NOT NULL,
    Team_Id int NOT NULL,				 
	DateOfCompetition_Id INT NOT NULL,
    FightResult VARCHAR(20)[] NOT NULL
	check (FightResult <@ ARRAY['Win', 'Lose', 'Draw']::varchar[]),
	Prize float ,
    CONSTRAINT EnemyTeam_NAME
    FOREIGN KEY (EnemyTeam_Id) REFERENCES Сommands(Command_Id),
    CONSTRAINT Team_Id
    FOREIGN KEY(Team_Id) REFERENCES Сommands(Command_Id),
    CONSTRAINT DateOfCompetition
    FOREIGN KEY (DateOfCompetition_Id) REFERENCES DateOfCompetition(DateOfCompetition_Id)
);
TRUNCATE TABLE Results RESTART IDENTITY;
INSERT INTO Results (EnemyTeam_Id,Team_Id,DateOfCompetition_Id,FightResult,Prize)
VALUES
(4,		6,		2,	'{Lose}',	20000),
(5,		1,		4,	'{Draw}',	40000),
(6,		7,		3,	'{Win}',	70000),
(7,		2,		5,	'{Lose}',	1000000),
(2,		3,		7,	'{Win}',	10000),
(8,		9,		9,	'{Lose}',	50000),
(10,	11,		8,	'{Win}',	20000),
(9,		11,		10,	'{Win}',	1000),
(2,		6,		2,	'{Win}',	200),
(2,		1,		8,	'{Lose}',	500),
(6,		2,		8,	'{Win}',	2000000),
(5,		2,		8,	'{Win}',	150000),
(9,		2,		11,	'{Lose}',	67000),
(3,		1,		15,	'{Win}',	86000),
(12,	2,		15,	'{Win}',	124000),
(1,		6,		6,	'{Lose}',	21000),
(8,		1,		13,	'{Win}',	1000),
(11,	10,		14,	'{Draw}',	35000),
(7,		9,		15,	'{Win}',	3200),
(2,		12,		14,	'{Lose}',	15000),
(12,	3,		9,	'{Draw}',	150000);



INSERT INTO Results (EnemyTeam_Id,Team_Id,DateOfCompetition_Id,FightResult,Prize)
VALUES (12,2,14,'{Lose}',15000)

SELECT * FROM Results;

--Перевірка на підрахунок виграшу
SELECT * FROM Сommands;

-- перевірка тригера на Update
UPDATE Results SET Prize = 1000 WHERE Result_Id = 2;

--перевірка тригера на DELETE
DELETE from Results where Result_Id = 22;


--перевіка тригера на INSERT
INSERT INTO Results (EnemyTeam_Id,Team_Id,DateOfCompetition_Id,FightResult,Prize)
VALUES(11,3,2,'{Draw}',21000)


TRUNCATE TABLE Results_history RESTART IDENTITY;		
SELECT * FROM Results_history;	



























