/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/
SELECT
    *
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees);

SELECT 
    COUNT(*)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT 
    *
FROM employees
WHERE job_id = 'IT_PROG' 
AND salary > (SELECT AVG(salary) FROM employees WHERE job_id = 'IT_PROG');

/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� �μ��� �����ִ� ������� 
��� ������ �˻��ϼ���.
*/
SELECT
    *
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
WHERE d.manager_id = 100;
/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/
SELECT
    *
FROM employees e
WHERE e.manager_id > (SELECT manager_id FROM employees WHERE first_name = 'Pat');

SELECT *
FROM employees 
WHERE manager_ID IN ( SELECT employee_ID FROM Employees WHERE first_name ='James');
/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/
SELECT 
    *
FROM 
    (
    SELECT 
        ROWNUM AS rn,
        first_name
    FROM (SELECT * FROM employees
    ORDER BY first_name DESC)
    )
WHERE rn > 40 AND rn <=51;


/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȭ��ȣ, �Ի����� ����ϼ���.
*/

SELECT 
    *
FROM 
    (
    SELECT 
        ROWNUM AS rn,
    employee_id,
    first_name || last_name AS �̸�,
    phone_number,
    hire_date
    FROM (SELECT * FROM employees
    ORDER BY hire_date DESC)
    )
WHERE rn > 30 AND rn <=40;

/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/
SELECT
    e.employee_id,
    e.first_name || e.last_name AS �̸�,
    d.department_id,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON d.department_id = e.department_id
ORDER BY e.employee_id ASC;
/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT 
    e.employee_id,
    e.first_name || e.last_name AS �̸�,
    (SELECT department_name FROM departments d WHERE d.department_id = e.department_id
    ) AS department_id,
    (SELECT department_name FROM departments d WHERE d.department_id = e.department_id
    ) AS department_name
FROM employees e
ORDER BY e.employee_id ASC;

/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, 
    ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/
SELECT 
    d.department_id,
    d.department_name,
    d.manager_id,
    loc.location_id,
    loc.street_address,
    loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY d.department_id ASC;

/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT 
    d.department_id,
    d.department_name,
    d.manager_id,
    (SELECT location_id FROM locations loc
    WHERE d.location_id = loc.location_id) AS location_id,
    (SELECT street_address FROM locations loc
    WHERE d.location_id = loc.location_id) AS street_address,
    (SELECT city FROM locations loc
    WHERE d.location_id = loc.location_id) AS city
FROM departments d
ORDER BY d.department_id ASC;
/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/
SELECT 
    loc.location_id,
    loc.street_address,
    loc.city,
    con.country_id,
    con.country_name
FROM locations loc
LEFT JOIN countries con
ON loc.country_id = con.country_id
ORDER BY con.country_name ASC;
/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT 
    loc.location_id,
    loc.street_address,
    loc.city,
    (SELECT country_id FROM countries con
    WHERE loc.country_id = con.country_id) AS country_id,
    (SELECT country_name FROM countries con 
    WHERE loc.country_id = con.country_id) AS country_name
FROM locations loc
ORDER BY country_name ASC;

/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 
1-10��° �����͸� ����մϴ�.
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, 
�μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/
SELECT * FROM employees;

SELECT
    ROWNUM AS RN,
    ed.*
FROM (
    SELECT 
        e.employee_id,
        e.first_name||e.last_name AS �̸�,
        e.phone_number,
        e.hire_date,
        d.department_id,
        d.department_name
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    ORDER BY hire_date ASC
) ed
WHERE rownum <= 10;
/*
���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
*/
SELECT 
    e.last_name, 
    e.job_id, 
    d.department_id, 
    d.department_name
FROM employees e
JOIN departments d 
ON d.department_id =e.department_id
WHERE job_id='SA_MAN';

/*
���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�.
*/
SELECT * FROM departments;
SELECT * FROM employees;

SELECT 
   d.department_id,   
   d.department_name,
   d.manager_id,
   COUNT(e.employee_id) as �ο���
FROM departments d  
JOIN employees e 
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name ,d.manager_id
HAVING COUNT(e.employee_id) > 0  
ORDER BY �ο��� DESC;  

/*
���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.
*/
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

SELECT
    d.*,
    l.street_address,
    l.postal_code,
    NVL(AVG(e.salary),0)
FROM departments d 
LEFT JOIN locations l
ON d.location_id = l.location_id
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY 
        d.department_id,
        d.department_name,
        d.manager_id,
        d.location_id,
        l.street_address, 
        l.postal_code;
/*
���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� 
ROWNUM�� �ٿ� 1-10 ������ ������ ����ϼ���.
*/
SELECT 
    ROWNUM,
    dle.*
FROM (
    SELECT
        d.*,
        l.street_address,
        l.postal_code,
        NVL(AVG(e.salary),0)
    FROM departments d 
    LEFT JOIN locations l
    ON d.location_id = l.location_id
    LEFT JOIN employees e
    ON d.department_id = e.department_id
    GROUP BY 
            d.department_id,
            d.department_name,
            d.manager_id,
            d.location_id,
            l.street_address, 
            l.postal_code
    ORDER BY d.department_id ASC        
)dle
WHERE ROWNUM <= 10;