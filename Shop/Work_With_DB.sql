
CREATE DATABASE librarytests;
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
SELECT customer.CustomerID,
OrderNumber,      #Номер замовлення
library.IdBook,   #Номер книжки
CustomerName,     # Ім'я замовника
CustomerPhone,    # Телефон замовника
CustomerEmail,    # Пошта замовника
NameBook,         # Назва книжки
NameAuthor,       # Ім'я автора книжки
Price,			  # Ціна Книжки
YearPublication,  # Рік видання
QuantityAvailable # Кількість в наявності
FROM Customer,SHOP,library WHERE
customer.CustomerID = 3 AND SHOP.CustomerID = customer.CustomerID AND library.IdBook = SHOP.IdBook; 
# (таблиця custumer)CustomerID = 2 і (таблиця SHOP) CustomerID = (таблиця custumer) CustomerID і (таблиця library )IdBook = (таблиця SHOP)IdBook;
# (Зрівняння з таблицею SHOP зроблено щоб інформація не повторювалась);
/*--------------------*/


/*-----------------------Заміна інформації-----------------------*/
UPDATE Customer SET CustomerID = 2 WHERE (CustomerName = 'Руслан');
DELETE FROM Customer WHERE CustomerName = 'Оксана';
/*------------------------------------------------------------*/

# IN - опертор фільтрації


/*------Використання функцій--------*/
/*------------------------------------*/
SELECT UCASE(NameAuthor) FROM library; # Використання функції UCASE - перетворення в верхній регістр (тип VARCHAR);
/*------------------------------------*/
SELECT LCASE(NameAuthor) FROM library; # Використання функції LCASE - перетворення в нижній регістр (тип VARCHAR);

SELECT IdBook,NameBook,NameAuthor FROM library ORDER BY NameBook DESC LIMIT 1; # Пошук 1-шого значення в стовпцю NameBook (тип VARCHAR);

SELECT IdBook,NameBook,NameAuthor FROM library ORDER BY NameBook ASC LIMIT 1; # Пошук 1-шого значення в стовпцю NameBook (тип VARCHAR);

SELECT * FROM library WHERE NameBook LIKE 'Гаррі%' OR NameBook LIKE 'Гарри%'; # Пошук назви книги починається на Гарри або Гаррі


/*----Скільки замовникики потратили на книги------*/
SELECT 
shop.CustomerID,
CustomerName,
CustomerPhone,
CONCAT(SUM(Price)," ","₴") AS MoneySpent,  # також можна з зробити з AVG();
CASE
	WHEN COUNT(library.IdBook) = 1
		THEN  CONCAT( COUNT(library.IdBook),"-" 'book')       #Або через **-- IF(COUNT(library.IdBook) = 1,'book','books') AS BoughtBooks --**
    ELSE  CONCAT(COUNT(library.IdBook), "-" 'books')
END AS BoughtBooks,
CONCAT(MIN(PRICE), " " , "₴" , " ",library.NameBook)AS Minimum_Price_Book,
CONCAT(MAX(PRICE), " " , "₴" , " ",library.NameBook)AS Maximum_Price_Book
FROM library,SHOP,customer
WHERE  
shop.CustomerID = customer.CustomerID AND
library.IdBook  = shop.IdBook 
GROUP BY shop.CustomerID
ORDER BY MoneySpent DESC;
/*----------------------------------------------*/

SELECT NameAuthor,NOW() FROM library;





/*------------------------------------*/

/*Інформація про зміні в таблиці*/
DESCRIBE Customer;
DESCRIBE library;
DESCRIBE SHOP;