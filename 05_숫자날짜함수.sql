-- 숫자함수
-- ROUND(반올림)
-- 원하는 반올림 위치를 매개값으로 지정. 음수를 주는 것도 가능

SELECT
    round(31.4515, 3),
    round(31.4515, 0),
    round(31.4515, - 1)
FROM
    dual;

-- TRUNK(절사)
-- 정해진 소수점 자리수까지 잘라냅니다.

SELECT
    trunk(31.4515, 3),
    trunk(31.4515, 0),
    trunk(31.4515, - 1)
FROM
    dual;

--ABS(절대값)
SELECT
    abs(- 34)
FROM
    dual;

-- CEIL(올림), FLOOR(내림)
SELECT
    ceil(3.14),
    floor(3.14)
FROM
    dual;
    
-- MODE(나머지)
SELECT
    10 / 4,
--    10%4, -- 오라클에서 나머지 연산자가 안됨
    mod(10, 4)
FROM
    dual;
    
-- 날짜 함수
-- sysdate : 컴퓨터의 날짜 정보를 가져와서 제공하는 함수
-- sysdatestamp : 컴퓨터의 날짜,시간 정보를 가져와서 제공하는 함수
SELECT
    sysdate
FROM
    dual;

SELECT
    systimestamp
FROM
    dual;
    
-- 날짜도 연산이 가능합니다
SELECT
    sysdate + 1
FROM
    dual;

-- 날짜타입과 날짜타입은 뺄셈 연산을 지원하고 덧셈은 허용하지 않습니다.
SELECT
    first_name,
--    round(sysdate + hire_date) -- 일 수,
    round(sysdate - hire_date) -- 일 수
FROM
    employees;

SELECT
    first_name,
    hire_date,
    (sysdate - hire_date) / 7 AS week
FROM
    employees; -- 주수

SELECT
    first_name,
    hire_date,
    (sysdate - hire_date) / 365 AS year
FROM
    employees; -- 년수

-- 날짜 반올림, 절사
SELECT
    sysdate,
    round(sysdate) -- 전달값이 없으면 '정오'를 기준으로 반올림이 됨
FROM
    dual;
SELECT ROUND(sysdate) FROM dual;
SELECT ROUND(sysdate,'year') FROM dual; -- 1년의 절반을 기준으로 반올림
SELECT ROUND(sysdate,'month') FROM dual; -- 30일의 절반을 기준으로 반올림
SELECT ROUND(sysdate,'day') FROM dual; -- 일 기준으로 반올림 (해당 주의 일요일 날짜)

SELECT TRUNC(sysdate) FROM dual; -- 1년의 절반을 기준으로 절사
SELECT TRUNC(sysdate,'year') FROM dual; -- 1년의 절반을 기준으로 절사
SELECT TRUNC(sysdate,'month') FROM dual; -- 30일의 절반을 기준으로 절사
SELECT TRUNC(sysdate,'day') FROM dual; -- 일 기준으로 절사 (해당 주의 일요일 날짜)

