// 서브 쿼리 과제 1
//Q1
SELECT department_id FROM employees WHERE last_name = 'Patel';

SELECT employee_id, last_name, hire_date, salary FROM employees 
	WHERE department_id = (SELECT department_id FROM employees WHERE last_name = 'Patel');
    

//Q2
SELECT job_id FROM employees WHERE last_name = 'Austin';

SELECT last_name, d.department_name, salary, job_id 
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
	AND job_id = (SELECT job_id FROM employees WHERE last_name = 'Austin')
    AND last_name <> 'Austin';

//Q3
SELECT salary FROM employees WHERE last_name = 'Seo';

SELECT employee_id, last_name, salary FROM employees
	WHERE salary = (SELECT salary FROM employees WHERE last_name = 'Seo')
    AND last_name <> 'Seo';

//Q4
SELECT MAX(salary) FROM employees WHERE department_id = 30;

SELECT employee_id, last_name, salary FROM employees
	WHERE salary > ALL(SELECT salary FROM employees WHERE department_id = 30);

//Q5
SELECT employee_id, last_name, salary FROM employees 
  WHERE salary > ANY(SELECT salary FROM employees WHERE department_id = 30);

//Q6
SELECT AVG(salary) FROM employees;

SELECT e.employee_id, e.last_name, d.department_name, l.city, e.salary 
    FROM employees e, departments d, locations l
	WHERE e.department_id = e.department_id
    AND d.location_id = l.location_id
    AND salary > (SELECT AVG(salary) FROM employees);

//Q7
SELECT e.employee_id, e.last_name, d.department_name, l.city, e.salary  
  FROM employees e, departments d, locations l 
  WHERE e.department_id = d.department_id 
  AND d.location_id = l.location_id 
  AND NOT e.job_id IN(SELECT job_id FROM employees WHERE department_id = 30) 
  AND e.department_id = 100;  
  
// -------------------------------------------------------------------------

// 조인과제2
// Q1
SELECT d.deptno, d.dname, e.empno, e.ename, e.sal
    FROM dept d, emp e
    WHERE d.deptno = e.deptno
    AND e.sal > 2000
    ORDER BY deptno, e.sal;
    
// Q2
SELECT d.deptno, d.dname, TRUNC(AVG(e.sal)) AS AVG_SAL, MAX(e.sal) AS MAX_SAL, count(*) AS CNT
    FROM dept d, emp e
    WHERE d.deptno = e.deptno
    GROUP BY d.deptno, d.dname
    ORDER BY deptno;
    
SELECT d.deptno, d.dname, TRUNC(AVG(e.sal), 0) AS AVG_SAL, MAX(e.sal) AS MAX_SAL, count(*)
    FROM dept d INNER JOIN emp e
    ON d.deptno = e.deptno
    GROUP BY d.deptno, d.dname;
    
// Q3
SELECT d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
    FROM dept d, emp e
    WHERE d.deptno = e.deptno(+)
    ORDER BY deptno, ename;
    
// Q4
SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.MGR, E.SAL, E.DEPTNO,
       S.LOSAL, S.HISAL, S.GRADE,
       E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
  FROM EMP E, DEPT D, SALGRADE S, EMP E2
 WHERE E.DEPTNO(+) = D.DEPTNO
   AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
   AND E.MGR = E2.EMPNO(+)
ORDER BY D.DEPTNO, E.EMPNO; 
