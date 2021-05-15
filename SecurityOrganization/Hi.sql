INSERT INTO public."Country"(
	"CountriesId", "CountryName")
	VALUES (1, 'Ukraine');
	
	INSERT INTO public."City"(
	"CityId", "CityName", "CountriesId")
	VALUES (1, 'Lviv', 1);
	


INSERT INTO public."SecurityOrganization"(
"SecurityOrganizationId", "NameOrganization", "Email", "CountEmployees", "CityId")
VALUES ('2', 'Bears', 'Bears.gmail.com', 200, 1);
	
SELECT * FROM 	public."SecurityOrganization"

INSERT INTO public."Service"(
"ServiceId", "SecurityOrganizationId", "Name", "Price", "Description")
VALUES (2, 2, 'Vesdaro', 200, 'hello');
select * from "Service"
------------------	------------------	------------------	------------------	
INSERT INTO public."Customer"(
"CustomerId", "Customer_Name", "Custome_Surname", "Phone", "Email", "CityId")
VALUES (2, 'Andrian', 'Kobrin', 3802469839797, 'kondak.yura@gmaio', 1);
	
select * from public."Customer"
------------------	------------------	------------------	------------------	

	
	
	
INSERT INTO public."Subscription"(
"SubscriptionId", "ServiceId", "ServiceSecurityOrganizationId", "CustomerId", "SubscriptionName", "Price", "StartSubscription", "EndtSubscription")
VALUES (2, 2, 2, 2, 'Parasolka',1000, '2001.05.25', '2001.05.25');
SELECT * FROM public."Subscription"
------------------	------------------	------------------	------------------	

	

INSERT INTO public."Events"(
"EventsId", "SubscriptionId", "SubscriptionServiceId", "SubscriptionServiceSecurityOrganizationId", "SubscriptionCustomerId", "Event_Type", "Time_call", "Priority", "Notes")
VALUES (2, 2, 2, 2,2, 'Пограбування', '2001.05.25', 'Hight', 'No notes');
select * from public."Events"
------------------	------------------	------------------	------------------		
	
	
	
INSERT INTO public."Staff"(
	"StaffId", "NameCommand", "CountPeople", "CityId")
	VALUES (1, 'Berkut', 10, 1);
------------------	------------------	------------------	------------------	

INSERT INTO public."DeparutureInfo"(
	"DeparutureInfoId", "EventsId", "EventsSubscriptionId", "EventsSubscriptionServiceId", "EventsSubscriptionServiceSecurityOrganizationId", "EventsSubscriptionCustomerId", "StaffId", "Notes", "DepartureTime")
	VALUES (2, 2, 2, 2, 2, 2, 1, 'fasolka', '2001.05.25');
select * from public."DeparutureInfo"
------------------	------------------	------------------	------------------	
	
	