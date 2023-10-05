/*
프로시저명 divisor_proc
숫자 하나를 전달받아 해당 값의 약수의 개수를 출력하는 프로시저를 선언합니다.
*/
CREATE OR REPLACE PROCEDURE divisor_proc
    (p_num IN NUMBER)
IS
    v_count NUMBER :=0;
BEGIN 
    FOR i IN 1..p_num LOOP
        IF MOD(p_num, i) = 0 THEN
            v_count := v_count+1;
        END IF;
    END LOOP;
    dbms_output.put_line(p_num||'의 약수의 개수 : ' || v_count);
END;

EXEC divisor_proc(120);
/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
*/
CREATE OR REPLACE PROCEDURE depts_proc
    (
    p_department_id IN departments.department_id%TYPE,
    p_department_name IN departments.department_name%TYPE,
    p_flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_cnt FROM depts WHERE department_id = p_department_id;   
    IF p_flag = 'I' THEN
        INSERT INTO depts (department_id, department_name)
        VALUES (p_department_id, p_department_name);
    ELSIF p_flag = 'U' THEN
        UPDATE depts 
        SET department_name = p_department_name
        WHERE department_id = p_department_id;  
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('삭제하고자 하는 부서가 존재하지 않습니다.');
            RETURN;
        END IF;    
        DELETE FROM depts 
        WHERE department_id = p_department_id;
    else    
        dbms_output.put_line('잘못된 작업요청(flag) 입니다');
    END IF;
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('예외가 발생했습니다.');
        dbms_output.put_line('ERROR MSG : ' || SQLERRM);
        ROLLBACK;
END;

EXEC depts_proc(310,'업데이트','D');
SELECT * FROM depts;


/*
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/
CREATE OR REPLACE PROCEDURE years_of_service
    (
    p_employee_id IN employees.employee_id%TYPE,
    out_years OUT NUMBER
    )
IS
    v_hire_date employees.hire_date%TYPE;
BEGIN
    SELECT 
        hire_date
    INTO v_hire_date
    FROM employees
    WHERE employee_id = p_employee_id;
    out_years:=TRUNC(MONTHS_BETWEEN(sysdate,v_hire_date)/12);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('ID가 '||p_employee_id || '에 해당하는 사원이 없습니다');
        dbms_output.put_line(out_years);
END;

DECLARE
	v_years NUMBER;
BEGIN	
	years_of_service(576,v_years);
    IF v_years IS NULL
    THEN 
        RETURN;
    END IF;
	DBMS_OUTPUT.PUT_LINE('근속년수: '||v_years||'년');
END;

/*
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요

머지를 할 타겟 테이블 -> emps
병합시킬 데이터 -> 프로시저로 전달받은 employee_id를 dual에 select 때려서 비교.
프로시저가 전달받아야 할 값: 사번, last_name, email, hire_date, job_id
*/
CREATE TABLE emps AS SELECT * FROM employees; 
SELECT * FROM emps;

CREATE OR REPLACE PROCEDURE new_emp_proc
    (
 	p_employee_id IN employees.employee_id%TYPE,
	p_last_name IN employees.first_name%TYPE,
	p_email IN employees.email%TYPE,
	p_hire_date IN employees.hire_date%TYPE,
	p_job_id IN employees.job_id%TYPE	
    )
IS
BEGIN
	MERGE INTO emps e 
    USING 
        (SELECT p_employee_id AS employee_id FROM dual) d 
	ON 
        (e.employee_id = d.employee_id)
	WHEN MATCHED THEN 
		UPDATE SET 
            e.last_name = p_last_name, 
            e.email = p_email, 
            e.hire_date = p_hire_date,
            e.job_Id = p_job_Id	
	WHEN NOT MATCHED THEN 
		INSERT (employee_Id,last_Name,email,hire_Date ,job_Id)
		VALUES (p_employee_Id,p_last_name,p_email,p_hire_date,p_job_Id);
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('예외 발생');
        dbms_output.put_line('SQL ERROR CODE : ' || SQLCODE); -- 에러, 오류 코드
        dbms_output.put_line('SQL ERROR MSG : ' || SQLERRM);  -- 에러, 오류 메세지
		ROLLBACK;
END;

SELECT * FROM emps;
DELETE FROM emps WHERE employee_id = 321;
SELECT * FROm dual;
EXEC new_emp_proc (322,'asdasdasd','ㅁㄴㅇㅁㄴㅇ',sysdate,'ㅁㄴㅇ');
