// 1) 조인(JOIN)
// - 2개 이상의 테이블에서 데이터를 검색하기 위해
// - 문제1>’King’의 부서이름을 출력하라
--SELECT employee_id, department_id
--	FROM employees
--	WHERE last_name = 'King';
--
--SELECT department_id, department_name
--	FROM departments
--	WHERE department_id IN(80, 90);

//- 조인 이용 방법
//    - 내가 원하는 데이터는 무엇인가? (컬럼목록)
//    - 원하는 데이터가 어느 테이블에 있는가?
//    - 여러 테이블에 있다면 각각의 테이블의 공통컬럼을 찾는다.
--SELECT e.employee_id, e.department_id, d.department_name
--	FROM employees e, departments d
--	WHERE e.department_id = d.department_id
--	AND last_name = 'King';

--// 2) ANSI JOIN
--SELECT e.employee_id, e.department_id, d.department_name
--	FROM employees e INNER JOIN departments d
--	ON e.department_id = d.department_id
--	WHERE last_name = 'King';

// - 퀴즈1
//- hr> 3개 이상 테이블을 조인하여
//- (사원이름, 이메일, 부서번호, 부서이름, 직종번호(job_id), 직종이름(job_title))을 출력해보자.
//- WHERE절과 ANSI JOIN 두가지 방법 모두 해보기.
// WHERE절 방법 
--SELECT e.last_name, e.email, e.department_id, d.department_name, j.job_id, j.job_title
--    FROM employees e, departments d, jobs j
--    WHERE e.department_id = d.department_id
--    AND j.job_id = e.job_id;

// ANSI JOIN 방법
--SELECT e.last_name, e.email, e.department_id, d.department_name, j.job_id, j.job_title
--	FROM employees e INNER JOIN departments d
--    ON e.department_id = d.department_id
--    INNER JOIN jobs j
--    ON e.job_id = j.job_id;

// - 퀴즈2
//- hr> ‘Seattle’ (city)에 근무하는 사원이름, 부서번호, 직종번호, 직종이름, 도시이름 출력해보자. ⇒ (WHERE, ANSI)
// WHERE
--SELECT e.last_name, e.department_id, j.job_id, j.job_title, l.city
--    FROM employees e, departments d, jobs j, locations l
--    WHERE e.department_id = d.department_id
--    AND e.job_id = j.job_id
--    AND d.location_id = l.location_id
--    AND l.city = 'Seattle';

// ANSI JOIN
--SELECT e.last_name, e.department_id, j.job_id, j.job_title, l.city
--    FROM employees e INNER JOIN departments d
--    ON e.department_id = d.department_id
--    INNER JOIN jobs j
--    ON e.job_id = j.job_id
--    INNER JOIN locations l
--    ON d.location_id = l.location_id
--    WHERE l.city = 'Seattle';

// 3) Self JOIN
//- self join은 논리적으로 테이블이 하나 더 있다고 생각하면 됨.
//- 컬럼명이 같다고 공통컬럼이 되는 것이 아님.
//- ‘Kochhar’ 직속상사의 정보를 출력하라.
--SELECT A.last_name || '의 매니저는 '|| B.last_name || ' 이다.'
--	FROM employees A, employees B
--	WHERE A.manager_id = B.employee_id
--	AND A.last_name = 'Kochhar';

// 4) OUTER JOIN (외부조인)
// 매우 많이 씀❗
// - INNER JOIN은 데이터 누락 가능성 있음.
--SELECT * FROM employees; // 107 row 모든 데이터 조회.

// INNER JOIN
// INER JOIN으로 짜면 데이터값 누락 될 수 있음.
// department_id 값이 null인 경우. 데이터 값이 있는 경우만 선택됨.
--SELECT e.employee_id, e.department_id, d.department_name
--	FROM employees e, departments d
--	WHERE e.department_id = d.department_id; // 106 row

