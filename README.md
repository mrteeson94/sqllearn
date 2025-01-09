# sqllearn
Learning sql database, this repo is made to track my progress and be used for refreshers.

SQL Practice questions library
Source: https://www.sql-practice.com/ 
sql 

**EASY**
* Show first name, last name, and gender of patients whose gender is 'M'
* Show first name and last name of patients who does not have allergies. (null)
* Show first name of patients that start with the letter 'C'
* Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
* Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
* Show first name and last name concatinated into one column to show their full name. solution - can use this *SELECT firstname || ' ' || lastname as fullname*
* Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON'
* Show how many patients have a birth_date with 2010 as the birth year.
* Show the first_name, last_name, and height of the patient with the greatest height.
* Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
* Show the total number of admissions
* Show all the columns from admissions where the patient was admitted and discharged on the same day.
* Show the patient id and the total number of admissions for patient_id 579.
* Based on the cities that our patients live in, show unique cities that are in province_id 'NS'.
* Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

**MEDIUM**
* Show unique birth years from patients and order them by ascending.
* Show unique first names from the patients table which only occurs once in the list.

For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
* Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
* Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table.
* Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
* Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.
* Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
* Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
* Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.
* Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"
* Show all allergies ordered by popularity. Remove NULL values from query.
* Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
* We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane

**HARD**
* 
* 
* 
* 
* 