USE sportscompetitions;

CREATE TABLE TypeOfCompetition
(
	Competition_Id INT NOT NULL AUTO_INCREMENT,
    Competition_Name VARCHAR(40) NOT NULL UNIQUE,
    PRIMARY KEY (Competition_Id)
);
INSERT INTO TypeOfCompetition(Competition_Name)
VALUES
("Шахи"),
("Настільний теніс"),
("Дартс"),
("Бадмінтон"),
("Легка атлетика"),
("Олімпійські ігри"),
("Чемпіонати світу"),
("Футбол"),
("Лижні гонки"),
("Шашки");
SELECT * FROM TypeOfCompetition;