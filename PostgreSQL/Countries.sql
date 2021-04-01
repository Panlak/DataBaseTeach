CREATE TABLE Сountries
(
	Country_Name VARCHAR(40) NOT NULL UNIQUE PRIMARY KEY
);
INSERT INTO Сountries(Country_Name)
VALUES
('Ukraine'),
('Rusia'),
('Belarus'),
('America'),
('Canada'),
('Germany'),
('Brazil'),
('France'),
('Poland'),
('Sweden'),
('Romania'),
('Mexico'),
('Netherlands'),
('South Korea'),
('Portugal'),
('Slovenia'),
('Slovakia'),
('Turkey');

SELECT * FROM Сountries;