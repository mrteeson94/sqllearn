/*
QUERY MedicalPractice TASK 2

1.	List the first name and last name of female patients who live in St Kilda or Lidcombe.
2.	List the first name, last name, state and Medicare Number of any patients who do not live in NSW.
3.	List each patient's first name, last name, Medicare Number and their date of birth. Sort the list by date of birth, listing the youngest patients first.
4.	For each practitioner, list their ID, first name, last name, tNhe total number of days and the total number of hours they are scheduled to work in a standard week at the Medical Practice. Assume a workday is nine hours long.
5.	List the Patient's first name, last name and the appointment date and time, for all appointments held on the 18/09/2019 by Dr Anne Funsworth.
6.	List the ID and date of birth of any patient who has not had an appointment and was born before 1950.
7.	List the patient ID, first name, last name and the number of appointments for patients who have had at least three appointments. List the patients in 'number of appointments' order from most to least.
8.	List the first name, last name, gender, and the number of days since the last appointment of each patient and the 23/09/2019.
9.	List the full name and full address of each practitioner in the following format exactly.
Dr Mark P. Huston. 21 Fuller Street SUNSHINE, NSW 2343
Make sure you include the punctuation and the suburb in upper case.
Sort the list by last name, then first name, then middle initial.
10.	List the patient id, first name, last name and date of birth of the fifth oldest patient(s). 
11.	List the patient ID, first name, last name, appointment date (in the format 'Tuesday 17 September, 2019') and appointment time (in the format '14:15 PM') for all patients who have had appointments on any Tuesday after 10:00 AM.
12.	Create an address list for a special newsletter to all patients and practitioners. The mailing list should contain all relevant address fields for each household. Note that each household should only receive one newsletter.
*/

-- 1.	List the first name and last name of female patients who live in St Kilda or Lidcombe.
SELECT pt.Firstname, pt.LastName FROM Patient pt
WHERE pt.Gender = 'female' AND pt.Suburb IN ('St Kilda', 'Lidcombe')

-- 2.	List the first name, last name, state and Medicare Number of any patients who do not live in NSW.
 SELECT pt.Firstname, pt.LastName, pt.State, pt.MedicareNumber FROM Patient pt
 WHERE pt.State NOT IN ('NSW');

-- 3.	List each patient's first name, last name, Medicare Number and their date of birth. Sort the list by date of birth, listing the youngest patients first.

SELECT pt.Firstname, pt.LastName, pt.MedicareNumber, pt.DateOfBirth FROM Patient pt
ORDER BY pt.DateOfBirth DESC;

--4.	For each practitioner, list their ID, first name, last name, the total number of days and the total number of hours they are scheduled to work in a standard week at the Medical Practice. Assume a workday is nine hours long.
SELECT prac.Practitioner_ID, prac.Firstname, prac.LastName, COUNT(prac.Practitioner_ID) AS 'DaysWorked', Count(prac.Practitioner_ID)*9 AS 'HrsWorked' FROM Practitioner prac
JOIN Availability avail ON prac.Practitioner_ID = avail.Practitioner_Ref
GROUP BY prac.Practitioner_ID, prac.Firstname, prac.LastName;

--5. 5.	List the Patient's first name, last name and the appointment date and time, for all appointments held on the 18/09/2019 by Dr Anne Funsworth.
SELECT pt.Firstname, pt.LastName, app.ApptDate, app.ApptStartTime FROM Appointment app
JOIN Patient pt ON app.Patient_Ref = pt.Patient_ID
JOIN Practitioner prac ON app.Practitioner_Ref = prac.Practitioner_ID
WHERE
	prac.Firstname = 'Anne' AND app.ApptDate = '2019-09-18'

-- 6.	List the ID and date of birth of any patient who has not had an appointment and was born before 1950.
SELECT * FROM Patient pt
LEFT JOIN Appointment app ON pt.Patient_ID = app.Patient_Ref
WHERE app.ApptDate IS NULL AND pt.DateOfBirth < '1950';

