CREATE TABLE Countries
(
	Country_Id serial PRIMARY KEY,
	CountryName varchar(40) NOT NULL,
	Pupolation int NOT NULL
);
INSERT INTO Countries (CountryName,Pupolation)
VALUES
('Ukraine',2000000),
('Russia',3000000),
('Belarus',250000);

SELECT * FROM Countries;
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
CREATE TABLE City
(
	City_Id serial PRIMARY KEY,
	CityName varchar(40),
	Country_Id int NOT NULL,
	FOREIGN KEY(Country_Id) REFERENCES Countries(Country_Id)
);

INSERT INTO City (CityName,Country_Id)
VALUES
('Kiev',1),
('Moscow',2),
('Минск',3);

INSERT INTO City (CityName,Country_Id)
VALUES ('Lviv',1);

SELECT * FROM City;
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

CREATE TABLE SecurityOranizations
(
	SecurityOranizations_Id serial PRIMARY KEY,
	Name_Organization varchar(40) NOT NULL,
	CountEmployees int NOT NULL,
	Organization_Site varchar(40),
	Email varchar(40) NOT NULL,
	City_id int NOT NULL,
	FOREIGN KEY (City_id) REFERENCES City(City_id)
);
INSERT INTO SecurityOranizations (Name_Organization,CountEmployees,Organization_Site,
								 Email,City_id) 
			VALUES
			('Alpha',500,'Alpha.protection.com','Alpha.protection@gmail.com',1),
			('Bear',800,'Bear.protection.com','Bear.protection@gmail.com',2),
			('Shepherd',450,'shepherd.protection.com','shepherd.protection@gmail.com',3);
			
SELECT * FROM SecurityOranizations;
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
DROP TABLE Service;
CREATE TABLE Service
(
	Serivice_Id serial ,
	ServiceName varchar(100) NOT NULL,
	Price int NOT NULL,
	Description text,
	SecurityOranization_Id int,
	PRIMARY KEY (Serivice_Id,SecurityOranization_Id),
	FOREIGN KEY (SecurityOranization_Id) REFERENCES SecurityOranizations(SecurityOranizations_Id)
);

