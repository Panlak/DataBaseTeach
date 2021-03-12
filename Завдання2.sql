use library;
DROP TABLE VegetablesStore;
SELECT * FROM VegetablesStore;


SET  @num := 0;
UPDATE VegetablesStore SET IdProduct = @num := (@num+1);
SET SQL_SAFE_UPDATES = 0;


CREATE TABLE VegetablesStore
(
	IdProduct 		  INT(11)  AUTO_INCREMENT,
    ProductName 	  VARCHAR(100) NOT NULL,
    ProductPrice_1kg	  INT NOT NULL,
    QuantityAvailable_kg INT DEFAULT 0,
    TimeDilivery date,
    PRIMARY KEY (IdProduct)
);


INSERT INTO VegetablesStore(ProductName,ProductPrice_1kg,QuantityAvailable_kg,TimeDilivery)
VALUES("Помідор",10,300,'2021.3.9'),
	  ("Огірок",8,500,'2021.3.11'),
	  ("Капуста",11,200,'2021.3.12'),
	  ("Цибуля",6,450,'2021.2.9'),
	  ("Буряк",12,100,'2021.3.4'),
	  ("Картопля",9,600,'2020.11.9');
  
  

SELECT  
ProductName,
DATE(TimeDilivery) # сама безкорисна функція в світі після NOW(); 	(в цьому випадку) 
FROM VegetablesStore;




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

SELECT * FROM VegetablesStore;


DELETE FROM  VegetablesStore  WHERE  IdProduct = 6; # Видалити з таблиці під індексом 6 




