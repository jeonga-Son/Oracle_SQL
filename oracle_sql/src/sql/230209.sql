// ���̺� ���� �ҷ�����
SELECT * FROM tab;

// ��Ī (AS, "")
SELECT employee_id AS "�����ȣ", last_name as "����̸�" FROM employees;

// 1�� ����
SELECT SNO AS "�й�", SNAME AS "�̸�", AVR AS "����" FROM STUDENT;

// 2�� ����
SELECT CNO AS "�����ȣ", CNAME AS " �����", ST_NUM AS "������" FROM COURSE;

// 3�� ����
SELECT PNO AS "������ȣ", PNAME AS "�����̸�", ORDERS AS "����" FROM PROFESSOR;

// 4�� ����
// �޿��� 10% �λ����� �� �� �������� ���� ���޵Ǵ� �޿��� �˻��϶�.
SELECT ENO AS "�����ȣ", ENAME AS "����̸�", SAL * 1.1  AS "����" FROM EMP;

// 5�� ����
// ���� �л��� ������ 4.0 �����̴�. �̸� 4.5 �������� ȯ���ؼ� �˻��϶�.
SELECT SNO AS "�й�", SNAME AS "�̸�", AVR*4.5/4.0 AS "ȯ������" FROM STUDENT;

// ���� kosa01 > �� �а����� ������ ������ �������� ������ �˻��϶�. PROFESSOR
SELECT SECTION, PNAME, HIREDATE FROM PROFESSOR 
    ORDER BY SECTION, HIREDATE;
    
// ������
SELECT employee_id, last_name, hire_date FROM employees 
	WHERE hire_date >= '03/01/01' AND last_name = 'King';


// ������ ver1
// ������ 5000 - 10000 ���� ������ �������� ����϶�.
SELECT employee_id, last_name, salary FROM employees
WHERE salary >= 5000 and salary <= 10000;

// ������ ver2
SELECT employee_id, last_name, salary FROM employees
WHERE salary between 5000 and 10000;

// or ������
SELECT employee_id, last_name, job_id 
	FROM employees
	WHERE job_id = 'FI_MGR' OR job_id = 'FI_ACCOUNT';
	
// in �����ڷ� ���� (���� or ������ ��� ���, ���� �����! �� ����ϱ�)
SELECT employee_id, last_name, job_id FROM employees
WHERE job_id in ('FI_MGR','FI_ACCOUNT');

// not ������
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
	
// LIKE (���� �����!) -like ��� x
SELECT employee_id, last_name, hire_date
	FROM employees
	WHERE hire_date BETWEEN '07/01/01' AND '07/12/31';
	
// -like ��� o
SELECT employee_id, last_name, hire_date
	FROM employees
	WHERE hire_date LIKE '07%';
	
// hr>last_name �÷��� ��a���� ���� ����� ����϶�.
SELECT employee_id, last_name
    FROM employees
    WHERE NOT last_name LIKE '%a%';
    
// ȭ�а� �л� �߿� ���� ���������� �л��� �˻��϶�.
SELECT SNO, SNAME FROM STUDENT WHERE SNAME LIKE '��%';

// mission-2.1
SELECT SNO, SNAME FROM STUDENT WHERE MAJOR='ȭ��' SNAME LIKE '��%';

//mission-2.2
SELECT PNO, PNAME, HIREDATE FROM PROFESSOR;
    WHERE HIREDATE < '95/01/01'
    AND orders = '������';
    

//mission-2.3
SELECT PNO, PNAME FROM PROFESSOR
    WHERE PNAME LIKE '__';

//mission-2.4 
SELECT SNO, SNAME, AVR*4.5/4.0 AS "ȯ������" FROM STUDENT
    WHERE AVR >= 3.5;

//mission-2.5
SELECT * FROM STUDENT
    WHERE MAJOR != 'ȭ��'
    ORDER BY major, syear;
    


