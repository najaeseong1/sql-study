/*
���� 1.
-EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
-EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. 
(�޶����� ���� ���� �ּ����� Ȯ��)
*/
SELECT
    *
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id;

SELECT
    *
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id;

SELECT
    *
FROM
    employees   e
    RIGHT OUTER JOIN departments d ON e.department_id = d.department_id;

SELECT
    *
FROM
    employees   e
    FULL OUTER JOIN departments d ON e.department_id = d.department_id;

-- INNER 106��, LEFT OUTER 107��, RIGHT OUTER 122��, FULL OUTER 123��

/*
���� 2.
-EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
����)employee_id�� 200�� ����� �̸�, department_name�� ����ϼ���
����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
*/

SELECT
    e.first_name || e.last_name AS �̸�,
    d.department_name
--    ,employee_id
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id
WHERE
    e.employee_id = 200;

/*
���� 3.
-EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
HINT) � �÷����� ���� ����Ǿ� �ִ��� Ȯ��
*/
SELECT
    e.first_name || e.last_name AS �̸�,
    j.job_id                    AS �������̵�,
    j.job_title                 AS ����Ÿ��Ʋ
--    ,employee_id
FROM
         employees e
    INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY
    �̸� ASC;
/*
���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
*/
SELECT
    *
FROM
    jobs        j
    LEFT OUTER JOIN job_history jh ON j.job_id = jh.job_id;
/*
���� 5.
--Steven King�� �μ����� ����ϼ���.
*/
SELECT
    e.first_name || e.last_name AS �̸�,
    d.department_name           AS �μ���
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id
WHERE
        first_name = 'Steven'
    AND last_name = 'King';
/*
���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
*/
SELECT
    *
FROM
    employees,
    departments;

SELECT
    *
FROM
         employees e
    CROSS JOIN departments d;

/*
���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� 
SA_MAN ������� �����ȣ, �̸�, �޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
*/
SELECT
    e.employee_id               AS �����ȣ,
    e.first_name || e.last_name AS �̸�,
    e.salary                    AS �޿�,
    d.department_name           AS �μ���,
    loc.city                    AS �ٹ���
FROM
         employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN locations loc ON d.location_id = loc.location_id
WHERE
    e.job_id = 'SA_MAN';    
/*
���� 8.
-- employees, jobs ���̺��� ���� �����ϰ� job_title�� 
'Stock Manager', 'Stock Clerk'�� ���� ������ ����ϼ���.
*/
SELECT
    *
FROM
         employees e
    JOIN jobs j ON e.job_id = j.job_id
WHERE
    j.job_title IN ( 'Stock Manager', 'Stock Clerk' );  
/*
���� 9.
-- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
*/
SELECT
    e.employee_id,
    d.*
FROM
    departments d
    LEFT OUTER JOIN employees e 
ON d.department_id = e.department_id
WHERE
    e.employee_id IS NULL;
--    e.department_id IS NULL;
    
SELECT * 
FROM employees e
WHERE e.department_id IS NULL;

/*
���� 10. 
-join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
*/

SELECT
    e1.first_name || e1.last_name AS ����̸�,
    e2.first_name || e2.last_name AS �Ŵ����̸�
FROM
         employees e1
    JOIN employees e2 ON e1.manager_id = e2.employee_id;

/*
���� 11. 
-- EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� 
���� ����ϼ���
--�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
*/
SELECT
    e2.employee_id AS �Ŵ���,
    e1.first_name || e1.last_name AS ����̸�,
    e2.first_name || e2.last_name AS �Ŵ����̸�,
    e2.salary                     AS �Ŵ����޿�
FROM
    employees e1
    LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id
WHERE
    e1.manager_id IS NOT NULL
ORDER BY
    e2.salary DESC;