// OUTER JOIN
// employees의 데이터 값이 누락되었다.
// 반대에 + 기호를 넣으면 된다.
// 107 ROW
--SELECT e.employee_id, e.department_id, d.department_name
--	FROM employees e, departments d
--	WHERE e.department_id = d.department_id(+);

// ANSI JOIN
// 누락된 방향으로 
// 현재는 왼쪽이 누락됐기 때문에 LEFT JOIN
// 만약 오른쪽 테이블 값이 누락됐다면 RIGHT JOIN
// 107 ROW
SELECT e.employee_id, e.department_id, d.department_name
	FROM employees e LEFT JOIN departments d
	ON e.department_id = d.department_id;
    
// 퀴즈
// 1. 이름이 ‘Himuro’인 사원의 부서명을 출력하라.
SELECT e.last_name, d.department_name
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
    AND e.last_name = 'Himuro';


// 2. 직종명이 'Accountant'인 사원의 이름과 부서명을 출력하라.
SELECT e.last_name, e.department_id, d.department_name, j.job_id
    FROM employees e, departments d, jobs j
    WHERE e.department_id = d.department_id
    AND e.job_id = j.job_id
    AND job_title = 'Accountant';


// 3. 커미션을 받는 사람의 이름과 그가 속한 부서를 출력하라.
SELECT e.last_name, e.commission_pct, d.department_name
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
    AND commission_pct IS NOT NULL;

// 4. 급여가 4000이하인 사원의 이름, 급여, 근무지를 출력하라.
SELECT DISTINCT e.last_name, e.salary, d.location_id, l.city
FROM employees e, departments d, locations l
WHERE d.location_id = l.location_id
and e.salary <= 4000;    

// 5. 'Chen'과 동일한 부서에서 근무하는 사원의 이름을 출력하라.
// 한쪽은 chen 정보만 남겨두고 그리고 나머지 테이블에서 같은 걸 출력
SELECT e.last_name, e.department_id
    FROM employees e, employees a
    WHERE e.department_id = a.department_id
    and a.last_name = 'Chen';

// 5) 서브쿼리(하위질의문)
// - WHERE, HAVING절 → 하위질의문
// - FROM절 하위질의문 → (n-tier : table을 대체)   
// - 문제1
SELECT AVG(salary) FROM employees;    

SELECT last_name, salary
	FROM employees 
	WHERE salary > 6461.831775700934579439252336448598130841;
     
// 서브쿼리
SELECT last_name, salary
	FROM employees
	WHERE salary > (SELECT AVG(salary) FROM employees);

// - 퀴즈 1
//- hr> ‘Chen’ 사원보다 salary를 많이 받는 사원의 목록을 출력하라.
// 1. 서브쿼리 작성
SELECT salary FROM employees
    WHERE last_name = 'Chen'

// 2. 전체 쿼리 작성
SELECT last_name, salary 
    FROM employees
    WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Chen');
    
// 7) 다중컬럼 다중로우
// - 문제 1
//- 직무(job_id)별 최대급여자의 사원내역을출력하라.    
SELECT MAX(salary) FROM employees
	GROUP BY job_id;

// 서브쿼리에서 가져오는 리턴값이 하나가 아니다. 오류남.
// 각 부서별로 최대급여자가 가져와짐.
SELECT employee_id, last_name, salary, job_id
	FROM employees
	WHERE salary = (SELECT MAX(salary) FROM employees
										GROUP BY job_id); 
                                        
//  다중 로우 처리
SELECT employee_id, last_name, salary, job_id
	FROM employees
	WHERE salary IN (SELECT MAX(salary) FROM employees
										GROUP BY job_id);
                                        
//  다중 로우, 다중 컬럼 처리
SELECT employee_id, last_name, salary, job_id
	FROM employees
	WHERE (salary, job_id) IN (SELECT MAX(salary), job_id FROM employees
                                    GROUP BY job_id);
                                    
// - mission 1
//- hr> 부서번호 30번 최대급여자 보다 급여가 높은 사원을 출력하라.     
SELECT MAX(salary) FROM employees WHERE department_id = 30;

