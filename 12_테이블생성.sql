/*
- NUMBER(2) -> 舛呪研 2切軒猿走 煽舌拝 呪 赤澗 収切莫 展脊.
- NUMBER(5, 2) -> 舛呪採, 叔呪採研 杯庁 恥 切軒呪 5切軒, 社呪繊 2切軒
- NUMBER -> 胤硲研 持繰拝 獣 (38, 0)生稽 切疑 走舛桔艦陥.
- VARCHAR2(byte) -> 胤硲 照拭 級嬢臣 庚切伸税 置企 掩戚研 走舛. (4000byte猿走)
- CLOB -> 企遂勲 努什闘 汽戚斗 展脊 (置企 4Gbyte)
- BLOB -> 戚遭莫 企遂勲 梓端 (戚耕走, 督析 煽舌 獣 紫遂,置企 4Gbyte)
- DATE -> BC 4712鰍 1杉 1析 ~ AD 9999鰍 12杉 31析猿走 走舛 亜管
- 獣, 歳, 段 走据 亜管.
*/

CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14),
    loca VARCHAR2(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);

DESC dept2;
SELECT * FROM dept2;

-- NUMBER人 VARCHAR2 展脊税 掩戚研 溌昔.
INSERT INTO dept2 VALUES(10, '鯵降','辞随',sysdate,1000000);
INSERT INTO dept2 VALUES(20, '慎穣','辞随',sysdate,2000000);
--INSERT INTO dept2 VALUES(300, '井慎走据けけいしけいしけいしけいし','井奄',sysdate,2000000);
--走舛廃 切軒呪 限仲操醤 廃陥.

-- 鎮軍 蓄亜
ALTER TABLE dept2
ADD (dept_count NUMBER(3));

-- 伸戚硯 痕井
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;

-- 伸 紗失 呪舛
-- 幻鉦 痕井馬壱切 馬澗 鎮軍拭 汽戚斗亜 戚耕 糎仙廃陥檎 益拭 限澗 展脊生稽
-- 痕井背 爽偲醤 杯艦陥. 限走 省澗 展脊生稽澗 痕井戚 災亜管杯艦陥.
ALTER TABLE dept2
MODIFY (dept_count VARCHAR2(2));

-- 伸 肢薦
ALTER TABLE dept2
DROP COLUMN dept_bonus;

-- 砺戚鷺 戚硯 痕井
ALTER TABLE dept2
RENAME TO dept3;

DESC dept3;
SELECT * FROM dept3;

-- 砺戚鷺 肢薦 (姥繕澗 害移砧壱 鎧採 汽戚斗幻 乞砧 肢薦)
TRUNCATE TABLE dept3;

DROP TABLE dept3;

ROLLBACK;