# Hospital Management SQL Project

## Project Title
Hospital Management System – SQL Data Analysis Project

## Introduction
Healthcare organizations generate large volumes of data related to patients, doctors, treatments, hospital stays, and costs. Proper analysis of this data helps hospitals improve patient care, reduce operational costs, and optimize resource utilization.
This project focuses on analyzing a Hospital Management dataset using SQL (basic to intermediate level). The goal is to answer real-world healthcare questions such as patient demographics, hospital stay patterns, treatment costs, and readmission trends.

### Data Source
##### Kaggle – Healthcare / Hospital Management Datasets
##### Example:
###### Hospital Management Dataset
###### Healthcare Analytics Dataset
###### Dataset used for educational and portfolio purposes only.

## Business Questions & SQL Analysis

#### 1. How many patients were treated in total?

##### SELECT COUNT(DISTINCT patient_id) AS total_patients
##### FROM hospital_records;

#### Insight:
##### Shows the total number of unique patients treated by the hospital.

#### 2. What is the gender distribution of patients?

##### SELECT gender, COUNT(*) AS patient_count
##### FROM hospital_records
##### GROUP BY gender;

### Insight:
##### Helps understand patient demographics and gender-based healthcare demand.

### 3. What are the top 5 most common medical conditions?

##### SELECT condition, COUNT(*) AS cases
##### FROM hospital_records
##### GROUP BY condition
##### ORDER BY cases DESC
##### LIMIT 5;

### Insight:
##### Identifies the most frequent illnesses treated by the hospital.

### 4. What is the average length of stay per condition?

##### SELECT condition, AVG(length_of_stay) AS avg_stay_days
##### FROM hospital_records
##### GROUP BY condition
##### ORDER BY avg_stay_days DESC;

### Insight:
##### Conditions with longer stays may require more resources and specialized care.

### 5. What is the average treatment cost by procedure?

##### SELECT procedure, AVG(cost) AS avg_cost
##### FROM hospital_records
##### GROUP BY procedure
##### ORDER BY avg_cost DESC;

### Insight:
##### Highlights high-cost procedures that impact hospital finances.

### 6. How many patients were readmitted?

##### SELECT readmission, COUNT(*) AS patient_count
##### FROM hospital_records
##### GROUP BY readmission;

### Insight:
##### Readmissions often indicate treatment effectiveness and quality of care.

### 7. Which conditions have the highest readmission rate?

##### SELECT condition, COUNT(*) AS readmitted_cases
##### FROM hospital_records
##### WHERE readmission = 'Yes'
##### GROUP BY condition
##### ORDER BY readmitted_cases DESC;

### Insight:
##### Helps identify conditions that may need better post-discharge care.

### 8. What is the overall average patient satisfaction score?

##### SELECT AVG(satisfaction) AS avg_satisfaction_score
##### FROM hospital_records;

### Insight:
##### Measures overall patient experience and service quality.

### 9. Which outcomes occur most frequently?

##### SELECT outcome, COUNT(*) AS outcome_count
##### FROM hospital_records
##### GROUP BY outcome
##### ORDER BY outcome_count DESC;

### Insight:
##### Provides an overview of treatment success rates.

### 10. Monthly patient admissions trend.

##### SELECT MONTH(admission_date) AS month, COUNT(*) AS admissions
##### FROM hospital_records
##### GROUP BY MONTH(admission_date)
##### ORDER BY month;

### Insight:
##### Identifies seasonal trends in hospital admissions.

## Key Findings Summary

- The hospital treats a diverse patient population across multiple conditions.
- Certain medical conditions account for the majority of admissions.
- Longer hospital stays are associated with specific illnesses.
- A small number of procedures contribute significantly to total costs.
- Readmissions are concentrated in a few conditions, indicating potential quality improvement areas.
- Patient satisfaction scores suggest generally positive experiences but leave room for improvement.

## Recommendations

- Improve post-discharge care for conditions with high readmission rates.
- Optimize resource allocation for conditions requiring longer hospital stays.
- Review high-cost procedures to explore cost-reduction strategies.
- Enhance patient experience programs to further increase satisfaction scores.
- Plan staffing and resources based on monthly admission trends.

## Conclusion

- This SQL project demonstrates how basic SQL queries can be effectively used to analyze hospital management data. The insights derived can help hospital administrators improve patient care, reduce costs, and make data-driven operational decisions.




