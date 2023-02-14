// 1) Transaction(트랜잭션)
// - 전체 일처리가 완결 되어야만 의미가 있는 경우
// - 전체 성공 : commit / 실패 : rollback(전체 작업 취소)

// TRANSACTION 연습 문제
CREATE TABLE dept_tcl
    AS SELECT * FROM dept;
    
// 60번 부서로 임의의 데이터 입력
INSERT INTO dept_tcl VALUES(60, 'Database', '서울', 1111);

// Update => 40번 부서의 loc => '대구'로 수정
Update dept_tcl SET loc = '대구' WHERE dno = 40; 

// 그냥 ROLLBACK 하면 60번 부서 사라짐
--ROLLBACK;

// COMMIT 후 ROLLBACK 하면 안사라짐.
COMMIT;
ROLLBACK;
//----------------------------------------------------------------------------------
// Index
-- **오라클 실행 과정**
-- 1. SQL 파싱 : SQL 구문에 오류가 있는지, SQL 실행 대상 객체(테이블, 뷰) 존재 여부 검사
-- 2. SQL 최적화(실행계획) : SQL이 실행되는 데 필요한 비용(COST) 계산
-- 3. SQL 실행 : 세워진 실행 계획을 통해 물리적 실행

--- 인덱스 사용하기 전 단점
--    - 인덱스를 사용하기 전에는 검색 성능이 대용량 데이터에 있어서 현저하게 느리다. 전체를 FULL SCAN 하기 때문이다.
--    - 검색 속도가 일정하게 보장되지 못한다.

--- 인덱스 생성하면
--    - 해당 컬럼에 대한 indexing으로 ROWID를 생성한다.
--    - 인덱스로된 컬럼값과 ROWID로 구성된 LEAF BLOCKS, 
--    그 포인터를 갖는 BRANCH BLOCKS으로 나뉜다.
--    - B*Tree 구조로 balance를 유지한다.
--    - 오라클은 인덱스의 ROWID 주소를 가지고 원하는 테이블의 데이터를 접근할 수 있다. B*TREE 구조로 만든다.
--    - 인덱스를 사용하면 가장 큰 장점은 일정한 검색 속도를 유지할 수 있게 해준다.

--- ORACLE에서 인덱스 생성
--    - PRIMARY KEY, UNIQUE 갖는 컬럼은 기본적으로 인덱스가 자동으로 생성된다.
--    - CREATE INDEX 인덱스명

--- 인덱스를 생성해야 하는 경우
--    - WHERE절, JOIN 조건으로 자주 사용하는 컬럼
--    - 모든 값이 컬럼 내에서 UNIQUE
--    - 넓은 범위의 값을 가진 컬럼
--    - 아주 드물게 존재하는 컬럼

// 인덱스 예제
// 1. 시퀀스 만들기
CREATE SEQUENCE board_seq;

// 데이터 추가
INSERT INTO board VALUES(board_seq.nextval, 'a1', 'a', 'a', sysdate, 0);

// 넣을 때 마다 데이터 2배로 늘어난다.
INSERT INTO board(seq, title, writer, contents, regdate, hitcount)
	(select board_seq.nextval, title, writer, contents, regdate, hitcount FROM board);
    
// 검색
// F10 으로 확인 --> 모두 주석 후
SELECT * FROM board
	WHERE seq = 50001;

// 제약조건 생성
ALTER TABLE board
	ADD CONSTRAINT board_seq_pk PRIMARY KEY(seq);

// 검색
// F10 으로 확인 --> 모두 주석 후
SELECT * FROM board
	WHERE seq = 50001;



//### 퀴즈
// - ‘title’에 대한 글번호(seq) 10000번에 대해서 title 값을 ‘a10000’으로 수정하고 ‘a10000’을 검색 후 실행 계획을 확인 ⇒ full san
인덱스를 생성하고 다시 검색 후 ⇒ index scan

UPDATE board SET title = 'a10000' WHERE seq = 10000;

SELECT * FROM board
    WHERE title = 'a10000';

CREATE INDEX scan ON board(title);


SELECT * FROM board
    WHERE title = 'a10000';

DROP INDEX 인덱스이름;

drop table board;

// 4) View
//- 과도한 조인에 대한 인한 SQL을 단순화(추상화)
//- 보안적인 측면에서의 대안
//- mission
// hr> 기존에 과도한 조인이 필요한 sql을 ⇒ View로서 단순화 시키기

// 기존 과도한 조인 코드
SELECT s1.sno, s1.sname, grade FROM student s1 
	JOIN score s2 ON s1.sno = s2.sno 
	JOIN course c ON s2.cno = c.cno 
	JOIN scgrade ON result BETWEEN loscore AND hiscore WHERE cname = '일반화학'
AND grade > (SELECT grade FROM student s1 JOIN score s2 ON s1.sno = s2.sno JOIN course c ON s2.cno = c.cno JOIN scgrade ON result BETWEEN loscore AND hiscore WHERE sname = '관우' AND cname = '일반화학');

// VIEW로 단순화 시키는 과정
CREATE OR REPLACE VIEW hjcode_vw AS
	SELECT s1.sno, s1.sname, grade FROM student s1 
	JOIN score s2 ON s1.sno = s2.sno 
	JOIN course c ON s2.cno = c.cno 
	JOIN scgrade ON result BETWEEN loscore AND hiscore WHERE cname = '일반화학'
AND grade > (SELECT grade FROM student s1 JOIN score s2 ON s1.sno = s2.sno JOIN course c ON s2.cno = c.cno JOIN scgrade ON result BETWEEN loscore AND hiscore WHERE sname = '관우' AND cname = '일반화학');

// 단순화 된 VIEW 보기
SELECT * FROM hjcode_vw;

// mission
//hr > employees 테이블에서 salary를 제외한 내용으로 View를 구현해보자.
// VIEW로 단순화 시키는 과정
CREATE OR REPLACE VIEW employees_except_sal_vw AS
	SELECT employee_id, first_name, last_name, email, phone_number,
	hire_date, job_id, commission_pct, manager_id, department_id 
		FROM employees;

// 단순화 된 VIEW 보기
SELECT * FROM employees_except_sal_vw ;
