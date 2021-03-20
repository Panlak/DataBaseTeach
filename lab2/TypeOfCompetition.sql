USE sportscompetitions;

DROP TABLE TypeOfCompetition;
CREATE TABLE TypeOfCompetition
(
	Competition_Id INT NOT NULL AUTO_INCREMENT,
    Competition_Name VARCHAR(40) NOT NULL,
    PRIMARY KEY (Competition_Id,Competition_Name)
);
CREATE INDEX Competition_Name ON TypeOfCompetition(Competition_Name);





SHOW INDEX FROM TypeOfCompetition;
DROP INDEX Competition_Name ON TypeOfCompetition;

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