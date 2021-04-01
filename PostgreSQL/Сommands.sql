

DROP TABLE Сommands;
CREATE TABLE Сommands
(
	Command_Id SERIAL NOT NULL PRIMARY KEY,
    Command_Name VARCHAR(40) NOT NULL,
    Country_Name_Team VARCHAR(40) NOT NULL,
    CONSTRAINT Сountry 
    FOREIGN KEY(Country_Name_Team) REFERENCES Сountries(Country_Name)
    
);
INSERT INTO Сommands (Command_Name,Country_Name_Team)
VALUES
('TeamSpirit','Rusia'),
('Navi','Ukraine'),
('Dynamo','Ukraine'),
('Stars','Romania'),
('Bears','Canada'),
('Penguins','France'),
('liquid','America'),
('Bannermen','Turkey'),
('Outliers','Canada'),
('Titans','Slovenia'),
('Vikings','Netherlands'),
('Avengers','Ukraine');

SELECT * FROM Сommands;