SELECT last_name, employee_id, salary
    FROM employees
    WHERE salary > ALL(SELECT salary FROM employees WHERE department_id = 30);

//- hr> 부서번호 30번 최대급여자 보다 급여가 작은 사원을 출력하라.
SELECT MAX(salary) FROM employees WHERE department_id = 30;

SELECT last_name, employee_id, salary
    FROM employees
    WHERE salary < ANY(SELECT salary FROM employees WHERE department_id = 30);
    
       
    
// 9) FROM절 서브쿼리(n-tier)
// - 문제 1
// - 입사순서 오래된 5명을 출력하라.  
SELECT employee_id, last_name, hire_date
	FROM employees
	ORDER BY hire_date; 
    
SELECT ROWNUM, alias.*
	FROM (SELECT employee_id, last_name, hire_date
					FROM employees
					ORDER BY hire_date) alias
	WHERE ROWNUM <= 5;
    
//- 퀴즈 1
//- hr> 급여를 많이 받는 순서 3명의 사원 정보를 출력하라.    
SELECT employee_id, last_name, salary
    FROM employees
    ORDER BY salary DESC;
    
SELECT ROWNUM, alias.*
    FROM (SELECT employee_id, last_name, salary
            FROM employees
            ORDER BY salary DESC) alias
    WHERE ROWNUM <= 3;        

    
// - 퀴즈 kosa01>
// - ‘송강’ 교수가 강의하는 과목을 검색하라.
// - 교수번호(pno), 교수이름(pname), 과목명(cname)    

--SELECT p.pno, p.pname, c.cname
--    FROM professor p, course c
--    WHERE p.pno = c.pno
--    AND pname = '송강';

// - mission kosa01
//- 학점이 2학점인 과목과 이를 강의하는 교수를 검색하라.
--SELECT p.pname, c.cname, c.st_num
--    FROM professor p, course c
--    WHERE p.pno = c.pno
--    AND st_num = '2';

//- 화학과 1학년 학생의 기말고사 성적을 검색하라.
--SELECT st.major, st.syear, st.sname, sc.result 
--    FROM score sc, student st
--    WHERE sc.sno = st.sno
--    AND major = '화학'
--    AND syear = '1';
   
//- 화학과 1학년 학생이 수강하는 과목을 검색하라(3개 테이블 조인)
--SELECT major, syear, sname, cname
--    FROM student s, course c, score sc
--    WHERE s.sno = sc.sno
--    AND c.cno = sc.cno
--    AND major = '화학'
--    AND syear = 1;

// - 퀴즈
// - kosa01> 학생 중에 동명이인을 검색하라.
// - DISTINCT 사용
// - 논리적으로 테이블 2개 사용
--SELECT DISTINCT A.sno, A.sname
--    FROM student A, student B
--    WHERE A.sname = B.sname
--    AND A.sno != B.sno;

// - 퀴즈 
// - kosa01> 등록된 과목에 대한 모든 교수를 검색하라.
// - (등록하지 않은 교수도 출력, 누락된 교수가 없도록)
// <professor 기준>
// 1. 전체 조회 
// 모든 데이터 조회 후 row 몇개인지 검색.
// 36 row
SELECT * FROM professor; 

// 2. INNER JOIN
// 29row
SELECT c.cno, c.cname, c.st_num, p.pname
	FROM course c, professor p
	WHERE c.pno = p.pno;

// 3. OUTRE JOIN <professor 기준>
// 36row
SELECT c.cno, c.cname, c.st_num, p.pname
	FROM course c, professor p
	WHERE c.pno(+) = p.pno;

// 4. ANSI JOIN
// 36row
SELECT c.cno, c.cname, c.st_num, p.pname
	FROM course c RIGHT JOIN professor p
	ON c.pno = p.pno;

// <course 기준>
// 1. 전체 조회 
// 모든 데이터 조회 후 row 몇개인지 검색.
// 36 row
SELECT * FROM professor; 

