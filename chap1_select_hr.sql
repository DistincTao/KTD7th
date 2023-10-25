-- SQL 시작!!!
-- SELECT 문으로 특정 데이터를 추출하다
-- 기초 문법
-- SELECT * | [조회할 column1, column2, ....] FROM [조회할 Table];

--countries Table 모든 column 조회
SELECT * 
  FROM countries;

-- Department Table의 모든 Column 조회
SELECT * 
  FROM departments;

-- Employees Table의 모든 column 조회
SELECT * 
  FROM employees;

-- 사원의 이름만 조회
SELECT first_name, last_name 
  FROM employees;

-- 부서테이블에서 부서명만 조회
SELECT department_name 
  FROM departments;

-- 지역 테이블에서 도로명 주소만 조회하자
SELECT street_address 
  FROM locations;

-- 사원 테이블에서 사원 명과 급여를 조회
SELECT first_name, salary 
  FROM employees;

-- 사원 테이블에서 사번 이름 입사일을 조회
SELECT employee_id, first_name, hire_date 
  FROM employees;

--(1) 기본 사용법
-- column명에 별칭을 지어줄 수 있다.
-- 1)  column 명 기술 뒤 AS 키워드 사용
SELECT first_name 
    AS NAME 
  FROM employees;

SELECT employee_id 
    AS 사번 ,first_name 
    AS 이름 
  FROM employees;

-- 2) as 라는 키워드 를 생략해도 된다
SELECT first_name 이름 
  FROM employees;

-- 3) 별칭에 공백이나 특수문자를 포함하는 경우 " "로 묶는다.
-- SELECT first_name AS 이 름 FROM employees; =>  Error
SELECT first_name 
    AS "이^름" 
  FROM employees;

-- 4) DISTINCT 키워드는 중복된 데이터를 한번씩만 출력하게 한다.
SELECT job_id 
  FROM employees;

SELECT DISTINCT job_id 
  FROM employees;
--SELECT DISTINCT job_id, first_Name FROM employees; =>  의미가 없음

-- (2) WHERE 절을 사용하여 조건절을 사용할 수 있다.
-- WHERE 절의 조건식에 사용되는 연산자 : (>, <, >=, <=, =, !=(not equal <>, ^=))
SELECT * 
  FROM employees
 WHERE employee_id >= 200;

-- 사원테이블에서 급여가 5000달러 이상인 사원들의 사번 이름 급여를 조회
SELECT employee_id, first_name, salary 
  FROM employees
 WHERE salary >= 5000;

-- 사원 테이블에서 이름이 Adam인 사원의 사번, 이름, 입사일 조회
SELECT employee_id, first_name, hire_date
  FROM employees
 WHERE first_name = 'Adam'; -- 문자열(대소문자)을 맞춰서 조회를 해야함

-- 지역 테이블에서 지역 번호가 1800번 이하인 지역의 모든 컬럼을 조회
SELECT *
  FROM locations
 WHERE location_id <= 1800;

-- 사원 테이블에서 입사일이 2002년 이전 입사한 사원들의 사번 이름 급여 입사일을 출력
SELECT employee_id,first_name, salary, hire_date
  FROM employees
 WHERE hire_date < '02/01/01';

-- (3) 조건 연산자를 연결할 때 논리연산자(AND, OR, NOT)를 사용할 수 있다.
-- 사번이 130번 보다 작거나 또는 급여가 5000보다 큰 사원들의 사번 ㅡ 급여 출력
SELECT employee_id AS 사번, salary AS 급여
  FROM employees
 WHERE employee_id < 130 OR salary > 5000;

-- 급여가 5000 이상이고 부서 번호가 30번 보다 작은 사원들의 사번 급여 부서번호 출력
SELECT employee_id, salary, department_id
  FROM employees
 WHERE salary >= 5000 
       AND department_id < 30;

