/*
### Create tables for the medical practice data model. ###
For the data model include:
- Table
- Columns
- Data types
- Primary key 
- Foreign Key
- Unique index constraints(alternative keys)
 |   Table        | Alternative Key                |
 | Practitioner | MedicalRegistrationNumber        |
 | Appointment  | Patient_Ref,AppDate,AppstartTime |  


CREATE TABLE Patient (
	Patient_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Firstname NVARCHAR(50),
	MiddleInitial NCHAR(5),
	LastName NVARCHAR(50),
	HouseUnitLotNum NVARCHAR(5),
	Street NVARCHAR(50),
	Suburb NVARCHAR(50),
	State NVARCHAR(3),
	PostCode NCHAR(4),
	HomePhone NCHAR(10),
	MobilePhone NCHAR(10),
	MedicareNumber NCHAR(16),
	DateOfBirth DATE,
	Gender NVARCHAR(20)
);

CREATE TABLE PractitionerType (
	PractitionerType NVARCHAR(50) NOT NULL PRIMARY KEY
);

CREATE TABLE Practitioner (
	Practitioner_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Firstname NVARCHAR(50),
	MiddleInitial NCHAR(5),
	LastName NVARCHAR(50),
	HouseUnitLotNum NVARCHAR(5),
	Street NVARCHAR(50),
	Suburb NVARCHAR(50),
	State NVARCHAR(3),
	PostCode NCHAR(4),
	HomePhone NCHAR(10),
	MobilePhone NCHAR(10),
	MedicareNumber NCHAR(16),
	MedicalRegistrationNumber NCHAR(11),
	DateOfBirth DATE,
	Gender NVARCHAR(20),
	PractitionerType_Ref NVARCHAR(50) NOT NULL FOREIGN KEY REFERENCES PractitionerType(PractitionerType)
);

CREATE TABLE Appointment (
	Appt_ID INT IDENTITY(1,1) PRIMARY KEY,
	ApptDate DATE NOT NULL,
	ApptStartTime TIME NOT NULL ,
	Patient_Ref INT FOREIGN KEY REFERENCES Patient(Patient_ID),
	Practitioner_Ref INT FOREIGN KEY REFERENCES Practitioner(Practitioner_ID) --First column in .csv file
);

CREATE TABLE WeekDays (
WeekDayName NVARCHAR(9) PRIMARY KEY
);

CREATE TABLE Availability (
Practitioner_Ref INT NOT NULL FOREIGN KEY REFERENCES Practitioner(Practitioner_ID),
WeekDayName_Ref NVARCHAR(9) NOT NULL FOREIGN KEY REFERENCES WeekDays(WeekDayName),
CONSTRAINT PK_Availability PRIMARY KEY (Practitioner_Ref, WeekDayName_Ref)
);
*/

/*
### Import .csv data to populate the tables ###

BULK INSERT Patient
FROM 'C:\Users\AKATY\Desktop\TAFE Programming\Database skills_UPDATE\myfile\15_PatientData.csv'
	WITH
	(
		FIRSTROW = 1,
		FIELDTERMINATOR= ',',
		ROWTERMINATOR= '\n',
		TABLOCK
	)

BULK INSERT Practitioner
FROM 'C:\Users\AKATY\Desktop\TAFE Programming\Database skills_UPDATE\myfile\16_PractitionerData.csv'
	WITH
	(
		FIRSTROW = 1,
		FIELDTERMINATOR= ',',
		ROWTERMINATOR= '\n',
		TABLOCK
	)

BULK INSERT Appointment

FROM 'C:\Users\AKATY\Desktop\TAFE Programming\Database skills_UPDATE\myfile\12_AppointmentData.csv'
	WITH
	(
		FIRSTROW = 1,
		FIELDTERMINATOR= ',',
		ROWTERMINATOR= '\n',
		TABLOCK
	)
SELECT * FROM Appointment

BULK INSERT PractitionerType

FROM 'C:\Users\AKATY\Desktop\TAFE Programming\Database skills_UPDATE\myfile\17_PractitionerTypeData.csv'
	WITH
	(
		FIRSTROW = 1,
		FIELDTERMINATOR= ',',
		ROWTERMINATOR= '\n',
		TABLOCK
	)

BULK INSERT Weekdays

FROM 'C:\Users\AKATY\Desktop\TAFE Programming\Database skills_UPDATE\myfile\19_WeekDaysData.csv'
	WITH
	(
		FIRSTROW = 1,
		FIELDTERMINATOR= ',',
		ROWTERMINATOR= '\n',
		TABLOCK
	)


BULK INSERT Availability

FROM 'C:\Users\AKATY\Desktop\TAFE Programming\Database skills_UPDATE\myfile\13_AvailabilityData.csv'
	WITH
	(
		FIRSTROW = 1,
		FIELDTERMINATOR= ',',
		ROWTERMINATOR= '\n',
		TABLOCK
	)
*/

