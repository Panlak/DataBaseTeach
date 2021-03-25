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
    id_Sport INT NOT NULL,
    Country_NAME  VARCHAR(40) NOT NULL,
    DateEvent DATE,
    PRIMARY KEY(DateOfCompetition_Id),
    CONSTRAINT  TypeCompetition
    FOREIGN KEY(id_Sport) REFERENCES TypeSport(id_Sport),
	CONSTRAINT  Country
    FOREIGN KEY(Country_NAME) REFERENCES Сountries(Country_Name)
);
CREATE INDEX DateEvent ON DateOfCompetition(DateEvent);


INSERT INTO DateOfCompetition(DateEvent,Rang_Competition,id_Sport,Country_NAME)
VALUES
('2021-3-14','Олімпійські_ігри',1,"Belarus"),
('2022-6-3','Чемпіонат_світу',2,"America"),
('2023-5-6','Чемпіонат_Європи',3,"Mexico"),
('2023-6-12','Чемпіонат_світу',5,"France"),
('2024-5-28','Чемпіонат_Європи',7,"Sweden"),
('2026.10.31','Чемпіонат_світу',8,"Brazil"),
('2030.10.11','Чемпіонат_Європи',10,"Netherlands"),
('2027.5.16','Олімпійські_ігри',12,"Ukraine"),
('2029.6.17','Олімпійські_ігри',4,"Belarus"),
('2030.5.26','Чемпіонат_Європи',11,"South Korea"),
('2027.7.31','Чемпіонат_Європи',1,"Ukraine"),
('2032.10.11','Олімпійські_ігри',8,"Ukraine"),
('2027.10.15','Чемпіонат_світу',2,"Mexico"),
('2029.5.15','Чемпіонат_світу',8,"Netherlands"),
('2031.6.21','Чемпіонат_світу',3,"Ukraine");

SELECT * FROM DateOfCompetition;
SELECT DateOfCompetition_Id,DateOfCompetition.Competition_Name, DateOfCompetition.Country_Name,DateEvent 
FROM сountries,TypeOfCompetition,DateOfCompetition
WHERE DateOfCompetition.Competition_Name= TypeOfCompetition.Competition_Name
and DateOfCompetition.Country_Nam e= Сountries.Country_Name;

