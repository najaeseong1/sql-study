/*
覗稽獣煽誤 divisor_proc
収切 馬蟹研 穿含閤焼 背雁 葵税 鉦呪税 鯵呪研 窒径馬澗 覗稽獣煽研 識情杯艦陥.
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
    dbms_output.put_line(p_num||'税 鉦呪税 鯵呪 : ' || v_count);
END;

EXEC divisor_proc(120);
/*
採辞腰硲, 採辞誤, 拙穣 flag(I: insert, U:update, D:delete)聖 古鯵痕呪稽 閤焼 
depts 砺戚鷺拭 
唖唖 INSERT, UPDATE, DELETE 馬澗 depts_proc 空 戚硯税 覗稽獣煽研 幻級嬢左切.
益軒壱 舛雌曽戟虞檎 commit, 森須虞檎 継拷 坦軒馬亀系 坦軒馬室推.
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
            dbms_output.put_line('肢薦馬壱切 馬澗 採辞亜 糎仙馬走 省柔艦陥.');
            RETURN;
        END IF;    
        DELETE FROM depts 
        WHERE department_id = p_department_id;
    else    
        dbms_output.put_line('設公吉 拙穣推短(flag) 脊艦陥');
    END IF;
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('森須亜 降持梅柔艦陥.');
        dbms_output.put_line('ERROR MSG : ' || SQLERRM);
        ROLLBACK;
END;

EXEC depts_proc(310,'穣汽戚闘','D');
SELECT * FROM depts;


/*
employee_id研 脊径閤焼 employees拭 糎仙馬檎,
悦紗鰍呪研 out馬澗 覗稽獣煽研 拙失馬室推. (斥誤鷺系拭辞 覗稽獣煽研 叔楳)
蒸陥檎 exception坦軒馬室推
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
        dbms_output.put_line('ID亜 '||p_employee_id || '拭 背雁馬澗 紫据戚 蒸柔艦陥');
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
	DBMS_OUTPUT.PUT_LINE('悦紗鰍呪: '||v_years||'鰍');
END;

/*
覗稽獣煽誤 - new_emp_proc
employees 砺戚鷺税 差紫 砺戚鷺 emps研 持失杯艦陥.
employee_id, last_name, email, hire_date, job_id研 脊径閤焼
糎仙馬檎 戚硯, 戚五析, 脊紫析, 送穣聖 update, 
蒸陥檎 insert馬澗 merge庚聖 拙失馬室推

袴走研 拝 展為 砺戚鷺 -> emps
佐杯獣迭 汽戚斗 -> 覗稽獣煽稽 穿含閤精 employee_id研 dual拭 select 凶形辞 搾嘘.
覗稽獣煽亜 穿含閤焼醤 拝 葵: 紫腰, last_name, email, hire_date, job_id
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
		DBMS_OUTPUT.PUT_LINE('森須 降持');
        dbms_output.put_line('SQL ERROR CODE : ' || SQLCODE); -- 拭君, 神嫌 坪球
        dbms_output.put_line('SQL ERROR MSG : ' || SQLERRM);  -- 拭君, 神嫌 五室走
		ROLLBACK;
END;

SELECT * FROM emps;
DELETE FROM emps WHERE employee_id = 321;
SELECT * FROm dual;
EXEC new_emp_proc (322,'asdasdasd','けいしけいし',sysdate,'けいし');
