
DROP TABLE Сommands;
TRUNCATE TABLE Сommands;
CREATE TABLE Сommands
(
	Command_Id SERIAL NOT NULL PRIMARY KEY,
    Command_Name VARCHAR(40) NOT NULL,
	Earnings bigint NOT NULL ,
    Country_Name_Team VARCHAR(40) NOT NULL,
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

SELECT * FROM Сommands;

