CREATE TABLE Customer
(	
	CustomerID INT(11) NOT NULL AUTO_INCREMENT, # Номер замовника;
	CustomerName VARCHAR(50) NOT NULL,			#Імя замовника;
    CustomerPhone VARCHAR(50) NOT NULL UNIQUE,	#Телефон замовника;
    CustomerEmail VARCHAR(100) NOT NULL,		#Адрес 	 замовника;
    PRIMARY KEY(CustomerID)
)ENGINE = InnoDB;

INSERT INTO Customer (CustomerName,CustomerPhone,CustomerEmail)
VALUES("Борис",380993550562,"ovasilenko@rivaloo.com"),
	("Руслан",380990872179,"antonenko.oksan@homemortgagedirectlender.com"),
	("Євген",380992661392,"kravcenko.dmitr@israel-international.de"),
     ("Данил",0999822606,"ludmila.ivancen@touchsalabai.org"),
     ("Андрій",0999502274,"miroslav72@baotaochi.com");
SELECT * FROM Customer;