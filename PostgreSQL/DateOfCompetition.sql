
DROP TABLE DateOfCompetition;
CREATE TABLE DateOfCompetition
(
	DateOfCompetition_Id SERIAL NOT NULL PRIMARY KEY,
    Rang_Competition VARCHAR(20)[] NOT NULL, 
	check (Rang_Competition <@ ARRAY['Олімпійські_ігри', 'Чемпіонат_світу', 'Чемпіонат_Європи']::varchar[]),
    SportId INT NOT NULL,
    Country_NAME  VARCHAR(40) NOT NULL,
    DateEvent DATE,
    FOREIGN KEY(SportId) REFERENCES TypeSport(id_Sport),
	CONSTRAINT  Country
    FOREIGN KEY(Country_NAME) REFERENCES Сountries(Country_Name)
);
INSERT INTO DateOfCompetition(DateEvent,Rang_Competition,SportId,Country_NAME)
VALUES
('2021-3-14','{Олімпійські_ігри}',1,'Belarus'),
('2022-6-3','{Чемпіонат_світу}',2,'America'),
('2023-5-6','{Чемпіонат_Європи}',3,'Mexico'),
('2023-6-12','{Чемпіонат_світу}',5,'France'),
('2024-5-28','{Чемпіонат_Європи}',7,'Sweden'),
('2026.10.31','{Чемпіонат_світу}',8,'Brazil'),
('2030.10.11','{Чемпіонат_Європи}',10,'Netherlands'),
('2027.5.16','{Олімпійські_ігри}',12,'Ukraine'),
('2029.6.17','{Олімпійські_ігри}',4,'Belarus'),
('2030.5.26','{Чемпіонат_Європи}',11,'South Korea'),
('2027.7.31','{Чемпіонат_Європи}',1,'Ukraine'),
('2032.10.11','{Олімпійські_ігри}',8,'Ukraine'),
('2027.10.15','{Чемпіонат_світу}',2,'Mexico'),
('2029.5.15','{Чемпіонат_світу}',8,'Netherlands'),
('2031.6.21','{Чемпіонат_світу}',3,'Ukraine');

SELECT * FROM DateOfCompetition;
