// �׷��Լ�
// sum(), avg(), max(), count()
// Ư�� count(*)�� �ش��ϴ� �÷��� row�� ���ϰ� ���� �� ���� ����Ѵ�.
SELECT sum(salary) FROM employees;

// GRUOP BY ��
// �μ����� ��� �޿��� �˻��϶�.
// ���ǻ��� : SELECT�� �÷� ������ �ݵ�� �׷��Լ� �Ǵ� GROUP BY ������ ����� �÷��� ����ؾ� ��.
// ���� last_name�� ����Ѵٸ� �׷��Լ��� �ƴ� �����̱� ������ ������ ���.
SELECT department_id, avg(salary)
	FROM employees
	GROUP BY department_id;

// ����
// hr> �μ����� ����� ���� Ŀ�̼��� �޴� ����� ���� �˻��϶�.
SELECT department_id, count(*), count(commission_pct)
	FROM employees
	GROUP BY department_id
	ORDER BY department_id;
	
// mission kosa01 -1
//1. ȭ�а� �г� �� ��� ������ �˻��϶�.
SELECT syear, major, avg(avr) 
    FROM student
    WHERE major = 'ȭ��'
    GROUP BY major, syear;

//2. �� �а��� �л����� �˻��϶�.
SELECT MAJOR, COUNT(*)
    FROM STUDENT
    GROUP BY MAJOR;

//3. ȭ�а� �����а� �л��� 4.5ȯ�� ������ ����� ���� �˻��϶�.
SELECT major, avg(avr*4.5/4.0)
    FROM student
    WHERE major IN('ȭ��', '����')
    GROUP BY major;

// HAVING��
//- ��ü �׷쿡�� �Ϻ� �׷츸 �����ϱ� ����
// �μ��� �޿� ����� 5000 �̸��� �μ��� ��� �޿��� �˻��϶�.
SELECT department_id, AVG(salary) 
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary) < 5000;
	
// mission kosa01 -2    
// 1. ȭ�а��� ������ �л����� ���� ���� ����� �˻��϶�.
SELECT major, ROUND(AVG(avr), 2)
    FROM student
    GROUP BY major
    HAVING major != 'ȭ��';

// 2. ȭ�а��� ������ �� �а��� ���� �߿� ������ 2.0 �̻� �а� ������ �˻��϶�.
SELECT major,  ROUND(AVG(avr), 2)
    FROM student
    GROUP BY major
    HAVING AVG(avr) >= 2.0 
    AND NOT major = 'ȭ��';

// 3. �ٹ����� ���� 3�� �̻��� �μ��� �˻��϶�.(emp)
SELECT dno, COUNT(*) 
    FROM emp
    GROUP BY dno
    HAVING COUNT(*) >= 3;
    

// �����Լ�
// - LOWER() �� �ҹ��ڷ� ��ȯ
// - UPPER() �� �빮�ڷ� ��ȯ
SELECT 'DataBase', LOWER('DataBase') FROM dual; 

// - SUBSTR(���ڿ�, �ε���(1����), ���ڼ�)
// - BSTR(���ڿ�, �ε���(1����)) �� �̷��Ը� �� ���� �ִ�.
// - SUBSTR(���ڿ�, �ε���(1����/ ����)) �� ������ �����ϴ�.
SELECT SUBSTR('abcdefg', 2, 4) FROM dual;

// - LPAD(), RPAD()
SELECT 'Oracle', LPAD('Oracle', 10, '#') FROM dual;

// - ����
// - kosa01> ����� ������ ���ڸ� �����ϰ� ����϶�.(course : cname)  
SELECT cname, 
    SUBSTR(cname, 1, Length(cname) - 1)
    FROM course;
    
//3) �����Լ�
// - MOD(10, 3)
// - ROUND(3432.43432, 2)

// 4) ��¥�Լ�
//- SYSDATE �� ����ð��� �����ϴ� �Լ�
SELECT SYSDATE -1 ��������, SYSDATE �����á�, SYSDATE +1 �����ϡ� FROM dual;

//- ����
// hr > ����� �ټӳ��� ����϶�. ex) 10.5�� employees : hire_date
SELECT last_name, ROUND((SYSDATE - hire_date)/365, 1) || '��'
    FROM employees;
    
// 5) ��ȯ�Լ�
// - TO_CHAR() : ����, ��¥ �� ���ڿ� ��ȯ
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 
	TO_CHAR(50000000, '$999,999,999') FROM dual;
    
