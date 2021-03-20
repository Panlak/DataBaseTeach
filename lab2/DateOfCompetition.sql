USE sportscompetitions;


SET  @num := 0;
UPDATE DateOfCompetition SET DateOfCompetition_Id = @num := (@num+1);
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE DateOfCompetition AUTO_INCREMENT = 1;


DROP TABLE DateOfCompetition;
CREATE TABLE DateOfCompetition
(
	DateOfCompetition_Id INT NOT NULL AUTO_INCREMENT,
    Competition_Name VARCHAR(40),
    Country_Name VARCHAR(40) NOT NULL,
    DateEvent DATE,
    PRIMARY KEY(DateOfCompetition_Id,DateEvent),
    CONSTRAINT  TypeCompetition
    FOREIGN KEY(Competition_Name) REFERENCES TypeOfCompetition(Competition_Name),
	CONSTRAINT  Country
    FOREIGN KEY(Country_Name) REFERENCES Сountries(Country_Name)
);
CREATE INDEX DateEvent ON DateOfCompetition(DateEvent);



INSERT INTO DateOfCompetition(DateEvent,Competition_Name,Country_Name)
VALUES
#('2021-3-14',"Шахи","Belarus"),
#('2022-6-3',"Олімпійські ігри","America"),
#('2023-5-6',"Футбол","Mexico"),
#('2023-6-12',"Лижні гонки","France"),
#('2024-5-28',"Чемпіонати світу","Sweden"),
#('2026.10.31',"Шашки","Brazil"),
#('2030.10.11',"Олімпійські ігри","Netherlands")
('2027.5.16',"Чемпіонати світу","Ukraine"),
('2029.6.17',"Футбол","Belarus"),
('2030.5.26',"Дартс","South Korea");



SELECT DateOfCompetition_Id,DateOfCompetition.Competition_Name, DateOfCompetition.Country_Name,DateEvent 
FROM сountries,TypeOfCompetition,DateOfCompetition
WHERE DateOfCompetition.Competition_Name= TypeOfCompetition.Competition_Name
and DateOfCompetition.Country_Name=Сountries.Country_Name;

