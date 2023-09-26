-- MERGE: 테이블 병합

/*
UPDATE와 INSERT를 한 방에 처리.
한 테이블에 해당하는 데이터가 있다면 UPDATE를, 없으면 INSERT로 처리해라
*/

CREATE TABLE emps_it AS (SELECT * FROM employees WHERE 1=2);

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES
    (105, '일론','머스크','ELONMUSK',sysdate,'IT_PROG');
    
SELECT * FROM emps_it;

SELECT * FROM employees
WHERE job_id = 'IT_PROG';