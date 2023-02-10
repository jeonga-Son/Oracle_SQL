// 그룹함수
// sum(), avg(), max(), count()
// 특히 count(*)는 해당하는 컬럼의 row를 구하고 싶을 때 많이 사용한다.
SELECT sum(salary) FROM employees;

// GRUOP BY 절
// 부서별로 평균 급여를 검색하라.
// 주의사항 : SELECT절 컬럼 내역은 반드시 그룹함수 또는 GROUP BY 절에서 사용한 컬럼을 사용해야 됨.
// 만약 last_name을 사용한다면 그룹함수가 아닌 개인이기 때문에 오류가 뜬다.
SELECT department_id, avg(salary)
	FROM employees
	GROUP BY department_id;

// 퀴즈
// hr> 부서별로 사원의 수와 커미션을 받는 사원의 수를 검색하라.
SELECT department_id, count(*), count(commission_pct)
	FROM employees
	GROUP BY department_id
	ORDER BY department_id;
	
// mission kosa01 -1
//1. 화학과 학년 별 평균 학점을 검색하라.
SELECT syear, major, avg(avr) 
    FROM student
    WHERE major = '화학'
    GROUP BY major, syear;

//2. 각 학과별 학생수를 검색하라.
SELECT MAJOR, COUNT(*)
    FROM STUDENT
    GROUP BY MAJOR;

//3. 화학과 생물학과 학생을 4.5환산 학점의 평균을 각각 검색하라.
SELECT major, avg(avr*4.5/4.0)
    FROM student
    WHERE major IN('화학', '생물')
    GROUP BY major;

// HAVING절
//- 전체 그룹에서 일부 그룹만 추출하기 위해
// 부서별 급여 평균이 5000 미만의 부서의 평균 급여를 검색하라.
SELECT department_id, AVG(salary) 
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary) < 5000;
	
// mission kosa01 -2    
// 1. 화학과를 제외한 학생들의 과별 평점 평균을 검색하라.
SELECT major, ROUND(AVG(avr), 2)
    FROM student
    GROUP BY major
    HAVING major != '화학';

// 2. 화학과를 제외한 각 학과별 평점 중에 평점이 2.0 이상 학과 정보를 검색하라.
SELECT major,  ROUND(AVG(avr), 2)
    FROM student
    GROUP BY major
    HAVING AVG(avr) >= 2.0 
    AND NOT major = '화학';

// 3. 근무중인 직원 3명 이상인 부서를 검색하라.(emp)
SELECT dno, COUNT(*) 
    FROM emp
    GROUP BY dno
    HAVING COUNT(*) >= 3;
    

// 문자함수
// - LOWER() → 소문자로 변환
// - UPPER() → 대문자로 변환
SELECT 'DataBase', LOWER('DataBase') FROM dual; 

// - SUBSTR(문자열, 인덱스(1부터), 문자수)
// - BSTR(문자열, 인덱스(1부터)) ⇒ 이렇게만 할 수도 있다.
// - SUBSTR(문자열, 인덱스(1부터/ 음수)) ⇒ 음수도 가능하다.
SELECT SUBSTR('abcdefg', 2, 4) FROM dual;

// - LPAD(), RPAD()
SELECT 'Oracle', LPAD('Oracle', 10, '#') FROM dual;

// - 퀴즈
// - kosa01> 과목명 마지막 글자를 제외하고 출력하라.(course : cname)  
SELECT cname, 
    SUBSTR(cname, 1, Length(cname) - 1)
    FROM course;
    
//3) 숫자함수
// - MOD(10, 3)
// - ROUND(3432.43432, 2)

// 4) 날짜함수
//- SYSDATE ⇒ 현재시간을 리턴하는 함수
SELECT SYSDATE -1 “어제”, SYSDATE “오늘”, SYSDATE +1 “내일” FROM dual;

//- 퀴즈
// hr > 사원의 근속년을 출력하라. ex) 10.5년 employees : hire_date
SELECT last_name, ROUND((SYSDATE - hire_date)/365, 1) || '년'
    FROM employees;
    
