-- ������ (���������� �����ϴ� ���� ����� �ִ� ��ü)

CREATE SEQUENCE dept2_seq
    START WITH 1 -- ���۰� (�⺻���� ������ �� �ּҰ�, ������ �� �ִ밪) , �������ϸ� ���������� ������
    INCREMENT BY 1 -- ������(����� ����, ������ ����, �⺻�� 1)
    MAXVALUE 10  -- �ִ밪 (�⺻���� �����϶� 1027, ������ �� -1) �⺻���� �ִ� ������ �˰�
    MINVALUE 1 -- �ּҰ� (�⺻���� ������ �� 1, �����϶� -1028) �������ϸ� �������ִ°� ����
    NOCACHE -- ĳ�ø޸� ��뿩�� (CACHE)
    NOCYCLE; -- ��ȯ ���� (NOCYCLE�� �⺻, ��ȯ��Ű���� CYCLE)

DROP SEQUENCE dept2_seq;
DROP TABLE dept2;

CREATE TABLE dept2(
    dept_no NUMBER(2) PRIMARY KEY,
    dept_name VARCHAR2(14),
    Loca VARCHAR2(13),
    dept_date DATE
);

-- ������ ����ϱ� (NEXTVAL, CURRVAL)
INSERT INTO dept2 VALUES(dept2_seq.NEXTVAL,'test','test',sysdate);

SELECT * FROM dept2;

SELECT dept2_seq.CURRVAL FROM dual;

-- ������ ����(���� ���� ����)
-- START WITH�� ������ �Ұ����մϴ�.

ALTER SEQUENCE dept2_seq MAXVALUE 9999;
ALTER SEQUENCE dept2_seq INCREMENT BY 10;
ALTER SEQUENCE dept2_seq MINVALUE 0;

-- ������ ���� �ٽ� ó������ ������ ��� (���簪�� ������)
ALTER SEQUENCE dept2_seq INCREMENT BY -40;
SELECT dept2_seq.NEXTVAL FROM dual;
ALTER SEQUENCE dept2_seq INCREMENT BY 1;

DROP SEQUENCE dept2_seq;

/*
- index
index�� primary key, unique ���� ���ǿ��� �ڵ����� �����ǰ�,
��ȸ�� ������ �� �ִ� hint ������ �մϴ�.
index�� ��ȸ�� ������ ������, �������ϰ� ���� �ε����� �����ؼ�
����ϸ� ������ ���� ���ϸ� ����ų �� �ֽ��ϴ�.
���� �ʿ��� ���� index�� ����ϴ� ���� �ٶ����մϴ�.
*/

SELECT * FROM employees WHERE salary = 12008;

-- �ε��� ����
CREATE INDEX emp_salary_idx ON employees(salary);

/*
���̺� ��ȸ �� �ε����� ���� �÷��� �������� ����Ѵٸ�
���̺� ��ü ��ȸ�� �ƴ�, �÷��� ���� �ε����� �̿��ؼ� ��ȸ�� �����մϴ�.
�ε����� �����ϰ� �Ǹ� ������ �÷��� ROWID�� ���� �ε����� �غ�ǰ�,
��ȸ�� ������ �� �ش� �ε����� ROWID�� ���� ���� ��ĵ�� �����ϰ� �մϴ�.
*/
DROP INDEX emp_salary_idx;

-- �������� �ε����� ����ϴ� hint ���
CREATE SEQUENCE board_seq
    START WITH 1 
    INCREMENT BY 1 
    NOCACHE 
    NOCYCLE;
    
CREATE TABLE tb1_board(
    bno NUMBER(10) PRIMARY KEY,
    writer VARCHAR2(20)
);
INSERT INTO tb1_board VALUES(board_seq.NEXTVAL,'test');
INSERT INTO tb1_board VALUES(board_seq.NEXTVAL,'admin');
INSERT INTO tb1_board VALUES(board_seq.NEXTVAL,'kim');
INSERT INTO tb1_board VALUES(board_seq.NEXTVAL,'hong');

SELECT * FROM tb1_board;
DROP sequence board_seq;
DROP TABLE tb1_board;

COMMIT;

ALTER INDEX SYS_C006999
RENAME TO tb1_board_idx;

SELECT 
    *
FROM    
    (
    SELECT 
        ROWNUM AS rn, a.*
    FROM
        (SELECT * FROM tb1_board ORDER BY bno DESC) a
    )
WHERE rn>10 AND rn<=20;

-- /*+ INDEX(table_name index_name) */
-- ������ �ε����� ������ ���Բ� ����.
-- INDEX ASC, DESC�� �߰��ؼ� ������, ������ ������ ���Բ� ���� ����.

SELECT * FROM (
SELECT /*+ INDEX_DESC(tb1_board tb1_board_idx)*/
    ROWNUM AS rn,
    bno,
    writer
FROM tb1_board
ORDER BY bno DESC
)
WHERE rn>10 AND rn <=20;

/*
- �ε����� ����Ǵ� ��� 
1. �÷��� WHERE �Ǵ� �������ǿ��� ���� ���Ǵ� ���
2. ���� �������� ���� �����ϴ� ���
3. ���̺��� ������ ���
4. Ÿ�� �÷��� ���� ���� null���� �����ϴ� ���.
5. ���̺��� ���� �����ǰ�, �̹� �ϳ� �̻��� �ε����� ������ �ִ� ��쿡��
 �������� �ʽ��ϴ�.
*/