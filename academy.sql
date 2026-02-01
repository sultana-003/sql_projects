use students;
create database academy;
use academy;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    gender VARCHAR(10),
    grade_level INT
);
INSERT INTO students VALUES
(1, 'Ayesha', 'Female', 10),
(2, 'Rahim', 'Male', 10),
(3, 'Karim', 'Male', 9),
(4, 'Nusrat', 'Female', 9),
(5, 'Sadia', 'Female', 10);
select * from students;

CREATE TABLE scores (
    score_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(20),
    score INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
INSERT INTO scores VALUES
(1, 1, 'Math', 85),
(2, 1, 'English', 78),
(3, 2, 'Math', 65),
(4, 2, 'English', 70),
(5, 3, 'Math', 55),
(6, 3, 'English', 60),
(7, 4, 'Math', 90),
(8, 4, 'English', 88),
(9, 5, 'Math', 72),
(10, 5, 'English', 75);
select * from scores;

CREATE TABLE attendance (
    student_id INT,
    attendance_percentage DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
INSERT INTO attendance VALUES
(1, 95.5),
(2, 88.0),
(3, 70.5),
(4, 98.0),
(5, 90.0);
select * from attendance;



-- SQL Analysis Queries

-- 1️. Average Score per Student
SELECT 
    s.student_name,
    ROUND(AVG(sc.score), 2) AS avg_score
FROM students s
JOIN scores sc ON s.student_id = sc.student_id
GROUP BY s.student_name;

-- 2. Subject-wise Average Score
SELECT 
    subject,
    ROUND(AVG(score), 2) AS avg_score
FROM scores
GROUP BY subject;

-- 3. Top Performing Students (Avg Score ≥ 80)
SELECT 
    s.student_name,
    ROUND(AVG(sc.score), 2) AS avg_score
FROM students s
JOIN scores sc ON s.student_id = sc.student_id
GROUP BY s.student_name
HAVING AVG(sc.score) >= 80;

-- 4. Students with Low Attendance (< 80%)
SELECT 
    s.student_name,
    a.attendance_percentage
FROM students s
JOIN attendance a ON s.student_id = a.student_id
WHERE a.attendance_percentage < 80;

-- 5. Performance Category Using CASE
SELECT 
    s.student_name,
    ROUND(AVG(sc.score),2) AS avg_score,
    CASE 
        WHEN AVG(sc.score) >= 80 THEN 'Excellent'
        WHEN AVG(sc.score) >= 60 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_level
FROM students s
JOIN scores sc ON s.student_id = sc.student_id
GROUP BY s.student_name;

-- 6. Attendance vs Performance
SELECT 
    s.student_name,
    a.attendance_percentage,
    ROUND(AVG(sc.score),2) AS avg_score
FROM students s
JOIN attendance a ON s.student_id = a.student_id
JOIN scores sc ON s.student_id = sc.student_id
GROUP BY s.student_name, a.attendance_percentage
ORDER BY avg_score DESC;

