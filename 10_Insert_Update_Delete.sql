-- insert
-- ���̺� ���� Ȯ��
DESC departments;

-- INSERT�� ù��° ��� (��� �÷� �����͸� �� ���� ����)
INSERT INTO departments  
VALUES(300, '���ߺ�','','');

SELECT * FROM departments;

ROLLBACK; -- ���� ������ �ٽ� �ڷ� �ǵ����� Ű����

-- INSERT�� �ι�° ��� (���� �÷��� �����ϰ� ����, NOT NULL Ȯ���ϼ���!)
INSERT INTO departments 
    (department_id,department_name,location_id)
VALUES
    (290,'�ѹ���',1700);
    
-- �纻 ���̺� ������
-- �纻 ���̺��� ������ �� �׳� �����ϸ� -> ��ȸ�� �����ͱ��� ��� ����
-- WHERE���� false�� (1=2) �����ϸ� -> ���̺��� ������ ����ǰ� �����ʹ� ���� x
CREATE TABLE emps AS 
(SELECT employee_id, first_name, job_id, hire_date 
FROM employees WHERE 1=2);

SELECT * FROM emps;
DROP TABLE emps;

--INSERT (��������)
INSERT INTO emps
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE department_id = 50);

-------------------------------------------------------------------------------
--UPDATE
CREATE TABLE emps AS 
(SELECT * FROM employees);

SELECT * FROM emps;
DROP TABLE emps;
ROLLBACK;

-- UPDATE�� ���� �� ���� ������ ������ �� �� �����ؾ� �մϴ�.
-- �׷��� ������ ���� ����� ���̺� ��ü�� ����˴ϴ�.
UPDATE emps SET salary=30000
WHERE employee_id = 100;

UPDATE emps SET salary=salary+salary*0.1
WHERE employee_id = 100;

UPDATE emps
SET phone_number='010.4272.8917',manager_id=102
WHERE employee_id = 100;

--UPDATE emps SET employee_id = 102 WHERE employee_id=100;
-- �̰� �ǳ�? Ű ������ �� ������ ������


-- UPDATE (��������)
UPDATE emps SET (job_id, salary, manager_id) = 
    (
        SELECT job_id, salary, manager_id
        FROM emps
        WHERE employee_id = 100
    )
WHERE employee_id = 101;

SELECT * FROM emps;

-------------------------------------------------------------------------------
-- DELETE
DELETE FROM emps
WHERE employee_id = 103;

-- DELETE
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM departments 
                        WHERE department_name = 'IT');
SELECT * FROM employees;
SELECT * FROM emps_it;

MERGE INTO emps_it a -- MERGE�� �� Ÿ�� ���̺�
    USING   -- ���ս�ų ������
        (SELECT * FROM employees 
        WHERE job_id='IT_PROG') b  -- ���ս�ų �����͸� ���������� ǥ��
    ON      -- ���ս�ų �������� ���� ����
        (a.employee_id = b.employee_id) 
WHEN MATCHED THEN -- ������ ��ġ�ϴ� ���� Ÿ�� ���̺� �̷��� �����϶�
    UPDATE SET 
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
         /*
        DELETE�� �ܵ����� �� ���� �����ϴ�.
        UPDATE ���Ŀ� DELETE �ۼ��� �����մϴ�.
        UPDATE �� ����� DELETE �ϵ��� ����Ǿ� �ֱ� ������
        ������ ��� �÷����� ������ ������ �ϴ� UPDATE�� �����ϰ�
        DELETE�� WHERE���� �Ʊ� ������ ������ ���� �����ؼ� �����մϴ�.
        */
        
        DELETE 
            WHERE a.employee_id = b.employee_id
        
WHEN NOT MATCHED THEN -- ������ ��ġ���� �ʴ� ��� == ��� ���ʿ��� �����ϴ� ���
    INSERT/*�Ӽ�(�÷�)*/ VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);

-------------------------------------------------------------------------------    
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '����', '��', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '�ϳ�', '��', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '���', '��', 'HMSON', '20/04/06', 'AD_VP');    

