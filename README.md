# Stored-Procedures-and-Functions
in this task, I learned how to modularize SQL logic using stored procedures and user-defined functions (UDFs). These allow reusability, abstraction, and cleaner database operations.  Stored Procedures → perform actions like inserting, updating, or retrieving data.  Functions → return a single computed value and can be used inside queries.

Key topics focused:
Use CREATE PROCEDURE for reusable database actions.
Use CREATE FUNCTION for computations that return values.
Pass parameters into procedures/functions for flexibility
Apply conditional logic (IF, CASE) inside stored programs.
Functions must be created inside the correct database schema (e.g., CollegeDB).

-- Stored Procedure: Get student details by ID
DELIMITER $$
CREATE PROCEDURE GetStudentDetails(IN sid INT)
BEGIN
    SELECT student_id, first_name, dob
    FROM Students
    WHERE student_id = sid;
END $$
DELIMITER ;

CALL GetStudentDetails(1);

-----------------------------------------------------

-- Stored Procedure: Add a new course
DELIMITER $$
CREATE PROCEDURE AddCourse(IN cname VARCHAR(100), IN credits INT, IN instructor INT)
BEGIN
    INSERT INTO Courses(course_name, credits, instructor_id)
    VALUES(cname, credits, instructor);
END $$
DELIMITER ;

CALL AddCourse('Operating Systems', 4, 2);

-----------------------------------------------------

-- User-Defined Function: Calculate student age
DELIMITER $$
CREATE FUNCTION GetAge(dob DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, dob, CURDATE());
    RETURN age;
END $$
DELIMITER ;

SELECT first_name, GetAge(dob) AS age
FROM Students;

-----------------------------------------------------

-- User-Defined Function: Total courses by instructor
DELIMITER $$
CREATE FUNCTION TotalCoursesByInstructor(iid INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Courses
    WHERE instructor_id = iid;
    RETURN total;
END $$
DELIMITER ;

SELECT name, TotalCoursesByInstructor(instructor_id) AS courses_handled
FROM Instructors;

Outcome:
Learned how to create and call stored procedures
Created user-defined functions to compute values like student age and instructor workload
Understood how to use parameters and logic in stored programs
Improved ability to modularize SQL logic for maintainability and reusability
