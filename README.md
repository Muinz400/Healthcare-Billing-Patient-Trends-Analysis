# Healthcare Billing & Patient Trends Analysis

## Project Overview

This project analyzes healthcare patient records to uncover trends related to patient billing, admission types, insurance providers, medical conditions, and hospital stay duration.

The project follows a complete end-to-end analytics workflow using:

- SQL for database design and querying
- Python (Pandas) for data cleaning and feature engineering
- Tableau Public for dashboard visualization

---

# Tools Used

- PostgreSQL
- SQL
- Python
- Pandas
- Tableau Public
- Git & GitHub

---

# Dataset Features

The dataset includes:

- Patient demographics
- Medical conditions
- Admission information
- Insurance providers
- Billing amounts
- Medications
- Test results
- Hospitals and doctors

---

# SQL Workflow

The raw healthcare dataset was normalized into relational tables:

- patients
- admissions
- billing
- treatment

Key SQL tasks included:

- Creating relational database tables
- Importing CSV data into PostgreSQL
- Building JOIN relationships
- Writing analytical queries
- Creating a healthcare analytics SQL view

### Business Questions Explored

- Which medical conditions have the highest treatment costs?
- Which admission types lead to higher billing?
- Which insurance providers cover the highest-cost patients?
- Which patient groups are associated with abnormal test results?
- How do billing trends change over time?

---

# Python Data Cleaning & Analysis

Using Pandas, the dataset was cleaned and validated through:

- Duplicate checks and removal
- Datetime conversion
- Billing validation
- Length-of-stay calculations
- Feature engineering
- Grouped exploratory analysis

### Features Created

- `length_of_stay_days`
- `negative_bill`
- `age_group`

### Key Python Analysis

- Average billing by age group
- Billing by admission type
- Length of stay by medical condition
- Insurance provider patient volume
- Billing comparisons by gender

---

# Tableau Dashboard

An interactive Tableau dashboard was created to visualize:

- Total patients
- Average billing
- Average length of stay
- Billing by age group
- Billing by admission type
- Insurance provider trends
- Medical condition analysis

### Dashboard Features

- KPI cards
- Interactive filters
- Bar charts
- Healthcare trend analysis

---

# Key Insights

- Patients aged 0–18 had the highest average billing.
- Elective admissions produced the highest average billing amounts.
- Asthma patients showed the longest average hospital stays.
- Billing amounts showed weak correlation with hospital stay duration.
- Insurance provider patient volumes were relatively balanced.

---

# Skills Demonstrated

## SQL
- Database normalization
- JOIN operations
- Aggregations
- Views
- ETL workflows

## Python
- Data cleaning
- Feature engineering
- Exploratory data analysis
- Data validation

## Tableau
- Dashboard design
- KPI reporting
- Interactive filtering
- Data storytelling

---

# Conclusion

This project demonstrates an end-to-end healthcare analytics workflow from SQL database design to Python data cleaning and Tableau dashboard development.

The project strengthened practical skills in data modeling, exploratory analysis, feature engineering, and business-focused visualization.