// - TO_DATE() : ���ڿ� �� ��¥ ������ ��ȯ
SELECT TO_DATE('2023-02-10', 'YYYY/MM/DD'),
	TO_DATE('20230211', 'YYYY-MM-DD') FROM dual; 
    
// - NVL : NULL�� 0�Ǵ� ��Ÿ default ������ ��ȯ
SELECT employee_id, salary, NVL(commission_pct, 0) 
	FROM employees;
    
// - NVL2
SELECT employee_id, salary, NVL2(commission_pct, 'O', 'X') 
	FROM employees;
    
// - ����
//- 2007�⵵�� �Ի��� ����� ���    
SELECT * FROM employees
	WHERE TO_CHAR(hire_date, 'YYYY') = '2007';
    
//6) DECODE �Լ� 
SELECT job_id, DECODE(job_id, 'SA_MAN', 'Salses Dept',
    'SH_CLEARK', 'Sales Dept', 'Another') FROM employees;
    
//7) CASE WHEN
SELECT job_id,
	CASE job_id
		WHEN 'SA_MAN' THEN 'Sales Dept2'
		WHEN 'SH_CLEARK' THEN 'Sales Dept2'
		ELSE 'Another2'
	END "CASE"
	FROM employees;

// - ���̺� ����(���� + ������)   
// ������ �����Ͱ��� ��� emp01�� ����ȴ�.
CREATE TABLE emp01 AS SELECT * FROM employees;

// - ���̺� ����(����)
// ������ emp02�� ����ȴ�.
CREATE TABLE emp02 AS SELECT * FROM employees WHERE 1 = 0;

//- ���̺� ���� ����
// �÷��߰�
ALTER TABLE emp02
	ADD(job VARCHAR2(50));
    
//- �÷� ����
ALTER TABLE emp02
    MODIFY(job VARCHAR2(100));
    
// -�÷� ����
ALTER TABLE emp02
    DROP COLUMN jab;
    
// - ���̺� ������ ����
// DML(Ʈ����� ���, ROLLBACK ����)
DELETE FROM emp01;
// DDL(Ʈ����� ���X)
TRUNCATE TABLE emp01;

//- ���̺� ����
DROP TABLE emp02;

// -����1
//1. departments ���̺�κ��� ������ �����͸� dept01�� ��������.
CREATE TABLE dept01 AS SELECT * FROM DEPARTMENTS;

//2. INSERT(������ �߰�)
INSERT INTO dept01 VALUES(300, 'Developer', 100, 10);
INSERT INTO dept01(department_id, department_name)
	VALUES(400, 'Sales');
    
//3. UPDATE(������ ����)
UPDATE dept01 SET department_name='IT Service'
	WHERE department_id = 300;

// - ����2
// hr> emp01 ���̺��� salary 3000 �̻� ����ڿ��� salary 10% �λ��� ����.
CREATE TABLE emp01 AS SELECT * FROM employees; 
UPDATE emp01 SET salary = salary * 1.1
    WHERE salary >= 3000;

// ������ ����(DELETE)
// DELETE FROM ���̺� WHERE �������
// hr>dept01 ���̺��� �μ��̸��� ��IT Service�� ���� ���� �ο츦 ����
DELETE FROM dept01 WHERE department_name = 'IT Service';

// 9) ��������
//- �����ͺ��̽� ����(�𵨸�) �ʼ�
//- ������ �߰�, ����, ���� ��� DB ���Ἲ ����(����)

--CREATE TABLE emp01(
--    empno NUMBER,
--    ename VARCHAR2(20),
--    job VARCHAR2(20),
--    deptno NUMBER
--)
--
--CREATE TABLE dept01 AS SELECT * FROM DEPARTMENTS;
--
--INSERT INTO emp01 VALUES(null, null, 'IT', 30);
--
--CREATE TABLE emp02(
--    empno NUMBER NOT NULL,
--    ename VARCHAR2(20) NOT NULL,
--    job VARCHAR2(20),
--    deptno NUMBER
--)
--
--INSERT INTO emp02 VALUES(null, null, 'IT', 30);
--
--INSERT INTO emp02 VALUES(100, 'kim', 'IT', 30);
--INSERT INTO emp02 VALUES(100, 'park' 'IT', 30);
--
--CREATE TABLE emp03(
--	empno NUMBER UNIQUE,
--	ename VARCHAR2(20) NOT NULL,
--	job VARCHAR2(20),
--	deptno NUMBER
--)
--
--INSERT INTO emp03 VALUES(100, 'kim', 'IT', 30);
--INSERT INTO emp03 VALUES(100, 'park' 'IT', 30); // �� ��°�� �ȵ�.

