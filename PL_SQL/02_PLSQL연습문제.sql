-- 1. 구구단 중 3단을 출력하는 익명 블록을 만들어 보자.
DECLARE
    v_result NUMBER;
BEGIN
    FOR i IN 1..9 LOOP
        v_result := 3 * i;
        dbms_output.put_line('3 x ' || i || ' = ' || v_result);
    END LOOP;
END;

-- 2. employees 테이블에서 201번 사원의 이름과 이메일 주소를 출력하는
-- 익명블록을 만들어 보자. (변수에 담아서 출력하세요.)
DECLARE -- 변수 선언
    v_emp_id employees.employee_id%TYPE;	
    v_emp_name employees.first_name%TYPE;
    v_emp_email employees.email%TYPE;
BEGIN
    SELECT
    employee_id,first_name, email
    INTO v_emp_id, v_emp_name, v_emp_email
    FROM employees 
    WHERE employee_id = 201;
    dbms_output.put_line('사원 번호: ' || v_emp_id);
    dbms_output.put_line('사원 이름: ' || v_emp_name);
    dbms_output.put_line('이메일 주소: ' || v_emp_email);
END;
-- 3. employees 테이블에서 사원번호가 제일 큰 사원을 찾아낸 뒤 (MAX 함수 사용)
-- 이 번호 + 1번으로 아래의 사원을 emps 테이블에
-- employee_id, last_name, email, hire_date, job_id를 신규 삽입하는 익명 블록을 만드세요.
-- SELECT절 이후에 INSERT문 사용이 가능합니다.
/*
<사원명>: steven
<이메일>: stevenjobs
<입사일자>: 오늘날짜
<JOB_ID>: CEO
*/

DECLARE 
   v_employee_id employees.employee_id%type := (SELECT MAX(employee_id) + 1 FROM employees);
   v_last_name employees.last_name%type := 'steven';
   v_email employees.email%type := 'stevenjobs';
   v_hire_date employees.hire_date%type := SYSDATE; 
   v_job_id employees.job_id%TYPE := 'CEO';

BEGIN
    SELECT MAX(employee_id) INTO v_employee_id FROM employees;

    INSERT INTO emps 
        (employee_id, last_name, email, hire_date, job_id) 
    VALUES 
        ( v_employee_id, v_last_name, v_email, v_hire_date, v_job_id );

    dbms_output.put_line('<사원명>: ' || v_last_name);
    dbms_output.put_line('<이메일>: ' || v_email);
    dbms_output.put_line('<입사일자>: ' || v_hire_date);
    dbms_output.put_line('<JOB_ID>: ' || v_job_id);
END;


DECLARE
    v_max_empno employees.employee_id%TYPE;
BEGIN
    SELECT
        MAX(employee_id)
    INTO
        v_max_empno
    FROM employees;
    
    INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
    VALUES
        (v_max_empno + 1, 'steven', 'stevenjobs', sysdate, 'CEO');
END;

SELECT * FROM emps;
SELECT * FROM emps WHERE employee_id = 207;