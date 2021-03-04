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

/*----------------Create Table Customer----------------*/
CREATE TABLE Customer
(	
	CustomerID INT(11) NOT NULL AUTO_INCREMENT, # Номер замовника;
	CustomerName VARCHAR(50) NOT NULL,			#Імя замовника;
    CustomerPhone VARCHAR(50) NOT NULL UNIQUE,	#Телефон замовника;
    CustomerEmail VARCHAR(100) NOT NULL,		#Адрес 	 замовника;
    PRIMARY KEY(CustomerID)
)ENGINE = InnoDB;
/*-------------------------------------------------*/


/*----------------Create Table library----------------*/
CREATE TABLE library
(	
	IdBook INT(11) NOT NULL AUTO_INCREMENT,		# Номер кники;
	NameBook VARCHAR(100) NOT NULL,				# Назва книжки;
    NameAuthor VARCHAR(100) NOT NULL,		    #Ім'я  автора
    Price INT(11) NOT NULL,			     	    # Ціна книги
	YearPublication YEAR NOT NULL,   		    #Рік видання;
	QuantityAvailable	INT(11)	NOT NULL,		#Кількість в наявності;
    PRIMARY KEY (Idbook)

)ENGINE = InnoDB;
/*-------------------------------------------------*/

/*----------------Create Table SHOP----------------*/
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
/*-------------------------------------------------*/

#-------------Онулення інкрементів-------------------
ALTER TABLE Customer AUTO_INCREMENT = 1;
ALTER TABLE library AUTO_INCREMENT  = 1;
ALTER TABLE SHOP AUTO_INCREMENT     = 1;
#----------------------------------------------------
										
/*-------------------Заповнення таблиць--------------------*/
INSERT INTO Customer (CustomerName,CustomerPhone,CustomerEmail)
VALUES#("Борис",380993550562,"ovasilenko@rivaloo.com"),
	#("Руслан",380990872179,"antonenko.oksan@homemortgagedirectlender.com"),
	#("Євген",380992661392,"kravcenko.dmitr@israel-international.de"),
     ("Данил",0999822606,"ludmila.ivancen@touchsalabai.org"),
     ("Андрій",0999502274,"miroslav72@baotaochi.com");
    
/*-------------------------------------------------*/
INSERT INTO library(NameBook,NameAuthor,Price,YearPublication,QuantityAvailable)
VALUES#("Повна темрява. Без зірок","Стівен Кінг",215,2020,100),
	  #("Гарри Поттер и Тайная комната","Джоан Роулинг",220,2014,200),
	  #("Гаррі Поттер i в’язень Азкабану","Джоан Роулинг",190,2017,231),
       ("Мистецтво говорити. Таємниці ефективного спілкування","Джеймс Борг",200,2019,591),
       ("Ведмеже місто","Фредрик Бакман",250,2016,500);       
/*----Записи продажів--------------------------------------------*/
INSERT INTO SHOP (IdBook,CustomerID) VALUES(3,2);
/*-------------------------------------------------*/

/*Інформація про таблиці*/
SELECT * FROM Customer;
SELECT * FROM library;
SELECT * FROM SHOP;                           


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
/*--------------------*/
