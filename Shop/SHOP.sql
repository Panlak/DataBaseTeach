CREATE TABLE SHOP
(
	OrderNumber INT(11) NOT NULL AUTO_INCREMENT, # Номер замовлення;
    IdBook INT NOT NULL,						 # Номер Книги;
    CustomerID INT NOT NULL,					 # Номер Замовника
    PRIMARY KEY(OrderNumber),
    CONSTRAINT libraryIdBook
    FOREIGN KEY (IdBook) REFERENCES library(IdBook),  # 1 зовнішній ключ
    CONSTRAINT CustomerCustomerID
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)  # 2 зовнішній ключ
)ENGINE = InnoDB;

INSERT INTO SHOP (IdBook,CustomerID) VALUES(3,2);