-- 부서 번호가 100번이 아닌 모든 사원들의 모든 컬럼을 조회하자
SELECT *
  FROM employees
--WHERE DEPARTMENT_ID != 100;
--WHERE DEPARTMENT_ID <> 100;
--WHERE DEPARTMENT_ID ^= 100;
 WHERE NOT department_id = 100;

-- (4) BETWEEN A AND B 연산자 => A 이상이고, B 이하
-- 급여가 5000 이상이고 급여가 7000이하인 사원들의 이름 급여를 출력
SELECT first_name, salary
  FROM employees
 WHERE salary >= 5000 
       AND salary <= 7000; 
 
 SELECT first_name, salary
  FROM employees
 WHERE salary 
       BETWEEN 5000 
       AND 7000; 
 
-- 입사년도가 2003년 에서 2005년 이하인 사원들의 모든 정보를 조회
SELECT *
  FROM employees
 WHERE hire_date 
       BETWEEN '03/01/01' 
       AND '05,12,31';

-- (5) IN (A, B, C ...) 연산자 : A 또는 B 또는 C ....
-- 부서 번호가 10번 50번 100번 인 사원들의 모든 정보를 출력
--(IN)
SELECT *
  FROM employees
 WHERE department_id IN (10, 50, 100);
--(or)
SELECT *
  FROM employees
 WHERE department_id = 10 
       OR department_id = 50 
       OR department_id = 100;
       
-- (5)패턴을 이용하여 검색하는 LIKE 연산자
-- 1) column LIKE 패턴
-- 2) 패턴은 아래 2가지 (와일드카드)를 이용할 수 있다.
-- '%' : 문자가 없거나 하나 이상의 문자가 어떤 값이 오든 상관 없다
-- '_'하나의 문자가 어떤 값이 오든 상관 없다.

-- 이름이 s로 시작하는 모든 사원의 정보를 출력
SELECT  *
  FROM employees
 WHERE first_name LIKE 'S%';

-- 이름이 n으로 끝나는 모든 사원의 정보를 출력
SELECT  *
  FROM employees
 WHERE first_name LIKE '%n';
 
 -- 직무가 AN으로 띁나는 모든 사원의 정보를 출력
SELECT  *
  FROM employees
 WHERE JOB_ID LIKE '%AN';
 
 -- 이름이 끝에서 2번째 글자가 A 인 사원들의 모든 정보를 출력하자
SELECT  *
  FROM employees
 WHERE FIRST_NAME LIKE '%a_';
 
 -- 이름에 3번쨰 글자가  r인 사원듫의 모든 정보 출려
SELECT  *
  FROM employees
 WHERE FIRST_NAME LIKE '__r%';
 
-- 직무에 _가 포함된 사원들의 모든 정보를 출력
SELECT  *
  FROM employees
 WHERE JOB_ID LIKE '%_%';
 
-- (6) IS NULL (NULL 을 위한 연산자
-- 커미션을 받는 모든 사원의 모든 정보를 출력하자
-- SELECT * FROM employees WHERE COMMISSION_PCT != NULL; => 적용 안됨
-- IS NULL | IS NOT NULL 
SELECT  *
  FROM employees
 WHERE COMMISSION_PCT IS NOT NULL;
 
-- (7) 정렬을 하기 위해서는 ORDER BY 절을 사용
-- ORDER BY column명 [정렬 기준]
-- 정렬 기준의 기본 값은 오름 차순

-- 사원들의 급여를 내림 차순으로 정렬해서 모든 사원의 정보를 출력하자
SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY ASC;
 
SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY DESC;
 
-- 정렬은 ,로 구분하여 여러개를 사용할 수 있다.
-- 부서번호가 50번인 사원들의 모든 정보를 출력하되, 이름, 급여 오름차순으로 정렬하고, 급여가 같은 경우 이름은 내림차순으로 정렬

SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50
 ORDER BY SALARY, FIRST_NAME DESC;