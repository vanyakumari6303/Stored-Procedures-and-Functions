use collegeDB;

-- 1. Stored Procedure: Get student details by ID
DELIMITER $$
CREATE PROCEDURE GetStudentDetails(IN sid INT)
BEGIN
    SELECT student_id, first_name, dob
    FROM Students
    WHERE student_id = sid;
END $$
DELIMITER ;

-- Call the procedure
CALL GetStudentDetails(1);

-----------------------------------------------------

-- 2. Stored Procedure: Add a new course
DELIMITER $$
CREATE PROCEDURE AddCourse(IN cname VARCHAR(100), IN credits INT, IN instructor INT)
BEGIN
    INSERT INTO Courses(course_name, credits, instructor_id)
    VALUES(cname, credits, instructor);
END $$
DELIMITER ;

-- Call the procedure
CALL AddCourse('Operating Systems', 4, 2);

-----------------------------------------------------

-- 3. User-Defined Function: Calculate student age
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

-- Use the function
SELECT first_name, GetAge(dob) AS age
FROM Students;

-----------------------------------------------------

-- 4. User-Defined Function: Total courses by instructor
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

-- Use the function
SELECT first_name, TotalCoursesByInstructor(instructor_id) AS courses_handled
FROM Instructors;
