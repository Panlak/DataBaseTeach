USE sportscompetitions;

DROP TABLE Сommands;
CREATE TABLE Сommands
(
	Command_Id INT NOT NULL AUTO_INCREMENT,
    Command_Name VARCHAR(40) NOT NULL,
    Сountry_Team_Id INT,
    CONSTRAINT СommandspRIMARYkey
    PRIMARY KEY(Command_Id,Сountry_Team_Id),
    CONSTRAINT Сountry
    FOREIGN KEY(Сountry_Team_Id) REFERENCES Сountries(Country_ID) # 1 зовнішній ключ
);

DELETE FROM Сommands WHERE Command_Id = 1;

INSERT INTO Сommands (Command_Name,Сountry_Team_Id)
VALUES("wolves",11);

SELECT * FROM Сountries WHERE Country_ID = 5;

SELECT * FROM Сommands;


UPDATE  Сommands SET  Command_Name = "STARS" WHERE  Command_Id = 3;


# WHERE DateOfCompetition.Competition_Id = Сountries.Country_ID 
SELECT Command_Name ,
DateOfCompetition.Country_ID AS СountryCompetition,
Сommands.Сountry_Team_Id AS TeamСountry,
DateEvent AS TimeOfHolding,
Competition_Name 
FROM Сommands,DateOfCompetition,Сountries,TypeOfCompetition
WHERE Сommands.DateOfCompetition_Id = DateOfCompetition.DateOfCompetition_Id
AND DateOfCompetition.Competition_Id = TypeOfCompetition.Competition_Id
AND Сommands.Сountry_Team_Id = Сountries.Country_Id
AND TypeOfCompetition.Competition_Id = 6
AND DateOfCompetition.DateEvent > '2023-06-12';

SELECT Country_Name,DateEvent,Competition_Name,Command_Name FROM DateOfCompetition,Сountries,TypeOfCompetition,Сommands
WHERE TypeOfCompetition.Competition_Id = 6 and 
Сountries.Country_ID = DateOfCompetition.Country_ID AND 
DateOfCompetition.Competition_Id = TypeOfCompetition.Competition_Id
AND DateOfCompetition.DateOfCompetition_Id = Сommands.DateOfCompetition_Id
AND DateOfCompetition.DateEvent > '2023-05-12';

