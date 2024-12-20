/*
1.	Create a view (called vwNurseDays) with the name and phone details of any nurse (registered or not) and the days that they work. Execute the SQL statements to create the view.
2.	Using your view, write a query to retrieve the name and phone number details of all nurses who are scheduled to work on a Wednesday.
3.	Create a view (called vwNSWPatients) that contains all patient details for patients whose address is in NSW. Execute the SQL statements to create the view.
4.	Create a stored procedure (called spSelect_vwNSWPatients) to retrieve all records and columns from vwNSWPatients in postcode order ascending. Execute the stored procedure.
5.	Create a stored procedure (called spInsert_vwNSWPatients) to insert a new record into vwNSWPatients, using parameters for all relevant data. Execute the stored procedure inserting a record for a new patient named Mr Mickey M Mouse from 1 Smith St, Smithville, NSW 2222. 
Run a query to verify that the record has been added to the Patient table.
6.	Create a stored procedure (called spModify_PractitionerMobilePhone) using the Practitioner table to change a practitioner’s mobile phone number, using the Practitioner ID and the new mobile number as parameters. Execute the stored procedure to change Hilda Brown’s mobile number to 0412345678.
Run a query to verify that the record has been updated in the Practitioner table.
7.	Manipulate the Practitioner table to store a driver’s licence number. For privacy and security purposes this data needs to be encrypted. Name the new column DriversLicenceHash. For encrypting the column, use a one-way hashing algorithm. Execute the statement to create the new column.
Add the drivers licence number of 1066AD Dr Ludo Vergenargen’s (Practitioner ID 10005) drivers licence using a SHA hashing function.
Display Dr Vertenargen’s record to view the hashed number.
8.	Manipulate the Patient table to add a new column that will store a date value which is the last date they made contact. The default value should be the date of record creation. Name the new column LastContactDate. Execute the statement to create the new column.
9.	Create a trigger on the Appointment table that will update LastContactDate on the Patient table each time a new record is added to the Appointment table. The value of the LastContactDate should be the date the record is added. Name the trigger tr_Appointment_AfterInsert.
10.	Delete the view vwNurseDays from the database.
11.	Delete the stored procedure spSelect_vwNSWPatients from the database.
*/

/*1.	Create a view (called vwNurseDays) with the name and phone details of any nurse (registered or not) and the days that they work. Execute the SQL statements to create the view.
	CREATE VIEW vwNurseDays AS
	SELECT prac.Firstname, prac.LastName,prac.HomePhone, prac.MobilePhone, av.WeekDayName_Ref 
	FROM Practitioner prac
	JOIN Availability av ON prac.Practitioner_ID = av.Practitioner_Ref
		WHERE PractitionerType_Ref LIKE '%nurse%';
	SELECT * FROM vwNurseDays;
*/

--2.	Using your view, write a query to retrieve the name and phone number details of all nurses who are scheduled to work on a Wednesday.
SELECT  
FROM vwNurseDays vwn
WHERE vwn.WeekDayName_Ref = 'Wednesday';

--3.	Create a view (called vwNSWPatients) that contains all patient details for patients whose address is in NSW. Execute the SQL statements to create the view.
/*
	CREATE VIEW vwNSWPatients AS
	SELECT *
	FROM Patient pt
	WHERE pt.State = 'NSW';
*/
-- 4.	Create a stored procedure (called spSelect_vwNSWPatients) to retrieve all records and columns from vwNSWPatients in postcode order ascending. Execute the stored procedure.
/*
CREATE OR ALTER PROCEDURE spSelect_vwNSWPatients 
AS
BEGIN
	SELECT *
	FROM vwNSWPatients vwnsw
	ORDER BY vwnsw.postcode ASC
END;

EXEC spSelect_vwNSWPatients;
*/

