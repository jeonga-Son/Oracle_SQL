// 테이블 구조 불러오기
SELECT * FROM tab;

// 별칭 (AS, "")
SELECT employee_id AS "사원번호", last_name as "사원이름" FROM employees;

// 1번 문제
SELECT SNO AS "학번", SNAME AS "이름", AVR AS "학점" FROM STUDENT;

// 2번 문제
SELECT CNO AS "과목번호", CNAME AS " 과목명", ST_NUM AS "학점수" FROM COURSE;

// 3번 문제
SELECT PNO AS "교수번호", PNAME AS "교수이름", ORDERS AS "직위" FROM PROFESSOR;

// 4번 문제
// 급여를 10% 인상했을 때 각 직원마다 연간 지급되는 급여를 검색하라.
SELECT ENO AS "사원번호", ENAME AS "사원이름", SAL * 1.1  AS "연봉" FROM EMP;

// 5번 문제
// 현재 학생의 평점은 4.0 만점이다. 이를 4.5 만점으로 환산해서 검색하라.
SELECT SNO AS "학번", SNAME AS "이름", AVR*4.5/4.0 AS "환산학점" FROM STUDENT;

// 퀴즈 kosa01 > 각 학과별로 교수의 정보를 부임일자 순으로 검색하라. PROFESSOR
SELECT SECTION, PNAME, HIREDATE FROM PROFESSOR 
    ORDER BY SECTION, HIREDATE;
    
// 조건절
SELECT employee_id, last_name, hire_date FROM employees 
	WHERE hire_date >= '03/01/01' AND last_name = 'King';


// 연산자 ver1
// 연봉이 5000 - 10000 원인 사이의 직원들을 출력하라.
SELECT employee_id, last_name, salary FROM employees
WHERE salary >= 5000 and salary <= 10000;

// 연산자 ver2
SELECT employee_id, last_name, salary FROM employees
WHERE salary between 5000 and 10000;

// or 연산자
SELECT employee_id, last_name, job_id 
	FROM employees
	WHERE job_id = 'FI_MGR' OR job_id = 'FI_ACCOUNT';
	
// in 연산자로 변경 (위의 or 연산자 대신 사용, 많이 사용함! 꼭 기억하기)
SELECT employee_id, last_name, job_id FROM employees
WHERE job_id in ('FI_MGR','FI_ACCOUNT');

// not 연산자
// ver1
SELECT department_id, department_name 
	FROM departments
	WHERE department_id != 10;
	
// ver2
SELECT department_id, department_name 
	FROM departments
	WHERE department_id <> 10;

// ver3
SELECT department_id, department_name 
	FROM departments
	WHERE department_id ^= 10;
	
// ver4
SELECT department_id, department_name 
	FROM departments
	WHERE NOT department_id = 10;
	
// IS NOT NULL
SELECT employee_id, last_name, commission_pct
	FROM employees
	WHERE commission_pct IS NOT NULL;
	
// LIKE (많이 사용함!) -like 사용 x
SELECT employee_id, last_name, hire_date
	FROM employees
	WHERE hire_date BETWEEN '07/01/01' AND '07/12/31';
	
// -like 사용 o
SELECT employee_id, last_name, hire_date
	FROM employees
	WHERE hire_date LIKE '07%';
	
// hr>last_name 컬럼에 ‘a’가 없는 사원을 출력하라.
SELECT employee_id, last_name
    FROM employees
    WHERE NOT last_name LIKE '%a%';
    
// 화학과 학생 중에 성이 ‘관’씨인 학생을 검색하라.
SELECT SNO, SNAME FROM STUDENT WHERE SNAME LIKE '관%';

// mission-2.1
SELECT SNO, SNAME FROM STUDENT WHERE MAJOR='화학' SNAME LIKE '관%';

//mission-2.2
SELECT PNO, PNAME, HIREDATE FROM PROFESSOR;
    WHERE HIREDATE < '95/01/01'
    AND orders = '정교수';
    

//mission-2.3
SELECT PNO, PNAME FROM PROFESSOR
    WHERE PNAME LIKE '__';

//mission-2.4 
SELECT SNO, SNAME, AVR*4.5/4.0 AS "환산학점" FROM STUDENT
    WHERE AVR >= 3.5;

//mission-2.5
SELECT * FROM STUDENT
    WHERE MAJOR != '화학'
    ORDER BY major, syear;
    


