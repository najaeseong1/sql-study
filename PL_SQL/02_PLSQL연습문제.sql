-- 1. ������ �� 3���� ����ϴ� �͸� ����� ����� ����.
DECLARE
    v_result NUMBER;
BEGIN
    FOR i IN 1..9 LOOP
        v_result := 3 * i;
        dbms_output.put_line('3 x ' || i || ' = ' || v_result);
    END LOOP;
END;

-- 2. employees ���̺��� 201�� ����� �̸��� �̸��� �ּҸ� ����ϴ�
-- �͸����� ����� ����. (������ ��Ƽ� ����ϼ���.)
DECLARE -- ���� ����
    v_emp_id employees.employee_id%TYPE;	
    v_emp_name employees.first_name%TYPE;
    v_emp_email employees.email%TYPE;
BEGIN
    SELECT
    employee_id,first_name, email
    INTO v_emp_id, v_emp_name, v_emp_email
    FROM employees 
    WHERE employee_id = 201;
    dbms_output.put_line('��� ��ȣ: ' || v_emp_id);
    dbms_output.put_line('��� �̸�: ' || v_emp_name);
    dbms_output.put_line('�̸��� �ּ�: ' || v_emp_email);
END;
-- 3. employees ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� �� (MAX �Լ� ���)
-- �� ��ȣ + 1������ �Ʒ��� ����� emps ���̺�
-- employee_id, last_name, email, hire_date, job_id�� �ű� �����ϴ� �͸� ����� ���弼��.
-- SELECT�� ���Ŀ� INSERT�� ����� �����մϴ�.
/*
<�����>: steven
<�̸���>: stevenjobs
<�Ի�����>: ���ó�¥
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

    dbms_output.put_line('<�����>: ' || v_last_name);
    dbms_output.put_line('<�̸���>: ' || v_email);
    dbms_output.put_line('<�Ի�����>: ' || v_hire_date);
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