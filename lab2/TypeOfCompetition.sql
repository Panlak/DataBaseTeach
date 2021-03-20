USE sportscompetitions;

DROP TABLE TypeOfCompetition;
CREATE TABLE Competition
(
	Competition_Id INT NOT NULL AUTO_INCREMENT,
    Rang_Competition_Name SET('Олімпійські_ігри','Чемпіонат_світу','Чемпіонат_Європи'),
    Type_Sport VARCHAR(40) NOT NULL,
    PRIMARY KEY (Competition_Id,Competition_Name),
    CONSTRAINT TypeSport
    FOREIGN KEY (Type_Sport) REFERENCES TypeSport(NAME_Sport)
);
CREATE INDEX Competition_Name ON TypeOfCompetition(Competition_Name);

SHOW INDEX FROM TypeOfCompetition;
DROP INDEX Competition_Name ON TypeOfCompetition;


INSERT INTO TypeOfCompetition(Rang_Competition_Name,Type_Sport)
VALUES
('Олімпійські_ігри',"Бадмінтон"),
('Чемпіонат_світу',"Бадмінтон"),
('Чемпіонат_Європи',"Дартс"),
('Чемпіонат_Європи',"Лижні гонки"),
('Чемпіонат_світу',"Шахи"),
('Олімпійські_ігри',"CSGO"),
('Чемпіонат_світу',"CSGO"),
('Чемпіонат_Європи',"Шашки"),
('Чемпіонат_світу',"Легка атлетика"),
('Чемпіонат_Європи',"Легка атлетика");
SELECT * FROM TypeOfCompetition;