-- 7.	List the patient ID, first name, last name and the number of appointments for patients who have had at least three appointments. List the patients in 'number of appointments' order from most to least.
SELECT pt.Patient_ID, pt.Firstname, pt.LastName, COUNT(app.ApptDate) AS 'NumOfAppoint'
FROM Patient pt
JOIN Appointment app ON pt.Patient_ID = app.Patient_Ref
	GROUP BY pt.Patient_ID, pt.Firstname, pt.LastName
	HAVING COUNT(app.ApptDate) > 2
	ORDER BY COUNT(app.ApptDate) DESC;

-- 8.	List the first name, last name, gender, and the number of days since the last appointment of each patient and the 23/09/2019.
SELECT DISTINCT pt.Firstname, pt.LastName, pt.Gender, DATEDIFF(DAY, app.ApptDate, '2019-09-23') AS 'DaySinceAppoint'
FROM Patient pt
	JOIN Appointment app ON pt.Patient_ID = app.Patient_Ref

/* 9.	List the full name and full address of each practitioner in the following format exactly.
Dr Mark P. Huston. 21 Fuller Street SUNSHINE, NSW 2343
Make sure you include the punctuation and the suburb in upper case.
Sort the list by last name, then first name, then middle initial. 
*/
SELECT CONCAT(
	'Dr',' ',
	prac.Firstname,' ',
	prac.MiddleInitial,'.',
	prac.LastName,'. ',
	prac.HouseUnitLotNum,' ',
	prac.Street, ' ',
	prac.Suburb, ', ',
	prac.State, ' ',
	prac.PostCode
) AS 'Description'
FROM Practitioner prac
ORDER BY LastName, Firstname, MiddleInitial;

--10.	List the patient id, first name, last name and date of birth of the fifth oldest patient(s). 
SELECT pt.Patient_ID, pt.Firstname, pt.LastName, pt.DateOfBirth 
FROM Patient pt
ORDER BY pt.DateOfBirth
OFFSET 4 ROWS FETCH NEXT 1 ROW ONLY;

-- 11.	List the patient ID, first name, last name, appointment date (in the format 'Tuesday 17 September, 2019') and appointment time (in the format '14:15 PM') for all patients who have had appointments on any Tuesday after 10:00 AM.
SELECT pt.Patient_ID, pt.Firstname, pt.LastName, FORMAT(app.ApptDate, 'dddd dd MMMM, yyyy') AS 'Appointment', FORMAT(CAST(app.ApptStartTime AS DATETIME), 'hh:mm tt') AS 'Time'
FROM Patient pt
JOIN Appointment app ON pt.Patient_ID = app.Patient_Ref
	WHERE app.ApptStartTime > '10:00' 
	AND 
	FORMAT(app.ApptDate, 'dddd') LIKE '%Tuesday%';
	

-- 12.	Create an address list for a special newsletter to all patients and practitioners. The mailing list should contain all relevant address fields for each household. Note that each household should only receive one newsletter.

DECLARE @AddressTable TABLE (
firstname NVARCHAR(50),
lastname NVARCHAR(50),
HouseUnitLotNum NVARCHAR(5), 
street nvarchar(50),
suburb nvarchar(50),
state nvarchar(3),
postcode nchar(4)
)

--For Patients
INSERT INTO @AddressTable
SELECT pt.Firstname,pt.LastName, pt.HouseUnitLotNum, pt.Street, pt.Suburb, pt.State, pt.PostCode FROM Patient pt

--For Practitioners
INSERT INTO @AddressTable
SELECT prac.Firstname,prac.LastName, prac.HouseUnitLotNum, prac.Street, prac.Suburb, prac.State, prac.PostCode FROM Practitioner prac

SELECT DISTINCT * FROM @AddressTable
ORDER BY street