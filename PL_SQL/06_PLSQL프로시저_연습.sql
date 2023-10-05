/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
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
    dbms_output.put_line(p_num||'�� ����� ���� : ' || v_count);
END;

EXEC divisor_proc(120);
/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
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
            dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
            RETURN;
        END IF;    
        DELETE FROM depts 
        WHERE department_id = p_department_id;
    else    
        dbms_output.put_line('�߸��� �۾���û(flag) �Դϴ�');
    END IF;
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
        dbms_output.put_line('ERROR MSG : ' || SQLERRM);
        ROLLBACK;
END;

EXEC depts_proc(310,'������Ʈ','D');
SELECT * FROM depts;


/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
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
        dbms_output.put_line('ID�� '||p_employee_id || '�� �ش��ϴ� ����� �����ϴ�');
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
	DBMS_OUTPUT.PUT_LINE('�ټӳ��: '||v_years||'��');
END;

/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���޹޾ƾ� �� ��: ���, last_name, email, hire_date, job_id
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
		DBMS_OUTPUT.PUT_LINE('���� �߻�');
        dbms_output.put_line('SQL ERROR CODE : ' || SQLCODE); -- ����, ���� �ڵ�
        dbms_output.put_line('SQL ERROR MSG : ' || SQLERRM);  -- ����, ���� �޼���
		ROLLBACK;
END;

SELECT * FROM emps;
DELETE FROM emps WHERE employee_id = 321;
SELECT * FROm dual;
EXEC new_emp_proc (322,'asdasdasd','������������',sysdate,'������');
