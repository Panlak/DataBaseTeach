USE sportscompetitions;

DROP TABLE DateOfCompetition;
CREATE TABLE DateOfCompetition
(
	DateOfCompetition_Id INT NOT NULL AUTO_INCREMENT,
    Competition_Id INT,
    Country_ID INT,
    DateEvent DATE,
    PRIMARY KEY(DateOfCompetition_Id),
    CONSTRAINT  TypeCompetition
    FOREIGN KEY(Competition_Id) REFERENCES TypeOfCompetition(Competition_Id),
	CONSTRAINT  Country
    FOREIGN KEY(Country_ID) REFERENCES Сountries(Country_ID)
);

INSERT INTO DateOfCompetition(DateEvent,Competition_Id,Country_ID)
VALUES
#('2021-3-14',1,1),
#('2022-6-3',2,7),
#('2023-5-6',3,6)
#('2023-6-12',6,1)
#('2024-5-28',6,2)
 ('2026.10.31',6,11);


SELECT * FROM DateOfCompetition;

SELECT TypeOfCompetition.Competition_Name,Country_Name,DateEvent 
FROM DateOfCompetition ,TypeOfCompetition, Сountries
WHERE DateOfCompetition.Competition_Id = TypeOfCompetition.Competition_Id
AND DateOfCompetition.Country_ID = Сountries.Country_ID;
