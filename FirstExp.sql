use test;
DROP TABLE Orders;
DROP TABLE Customers;
SET  @num := 0;
UPDATE Customers SET Id = @num := (@num+1);
SET SQL_SAFE_UPDATES = 0;
SET @@GLOBAL.auto_increment_increment=1;
CREATE TABLE Customers
(
	Id INT AUTO_INCREMENT,
    Age INT,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Phone VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (Id)
);

CREATE TABLE Orders
(
	Id INT AUTO_INCREMENT,
    CustomerId INT,
    CreatedAt Date,
    PRIMARY KEY (Id),
    CONSTRAINT orders_custonmers_fk
    FOREIGN KEY (CustomerId) REFERENCES customers(Id)
);
ALTER TABLE Orders AUTO_INCREMENT = 1;
/*****************************************/
INSERT INTO Orders (CreatedAt,CustomerId)
VALUES('2015-6-15',1);
ALTER TABLE customers AUTO_INCREMENT = 1;
INSERT INTO Customers (Age,FirstName,LastName,Phone)
VALUES(15,"Yura","Kondak",3966333557);


/*****************************************/
DELETE FROM Orders WHERE Id = 3;
DELETE FROM customers WHERE Id = 8;
/*****************************************/
SELECT * FROM Orders;
SELECT * FROM customers;

