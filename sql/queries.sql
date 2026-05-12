CREATE TABLE healthcare_data (
name TEXT,
age INT,
gender TEXT,
blood_type TEXT,
medical_condition TEXT,
date_of_admission DATE,
doctor TEXT,
hospital TEXT,
insurance_provider TEXT,
billing_amount NUMERIC,
room_number INT,
admission_type TEXT,
discharge_date DATE,
medication TEXT,
test_results TEXT
);


CREATE TABLE patients (
patient_id SERIAL PRIMARY KEY,
name TEXT,
age INT,
gender TEXT,
blood_type TEXT
);


CREATE TABLE admissions (
admission_id SERIAL PRIMARY KEY,
patient_id INT,
medical_condition TEXT,
date_of_admission DATE,
discharge_date DATE,
admission_type TEXT,
room_number INT,
hospital TEXT,
doctor TEXT,
FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);


COPY healthcare_data
FROM '/Users/manyangtaal/Downloads/healthcare_project/data/healthcare_data.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE billing (
billing_id SERIAL PRIMARY KEY,
admission_id INT,
insurance_provider TEXT,
billing_amount NUMERIC,
FOREIGN KEY (admission_id) REFERENCES admissions(admission_id)
);

CREATE TABLE treatment (
treatment_id SERIAL PRIMARY KEY,
admission_id INT,
medication TEXT,
test_results TEXT,
FOREIGN KEY (admission_id) REFERENCES admissions(admission_id)
);



INSERT INTO patients (name, age, gender, blood_type)
SELECT DISTINCT name, age, gender, blood_type
FROM healthcare_data;




INSERT INTO admissions (
patient_id,
medical_condition,
date_of_admission,
discharge_date,
admission_type,
room_number,
hospital,
doctor
)
SELECT
p.patient_id,
h.medical_condition,
h.date_of_admission,
h.discharge_date,
h.admission_type,
h.room_number,
h.hospital,
h.doctor
FROM healthcare_data h
JOIN patients p
ON h.name = p.name;



INSERT INTO billing (
admission_id,
insurance_provider,
billing_amount
)
SELECT
a.admission_id,
h.insurance_provider,
h.billing_amount
FROM healthcare_data h
JOIN patients p
ON h.name = p.name
JOIN admissions a
ON a.patient_id = p.patient_id
AND a.date_of_admission = h.date_of_admission;





INSERT INTO treatment (
admission_id,
medication,
test_results
)
SELECT
a.admission_id,
h.medication,
h.test_results
FROM healthcare_data h
JOIN patients p
ON h.name = p.name
JOIN admissions a
ON a.patient_id = p.patient_id
AND a.date_of_admission = h.date_of_admission;







SELECT *
FROM healthcare_analysis
LIMIT 10;



SELECT * FROM patients
LIMIT 10

SELECT * FROM admissions
LIMIT 10


SELECT * FROM billing
LIMIT 10


SELECT * FROM treatment
LIMIT 10


/*
Core Questions
1- Which medical conditions have the highest average treatment cost?
2- Which admission types (Emergency, Urgent, Elective) are associated with higher costs and longer hospital stays?
3- Which insurance providers cover the highest-cost patients?
4- Which patient groups (age or gender) are most associated with abnormal test results?
5- Which hospitals have the highest patient volume and total billing amounts?
6- How do admissions and billing amounts change over time?
*/


/* 1- Which medical conditions have the highest average treatment cost? */

SELECT a.medical_condition,
       AVG(b.billing_amount) AS avg_bill
FROM admissions a
JOIN billing b
ON a.admission_id = b.admission_id
GROUP BY a.medical_condition
ORDER BY avg_bill DESC



/* 2- Which admission types (Emergency, Urgent, Elective) are associated with higher costs and longer hospital stays? */


SELECT admission_type,
       AVG(discharge_date - date_of_admission) AS hospital_stays,
       AVG(billing_amount) AS bills
FROM admissions a
JOIN billing b
ON  a.admission_id = b.admission_id
GROUP BY 1
ORDER BY 2 DESC


/*3- Which insurance providers cover the highest-cost patients? */

SELECT COUNT(*),
       insurance_provider,
       AVG(billing_amount) AS avg_bill_amount
FROM billing
GROUP BY 2
ORDER BY 3 DESC


/* 4- Which patient groups (age or gender) are most associated with abnormal test results? */

/* GENDER */
SELECT COUNT(*),
       gender,
       test_results
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id
JOIN treatment t 
ON a.admission_id = t.admission_id
GROUP BY 2, 3
ORDER BY 2, 3

/* AGE */
SELECT  CASE WHEN age BETWEEN 13 and 17 THEN 'teenagers'
            WHEN age BETWEEN 18 and 30 THEN 'young_adults'
            WHEN age BETWEEN 31 and 45 THEN 'grown_adults'
            WHEN age BETWEEN 46 and 60 THEN 'older_adults'
        ELSE 'senior_citizens'
        END AS age_group,
        COUNT(*) AS total_cases,
        test_results
    FROM patients p
    JOIN admissions a
    ON p.patient_id = a.patient_id
    JOIN treatment t 
    ON a.admission_id = t.admission_id             
    GROUP BY 1, 3
    ORDER BY 1, 3



/*5- Which medical conditions have the highest patient volume and total billing amounts? */


SELECT COUNT(*) AS patient_volume,
       medical_condition,
       SUM(billing_amount) AS total_billing_amount,
       AVG(billing_amount) AS avg_billing_amount
    FROM admissions a
    JOIN billing b 
    ON a.admission_id = b.admission_id
    GROUP BY 2
    ORDER BY 3 DESC





/*6- How do admissions and billing amounts change over time? */


SELECT COUNT(DISTINCT(a.admission_id)) AS total_admission,
       date_trunc('month', date_of_admission) AS month,
       SUM(billing_amount) AS total_bills
FROM admissions a
JOIN billing b 
ON a.admission_id = b.admission_id
GROUP BY month
ORDER BY month ASC



CREATE VIEW healthcare_analysis AS
SELECT
p.patient_id,
p.name,
p.age,
p.gender,
p.blood_type,
a.admission_id,
a.medical_condition,
a.date_of_admission,
a.discharge_date,
a.admission_type,
a.room_number,
a.hospital,
a.doctor,
b.insurance_provider,
b.billing_amount,
t.medication,
t.test_results
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id
JOIN billing b
ON a.admission_id = b.admission_id
JOIN treatment t
ON a.admission_id = t.admission_id;




COPY (
    SELECT * 
    FROM healthcare_analysis
)
TO '/Users/manyangtaal/Downloads/healthcare_project/data/healthcare_analysis.csv'
DELIMITER ','
CSV HEADER;

