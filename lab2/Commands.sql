USE sportscompetitions;


SET  @num := 0;
UPDATE Сommands SET Command_Id = @num := (@num+1);
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE Сommands AUTO_INCREMENT = 1;


DROP TABLE Сommands;
CREATE TABLE Сommands
(
	Command_Id INT NOT NULL AUTO_INCREMENT,
    Command_Name VARCHAR(40) NOT NULL,
    Country_Name_Team VARCHAR(40) NOT NULL,
    CONSTRAINT СommandspRIMARYkey
    PRIMARY KEY(Command_Id,Command_Name),
    CONSTRAINT Сountry 
    FOREIGN KEY(Country_Name_Team) REFERENCES Сountries(Country_Name) # 1 зовнішній ключ
    
);
CREATE INDEX Command_Name ON Сommands(Command_Name);


DELETE FROM Сommands WHERE Command_Id = 1;




INSERT INTO Сommands (Command_Name,Country_Name_Team)
VALUES
#("TeamSpirit","Rusia"),
#("Navi","Ukraine"),
#("Dynamo","Ukraine"),
#("Stars","Romania"),
#("Bears","Canada"),
#("Penguins","France"),
#("liquid","America"),
("Bannermen","Turkey"),
("Outliers","Canada"),
("Titans","Slovenia"),
("Vikings","Netherlands");

SELECT Command_Id,Command_Name,Country_Name FROM Сommands,Сountries WHERE Country_Name_Team = Country_Name;

SELECT Command_Id,Command_Name


UPDATE  Сommands SET  Command_Name = "STARS" WHERE  Command_Id = 3;




