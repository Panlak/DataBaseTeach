
DROP TABLE Сommands;
TRUNCATE TABLE Сommands;
CREATE TABLE Сommands
(
	Command_Id SERIAL NOT NULL PRIMARY KEY,
    Command_Name VARCHAR(40) NOT NULL,
	Earnings float NOT NULL ,
    Country_Name_Team VARCHAR(40) NOT NULL
    CONSTRAINT Сountry 
    FOREIGN KEY(Country_Name_Team) REFERENCES Сountries(Country_Name)
    
);
INSERT INTO Сommands (Command_Name,Country_Name_Team,Earnings)
VALUES
('TeamSpirit','Rusia',0),
('Navi','Ukraine',0),
('Dynamo','Ukraine',0),
('Stars','Romania',0),
('Bears','Canada',0),
('Penguins','France',0),
('liquid','America',0),
('Bannermen','Turkey',0),
('Outliers','Canada',0),
('Titans','Slovenia',0),
('Vikings','Netherlands',0),
('Avengers','Ukraine',0);

UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 1;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 2;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 3;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 4;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 5;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 6;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 7;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 8;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 9;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 10;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 11;
UPDATE Сommands SET Earnings = 0 WHERE Command_Id = 12;

SELECT * FROM Сommands;

