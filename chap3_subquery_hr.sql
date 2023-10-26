-- 서브 쿼리
-- 100 번 사원이 소속되어 있는 부서의 부서명을 알아보자.
-- 1) 100번 사원이 소속되어 있는 부서의 번호를 알아낸다
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 100;  -- => 90
 -- 2) 1)에서 알아낸 부서 본호 (90번) 의 부서 이름을 알아낸다.
SELECT DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE DEPARTMENT_ID = 90;
 
SELECT DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE DEPARTMENT_ID = 
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = 100);
         
-- 문제 ) EXECUTIVE 부서의 국가 코드 주, 시, 도로명 주소를 출력해보자

SELECT COUNTRY_ID, 
       STATE_PROVINCE,
       CITY,
       STREET_ADDRESS     
  FROM LOCATIONS
 WHERE LOCATION_ID = 
      (SELECT LOCATION_ID
         FROM DEPARTMENTS
        WHERE DEPARTMENT_NAME = 'Executive');
        
-- 서브 쿼리의 종류 : 단일행, 다중행 서브쿼리
-- 1) 단일행 (single row subquery) => 내부 select 문장으로 부터 하나의 행만 반환
--   -> 연산자로 =, >, <, >=, <=, != 를 사용
        
-- 문제 ) 'Diana'와 같은 부서에 다니는 동료의 모든 정보를 출력하세요.
SELECT *
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID = (
        SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         WHERE FIRST_NAME = INITCAP('DIANA'));
         
-- 문제 ) 사원들의 평균 급여보다 더 많은 급여를 받는 사원의 사번, 이름, 급여를 출력하세요
SELECT EMPLOYEE_ID, 
       FIRST_NAME,
       SALARY
 FROM EMPLOYEES
 WHERE SALARY > (
       SELECT AVG(SALARY)
         FROM EMPLOYEES);
         
-- 2) 다중행 서브쿼리 (multiple row subquery)
-- -> 서브쿼리에서 반환되는 행의 갯수가 2개 이상일 때 사용하는 서브 쿼리
-- IN : 메인쿼리의 비교 조건이 서부쿼리의 결과중에서 하나라도 일치하면 참
-- ANY : 매인쿼리의 비교조건이 서브쿼리의 결과와 하나 이상이 일치하면 참
-- ALL : 메인 쿼리의 비교 조건이 서브 쿼리의 결과와 모든 값이 일치하면 참

-- 문제 ) 급여를 7000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원들의 정보 출력
-- 1) 급여를 7000 이상 받는 사원이 소속된 부서
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
  WHERE SALARY >= 7000;
  
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (
        SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         WHERE SALARY >= 7000); --single-row subquery returns more than one row

-- 1) IN => (A OR B OR C OR ....)와 유사
    -- => EQUAL의 개념이 있다
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN
      (SELECT DEPARTMENT_ID
         FROM EMPLOYEES
        WHERE SALARY >= 13000);
        
-- 2) ANY => 
-- 2)-1 값 < ANY () : ANY연산자 LIST에 있는 값들 중에서 가장 큰 값보다 작으면 참 

SELECT FIRST_NAME,
       SALARY
  FROM EMPLOYEES
 WHERE SALARY < ANY (4000, 6000, 9000, 12000);

-- 2)-2 값 > ANY () : ANY연산자 LIST에 있는 값들 중에서 가장 작은 값보다 크면 참

SELECT FIRST_NAME,
       SALARY
  FROM EMPLOYEES
 WHERE SALARY > ANY (4000, 6000, 9000, 12000);

-- 2)-3 값 = ANY ( ) : IN 연산자와 같은 기능 -> 해당 값들만 참

SELECT FIRST_NAME,
       SALARY
  FROM EMPLOYEES
 WHERE SALARY = ANY (4000, 6000, 9000, 12000);
 
-- 문제) 30번 부서에 소속된 사원 중에서 급여를 가장 적게 받는 사원보다 더 많이 받는 사원의 이름 급여를 출력하시오
SELECT FIRST_NAME,
       SALARY
  FROM EMPLOYEES
 WHERE SALARY > ANY 
      (SELECT SALARY 
         FROM EMPLOYEES 
        WHERE DEPARTMENT_ID = 30);

SELECT MIN(SALARY)
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 30;
 
 
-- 3) ALL
-- 30번 부서에 소속된 사원 중에서 급여를 가장 많이 받는 사원 보다 더많이 받는 사원의 이름,. 급여를 출력
SELECT FIRST_NAME,
       SALARY
  FROM EMPLOYEES
 WHERE SALARY > ALL
      (SELECT SALARY
         FROM EMPLOYEES 
        WHERE DEPARTMENT_ID = 30);
        
SELECT FIRST_NAME,
       SALARY
  FROM EMPLOYEES
 WHERE SALARY > 
      (SELECT MAX(SALARY)
         FROM EMPLOYEES 
        WHERE DEPARTMENT_ID = 30);
        
