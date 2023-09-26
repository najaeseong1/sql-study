-- insert
-- 테이블 구조 확인
DESC departments;

-- INSERT의 첫번째 방법 (모든 컬럼 데이터를 한 번에 지정)
INSERT INTO departments  
VALUES(300, '개발부','','');

SELECT * FROM departments;

ROLLBACK; -- 실행 시점을 다시 뒤로 되돌리는 키워드

-- INSERT의 두번째 방법 (직접 컬럼을 지정하고 저장, NOT NULL 확인하세요!)
INSERT INTO departments 
    (department_id,department_name,location_id)
VALUES
    (290,'총무부',1700);
    
-- 사본 테이블 생성법
-- 사본 테이블을 생성할 때 그냥 생성하면 -> 조회된 데이터까지 모두 복사
-- WHERE절에 false값 (1=2) 지정하면 -> 테이블의 구조만 복사되고 데이터는 복사 x
CREATE TABLE emps AS 
(SELECT employee_id, first_name, job_id, hire_date 
FROM employees WHERE 1=2);

SELECT * FROM emps;
DROP TABLE emps;

--INSERT (서브쿼리)
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

-- UPDATE를 진행 할 때는 누구를 수정할 지 잘 지목해야 합니다.
-- 그렇지 않으면 수정 대상이 테이블 전체로 지목됩니다.
UPDATE emps SET salary=30000
WHERE employee_id = 100;

UPDATE emps SET salary=salary+salary*0.1
WHERE employee_id = 100;

UPDATE emps
SET phone_number='010.4272.8917',manager_id=102
WHERE employee_id = 100;

--UPDATE emps SET employee_id = 102 WHERE employee_id=100;
-- 이거 되네? 키 설정은 안 가지고 오나봄


-- UPDATE (서브쿼리)
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

MERGE INTO emps_it a -- MERGE를 할 타겟 테이블
    USING   -- 병합시킬 데이터
        (SELECT * FROM employees 
        WHERE job_id='IT_PROG') b  -- 병합시킬 데이터를 서브쿼리로 표현
    ON      -- 병합시킬 데이터의 연결 조건
        (a.employee_id = b.employee_id) 
WHEN MATCHED THEN -- 조건이 일치하는 경우는 타겟 테이블에 이렇게 실행하라
    UPDATE SET 
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
         /*
        DELETE만 단독으로 쓸 수는 없습니다.
        UPDATE 이후에 DELETE 작성이 가능합니다.
        UPDATE 된 대상을 DELETE 하도록 설계되어 있기 때문에
        삭제할 대상 컬럼들을 동일한 값으로 일단 UPDATE를 진행하고
        DELETE의 WHERE절에 아까 지정한 동일한 값을 지정해서 삭제합니다.
        */
        
        DELETE 
            WHERE a.employee_id = b.employee_id
        
WHEN NOT MATCHED THEN -- 조건이 일치하지 않는 경우 == 어느 한쪽에만 존재하는 경우
    INSERT/*속성(컬럼)*/ VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);

-------------------------------------------------------------------------------    
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '렉스', '박', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '니나', '최', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '흥민', '손', 'HMSON', '20/04/06', 'AD_VP');    

/*
employees 테이블을 매번 빈번하게 수정되는 테이블이라고 가정하자.
기존의 데이터는 email, phone, salary, comm_pct, man_id, dept_id을
업데이트 하도록 처리
새로 유입된 데이터는 그대로 추가.
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
INSERT INTO depts VALUES (280,'개발','',1800);
INSERT INTO depts VALUES (290,'회계부','',1800);
INSERT INTO depts VALUES (300,'재정',301,1800);
INSERT INTO depts VALUES (310,'인사',302,1800);
INSERT INTO depts VALUES (320,'영업',303,1700);

-- 문제 1-1
-- 문제 2-1
UPDATE depts SET department_name='IT bank' WHERE department_name='IT Support';
-- 문제 2-2
UPDATE depts SET manager_id = 301 WHERE department_id = 290;
-- 문제 2-3
UPDATE depts
SET
    department_name = 'IT Help',
    manager_id = 303,
    location_id = 1800
WHERE
    department_name = 'IT Helpdesk';
-- 문제 2-4 회계부, 재정, 인사, 영업의 매니저 아이디를 301로 일괄 변경하세요.
UPDATE depts SET manager_id = 301 WHERE department_name IN ('회계부','재정','인사','영업');

-- 문제 3-1
DELETE FROM depts WHERE department_id = 320;
-- 문제 3-2
DELETE FROM depts WHERE department_id=
    (SELECT department_id FROM depts WHERE department_name='NOC');
-- 문제 4-1
CREATE TABLE deptsss AS (SELECT * FROM depts );
DELETE FROM deptsss WHERE department_id > 200;
-- 문제 4-2
UPDATE deptsss SET manager_id = 100 WHERE manager_id IS NOT NULL;
 -- 문제 4-3, 4-4
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
-- 문제 5-1
CREATE TABLE jobs_it AS (SELECT * FROM jobs WHERE min_salary>6000);
-- 문제 5-2
INSERT INTO jobs_it VALUES('IT_DEV','아이티개발팀','6000','20000');
INSERT INTO jobs_it VALUES('NET_DEV','네트워크개발팀','5000','20000');
INSERT INTO jobs_it VALUES('SEC_DEV','보안개발팀','6000','19000');
-- 문제 5-3, 5-4
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