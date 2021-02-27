USE library;
SELECT * FROM books;
DESCRIBE books;

/*Видалення таблиці*/
DROP TABLE IF EXISTS books;
/*-----------------*/

/*----------Створення таблиці-------------*/
CREATE TABLE books
(
	idBook	INT(11)		NOT NULL	AUTO_INCREMENT,
	author	VARCHAR(100)		NOT NULL,		
	nameBook	varchar(100)	NOT NULL,			
	yearOfPublication	YEAR	NOT NULL,			
	CountAccounted	INT(11),
    PRIMARY KEY(idBook)
);

/*Добавлення Price - ціна після створення таблиці*/
ALTER TABLE books
ADD COLUMN Price INT(11);

/*----------------------------------------*/
/*----------Заповнення таблиці----------*/
INSERT INTO books(author,nameBook,yearOfPublication,CountAccounted,Price)
VALUES
("Ульф Старк", "Диваки і зануди",	2015, 60, 110),
("Макс Кідрук",	"Доки світло не згасне назавжди",	2019,	100,	120),
("Анджей Сапковський",	"Божі воїни",	2019,	80,	170),
("Ден Браун",	"Втрачений символ",	2018,	76,	149),
("Фрідріх Дюрренматт","Суддя та його кат", 2016,	75,	50),
("Ноа Гоулі",	"За мить до падіння",	2018,	45,	160),
("Д. Кіз",	"Квіти для Елджернона",	2015,	45,	130),
("Арундаті Рой",	"Міністерство граничного щастя",	2017,	36,	120),
("К. Р. Сафон",	"Опівнічний Палац. Книга 2",	2015,	35,	140);

/*----------------------------------------*/

/*--------------Знайти найстарішого видання книги з найменшою кількістю за обліком---------------------------*/
           /*yearOfPublication = рік видання ; CountAccounted = кількість за обліком; */
SELECT * FROM books WHERE 
yearOfPublication = (SELECT MIN(yearOfPublication) FROM books) 
AND 
(CountAccounted = (SELECT MIN(CountAccounted) FROM books));
/*--------------------------------------------------------*/
	
/*-------------------Знайти інформацію про всі книги, що мають найбільшу ціну-----------------------*/
	SELECT * FROM books 
    WHERE
    Price = (SELECT MAX(Price) FROM books)
/*--------------------------------------------------------*/

