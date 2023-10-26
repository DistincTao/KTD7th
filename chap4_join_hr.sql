-- 조인
-- 사번이 100번인 사원 정보 (사번, 이름, 부서번호)와 그가 소속된 부서의 부서명?까지 출력

SELECT EMPLOYEE_ID,
       FIRST_NAME, 
       EMPLOYEES.DEPARTMENT_ID, 
       DEPARTMENTS.DEPARTMENT_NAME
  FROM EMPLOYEES, DEPARTMENTS; -- => CARTESIAN PRODUCT
 
SELECT EMPLOYEE_ID,
       FIRST_NAME, 
       EMPLOYEES.DEPARTMENT_ID, 
       DEPARTMENTS.DEPARTMENT_NAME
  FROM EMPLOYEES, DEPARTMENTS
 WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;
 
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME, 
       E.DEPARTMENT_ID, 
       D.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;
 
-- CEO가 모든 직원에게 선물을 택배로 보내려 한다.
-- 모든 직원들이 택배를 무사히 받을 수 있도로그 사무실의 주소, 사원 정보를 출력
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME,
       E.PHONE_NUMBER,
       L.STREET_ADDRESS,
       L.POSTAL_CODE,
       L.CITY,
       L.STATE_PROVINCE,
       C.COUNTRY_NAME,
       R.REGION_NAME
  FROM EMPLOYEES E,
       DEPARTMENTS D, 
       LOCATIONS L, 
       COUNTRIES C, 
       REGIONS R
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
   AND D.LOCATION_ID = D.LOCATION_ID 
   AND C.COUNTRY_ID = L.COUNTRY_ID 
   AND R.REGION_ID = C.REGION_ID;
   
-- SCOTT --
--1. 전체 사원 중 ALLEN과 같은 직책(JOB)인 사원들의 
--   직무, 사원 번호, 사원이름, 월급. 부서번호 부서이름을 출력
SELECT E.JOB,
       E.EMPNO,
       E.ENAME,
       E.SAL,
       D.DEPTNO,
       D.DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.JOB = (SELECT JOB FROM EMP WHERE ENAME = UPPER('ALLEN')); 
 
--2. 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 
--   사원 정보, 부서정보, 급여 등급 정보(SALGRADE)를 출력
--   단, 출력할 때 급여가 많은 순으로 정렬하되 급여가 같은 경우 
--   사원 번호를 기준으로 오름차순 정렬
SELECT E.EMPNO,
       E.ENAME,
       E.DEPTNO,
       E.SAL,
       D.DNAME,
       CASE WHEN E.SAL > 700 AND E.SAL <= 1200
            THEN 1
            WHEN E.SAL >= 1201  AND E.SAL <= 1400
            THEN 2
            WHEN E.SAL >= 1401 AND E.SAL <= 2000
            THEN 3
            WHEN E.SAL >= 2001 AND E.SAL <= 3000
            THEN 4
            WHEN E.SAL >= 3001 AND E.SAL < 9999
            THEN 5
        END AS SALGRADE
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO 
 ORDER BY E.SAL DESC, E.EMPNO;
   
--3. 10번 부서에서 근무하는 사원 중 
--   20번 부서에는 존재하지 않는 직무를 가진 사원들의 
--   사원번호 이름 직무 부서 번호 부서이름 loc를 출력
SELECT E.EMPNO,
       E.ENAME,
       E.JOB,
       E.DEPTNO,
       D.DNAME,
       D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 10
   AND JOB NOT IN (SELECT JOB FROM EMP WHERE DEPTNO = 20);
   
--4. 직무가 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 
--   사원번호, 이름, 월급, GRADE(SALGRADE)를 출력
SELECT EMPNO,
       ENAME,
       SAL,
       CASE WHEN SAL > 700 AND SAL <= 1200
            THEN 1
            WHEN SAL >= 1201  AND SAL <= 1400
            THEN 2
            WHEN SAL >= 1401 AND SAL <= 2000
            THEN 3
            WHEN SAL >= 2001 AND SAL <= 3000
            THEN 4
            WHEN SAL >= 3001 AND SAL < 9999
            THEN 5
        END AS GRADE
  FROM EMP E
 WHERE SAL > ALL (SELECT SAL FROM EMP WHERE JOB = UPPER('SALESMAN'));
       