// 5) 변환함수
// - TO_CHAR() : 숫자, 날짜 ⇒ 문자열 변환
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 
	TO_CHAR(50000000, '$999,999,999') FROM dual;
    
// - TO_DATE() : 문자열 ⇒ 날짜 데이터 변환
SELECT TO_DATE('2023-02-10', 'YYYY/MM/DD'),
	TO_DATE('20230211', 'YYYY-MM-DD') FROM dual; 
    
// - NVL : NULL을 0또는 기타 default 값으로 변환
SELECT employee_id, salary, NVL(commission_pct, 0) 
	FROM employees;
    
// - NVL2
SELECT employee_id, salary, NVL2(commission_pct, 'O', 'X') 
	FROM employees;
    
// - 퀴즈
//- 2007년도에 입사한 사원의 목록    
SELECT * FROM employees
	WHERE TO_CHAR(hire_date, 'YYYY') = '2007';
    
//6) DECODE 함수 
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

// - 테이블 복사(구조 + 데이터)   
// 구조와 데이터값이 모두 emp01로 복사된다.
CREATE TABLE emp01 AS SELECT * FROM employees;

// - 테이블 복사(구조)
// 구조만 emp02로 복사된다.
CREATE TABLE emp02 AS SELECT * FROM employees WHERE 1 = 0;

//- 테이블 구조 수정
// 컬럼추가
ALTER TABLE emp02
	ADD(job VARCHAR2(50));
    
//- 컬럼 수정
ALTER TABLE emp02
    MODIFY(job VARCHAR2(100));
    
// -컬럼 삭제
ALTER TABLE emp02
    DROP COLUMN jab;
    
// - 테이블 데이터 삭제
// DML(트랜잭션 대상, ROLLBACK 가능)
DELETE FROM emp01;
// DDL(트랜잭션 대상X)
TRUNCATE TABLE emp01;

//- 테이블 삭제
DROP TABLE emp02;

// -퀴즈1
//1. departments 테이블로부터 구조와 데이터를 dept01에 복사하자.
CREATE TABLE dept01 AS SELECT * FROM DEPARTMENTS;

//2. INSERT(데이터 추가)
INSERT INTO dept01 VALUES(300, 'Developer', 100, 10);
INSERT INTO dept01(department_id, department_name)
	VALUES(400, 'Sales');
    
//3. UPDATE(데이터 수정)
UPDATE dept01 SET department_name='IT Service'
	WHERE department_id = 300;

// - 퀴즈2
// hr> emp01 테이블에서 salary 3000 이상 대상자에게 salary 10% 인상을 하자.
CREATE TABLE emp01 AS SELECT * FROM employees; 
UPDATE emp01 SET salary = salary * 1.1
    WHERE salary >= 3000;

// 데이터 삭제(DELETE)
// DELETE FROM 테이블 WHERE 삭제대상
// hr>dept01 테이블에서 부서이름이 ‘IT Service’ 값을 가진 로우를 삭제
DELETE FROM dept01 WHERE department_name = 'IT Service';

// 9) 제약조건
//- 데이터베이스 구축(모델링) 필수
//- 데이터 추가, 수정, 삭제 가운데 DB 무결성 유지(보장)

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
--INSERT INTO emp03 VALUES(100, 'park' 'IT', 30); // 두 번째는 안들어감.

--CREATE TABLE emp04(
--    empno NUMBER PRIMARY KEY,
--    ename VARCHAR2(20) NOT NULL,
--    job VARCHAR2(20),
--    deptno NUMBER
--)

--INSERT INTO emp04 VALUES(100, 'park', 'IT', 3000);

// FOREIGN KEY(외래키)
--CREATE TABLE emp05(
--	empno NUMBER PRIMARY KEY,
--	ename VARCHAR2(20) NOT NULL,
--	job VARCHAR2(20),
--	deptno NUMBER REFERENCES departments(department_id)
--)

// 값이 들어가지 않는다.
--INSERT INTO emp05 VALUES(100, 'park', 'IT', 3000);

// 테이블 레벨 방식 → 제약조건 이름을 명시
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

// - 테이블 수정 방식
// - 이미 테이블을 만들고 나서는 테이블의 구조를 변경한다.
// - ALTER TABLE emp07 제약조건~
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