// 2. INNER JOIN
// 29row
SELECT c.cno, c.cname, c.st_num, p.pname
	FROM course c, professor p
	WHERE c.pno = p.pno;

// 3. OUTRE JOIN <course 기준>
// 36row
SELECT c.cno, c.cname, c.st_num, p.pname
	FROM course c, professor p
	WHERE c.pno= p.pno(+);

// 4. ANSI JOIN
// 36row
SELECT c.cno, c.cname, c.st_num, p.pname
	FROM course c LEFT JOIN professor p
	ON c.pno = p.pno;

// - Full Join (39 row)
// 양쪽 다 만족해야됨
// row 증가 (39row)
// 양쪽 모두 누락 없음.
SELECT c.cno, c.cname, c.st_num, p.pname
	FROM course c Full JOIN professor p
	ON c.pno = p.pno;
    
// - mission 1 
// 1) '정의찬’과 부서(dept)가 다르지만 동일한 업무(job)을 수행하는 사원 목록을 출력하라.
SELECT job FROM emp WHERE ename = '정의찬';
SELECT dno FROM emp WHERE ename = '정의찬';

select eno, ename, dno, job FROM emp
    WHERE dno !=(SELECT dno FROM emp WHERE ename = '정의찬')
    AND job = (SELECT job FROM emp WHERE ename = '정의찬');

    
// 2) ‘관우’보다 일반화학 과목의 학점이 낮은 학생의 명단을 출력하라.    
SELECT grade FROM student s, course c, score r, scgrade g
    WHERE s.sno = r.sno
    AND c.cno = r.cno
    AND cname = '일반화학'
    AND sname = '관우'
    AND result BETWEEN loscore AND hiscore;
      
SELECT s.sno, sname, grade
    FROM student s, course c, score r, scgrade g
    WHERE s.sno = r.sno
    AND cname = '일반화학'
    AND result BETWEEN loscore AND hiscore
    AND grade > (SELECT grade FROM student s, course c, score r, scgrade g
                    WHERE s.sno = r.sno
                    AND c.cno = r.cno
                    AND cname = '일반화학'
                    AND sname = '관우'
                    AND result BETWEEN loscore AND hiscore);
                    

// 6) HAVING절 서브쿼리
// - 문제1
// - 부서 중에 평균급여를 가장 많이 받는 부서를 검색하라.
SELECT dno FROM emp
	GROUP BY dno
	HAVING AVG(sal) = (SELECT MAX(AVG(sal)) FROM emp
	GROUP BY dno);

// - 퀴즈 1
- kosa01> 학생 인원수가 가장 많은 학과를 검색하라.
SELECT MAX(COUNT(*)) FROM student GROUP BY major;

SELECT major FROM student
    GROUP BY major
    HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM student GROUP BY major);
    
// - Mission 01
// - 학생중 기말고사 평균성적이 가장 낮은 학생의 정보를 검색하라.   
SELECT MIN(AVG(result)) FROM SCORE group by SNO;

SELECT s.sno, sname
    FROM student s, score r
    WHERE s.sno = r.sno
    GROUP BY s.sno, sname
    HAVING AVG(result) = (SELECT MIN(AVG(result)) FROM SCORE group by SNO);
    
// - 화학과 1학년 학생중에 평점이 평균이하인 학생을 검색하라.    
SELECT AVG(avr) from student WHERE major = '화학' and syear = 1;

SELECT sname
    FROM student
    WHERE major = '화학'
    AND syear = 1
    GROUP BY sname
    HAVING AVG(avr) < (SELECT AVG(avr) from student WHERE major = '화학' and syear = 1);
    
SELECT *
    FROM student
    WHERE major = '화학'
    AND syear = 1 
    AND avr < (SELECT AVG(avr) from student WHERE major = '화학' and syear = 1);    
    
