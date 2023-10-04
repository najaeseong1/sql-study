-- WHILE��

DECLARE
    v_num NUMBER := 3;
    v_count NUMBER := 1; -- begin
BEGIN
    WHILE v_count <= 10 -- end
    LOOP
        v_num := v_num +v_count;
        v_count := v_count + 1; -- step
    END LOOP;
    
    dbms_output.put_line(v_count);
END;

-- Ż�⹮
DECLARE
    v_num NUMBER := 3;
    v_count NUMBER := 1; -- begin
BEGIN
    WHILE v_count <= 10 -- end
    LOOP
        EXIT WHEN v_count = 5;
        v_num := v_num +v_count;
        v_count := v_count + 1; -- step
    END LOOP;
    dbms_output.put_line(v_count);
END;

-- FOR ��
DECLARE
    v_num NUMBER := 4;
BEGIN
    FOR i IN 1..9 LOOP
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num*i);
    END LOOP;
END;

-- CONTINUE ��
DECLARE
    v_num NUMBER := 4;
BEGIN
    FOR i IN 1..9 LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num*i);
    END LOOP;
END;

-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2 ~ 9��)
-- ¦���ܸ� ����� �ּ���. (2, 4, 6, 8)
-- ����� ����Ŭ ������ �߿��� �������� �˾Ƴ��� �����ڰ� �����. (% ����~)

DECLARE
BEGIN
    FOR i IN 2..9 LOOP
        IF MOD(i, 2) = 0 THEN -- ¦���� ��쿡�� ���
            dbms_output.put_line('---------------------------------------');
            dbms_output.put_line('������ : ' || i || '��');
            FOR j IN 1..9 LOOP
                dbms_output.put_line(i || ' x ' || j || ' = ' || i*j);
            END LOOP;
        END IF;
        dbms_output.put_line('---------------------------------------');
    END LOOP;
END;   

-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....

CREATE TABLE board (
    bno NUMBER,
    writer VARCHAR2(20),
    title VARCHAR2(50)
);
CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 300
    MINVALUE 1
    NOCACHE;

DECLARE
BEGIN
    FOR i IN 1..300 LOOP
        BEGIN 
            INSERT INTO board (bno, writer, title)
            VALUES (board_seq.NEXTVAL , 'test' || i , 'title' || i);
        END;  
    END LOOP;
END;

SELECT * FROM board;
DROP TABLE board;
DROP SEQUENCE board_seq;