// NOT NULL은 MODIFY이다.
--ALTER TABLE emp07
--	MODIFY ename CONSTRAINT emp07_ename_nn NOT NULL;

--CREATE TABLE emp08(
--	empno NUMBER,
--	ename VARCHAR2(20),
--	job VARCHAR2(20),
--	deptno NUMBER
--)

// 한번에 제약조건 추가
--ALTER TABLE emp08
--	ADD CONSTRAINT emp08_empno_pk PRIMARY KEY(empno)
--	ADD CONSTRAINT emp08_deptno_fk FOREIGN KEY(deptno)
--	REFERENCES departments(department_id)
--	MODIFY ename CONSTRAINT emp08_ename_nn NOT NULL;

//- 체크 제약조건
--CREATE TABLE emp09(
--	empno NUMBER,
--	ename VARCHAR2(20),
--	job VARCHAR2(20),
--	deptno NUMBER,
--	gender CHAR(1) CHECK(gender IN('M','F'))
--)

// A는 데이터값에 못들어감
--INSERT INTO emp09 VALUES(100, 'park', 'IT', 3000, 'A');
// 데이터 값 들어감
--INSERT INTO emp09 VALUES(100, 'park', 'IT', 3000, 'F');

// - DEFAULT 제약조건
--CREATE TABLE emp10(
--	empno NUMBER,
--	ename VARCHAR2(20),
--	job VARCHAR2(20),
--	deptno NUMBER,
--	local VARCHAR2(20) DEFAULT 'Seoul'
--)

--INSERT INTO emp10 (empno, ename, job, deptno)
--	VALUES(100, 'kim', 'IT', 30);

// - 2개 이상 식별자 설정
// 먼저 테이블을 생성하고 (테이블 생성시 프라이머리 키 2개는 안됨.)
--CREATE TABLE emp12(
--	empno NUMBER,
--	ename VARCHAR2(20),
--	job VARCHAR2(20),
--	deptno NUMBER
--)

// 이렇게 하면 프라이머리 키 2개 됨.
--ALTER TABLE emp12
--	ADD CONSTRAINT emp12_empno_ename_pk PRIMARY KEY(empno, ename);
    
--INSERT INTO emp12 VALUES(100, 'kim', 'IT', 20);
--INSERT INTO emp12 VALUES(100, 'park', 'IT', 20);

// - 퀴즈
// - 1)dept 테이블의 department_id 기본키(PRIMARY KEY) 제약조건을 구현
// - 2)emp13 테이블의 deptno 컬럼이 dept01 테이블의 department_id를 참조하도록 구현하자. 
// (테이블 수정 방식)

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

// 퀴즈 -2
// 제약조건과제
// 1. 회원 정보를 저장하는 테이블을 MEMBER란 이름으로 생성한다.
// 주키만 테이블 수정 방식으로
--CREATE TABLE member(
--    id VARCHAR2(20),
--    name VARCHAR2(20) NOT NULL,
--    regno VARCHAR2(13) UNIQUE,
--    hp VARCHAR2(13),
--    address VARCHAR2(100)
--)

--ALTER TABLE MEMBER
--    ADD CONSTRAINT member_id_pk PRIMARY KEY(ID);

--// 2.도서정보를 저장하는 테이블 BOOK이라는 이름을 생성한다.
--CREATE TABLE book(
--    code NUMBER(4),
--    title VARCHAR2(50) NOT NULL,
--    count NUMBER(6),
--    price NUMBER(10),
--    publish VARCHAR2(50)
--)

--ALTER TABLE book
--    ADD CONSTRAINT book_code_pk PRIMARY KEY(code);

--// 3. 회원이 책을 주문하였을 때 이에 대한 정보를 저장하는 테이블 이름은 ORDER2로한다.
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

--INSERT INTO BOOK VALUES(1, '모험일지', 3, 10000, 'hhw');
--INSERT INTO MEMBER VALUES('001', 'HHW', '931028', '1038411326', '파주');
--INSERT INTO ORDER2 VALUES('1', '001', 1, 1, '20/02/26');

// 제약조건과제 2
// 퀴즈 -3
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

