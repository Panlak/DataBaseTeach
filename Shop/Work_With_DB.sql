USE librarytests;

SET  @num := 0;
UPDATE Customer SET CustomerID = @num := (@num+1);
SET  @num := 0;
UPDATE library SET IdBook = @num := (@num+1);
SET  @num := 0;
UPDATE SHOP SET OrderNumber = @num := (@num+1);
SET SQL_SAFE_UPDATES = 0;

/*-------Видалення таблиць-------*/
DROP TABLE Customer;
DROP TABLE library;
DROP TABLE SHOP;
/*------------------------------*/



/*Інформація про таблиці*/
SELECT * FROM Customer;
SELECT * FROM library;
SELECT * FROM SHOP;                           



/*Пошук замовників в яких є книжка*/
SELECT *
FROM Customer,SHOP,library WHERE
customer.CustomerID = 1 AND SHOP.CustomerID = customer.CustomerId=1 AND library.IdBook = SHOP.IdBook; 
/*--------------------*/


/*-----------------------Заміна інформації-----------------------*/

UPDATE Customer SET CustomerID = 2 WHERE (CustomerName = 'Руслан');
DELETE FROM Customer WHERE CustomerName = 'Оксана';
/*------------------------------------------------------------*/

/*Інформація про зміні в таблиці*/
DESCRIBE Customer;
DESCRIBE library;
DESCRIBE SHOP;