--CREATE TABLE emp04(
--    empno NUMBER PRIMARY KEY,
--    ename VARCHAR2(20) NOT NULL,
--    job VARCHAR2(20),
--    deptno NUMBER
--)

--INSERT INTO emp04 VALUES(100, 'park', 'IT', 3000);

// FOREIGN KEY(�ܷ�Ű)
--CREATE TABLE emp05(
--	empno NUMBER PRIMARY KEY,
--	ename VARCHAR2(20) NOT NULL,
--	job VARCHAR2(20),
--	deptno NUMBER REFERENCES departments(department_id)
--)

// ���� ���� �ʴ´�.
--INSERT INTO emp05 VALUES(100, 'park', 'IT', 3000);

// ���̺� ���� ��� �� �������� �̸��� ���
--CREATE TABLE emp06(
--	empno NUMBER,
--	ename VARCHAR2(20) NOT NULL,
--	job VARCHAR2(20),
--	deptno NUMBER,
--	
--	CONSTRAINT emp06_empno_pk PRIMARY KEY(empno),
--	CONSTRAINT emp06_deptno_fk
--		FOREIGN KEY(deptno)
--		REFERENCES departments(department_id)
--)

// - ���̺� ���� ���
// - �̹� ���̺��� ����� ������ ���̺��� ������ �����Ѵ�.
// - ALTER TABLE emp07 ��������~
--CREATE TABLE emp07(
--	empno NUMBER,
--	ename VARCHAR2(20),
--	job VARCHAR2(20),
--	deptno NUMBER
--)

--ALTER TABLE emp07
--	ADD CONSTRAINT emp07_empno_pk PRIMARY KEY(empno);


--ALTER TABLE emp07
--	ADD CONSTRAINT emp07_deptno_fk FOREIGN KEY(deptno)
--	REFERENCES departments(department_id);

// NOT NULL�� MODIFY�̴�.
--ALTER TABLE emp07
--	MODIFY ename CONSTRAINT emp07_ename_nn NOT NULL;

--CREATE TABLE emp08(
--	empno NUMBER,
--	ename VARCHAR2(20),
--	job VARCHAR2(20),
--	deptno NUMBER
--)

// �ѹ��� �������� �߰�
--ALTER TABLE emp08
--	ADD CONSTRAINT emp08_empno_pk PRIMARY KEY(empno)
--	ADD CONSTRAINT emp08_deptno_fk FOREIGN KEY(deptno)
--	REFERENCES departments(department_id)
--	MODIFY ename CONSTRAINT emp08_ename_nn NOT NULL;

//- üũ ��������
--CREATE TABLE emp09(
--	empno NUMBER,
--	ename VARCHAR2(20),
--	job VARCHAR2(20),
--	deptno NUMBER,
--	gender CHAR(1) CHECK(gender IN('M','F'))
--)

// A�� �����Ͱ��� ����
--INSERT INTO emp09 VALUES(100, 'park', 'IT', 3000, 'A');
// ������ �� ��
--INSERT INTO emp09 VALUES(100, 'park', 'IT', 3000, 'F');

// - DEFAULT ��������
--CREATE TABLE emp10(
--	empno NUMBER,
--	ename VARCHAR2(20),
--	job VARCHAR2(20),
--	deptno NUMBER,
--	local VARCHAR2(20) DEFAULT 'Seoul'
--)

--INSERT INTO emp10 (empno, ename, job, deptno)
--	VALUES(100, 'kim', 'IT', 30);

// - 2�� �̻� �ĺ��� ����
// ���� ���̺��� �����ϰ� (���̺� ������ �����̸Ӹ� Ű 2���� �ȵ�.)
--CREATE TABLE emp12(
--	empno NUMBER,
--	ename VARCHAR2(20),
--	job VARCHAR2(20),
--	deptno NUMBER
--)

// �̷��� �ϸ� �����̸Ӹ� Ű 2�� ��.
--ALTER TABLE emp12
--	ADD CONSTRAINT emp12_empno_ename_pk PRIMARY KEY(empno, ename);
    
--INSERT INTO emp12 VALUES(100, 'kim', 'IT', 20);
--INSERT INTO emp12 VALUES(100, 'park', 'IT', 20);

// - ����
// - 1)dept ���̺��� department_id �⺻Ű(PRIMARY KEY) ���������� ����
// - 2)emp13 ���̺��� deptno �÷��� dept01 ���̺��� department_id�� �����ϵ��� ��������. 
// (���̺� ���� ���)

--ALTER TABLE dept01
--	ADD CONSTRAINT dept01_department_id PRIMARY KEY(department_id)
    
