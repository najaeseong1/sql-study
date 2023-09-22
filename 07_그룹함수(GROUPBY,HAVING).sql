-- �׷� �Լ�, AVG, MAX, MIN, SUM, COUNT

SELECT
    trunc(AVG(salary),
          3),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
FROM
    employees;

SELECT
    COUNT(*)
FROM
    employees; -- �� �� �������� ��
SELECT
    COUNT(first_name)
FROM
    employees;

SELECT
    COUNT(commission_pct)
FROM
    employees; -- NULL�� �ƴ� ���� ����
SELECT
    COUNT(manager_id)
FROM
    employees; -- NULL�� �ƴ� ���� ��

-- �μ����� �׷�ȭ, �׷��Լ��� ���

SELECT
    department_id,
    trunc(AVG(salary),
          3)
FROM
    employees
GROUP BY
    department_id;

-- ���� �� �� !!!!!!
-- �׷� �Լ��� �Ϲ� Į���� ���ÿ� �׳� ����� ���� �����ϴ�.
SELECT
    department_id,
    AVG(salary)
FROM
    employees; -- ����
    
-- GROUP BY���� ����� �� GROUP���� ������ ������ �ٸ� �÷��� ��ȸ�� �� �����ϴ�.    
SELECT
    department_id,
    job_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id;--���� �߻� , job_id;    

SELECT
    department_id,
    job_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id,
    job_id
ORDER BY
    department_id;
    
-- GROUP BY�� ���� �׷�ȭ �� �� ������ �� ��� HAVING�� ���.
SELECT
    department_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id
HAVING
    SUM(salary) >= 100000;

SELECT
    job_id,
    COUNT(*)
FROM
    employees
GROUP BY
    job_id
HAVING
    COUNT(*) >= 5;

-- �μ� ���̵� 50�̻��� �͵��� �׷�ȭ ��Ű��, �׷� ���� ����� 5000�̻� ��ȸ

SELECT
    department_id,
    AVG(salary) AS ���
FROM
    employees
WHERE
    department_id >= 50
GROUP BY
    department_id
HAVING
    AVG(salary) >= 5000
ORDER BY
    department_id DESC;

/*
���� 1.
��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
*/
SELECT
    job_id,
    COUNT(job_id) AS �����
FROM
    employees
GROUP BY
    job_id;

SELECT
    job_id,
    AVG(salary) AS �������
FROM
    employees
GROUP BY
    job_id
ORDER BY
    ������� DESC;
/*
���� 2.
��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
(TO_CHAR() �Լ��� ����ؼ� ������ ��ȯ�մϴ�. �׸��� �װ��� �׷�ȭ �մϴ�.)
*/
SELECT
    to_char(hire_date, 'YYYY')
    || '�⵵ �Ի�'                        AS �Ի�⵵,
    COUNT(to_char(hire_date, 'YYYY')) AS �����
FROM
    employees
GROUP BY
    to_char(hire_date, 'YYYY')
ORDER BY
    �Ի�⵵;

/*
���� 3.
�޿��� 5000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. 
�� �μ� ��� �޿��� 7000�̻��� �μ��� ����ϼ���.
*/
SELECT 
    department_id AS �μ�,
    TRUNC(AVG(salary)) AS ��ձ޿�
FROM 
    employees
WHERE 
    salary >= 5000
GROUP BY 
    department_id
HAVING 
    TRUNC(AVG(salary)) >= 7000;


/*
���� 4.
��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
*/
SELECT
    department_id AS �μ���,
    TRUNC(AVG(salary*(1+commission_pct)),2) AS ��տ���,
    SUM(salary+(salary*commission_pct)) AS �հ�,
    count(*)
FROM
    employees
WHERE
    commission_pct IS NOT NULL
GROUP BY department_id;