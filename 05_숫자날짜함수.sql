-- �����Լ�
-- ROUND(�ݿø�)
-- ���ϴ� �ݿø� ��ġ�� �Ű������� ����. ������ �ִ� �͵� ����

SELECT
    round(31.4515, 3),
    round(31.4515, 0),
    round(31.4515, - 1)
FROM
    dual;

-- TRUNK(����)
-- ������ �Ҽ��� �ڸ������� �߶���ϴ�.

SELECT
    trunk(31.4515, 3),
    trunk(31.4515, 0),
    trunk(31.4515, - 1)
FROM
    dual;

--ABS(���밪)
SELECT
    abs(- 34)
FROM
    dual;

-- CEIL(�ø�), FLOOR(����)
SELECT
    ceil(3.14),
    floor(3.14)
FROM
    dual;
    
-- MODE(������)
SELECT
    10 / 4,
--    10%4, -- ����Ŭ���� ������ �����ڰ� �ȵ�
    mod(10, 4)
FROM
    dual;
    
-- ��¥ �Լ�
-- sysdate : ��ǻ���� ��¥ ������ �����ͼ� �����ϴ� �Լ�
-- sysdatestamp : ��ǻ���� ��¥,�ð� ������ �����ͼ� �����ϴ� �Լ�
SELECT
    sysdate
FROM
    dual;

SELECT
    systimestamp
FROM
    dual;
    
-- ��¥�� ������ �����մϴ�
SELECT
    sysdate + 1
FROM
    dual;

-- ��¥Ÿ�԰� ��¥Ÿ���� ���� ������ �����ϰ� ������ ������� �ʽ��ϴ�.
SELECT
    first_name,
--    round(sysdate + hire_date) -- �� ��,
    round(sysdate - hire_date) -- �� ��
FROM
    employees;

SELECT
    first_name,
    hire_date,
    (sysdate - hire_date) / 7 AS week
FROM
    employees; -- �ּ�

SELECT
    first_name,
    hire_date,
    (sysdate - hire_date) / 365 AS year
FROM
    employees; -- ���

-- ��¥ �ݿø�, ����
SELECT
    sysdate,
    round(sysdate) -- ���ް��� ������ '����'�� �������� �ݿø��� ��
FROM
    dual;
SELECT ROUND(sysdate) FROM dual;
SELECT ROUND(sysdate,'year') FROM dual; -- 1���� ������ �������� �ݿø�
SELECT ROUND(sysdate,'month') FROM dual; -- 30���� ������ �������� �ݿø�
SELECT ROUND(sysdate,'day') FROM dual; -- �� �������� �ݿø� (�ش� ���� �Ͽ��� ��¥)

SELECT TRUNC(sysdate) FROM dual; -- 1���� ������ �������� ����
SELECT TRUNC(sysdate,'year') FROM dual; -- 1���� ������ �������� ����
SELECT TRUNC(sysdate,'month') FROM dual; -- 30���� ������ �������� ����
SELECT TRUNC(sysdate,'day') FROM dual; -- �� �������� ���� (�ش� ���� �Ͽ��� ��¥)