--5.	Create a stored procedure (called spInsert_vwNSWPatients) to insert a new record into vwNSWPatients, using parameters for all relevant data. Execute the stored procedure inserting a record for a new patient named Mr Mickey M Mouse from 1 Smith St, Smithville, NSW 2222. 
/*CREATE OR ALTER PROCEDURE spInsert_vwNSWPatients
	@firstname NVARCHAR(50),
	@middle NCHAR(5),
	@lastname NVARCHAR(50),
	@housenum NVARCHAR(5),
	@street NVARCHAR(50),
	@suburb NVARCHAR(50),
	@state NVARCHAR(3),
	@postcode NCHAR(4),
	@homenum NCHAR(10),
	@mobilenum NCHAR(10),
	@medi NCHAR(16),
	@dob DATE,
	@gender NVARCHAR(20)
AS
BEGIN
	INSERT INTO Patient(Firstname, MiddleInitial ,LastName, HouseUnitLotNum, Street, Suburb, State, Postcode, Homephone, MobilePhone, MedicareNumber, DateOfBirth, Gender)
	VALUES(@firstname,@middle,@lastname,@housenum,@street,@suburb,@state,@postcode,@homenum,@mobilenum,@medi,@dob,@gender);
END;

EXEC spInsert_vwNSWPatients 
	@firstname = 'Mickey',
	@middle = 'M',
	@lastname = 'Mouse',
	@housenum = '1',
	@street = 'smith st',
	@suburb = 'Smithville',
	@state = 'NSW',
	@postcode = '2222',
	@homenum = '0405869785',
	@mobilenum = '0402555897',
	@medi = '091242358335',
	@dob = '1941-02-10',
	@gender = 'male'
;
*/
SELECT * FROM vwNSWPatients;


--6.	Create a stored procedure (called spModify_PractitionerMobilePhone) using the Practitioner table to change a practitioner’s mobile phone number, using the Practitioner ID and the new mobile number as parameters. 
-- Execute the stored procedure to change Hilda Brown’s mobile number to 0412345678.
/*
CREATE OR ALTER PROCEDURE spModify_PractitionerMobile
	@id INT,
	@num NCHAR(10)
AS
BEGIN
	UPDATE Practitioner
	SET MobilePhone = @num
	WHERE Practitioner_ID = @id;
END;

EXEC spModify_PractitionerMobile
	@id = 2,
	@num = '0412345678';
*/
SELECT * FROM Practitioner

--7.	Manipulate the Practitioner table to store a driver’s licence number. For privacy and security purposes this data needs to be encrypted. Name the new column DriversLicenceHash. For encrypting the column, use a one-way hashing algorithm. Execute the statement to create the new column.
--Add the drivers licence number of 1066AD Dr Ludo Vergenargen’s (Practitioner ID 10005) drivers licence using a SHA hashing function.
--Display Dr Vertenargen’s record to view the hashed number.
 /*
ALTER TABLE Practitioner
ADD DriversLicenceHash VARBINARY(64);


ALTER PROCEDURE spEncrypt_PracDriverLicence 
	@id INT,
	@driver NVARCHAR(64)
AS
BEGIN
	UPDATE Practitioner
	SET DriversLicenceHash = HASHBYTES('SHA2_512', @driver)
	WHERE Practitioner_ID =	@id
END;
*/
EXEC spEncrypt_PracDriverLicence
	@id= 6,
	@Driver= '1066AD';

SELECT * FROM Practitioner
WHERE Practitioner_ID = 6;


UPDATE Practitioner
SET DriversLicenceHash = HASHBYTES('SHA2_512', '2055AD')
WHERE Practitioner_ID =	5;

--8.	Manipulate the Patient table to add a new column that will store a date value which is the last date they made contact. The default value should be the date of record creation. Name the new column LastContactDate. 
-- Execute the statement to create the new column.
/*
ALTER TABLE Patient
ADD LastContactDate DATE;

SELECT * FROM Patient

UPDATE Patient
SET LastContactDate = (
	SELECT MAX(Appointment.ApptDate)
	FROM Appointment
	WHERE Appointment.Patient_Ref = Patient.Patient_ID
);
*/

-- 9.	Create a trigger on the Appointment table that will update LastContactDate on the Patient table each time a new record is added to the Appointment table. 
-- The value of the LastContactDate should be the date the record is added. Name the trigger tr_Appointment_AfterInsert.
CREATE OR ALTER TRIGGER trg_Appointment_AfterInsert
ON Appointment
AFTER INSERT
AS
BEGIN
	UPDATE Patient
	SET LastContactDate = GETDATE()
	FROM Patient pt
	JOIN inserted i ON pt.Patient_ID = i.Patient_Ref
END;

SELECT * FROM Appointment;

SET IDENTITY_INSERT Appointment ON;
INSERT INTO Appointment(Appt_ID,ApptDate,ApptStartTime,Patient_Ref,Practitioner_Ref) VALUES (21,'2024-12-24','10:00:00',77,2);
SET IDENTITY_INSERT Appointment OFF;

SELECT * FROM patient

--10.	Delete the view vwNurseDays from the database.
DROP VIEW vwNurseDays
-- 11.	Delete the stored procedure spSelect_vwNSWPatients from the database.
DROP PROCEDURE spSelect_vwNSWPatients