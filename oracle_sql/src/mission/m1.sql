//?Լ?????
//Q1
SELECT EMPNO, LPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS "MASKING_EMPNO", 
    ENAME, RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS "MASKING_ENAME"
    FROM EMP;
    
//Q2
SELECT EMPNO, ENAME, SAL, TRUNC(SAL/21.5,

    FROM EMP;
    
//Q3
SELECT EMPNO, ENAME, TO_CHAR(HIREDATE, 'YYYY/MM/DD') AS HIREDATE, 
    TO_CHAR(ADD_MONTHS(HIREDATE, 3), 'YYYY-MM-DD') AS R_JOB,
    NVL(TO_CHAR(COMM), 'N/A') AS COMM
    FROM EMP;

