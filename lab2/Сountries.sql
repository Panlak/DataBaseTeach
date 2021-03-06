use sportscompetitions;

DROP TABLE Сountries;
CREATE TABLE Сountries
(
    Country_Name VARCHAR(40) NOT NULL UNIQUE,
    PRIMARY KEY(Country_Name)
);
CREATE INDEX Country_Name ON Сountries(Country_Name);
SHOW INDEX FROM Сountries;


DROP INDEX Country_Name ON Сountries;
describe Сountries;

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