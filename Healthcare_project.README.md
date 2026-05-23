# Healthcare SQL Analytics Project

## Project Title
### Hospital Financial & Patient Operations Analytics Using SQL

# 1. Business Problem

#### A mid-sized healthcare organization noticed several operational and financial issues:

- Patient wait times were increasing
- Insurance claim denials were rising
- Some departments were becoming overcrowded
- Revenue collection was inconsistent
- Management lacked centralized reporting for decision-making

#### The leadership team wanted a data analytics solution that could:

- Track hospital performance
- Identify operational bottlenecks
- Improve patient experience
- Reduce claim rejection rates
- Increase financial efficiency

### The analytics team was asked to use SQL to analyze healthcare operational and billing data and create business insights for executives.

# 2. Project Objectives

#### The project aimed to answer these business questions:

- Which departments generate the highest revenue?
- Which insurance providers reject the most claims?
- Which doctors see the highest number of patients?
- What are the average patient wait times?
- Which departments have the longest stays?
- How much unpaid billing exists?
- Which months have the highest patient volume?

# 3. Dataset Design

#### Main Tables

A. Patients Table
B. Doctors Table
C. Visits Table
D. Billing Table

# 4. Database Schema (SQL)

```sql
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(50)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    department VARCHAR(50),
    experience_years INT
);

CREATE TABLE Visits (
    visit_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    visit_date DATE,
    diagnosis VARCHAR(100),
    wait_time_minutes INT,
    stay_days INT,
    
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Billing (
    bill_id INT PRIMARY KEY,
    visit_id INT,
    total_amount DECIMAL(10,2),
    insurance_provider VARCHAR(50),
    claim_status VARCHAR(20),
    paid_amount DECIMAL(10,2),

    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id)
);
```

# 5. Sample Dataset Inserts

Patients

```sql
INSERT INTO Patients VALUES
(1,'John Smith','Male',45,'Chicago'),
(2,'Sarah Lee','Female',30,'Houston'),
(3,'David Brown','Male',60,'Dallas'),
(4,'Emily Clark','Female',50,'Phoenix'),
(5,'Michael Scott','Male',39,'Seattle');
```

Doctors

```sql
INSERT INTO Doctors VALUES
(101,'Dr. Adams','Cardiology',15),
(102,'Dr. Wilson','Neurology',12),
(103,'Dr. Taylor','Orthopedics',10),
(104,'Dr. Evans','Emergency',8);
```

Visits

```sql
INSERT INTO Visits VALUES
(1001,1,101,'2026-01-10','Heart Disease',35,4),
(1002,2,102,'2026-01-11','Migraine',20,1),
(1003,3,101,'2026-01-12','Blood Pressure',50,3),
(1004,4,104,'2026-01-13','Accident Injury',60,5),
(1005,5,103,'2026-01-14','Fracture',25,2);
```

Billing

```sql
INSERT INTO Billing VALUES
(5001,1001,12000,'Aetna','Approved',11000),
(5002,1002,3000,'Cigna','Rejected',0),
(5003,1003,8000,'Aetna','Approved',8000),
(5004,1004,15000,'BlueCross','Pending',5000),
(5005,1005,6000,'UnitedHealth','Approved',6000);
```

# 6. Business Analysis Using SQL

## Analysis 1: Total Revenue by Department
### Business Goal

#### Identify which department generates the highest revenue.

```sql
SELECT 
    d.department,
    SUM(b.total_amount) AS total_revenue
FROM Billing b
JOIN Visits v
    ON b.visit_id = v.visit_id
JOIN Doctors d
    ON v.doctor_id = d.doctor_id
GROUP BY d.department
ORDER BY total_revenue DESC;
```

#### Insight
###### Department	###### Revenue
Emergency	Highest
Cardiology	Second highest

#### Business Decision
- Increase staffing in high-revenue departments
- Invest more equipment in profitable units
- Expand emergency services capacity


## Analysis 2: Insurance Claim Rejection Rate
### Business Goal

#### Find insurance companies with high rejection rates.

```sql
SELECT
    insurance_provider,
    COUNT(*) AS total_claims,
    SUM(CASE 
            WHEN claim_status = 'Rejected' 
            THEN 1 
            ELSE 0 
        END) AS rejected_claims,
        
    ROUND(
        100.0 * SUM(CASE 
                        WHEN claim_status = 'Rejected' 
                        THEN 1 
                        ELSE 0 
                    END) / COUNT(*),
        2
    ) AS rejection_rate
FROM Billing
GROUP BY insurance_provider
ORDER BY rejection_rate DESC;
```


#### Insight
- Cigna had the highest rejection rate.
#### Business Decision
- Improve documentation quality
- Train billing team
- Negotiate better claim processing agreements


