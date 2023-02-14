// 1) Transaction(Ʈ�����)
// - ��ü ��ó���� �ϰ� �Ǿ�߸� �ǹ̰� �ִ� ���
// - ��ü ���� : commit / ���� : rollback(��ü �۾� ���)

// TRANSACTION ���� ����
CREATE TABLE dept_tcl
    AS SELECT * FROM dept;
    
// 60�� �μ��� ������ ������ �Է�
INSERT INTO dept_tcl VALUES(60, 'Database', '����', 1111);

// Update => 40�� �μ��� loc => '�뱸'�� ����
Update dept_tcl SET loc = '�뱸' WHERE dno = 40; 

// �׳� ROLLBACK �ϸ� 60�� �μ� �����
--ROLLBACK;

// COMMIT �� ROLLBACK �ϸ� �Ȼ����.
COMMIT;
ROLLBACK;
//----------------------------------------------------------------------------------
// Index
-- **����Ŭ ���� ����**
-- 1. SQL �Ľ� : SQL ������ ������ �ִ���, SQL ���� ��� ��ü(���̺�, ��) ���� ���� �˻�
-- 2. SQL ����ȭ(�����ȹ) : SQL�� ����Ǵ� �� �ʿ��� ���(COST) ���
-- 3. SQL ���� : ������ ���� ��ȹ�� ���� ������ ����

--- �ε��� ����ϱ� �� ����
--    - �ε����� ����ϱ� ������ �˻� ������ ��뷮 �����Ϳ� �־ �����ϰ� ������. ��ü�� FULL SCAN �ϱ� �����̴�.
--    - �˻� �ӵ��� �����ϰ� ������� ���Ѵ�.

--- �ε��� �����ϸ�
--    - �ش� �÷��� ���� indexing���� ROWID�� �����Ѵ�.
--    - �ε����ε� �÷����� ROWID�� ������ LEAF BLOCKS, 
--    �� �����͸� ���� BRANCH BLOCKS���� ������.
--    - B*Tree ������ balance�� �����Ѵ�.
--    - ����Ŭ�� �ε����� ROWID �ּҸ� ������ ���ϴ� ���̺��� �����͸� ������ �� �ִ�. B*TREE ������ �����.
--    - �ε����� ����ϸ� ���� ū ������ ������ �˻� �ӵ��� ������ �� �ְ� ���ش�.

--- ORACLE���� �ε��� ����
--    - PRIMARY KEY, UNIQUE ���� �÷��� �⺻������ �ε����� �ڵ����� �����ȴ�.
--    - CREATE INDEX �ε�����

--- �ε����� �����ؾ� �ϴ� ���
--    - WHERE��, JOIN �������� ���� ����ϴ� �÷�
--    - ��� ���� �÷� ������ UNIQUE
--    - ���� ������ ���� ���� �÷�
--    - ���� �幰�� �����ϴ� �÷�

// �ε��� ����
// 1. ������ �����
CREATE SEQUENCE board_seq;

// ������ �߰�
INSERT INTO board VALUES(board_seq.nextval, 'a1', 'a', 'a', sysdate, 0);

// ���� �� ���� ������ 2��� �þ��.
INSERT INTO board(seq, title, writer, contents, regdate, hitcount)
	(select board_seq.nextval, title, writer, contents, regdate, hitcount FROM board);
    
// �˻�
// F10 ���� Ȯ�� --> ��� �ּ� ��
SELECT * FROM board
	WHERE seq = 50001;

// �������� ����
ALTER TABLE board
	ADD CONSTRAINT board_seq_pk PRIMARY KEY(seq);

// �˻�
// F10 ���� Ȯ�� --> ��� �ּ� ��
SELECT * FROM board
	WHERE seq = 50001;



//### ����
// - ��title���� ���� �۹�ȣ(seq) 10000���� ���ؼ� title ���� ��a10000������ �����ϰ� ��a10000���� �˻� �� ���� ��ȹ�� Ȯ�� �� full san
�ε����� �����ϰ� �ٽ� �˻� �� �� index scan

UPDATE board SET title = 'a10000' WHERE seq = 10000;

SELECT * FROM board
    WHERE title = 'a10000';

CREATE INDEX scan ON board(title);


SELECT * FROM board
    WHERE title = 'a10000';

DROP INDEX �ε����̸�;

drop table board;

// 4) View
//- ������ ���ο� ���� ���� SQL�� �ܼ�ȭ(�߻�ȭ)
//- �������� ���鿡���� ���
//- mission
// hr> ������ ������ ������ �ʿ��� sql�� �� View�μ� �ܼ�ȭ ��Ű��

// ���� ������ ���� �ڵ�
SELECT s1.sno, s1.sname, grade FROM student s1 
	JOIN score s2 ON s1.sno = s2.sno 
	JOIN course c ON s2.cno = c.cno 
	JOIN scgrade ON result BETWEEN loscore AND hiscore WHERE cname = '�Ϲ�ȭ��'
AND grade > (SELECT grade FROM student s1 JOIN score s2 ON s1.sno = s2.sno JOIN course c ON s2.cno = c.cno JOIN scgrade ON result BETWEEN loscore AND hiscore WHERE sname = '����' AND cname = '�Ϲ�ȭ��');

// VIEW�� �ܼ�ȭ ��Ű�� ����
CREATE OR REPLACE VIEW hjcode_vw AS
	SELECT s1.sno, s1.sname, grade FROM student s1 
	JOIN score s2 ON s1.sno = s2.sno 
	JOIN course c ON s2.cno = c.cno 
	JOIN scgrade ON result BETWEEN loscore AND hiscore WHERE cname = '�Ϲ�ȭ��'
AND grade > (SELECT grade FROM student s1 JOIN score s2 ON s1.sno = s2.sno JOIN course c ON s2.cno = c.cno JOIN scgrade ON result BETWEEN loscore AND hiscore WHERE sname = '����' AND cname = '�Ϲ�ȭ��');

// �ܼ�ȭ �� VIEW ����
SELECT * FROM hjcode_vw;

// mission
//hr > employees ���̺��� salary�� ������ �������� View�� �����غ���.
// VIEW�� �ܼ�ȭ ��Ű�� ����
CREATE OR REPLACE VIEW employees_except_sal_vw AS
	SELECT employee_id, first_name, last_name, email, phone_number,
	hire_date, job_id, commission_pct, manager_id, department_id 
		FROM employees;

// �ܼ�ȭ �� VIEW ����
SELECT * FROM employees_except_sal_vw ;
