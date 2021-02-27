USE librarytests;

/*-------Видалення таблиць-------*/
DROP TABLE authors;
DROP TABLE books;
/*------------------------------*/


/*----------------Create Table authors----------------*/
CREATE TABLE authors
(
	ID	INT(11)		NOT NULL AUTO_INCREMENT,
	Author	VARCHAR(40) NOT NULL UNIQUE	,
	PRIMARY KEY(ID)
);
/*-------------------------------------------------*/


/*----------------Create Table books----------------*/
CREATE TABLE books
(
	BookId	INT(11)		NOT NULL	AUTO_INCREMENT,
	AuthorName	VARCHAR(40)		NOT NULL,
	NameBook	VARCHAR(40)	NOT NULL,
	yearOfPublication YEAR NOT NULL,
	CountAccounted	INT(11)	NOT NULL,	
	Price	INT(11)	NOT NULL,
	PRIMARY KEY(BookId),
	CONSTRAINT AuthorKey
	FOREIGN KEY(AuthorName) REFERENCES authors(Author)
);
/*-------------------------------------------------*/

/*-------------------Заповнення таблиць--------------------*/
INSERT INTO authors(Author)
VALUES("Стівен Кінг");
/*-------------------------------------------------*/
INSERT INTO Books(AuthorName,NameBook,yearOfPublication,CountAccounted,Price)
VALUES("Стівен Кінг","Чужак",2018,30,299);
/*-------------------------------------------------*/

/*Інформація про таблиці*/
SELECT * FROM authors;
SELECT * FROM books;
/*--------------------*/


/*Інформація про зміні в таблиці*/
DESCRIBE authors;
DESCRIBE books;
/*--------------------*/




