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

`sql
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
