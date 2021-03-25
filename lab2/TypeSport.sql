USE sportscompetitions;

DROP TABLE TypeSport;
CREATE TABLE TypeSport
(
	id_Sport INT NOT NULL AUTO_INCREMENT,
    NAME_Sport VARCHAR(40) NOT NULL,
    PRIMARY KEY (id_Sport)
);

INSERT INTO TypeSport (NAME_Sport)
VALUES
("Бадмінтон"),
("Дартс"),
("Легка атлетика"),
("Лижні гонки"),
("Настільний теніс"),
("Шахи"),
("Шашки"),
("CSGO"),
("Футбол"),
("Бейсбол"),
("Бокс"),
("Карате");
SELECT * FROM TypeSport