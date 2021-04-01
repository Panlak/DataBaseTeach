
DROP TABLE CarsTesla;

CREATE TABLE CarsTesla
(
	Cars_Id SERIAL NOT NULL PRIMARY KEY,
	CarName VARCHAR(40) NOT NULL,
	Descriprion VARCHAR(40)

);
INSERT INTO CarsTesla (CarName,Descriprion)
VALUES
('ModelX','6,2 секунд від 0 до 100 км/год'),
('ModelS','1020к.с Пікова потужність'),
('ModelY','Подвійний двигун');


SELECT * FROM CarsTesla;