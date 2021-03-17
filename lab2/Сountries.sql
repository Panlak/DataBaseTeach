use sportscompetitions;

CREATE TABLE Сountries
(
	Country_ID INT NOT NULL AUTO_INCREMENT,
    Country_Name VARCHAR(40) NOT NULL,
    PRIMARY KEY(Country_ID)
);
INSERT INTO Сountries(Country_Name)
VALUES
("Ukraine"),
("Rusia"),
("Belarus"),
("America"),
("Canada"),
("Germany"),
("Brazil"),
("France"),
("Poland"),
("Sweden"),
("Romania"),
("Mexico"),
("Netherlands"),
("South Korea"),
("Portugal"),
("Slovenia"),
("Slovakia"),
("Turkey");

SELECT * FROM Сountries;