INSERT INTO Service (ServiceName,Price,Description,SecurityOranization_Id)
VALUES ('CCTV camera model',2000,'The model of the street video surveillance camera with the solar battery will help to scare away uninvited guests from penetration into your dwelling. The case is tight and made of
durable plastic. A feature of this model is the presence of a solar battery, which feeds the LED camera on a sunny day, and in the dark LED
can be powered by 2 type A batteries. Thanks to the solar battery significantly increases the life of the batteries. Moisture protection allows you to place the camera',
	   '1'),
	   ('Video intercom kit Slinex SM-07M + ML-15HR',2500,'the advantages of the 5іїпех 5М-О7М video intercom set include stylish modern design, compact size, affordable price, convenience and simplicity
use.',2),
('Video on-door speakerphone Slinex SQ-04 White',4000,'5іypeh 50-04 - network video intercom with a 4.5-inch screen. This model has nothing superfluous, does not take up much space and has a stylish design. Its main
Feature - simplicity. The intercom screen provides a clear and saturated image at a resolution of 480 by 272 pixels. The body of the device is made of high quality:
t plastic. On the front panel of the intercom there are: power indicators. At the bottom of the control button - view, open, open, hang up.',3);

SELECT * FROM Service;
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------


CREATE TABLE Customer
(
	Customer_id serial,
	CustomerName varchar(30),
	CustomerSurname varchar(30),
	Phone varchar(100),
	Email varchar(100),
	passport varchar(100),
	City_Id int NOT NULL,         
	PRIMARY KEY (Customer_id),
	FOREIGN KEY (City_id) REFERENCES City(City_id)	
);
INSERT INTO Customer(CustomerName,CustomerSurname,Phone,Email,passport,City_Id)
VALUES('Alexey','Lysenko','+380966001526','Alexey.Lysenko@gmail.com','photo/passport.jpg',4),
	  ('Tamara','Baranova','(495) 545-6558','Tamara.Baranova@gmail.com','photo/passport.jpg',2),
	  ('Vera','Borisovna','(495) 230-5044','Vera.Borisovna@gmail.com','photo/passport.jpg',3)

INSERT INTO Customer(CustomerName,CustomerSurname,Phone,Email,passport,City_Id)
VALUES('Ruslan','Kramarchuk','+38(0979)274259','Ruslan.Kramarchuk@gmail.com','photo/passport.jpg',1)

SELECT * FROM Customer;


-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
DROP TABLE SecuritycSubscription;
CREATE TABLE SecuritycSubscription
(
	Subscription_Id serial,
	SubscriptionName varchar(100) NOT NULL,
	Price INT NOT NULL,
	StartSubscription date NOT NULL,
	EndtSubscription date NOT NULL,
	Customer_id int NOT NULL,
	Service_id int NOT NULL,
	Service_Security_Id int NOT NULL,
	PRIMARY KEY (Subscription_Id,Service_id,Service_Security_Id,Customer_id),
	FOREIGN KEY (Service_id,Service_Security_Id) REFERENCES  Service (Serivice_Id,SecurityOranization_Id),
	FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

INSERT INTO SecuritycSubscription(SubscriptionName,Price,StartSubscription,EndtSubscription,Customer_id,Service_id,Service_Security_Id)
VALUES('ProfiSecurity',10000,(select now()),(select now() ),1,1,1)

INSERT INTO SecuritycSubscription(SubscriptionName,Price,StartSubscription,EndtSubscription,Customer_id,Service_id,Service_Security_Id)
VALUES('MediumSecurity',5000,(select now()),(select now() ),1,1,1)

INSERT INTO SecuritycSubscription(SubscriptionName,Price,StartSubscription,EndtSubscription,Customer_id,Service_id,Service_Security_Id)
VALUES('LowSecurity',3000,(select now()),(select now() ),4,2,2)


SELECT * FROM SecuritycSubscription;
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

DROP TABLE Events
CREATE TABLE Events
(
	Event_id serial,
	Event_Type VARCHAR(20)[] NOT NULL
	check (Event_Type <@ ARRAY['manual_call', 'automatic_alarm', 'Another']::varchar[]),
	Priority VARCHAR(20)[] NOT NULL
	check (Priority <@ ARRAY['Big', 'Medium', 'Low']::varchar[]),
	Call_Time timestamp NOT NULL,
	Notes varchar(255) NOT NULL,
	Subscription_Id int NOT NULL,
	SecuritycSubscription_Customer_id int NOT NULL,
	SecuritycSubscription_Service_id int NOT NULL,
	SecuritycSubscription_Service_Security_Id int NOT NULL,
	PRIMARY KEY (Event_id,Subscription_Id,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id),
	FOREIGN KEY (Subscription_Id,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id)
	REFERENCES  SecuritycSubscription(Subscription_Id,Customer_id,Service_id,Service_Security_Id)
);
INSERT INTO Events (Event_Type,Priority,Call_Time,Notes,Subscription_Id,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id)
VALUES ('{automatic_alarm}','{Big}','2021.04.05','occurrence',3,4,2,2)

INSERT INTO Events (Event_Type,Priority,Call_Time,Notes,Subscription_Id,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id)
VALUES ('{manual_call}','{Medium}','2021.03.05','looting',2,1,1,1)

INSERT INTO Events (Event_Type,Priority,Call_Time,Notes,Subscription_Id,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id)
VALUES ('{Another}','{Low}','2021.02.05','sabotage',1,1,1,1)

UPDATE Events SET Event_id =3 WHERE Event_id=5;

DELETE FROM Events WHERE Event_id =4

SELECT * FROM Events;

-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

CREATE TABLE Staff
(
	Staff_id serial NOT NULL,
	NameCommand varchar(45) NOT NULL,
	DepartureTime date NOT NULL,
	CountPeople int NOT NULL,
	Notes varchar(255) NOT NULL,
	City_Id int NOT NULL,
	Event_id int NOT NULL,
	Subscription_Id int NOT NULL,
	SecuritycSubscription_Customer_id int NOT NULL,
	SecuritycSubscription_Service_id int NOT NULL,
	SecuritycSubscription_Service_Security_Id int NOT NULL,
	PRIMARY KEY(Staff_id,Event_id,Subscription_Id,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id),
	FOREIGN KEY (Event_id,Subscription_Id,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id)
	REFERENCES	Events(Event_id,Subscription_Id ,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id),
	FOREIGN KEY (City_Id) REFERENCES City(City_Id)
);

SELECT * FROM Staff;

INSERT INTO Staff(NameCommand,DepartureTime,CountPeople,Notes,City_Id,Event_id,Subscription_Id,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id)
VALUES('Bears',(select now()),4,'3 robber',1,1,3,4,2,2);
INSERT INTO Staff(NameCommand,DepartureTime,CountPeople,Notes,City_Id,Event_id,Subscription_Id,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id)
VALUES('sharks',(select now()),2,'bank',2,2,2,1,1,1);
INSERT INTO Staff(NameCommand,DepartureTime,CountPeople,Notes,City_Id,Event_id,Subscription_Id,SecuritycSubscription_Customer_id,SecuritycSubscription_Service_id,SecuritycSubscription_Service_Security_Id)
VALUES('sharks',(select now()),2,'bank',2,3,1,1,1,1);

SELECT * FROM Staff;