// 8) 집합 연산자
// - IN : 검색된 값 중에 하나만 일치하면 참.
// - ANY : 검색된 값 중에 조건에 맞는 것이 하나 이상이면 참.
// - ALL : 검색된 값 중에 조건에 모두 일치해야 참.
// - 컬럼 > max() ⇒ 컬럼 > ALL(서브쿼리) // 같다‼ : 가장 큰 값 보다 크다.
// - 컬럼 < min() ⇒ 컬럼 < ALL(서브쿼리) : 가장 작은 값 보다 작다.
// - 컬럼 > min() ⇒ 컬럼 > ANY(서브쿼리 ) : 가장 작은 값 보다 크다.
// - 컬럼 < MAX() ⇒ 컬럼 < ANY(서브쿼리 ) : 가장 큰 값 보다 작다    

// - 문제 1
// - 10번 부서에서 가장 작은 급여자 보다 작게 받는 급여자를 출력하라.
SELECT MIN(sal) FROM emp
	WHERE dno = 10;

// 집합 연산자 사용 x
SELECT eno, ename, sal, dno
	FROM emp
	WHERE sal < (SELECT MIN(sal) FROM emp
								WHERE dno = 10);

// 집합 연산자 사용 O
// 그룹함수 사용할 필요 없다.
SELECT eno, ename, sal, dno
	FROM emp
	WHERE sal < ALL(SELECT sal FROM emp
								WHERE dno = 10);
                                
// - mission 2
// - ’손하늘’과 동일한 관리자(mgr)의 관리를 받으면서 업무도 같은 사원을 검색하라.   
SELECT mgr, job FROM emp WHERE ename = '손하늘';

SELECT eno, ename, mgr, job
    FROM emp
    WHERE (mgr, job)
    IN (SELECT mgr, job FROM emp WHERE ename = '손하늘');

//- 화학과 학생과 평점이 동일한 학생을 검색하라.
SELECT avr FROM student WHERE major = '화학';

SELECT sno, sname, major, avr
    FROM student
    WHERE avr IN (SELECT avr FROM student WHERE major = '화학');

// - 화학과 학생과 같은 학년에서 평점이 동일한 학생을 검색하라.
SELECT syear, avr FROM student WHERE major = '화학';

SELECT sno, sname, major, avr, syear
    FROM student
    WHERE (syear, avr) IN (SELECT syear, avr FROM student WHERE major = '화학');
                                
// - ROWNUM
// - 쿼리를 통해 가져온 데이터를 이용해서 번호를 매기는 방식
// - 주의사항 : 반드시 1번부터 포함되어야 한다.    
// 1. 테이블 생성
CREATE TABLE board(
	seq NUMBER,
	title VARCHAR2(50),
	writer VARCHAR2(50),
	contents VARCHAR2(200),
	regdate date,
	hitcount number
);

// 2. 데이터 넣기
INSERT INTO board VALUES(1, 'a1', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(8, 'a8', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(9, 'a9', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(2, 'a2', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(4, 'a4', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(5, 'a5', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(3, 'a3', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(6, 'a6', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(7, 'a7', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(10, 'a10', 'a', 'a', sysdate, 0);

// 6번에서 10번까지 출력되도록
// BUT 결과 안나옴. 문제 발생
// ROWNUM은 무조건 1번부터 시작되어야 한다.
SELECT ROWNUM, temp.*
	FROM(SELECT * FROM board
				ORDER BY seq) temp
	WHERE ROWNUM BETWEEN 6 AND 10;
    
// 문제 해결
// 페이징 처리 로직
// 바꿔준 데이터 값을 사용하기 때문에 ROWNUM != ROW_NUM
SELECT ROWNUM AS ROW_NUM, temp.*
	FROM(SELECT * FROM board
				ORDER BY seq) temp;

SELECT * FROM (
	SELECT ROWNUM AS ROW_NUM, temp.*
					FROM(SELECT * FROM board
								ORDER BY seq) temp
	)
	WHERE ROW_NUM BETWEEN 6 AND 10; 

    