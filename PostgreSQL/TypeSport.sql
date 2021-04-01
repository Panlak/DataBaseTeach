CREATE TABLE TypeSport
(
	id_Sport SERIAL NOT NULL  PRIMARY KEY,
    NAME_Sport VARCHAR(40) NOT NULL
);
INSERT INTO TypeSport (NAME_Sport)
VALUES
('Бадмінтон'),
('Дартс'),
('Легка атлетика'),
('Лижні гонки'),
('Настільний теніс'),
('Шахи'),
('Шашки'),
('CSGO'),
('Футбол'),
('Бейсбол'),
('Бокс'),
('Карате');

SELECT * FROM TypeSport;