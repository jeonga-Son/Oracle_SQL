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
