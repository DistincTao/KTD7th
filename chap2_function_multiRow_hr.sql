-- 2. 그룹 함수
------------------------------------------------------------------
-- 1) SUM() : 합계를 구하는 함수
SELECT SUM(SALARY)
  FROM EMPLOYEES;
  
--SELECT FIRST_NAME,
--       SUM(SALARY)
--  FROM EMPLOYEES; => ERROR

-- 2) AVG( ) : 평균을 구하는 함수
SELECT TO_CHAR(ROUND(AVG(SALARY), 2), 'L9,999.99')
  FROM EMPLOYEES;

-- 3) MAX ( ) : 최대값 구하기
--    MIN ( ) : 최소값 구하기
SELECT MAX(SALARY),
       MIN(SALARY)
  FROM EMPLOYEES;
  
-- 4) COUNT ( ) : 행의 갯수를 세어주는 함수 => NULL은 세지 않음
SELECT COUNT(*)
  FROM EMPLOYEES;

SELECT COUNT(COMMISSION_PCT)
  FROM EMPLOYEES;
  
-- 5) STDDEV ( ) : 표준편차
SELECT STDDEV(SALARY)
  FROM EMPLOYEES;

SELECT SQRT(VARIANCE (SALARY))
  FROM EMPLOYEES;

-- 6) VARIANCE ( ) : 분산
SELECT VARIANCE (SALARY)
  FROM EMPLOYEES;
  
-- GROUP BY
SELECT DEPARTMENT_ID,
       SUM(SALARY),
       AVG(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID;
 
-- 직무별 급여 총액과 급여 평균
SELECT JOB_ID,
       SUM(SALARY),
       AVG(SALARY)
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50
 GROUP BY JOB_ID;
 
-- HAVING 절 : ##그룹화를 시킨 컬럼에 조건을 부여할 때## 쓰는 것
-- GROUP BY 이후에 작성 (순서 바뀌도 동작은 하지만 구문 오류임)
SELECT DEPARTMENT_ID,
       AVG(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000;

--SELECT DEPARTMENT_ID,
--       AVG(SALARY)
--  FROM EMPLOYEES
--HAVING AVG(SALARY) >= 5000
-- GROUP BY DEPARTMENT_ID;
 
-- 직무별 급여 최대값과 급여 최소값을 구하되, 최대 급여가 7000이상인 부서만 출력하세요
SELECT JOB_ID,
       MAX (SALARY),
       MIN (SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
HAVING MAX(SALARY) >= 7000;

SELECT JOB_ID,
       DEPARTMENT_ID,
       SUM (SALARY),
       AVG(SALARY)
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID
       BETWEEN 50 AND 100
 GROUP BY JOB_ID,
          DEPARTMENT_ID
 ORDER BY JOB_ID; -- 맨 끝에 작성

SELECT JOB_ID,
       SUM(SALARY),
       AVG(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
HAVING AVG(SALARY) > 5000
 ORDER BY AVG(SALARY);
