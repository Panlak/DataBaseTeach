USE sportscompetitions;


SET  @num := 0;
UPDATE DateOfCompetition SET DateOfCompetition_Id = @num := (@num+1);
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE DateOfCompetition AUTO_INCREMENT = 1;


DROP TABLE DateOfCompetition;
CREATE TABLE DateOfCompetition
(
	DateOfCompetition_Id INT NOT NULL AUTO_INCREMENT,
    Rang_Competition SET('Олімпійські_ігри','Чемпіонат_світу','Чемпіонат_Європи'),
    Type_Sport VARCHAR(40),
    Country_Name VARCHAR(40) NOT NULL,
    DateEvent DATE,
    PRIMARY KEY(DateOfCompetition_Id,DateEvent),
    CONSTRAINT  TypeCompetition
    FOREIGN KEY(Type_Sport) REFERENCES TypeSport(NAME_Sport),
	CONSTRAINT  Country
    FOREIGN KEY(Country_Name) REFERENCES Сountries(Country_Name)
);
CREATE INDEX DateEvent ON DateOfCompetition(DateEvent);


INSERT INTO DateOfCompetition(DateEvent,Rang_Competition,Type_Sport,Country_Name)
VALUES
/*
('2021-3-14','Олімпійські_ігри',"Бадмінтон","Belarus"),
('2022-6-3','Чемпіонат_світу',"Дартс","America"),
('2023-5-6','Чемпіонат_Європи',"Легка атлетика","Mexico"),
('2023-6-12','Чемпіонат_світу',"Настільний теніс","France"),
('2024-5-28','Чемпіонат_Європи',"Шашки","Sweden"),
('2026.10.31','Чемпіонат_світу',"CSGO","Brazil"),
('2030.10.11','Чемпіонат_Європи',"Бейсбол","Netherlands"),
('2027.5.16','Олімпійські_ігри',"Карате","Ukraine"),
('2029.6.17','Олімпійські_ігри',"Лижні гонки","Belarus"),
('2030.5.26','Чемпіонат_Європи',"Бокс","South Korea"),
('2027.7.31','Чемпіонат_Європи',"Бадмінтон","Ukraine"),
('2032.10.11','Олімпійські_ігри',"CSGO","Ukraine"),
('2027.10.15','Чемпіонат_світу',"Дартс","Mexico"),
('2029.5.15','Чемпіонат_світу',"CSGO","Netherlands"),*/
('2031.6.21','Чемпіонат_світу',"Легка атлетика","Ukraine");

SELECT * FROM DateOfCompetition;
SELECT DateOfCompetition_Id,DateOfCompetition.Competition_Name, DateOfCompetition.Country_Name,DateEvent 
FROM сountries,TypeOfCompetition,DateOfCompetition
WHERE DateOfCompetition.Competition_Name= TypeOfCompetition.Competition_Name
and DateOfCompetition.Country_Name=Сountries.Country_Name;

