CREATE TABLE Countries
(
	Country_Id serial PRIMARY KEY,
	CountryName varchar(40) NOT NULL,
	Pupolation int NOT NULL
);



-------------------------------------------------------------
CREATE TABLE City
(
	City_Id serial PRIMARY KEY,
	CityName varchar(40),
	Country_Id int NOT NULL,
	FOREIGN KEY(Country_Id) REFERENCES (Countries);
);


------------------------------------------------------------- 

CREATE TABLE SecurityOranizations
(
	SecurityOranizations_Id serial PRIMARY KEY,
	Name_Organization varhcar(40) NOT NULL,
	CountEmployees int NOT NULL,
	Organization_Site varchar(40),
	Email varchar(40) NOT NULL,
	City_id int NOT NULL,
	FOREIGN KEY (City_id) REFERENCES City(City_id)
);


------------------------------------------------------------- 


CREATE TABLE DirectorsSecurityOrganization
(
	Director_Id serial  ,
	DirectorName varchar(40) NOT NULL,
	DirectorSurname varchar(40) NOT NULL,
	WorkPhone varchar(20) NOT NULL,
	HomePhone varchar(20) NOT NULL,
	Email varchar(30) NOT NULL,
	SecurityOranization_Id int ,
	City_Id int NOT NULL,
	PRIMARY KEY(Director_Id,SecurityOranization_Id),
	FOREIGN KEY (City_id) REFERENCES City(City_id),
	FOREIGN KEY (SecurityOranization_Id) REFERENCES SecurityOranizations(SecurityOranizations_Id)
);

------------------------------------------------------------- 

CREATE TABLE Service
(
	Serivice_Id serial ,
	ServiceName varchar(40) NOT NULL,
	Current_Price int NOT NULL,
	Description text,
	SecurityOranization_Id int,
	PRIMARY KEY (Serivice_Id,SecurityOranization_Id),
	FOREIGN KEY (SecurityOranization_Id) REFERENCES SecurityOranizations(SecurityOranizations_Id)
);


CREATE TABLE UserInformation
(
	UserInformationId serial,
	UserName varchar(30),
	UserSurname varchar(30),
	Phone varchar(100),
	Email varchar(100),
	passport varchar(100),
	ZIP Code int NOT NULL,
	Active boolean NOT NULL,
	City_Id int NOT NULL,
	SecurityOranization_Id int,
);







