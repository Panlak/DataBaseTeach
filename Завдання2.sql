use library;
DROP TABLE VegetablesStore;

SET  @num := 0;
UPDATE VegetablesStore SET IdProduct = @num := (@num+1);
SET SQL_SAFE_UPDATES = 0;


CREATE TABLE VegetablesStore
(
	IdProduct 		  INT(11)  AUTO_INCREMENT,
    ProductName 	  VARCHAR(100) NOT NULL,
    ProductPrice_1kg	  INT NOT NULL,
    QuantityAvailable_kg INT DEFAULT 0,
    PRIMARY KEY (IdProduct)
);


INSERT INTO VegetablesStore(ProductName,ProductPrice_1kg,QuantityAvailable_kg)
VALUES("Помідор",10,300),
	  ("Огірок",8,500),
	  ("Капуста",11,200),
	  ("Цибуля",6,450),
	  ("Буряк",12,100),
	  ("Картопля",9,600);
  
  
SELECT * FROM VegetablesStore;


/*--------Заміна інформації--------*/
UPDATE VegetablesStore 
SET ProductName = "Броколі", 
ProductPrice_1kg = 15 
WHERE IdProduct = 6;
/*----------------------*/


/*----------------------------------*/
# замінив на звичайне значення під IdProduct(5);
UPDATE VegetablesStore
SET QuantityAvailable_kg = DEFAULT 
WHERE IdProduct = 5;
/*----------------------------------*/



DELETE FROM  VegetablesStore  WHERE  IdProduct = 6; # Видалити з таблиці під індексом 6 




