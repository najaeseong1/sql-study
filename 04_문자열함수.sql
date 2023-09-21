-- lower(�ҹ���), initcap(�ձ��ڸ� �빮��), upper(�빮��)
-- dual�� ����Ŭ�� �����ϴ� ���� ���̺�
SELECT
    *
FROM
    dual; 
/*
dual�̶�� ���̺��� sys�� �����ϴ� ����Ŭ�� ǥ�� ���̺�μ�,
���� �� �࿡ �� �÷��� ��� �ִ� dummy ���̺� �Դϴ�.
�Ͻ����� ��� �����̳� ��¥ ���� � �ַ� ����մϴ�.
��� ����ڰ� ������ �� �ֽ��ϴ�.
*/

SELECT
    'abcdef',
    lower('abcDEF'),
    upper('abcDEF')
FROM
    dual;

SELECT
    last_name,
    lower('last_name'),
    initcap('last_name'),
    upper('last_name')
FROM
    employees;

SELECT
    last_name
FROM
    employees
WHERE
    lower(last_name) = 'austin';

-- length(����), instr(���� ã��, ������ 0����ȯ, ������ �ε�����)

SELECT
    'abcdef',
    length('abcdef'),
    instr('abcdef', 'a')
FROM
    dual;

SELECT
    first_name,
    length(first_name),
    instr(first_name, 'a')
FROM
    employees;
    
-- substr(�ڸ����ڿ�, ���� �ε���, ����), concat(���� ����)== �Ű����� 2�� �ۿ� ���� �ʴ´�
-- �ε��� 1���� ����
SELECT
    'abcdef' AS ex,
    substr('abcdef', 1, 4),
    concat('abcdef', 'def')
FROM
    dual;

SELECT
    first_name,
    substr(first_name, 1, 3),
    concat(first_name, last_name)
FROM
    employees;
    
-- LPAD, RPAD (��, ���� ���� ���ڿ��� ä���)

SELECT
    lpad('abc', 10, '*'),
    rpad('abc', 10, '*')
FROM
    dual;
    
-- LTRIM(), RTRIM(), TRIM() �������� -- LTRIM() RTRIM()������ ���� ã�Ƽ� ���ִ� �뵵
-- LTRIM(param1, param2) -> param2�� ���� param1���� ã�Ƽ� ����. (���ʺ���)
-- RTRIM(param1, param2) -> param2�� ���� param1���� ã�Ƽ� ����. (�����ʺ���)

SELECT
    ltrim('javascript_java', 'java')
FROM
    dual;

SELECT
    rtrim('javascript_java', 'java')
FROM
    dual;
--SELECT TRIM('javascript_java','java')FROM dual;
SELECT
    TRIM('                   java               ')
FROM
    dual;

-- replace()
SELECT
    replace('My dream is a president', 'president', 'programer')
FROM
    dual;

SELECT
    replace(replace('My dream is a president', 'president', 'programer'),
            ' ',
            '')
FROM
    dual;

SELECT
    replace(concat('hello', ' world!'),
            '!',
            '?')
FROM
    dual;

/*
���� 1.
EMPLOYEES ���̺��� �̸�, �Ի����� �÷����� ����(��Ī AS)�ؼ� �̸������� �������� ��� �մϴ�.
���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
*/
SELECT
    concat(first_name, last_name) AS �̸�,
    replace(hire_date, '/', '')   AS �Ի�����
FROM
    employees
ORDER BY
    first_name;

/*
���� 2.
EMPLOYEES ���̺��� phone_number�÷��� ###.###.####���·� ����Ǿ� �ִ�
���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� 
��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���. (CONCAT, SUBSTR, LENGTH ���)
*/
SELECT 
--    CONCAT('(02)', SUBSTR(phone_number, 4,LENGTH(phone_number))) AS ��ȭ��ȣ
    CONCAT('(02)', SUBSTR(phone_number, 4)) AS ��ȭ��ȣ
FROM 
    employees;

/*
���� 3. 
EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
���� 1) ���ϱ� ���� ���� �ҹ��ڷ� ���ؾ� �մϴ�.(��Ʈ : lower �̿�)
���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
*/
SELECT 
    RPAD(SUBSTR(first_name, 1, 3), LENGTH(first_name),'*') AS name,
    LPAD(salary, 10, '*') AS salary
FROM 
    employees
WHERE 
    LOWER(job_id) = 'it_prog';