/*
employees ���̺��� �Ź� ����ϰ� �����Ǵ� ���̺��̶�� ��������.
������ �����ʹ� email, phone, salary, comm_pct, man_id, dept_id��
������Ʈ �ϵ��� ó��
���� ���Ե� �����ʹ� �״�� �߰�.
*/

MERGE INTO emps_it a
    USING (SELECT * FROM employees) b
    ON (a.employee_id = b.employee_id)    
WHEN MATCHED THEN
    UPDATE SET 
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
WHEN NOT MATCHED THEN
    INSERT VALUES
        (b.employee_id, b.first_name, b.last_name,
        b.email, b.phone_number, b.hire_date, b.job_id,
        b.salary, b.commission_pct, b.manager_id, b.department_id);
        
SELECT * FROM emps_it
ORDER BY employee_id ASC;

--DROP TABLE depts;
SELECT * FROM depts;

CREATE TABLE depts AS (SELECT * FROM departments);
INSERT INTO depts VALUES (280,'����','',1800);
INSERT INTO depts VALUES (290,'ȸ���','',1800);
INSERT INTO depts VALUES (300,'����',301,1800);
INSERT INTO depts VALUES (310,'�λ�',302,1800);
INSERT INTO depts VALUES (320,'����',303,1700);

-- ���� 1-1
-- ���� 2-1
UPDATE depts SET department_name='IT bank' WHERE department_name='IT Support';
-- ���� 2-2
UPDATE depts SET manager_id = 301 WHERE department_id = 290;
-- ���� 2-3
UPDATE depts
SET
    department_name = 'IT Help',
    manager_id = 303,
    location_id = 1800
WHERE
    department_name = 'IT Helpdesk';
-- ���� 2-4 ȸ���, ����, �λ�, ������ �Ŵ��� ���̵� 301�� �ϰ� �����ϼ���.
UPDATE depts SET manager_id = 301 WHERE department_name IN ('ȸ���','����','�λ�','����');

-- ���� 3-1
DELETE FROM depts WHERE department_id = 320;
-- ���� 3-2
DELETE FROM depts WHERE department_id=
    (SELECT department_id FROM depts WHERE department_name='NOC');
-- ���� 4-1
CREATE TABLE deptsss AS (SELECT * FROM depts );
DELETE FROM deptsss WHERE department_id > 200;
-- ���� 4-2
UPDATE deptsss SET manager_id = 100 WHERE manager_id IS NOT NULL;
 -- ���� 4-3, 4-4
 MERGE INTO depts td
    USING (SELECT * FROM departments) d
    ON (td.department_id = d.department_id)
WHEN MATCHED THEN
    UPDATE SET
        td.department_name = d.department_name,
        td.manager_id = d.manager_id,
        td.location_id = d.location_id
WHEN NOT MATCHED THEN
    INSERT VALUES
        (d.department_id,
        d.department_name,
        d.manager_id,
        d.location_id);
-- ���� 5-1
CREATE TABLE jobs_it AS (SELECT * FROM jobs WHERE min_salary>6000);
-- ���� 5-2
INSERT INTO jobs_it VALUES('IT_DEV','����Ƽ������','6000','20000');
INSERT INTO jobs_it VALUES('NET_DEV','��Ʈ��ũ������','5000','20000');
INSERT INTO jobs_it VALUES('SEC_DEV','���Ȱ�����','6000','19000');
-- ���� 5-3, 5-4
MERGE INTO jobs_it ta
    USING (SELECT * FROM jobs WHERE min_salary > 5000) j
    ON (ta.job_id = j.job_id)
WHEN MATCHED THEN
    UPDATE SET 
        ta.min_salary = j.min_salary,
        ta.max_salary = j.max_salary
WHEN NOT MATCHED THEN
    INSERT VALUES (j.job_id,j.job_title,j.min_salary,j.max_salary);
        
SELECT * FROM depts; 
SELECT * FROM deptsss;
SELECT * FROM jobs_it;
SELECT * FROM jobs;

DROP TABLE jobs_it;