## Analysis 3: Average Patient Wait Time
### Business Goal

#### Reduce patient dissatisfaction caused by delays.

```sql
SELECT
    d.department,
    AVG(v.wait_time_minutes) AS avg_wait_time
FROM Visits v
JOIN Doctors d
    ON v.doctor_id = d.doctor_id
GROUP BY d.department
ORDER BY avg_wait_time DESC;
```


#### Insight
- Emergency department had the longest wait time.
#### Business Decision
- Add more nurses during peak hours
- Improve appointment scheduling
- Optimize triage process
  

## Analysis 4: Top Performing Doctors
### Business Goal

#### Measure doctor workload and patient volume.

```sql
SELECT
    d.doctor_name,
    d.department,
    COUNT(v.visit_id) AS total_patients
FROM Doctors d
LEFT JOIN Visits v
    ON d.doctor_id = v.doctor_id
GROUP BY d.doctor_name, d.department
ORDER BY total_patients DESC;
```


#### Insight
- Cardiology doctors handled the highest patient count.
#### Business Decision
- Prevent doctor burnout
- Balance patient assignments
- Hire additional specialists


## Analysis 5: Unpaid Billing Analysis
### Business Goal

#### Identify outstanding payments affecting cash flow.

```sql
SELECT
    bill_id,
    total_amount,
    paid_amount,
    (total_amount - paid_amount) AS unpaid_balance
FROM Billing
WHERE total_amount > paid_amount
ORDER BY unpaid_balance DESC;
```

#### Insight
- Several high-value bills remained partially unpaid.
#### Business Decision
- Improve collection processes
- Follow up pending insurance claims
- Create payment reminder automation


## Analysis 6: Monthly Patient Volume Trend
### Business Goal

#### Understand seasonal patient demand.

```sql
SELECT
    MONTH(visit_date) AS month_number,
    COUNT(*) AS total_visits
FROM Visits
GROUP BY MONTH(visit_date)
ORDER BY month_number;
```

#### Insight
- January showed increased patient volume.
#### Business Decision
- Increase seasonal staffing
- Prepare emergency inventory
- Adjust scheduling capacity


## 7. Advanced SQL Concepts Used
###### SQL_Concept	              Purpose
JOINs	                       Combine tables
GROUP BY	                Aggregate reporting
CASE WHEN	               Conditional calculations
Aggregate Functions	       SUM, AVG, COUNT
ORDER BY	               Ranking insights
Foreign Keys	            Maintain data integrity
Aliases	                  Improve readability



## 8. Challenges Faced During Project
#### Challenge 1: Duplicate Billing Records
##### Problem
- Some visits had duplicate billing entries.


#### Solution

```sql
SELECT
    visit_id,
    COUNT(*) AS duplicate_count
FROM Billing
GROUP BY visit_id
HAVING COUNT(*) > 1;
```

#### The duplicates were cleaned before analysis.


#### Challenge 2: Missing Payment Values
#### Problem
- Some bills had NULL paid amounts.

#### Solution

```sql
SELECT
    bill_id,
    COALESCE(paid_amount,0) AS paid_amount
FROM Billing;
```

#### This prevented incorrect revenue calculations.


#### Challenge 3: Inconsistent Insurance Names
#### Problem
- Insurance names appeared differently:

- Blue Cross
- BlueCross
- bluecross
  
#### Solution

```sql
SELECT
    UPPER(insurance_provider) AS insurance_provider,
    COUNT(*)
FROM Billing
GROUP BY UPPER(insurance_provider);
```

#### Standardized names improved reporting accuracy.


## 9. Final Business Impact
#### Operational Improvements
- Reduced patient wait times
- Improved department staffing
- Better doctor workload balancing

#### Financial Improvements
- Identified unpaid balances
- Reduced insurance rejection rates
- Improved revenue tracking

#### Strategic Improvements
- Data-driven staffing decisions
- Better resource allocation
- Improved executive reporting


## 10. Recommended Dashboard KPIs

#### This SQL project can later connect to tools like:

- Microsoft Power BI
- Tableau
- Microsoft Excel


## 11. Conclusion

#### This healthcare SQL analytics project demonstrates how SQL can help healthcare organizations improve both operational efficiency and financial performance.

By transforming raw hospital data into actionable insights, the business was able to:

- Improve patient care
- Optimize staffing
- Increase revenue visibility
- Reduce operational bottlenecks
- Support executive decision-making with data

This is a realistic end-to-end healthcare analytics project suitable for:

- Data Analyst portfolios
- SQL interview preparation
- Healthcare analytics case studies
- Dashboard development projects
- Business intelligence demonstrations