--CREATE TABLE emp13(
--	empno NUMBER,
--	ename VARCHAR2(20),
--	job VARCHAR2(20),
--	deptno NUMBER
--)    

--ALTER TABLE emp13
--	ADD CONSTRAINT emp13_empno_pk PRIMARY KEY(empno)
--	ADD CONSTRAINT emp13_deptno_fk FOREIGN KEY(deptno)
--		REFERENCES dept01(department_id)
        
-- INSERT INTO emp13 VALUES(100, 'park', 'IT', 3000)       

--DELETE FROM dept01 WHERE department_id = 30;

--CREATE TABLE emp14(
--	empno NUMBER PRIMARY KEY,
--	ename VARCHAR2(20) NOT NULL,
--	job VARCHAR2(20),
--	deptno NUMBER REFERENCES dept01(department_id)
--		ON DELETE CASCADE
--)

--INSERT INTO emp14 VALUES(100, 'park', 'IT', 20);
--DELETE FROM dept01 WHERE department_id = 20;

// ���� -2
// �������ǰ���
// 1. ȸ�� ������ �����ϴ� ���̺��� MEMBER�� �̸����� �����Ѵ�.
// ��Ű�� ���̺� ���� �������
--CREATE TABLE member(
--    id VARCHAR2(20),
--    name VARCHAR2(20) NOT NULL,
--    regno VARCHAR2(13) UNIQUE,
--    hp VARCHAR2(13),
--    address VARCHAR2(100)
--)

--ALTER TABLE MEMBER
--    ADD CONSTRAINT member_id_pk PRIMARY KEY(ID);

--// 2.���������� �����ϴ� ���̺� BOOK�̶�� �̸��� �����Ѵ�.
--CREATE TABLE book(
--    code NUMBER(4),
--    title VARCHAR2(50) NOT NULL,
--    count NUMBER(6),
--    price NUMBER(10),
--    publish VARCHAR2(50)
--)

--ALTER TABLE book
--    ADD CONSTRAINT book_code_pk PRIMARY KEY(code);

--// 3. ȸ���� å�� �ֹ��Ͽ��� �� �̿� ���� ������ �����ϴ� ���̺� �̸��� ORDER2���Ѵ�.
--CREATE TABLE order2(
--    no VARCHAR2(10),
--    id VARCHAR2(20),
--    code NUMBER(4),
--    count NUMBER(6),
--    dr_date DATE
--)

--ALTER TABLE order2
--    ADD CONSTRAINT order2_no_pk PRIMARY KEY(no);
    
--ALTER TABLE order2
--    ADD CONSTRAINT order2_id_fk FOREIGN KEY(id) REFERENCES member(ID);

--ALTER TABLE order2
--    ADD CONSTRAINT order2_code_fk FOREIGN KEY(code) REFERENCES book(code);

--INSERT INTO BOOK VALUES(1, '��������', 3, 10000, 'hhw');
--INSERT INTO MEMBER VALUES('001', 'HHW', '931028', '1038411326', '����');
--INSERT INTO ORDER2 VALUES('1', '001', 1, 1, '20/02/26');

// �������ǰ��� 2
// ���� -3
--CREATE TABLE DEPT_CONST ( 
--   DEPTNO NUMBER(2)    CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY, 
--   DNAME  VARCHAR2(14) CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE, 
--   LOC    VARCHAR2(13) CONSTRAINT DEPTCONST_LOC_NN NOT NULL 
--);

--CREATE TABLE EMP_CONST ( 
--   EMPNO    NUMBER(4) CONSTRAINT EMPCONST_EMPNO_PK PRIMARY KEY, 
--   ENAME    VARCHAR2(10) CONSTRAINT EMPCONST_ENAME_NN NOT NULL, 
--   JOB      VARCHAR2(9), 
--   TEL      VARCHAR2(20) CONSTRAINT EMPCONST_TEL_UNQ UNIQUE, 
--   HIREDATE DATE, 
--   SAL      NUMBER(7, 2) CONSTRAINT EMPCONST_SAL_CHK CHECK (SAL BETWEEN 1000 AND 9999), 
--   COMM     NUMBER(7, 2), 
--   DEPTNO   NUMBER(2) CONSTRAINT EMPCONST_DEPTNO_FK REFERENCES DEPT_CONST (DEPTNO) 
--); 

--SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE 
--    FROM USER_CONSTRAINTS 
--    WHERE TABLE_NAME IN ( 'EMP_CONST', 'DEPT_CONST' ) 
--ORDER BY CONSTRAINT_NAME; 

