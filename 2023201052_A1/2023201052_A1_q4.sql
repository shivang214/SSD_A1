


CREATE TABLE UpdatedEmpSkills (
    emp_no INT,
    curr_salary DECIMAL(10, 2),
    increment DECIMAL(4, 2),
    new_salary DECIMAL(10, 2),
    skill_level VARCHAR(20)
);



DELIMITER //

   CREATE PROCEDURE GenerateUpdatedEmpSkills()
  BEGIN
      DECLARE done INT DEFAULT FALSE;
      DECLARE emp_no INT;
      
    DECLARE emp_name VARCHAR(255);
    
    DECLARE emp_joining_date DATE;
    DECLARE emp_salary DECIMAL(10, 2);
    DECLARE courses_completed INT;
    DECLARE certs_completed INT;
    DECLARE skill_level VARCHAR(20);
    DECLARE curr_increment INT;
    DECLARE new_salary DECIMAL(10, 2);



    DECLARE emp_cursor CURSOR FOR
        
        SELECT emp_no, emp_name, emp_joining_date, emp_salary
        FROM Employee;

   
   
   
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;


    OPEN emp_cursor;

   
   
   
    emp_loop: LOOP
        FETCH emp_cursor INTO emp_no, emp_name, emp_joining_date, emp_salary;

        IF done THEN
            LEAVE emp_loop;
        END IF;




        SELECT 
            COUNT(DISTINCT cc.course_id) INTO courses_completed
        FROM CourseCompletions cc
        WHERE cc.emp_no = emp_no;

        SELECT 
            COUNT(DISTINCT certc.cert_id) INTO certs_completed
        FROM CertificateCompletions certc
        WHERE certc.emp_no = emp_no;




        IF courses_completed >= 10 AND certs_completed >= 8 THEN
            SET skill_level = 'Expert';
            SET curr_increment = 25;
        ELSEIF courses_completed >= 6 AND certs_completed >= 6 THEN
            SET skill_level = 'Advanced';
            SET curr_increment = 20;
        ELSEIF courses_completed >= 4 AND certs_completed >= 4 THEN
            SET skill_level = 'Intermediate';
            SET curr_increment = 15;
        ELSEIF courses_completed >= 2 AND certs_completed >= 2 THEN
            SET skill_level = 'Beginner';
            SET curr_increment = 10;
        ELSE
            SET skill_level = NULL;
            SET curr_increment = 0;
        END IF;



        IF emp_joining_date > '2022-07-31' THEN
            SET curr_increment = 0;
        END IF;

       
        SET new_salary = emp_salary + (emp_salary * curr_increment / 100);



        INSERT INTO UpdatedEmpSkills (emp_no, curr_salary, increment, new_salary, skill_level)
        VALUES (emp_no, emp_salary, curr_increment, new_salary, skill_level);
    END LOOP;

   
    CLOSE emp_cursor;
END;
//

DELIMITER ;


CALL GenerateUpdatedEmpSkills();
