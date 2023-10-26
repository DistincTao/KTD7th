-- (5) 일반 함수
------------------------------------------------------------------
SELECT EMPLOYEE_ID, 
       FIRST_NAME, 
       ROUND((1 + COMMISSION_PCT) * (SALARY * 12), 2) AS "annual salary"
  FROM employees;
-- ### 중요 ###
-- 1) NVL( ) : 첫번째 인자로 받은 값이 NULL이면 두번째 인자 값으로 변경 

SELECT EMPLOYEE_ID, 
       FIRST_NAME, 
       ROUND((1 + NVL(COMMISSION_PCT, 0)) * (SALARY * 12), 2) AS "annual salary"
  FROM employees;
  
-- 2) DECODE( ) : 프로그래밍 언어의 SWITCH CASE 문과 같은 역할
-- 1개일 경우
SELECT FIRST_NAME,
       DEPARTMENT_ID,
       DECODE (DEPARTMENT_ID, 90, 'Executive') AS 부서이름
  FROM EMPLOYEES;
-- 2개 이상일 경우
SELECT FIRST_NAME,
       DEPARTMENT_ID,
       DECODE (DEPARTMENT_ID, 90, 'Executive',
                              60, 'IT', 
                              100, 'Finance',
                              'DEFAULT') AS 부서이름
  FROM EMPLOYEES;
  
-- 3) CASE ( ) : IF ~ ELSE IF 와 비슷한 역할
SELECT FIRST_NAME,
       DEPARTMENT_ID,
  CASE WHEN DEPARTMENT_ID = 90
       THEN 'Executive'
       WHEN DEPARTMENT_ID = 60
       THEN 'IT'
       WHEN DEPARTMENT_ID = 100
       THEN 'Finance'
       ELSE 'DEFAULT'
   END AS 부서명
  FROM EMPLOYEES;
  
-- 4) RANK ( )  : 공통 순위는 건너뛰고 다음 순외로 출력
--    DENSE_RANK ( ) : 공통순위를 던너뛰지 않고 다음 순위를 출력
--    ROW_NUMBER ( ) : 공통순위 없이 순위 순서대로 출력
SELECT FIRST_NAME,
       SALARY,
       RANK () OVER (ORDER BY SALARY DESC) AS RANK,
       DENSE_RANK() OVER (ORDER BY SALARY DESC) AS DENSE_RANK,
       ROW_NUMBER ()OVER (ORDER BY SALARY DESC) AS ROW_NUM
  FROM EMPLOYEES;