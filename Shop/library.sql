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

INSERT INTO library(NameBook,NameAuthor,Price,YearPublication,QuantityAvailable)
VALUES#("Повна темрява. Без зірок","Стівен Кінг",215,2020,100),
	  #("Гарри Поттер и Тайная комната","Джоан Роулинг",220,2014,200),
	  #("Гаррі Поттер i в’язень Азкабану","Джоан Роулинг",190,2017,231),
       ("Мистецтво говорити. Таємниці ефективного спілкування","Джеймс Борг",200,2019,591),
       ("Ведмеже місто","Фредрик Бакман",250,2016,500);       