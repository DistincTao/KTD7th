SELECT * 
  FROM EMP_DETAILS_VIEW;

SELECT * 
  FROM EMP_DETAILS_VIEW
 WHERE DEPARTMENT_ID = 90;

SELECT * 
  FROM EMP_DETAILS_VIEW
 WHERE DEPARTMENT_ID = 90
 ORDER BY SALARY;
 
SELECT VIEW_NAME TEXT 
  FROM USER_VIEWS;

CREATE OR REPLACE FORCE VIEW "HR"."EMP_DETAILS_VIEW" ("EMPLOYEE_ID", "JOB_ID", "MANAGER_ID", "DEPARTMENT_ID", "LOCATION_ID", "COUNTRY_ID", "FIRST_NAME", "LAST_NAME", "SALARY", "COMMISSION_PCT", "DEPARTMENT_NAME", "JOB_TITLE", "CITY", "STATE_PROVINCE", "COUNTRY_NAME", "REGION_NAME") AS 
  SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id;

-- 뷰 생성
-- CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름
--     AS (서브 쿼리)
--        [WITH CHECK OPTION]
--        [WITH READ ONLY]

-- [OR REPLACE] => 뷰가 존재하면 뷰를 수정하고, 뷰가 없으면 생성

CREATE OR REPLACE VIEW VIEW_EMP30
    AS SELECT *
         FROM EMPLOYEES
        WHERE DEPARTMENT_ID = 30;
        
SELECT * 
  FROM VIEW_EMP30;

INSERT INTO VIEW_EMP30
VALUES (300, 'Eugene', 'Cho', 'DIS', '010.124.5667', '23/01/01', 'PU_MAN', 50000, 0.8, 100, 30);

DELETE FROM VIEW_EMP30
 WHERE EMPLOYEE_ID = 300;
 
--  CHECK OPTION으로 뷰 생성

CREATE OR REPLACE VIEW VIEW_EMP90
    AS SELECT EMPLOYEE_ID,
              FIRST_NAME,
              LAST_NAME,
              EMAIL,
              JOB_ID,
              HIRE_DATE,
              DEPARTMENT_ID
         FROM EMPLOYEES
        WHERE DEPARTMENT_ID = 90
  WITH CHECK OPTION;
  
INSERT INTO VIEW_EMP90
VALUES (301, 'DOOLY', 'KIM', 'KDOOLY', 'AD_PRES', SYSDATE, 90);

UPDATE VIEW_EMP90
   SET SALARY = 100000
 WHERE EMPLYEE_ID = 301;
 --> CHECK 옵션으로 만들어진 항목(COLUMN) 외에는 추가 불가
 -- ORA-00904: "EMPLYEE_ID": invalid identifier

UPDATE VIEW_EMP90
   SET HIRE_DATE = '23/11/01'
 WHERE EMPLOYEE_ID = 301;
 --> CHECK 옵션을 만들어진 항목은 추가 가능

DELETE FROM VIEW_EMP90
 WHERE EMPLOYEE_ID = 301;
 
  DROP VIEW VIEW_EMP90;


-- [WITH READ ONLY]
CREATE OR REPLACE VIEW VIEW_EMP90
    AS SELECT EMPLOYEE_ID,
              FIRST_NAME,
              LAST_NAME,
              EMAIL,
              JOB_ID,
              HIRE_DATE,
              DEPARTMENT_ID
         FROM EMPLOYEES
        WHERE DEPARTMENT_ID = 90
  WITH READ ONLY;

-- ORA-42399: cannot perform a DML operation on a read-only view
DELETE FROM VIEW_EMP90
 WHERE EMPLOYEE_ID = 301;
-- 읽기 전용이라 삭제 불가

INSERT INTO VIEW_EMP90
VALUES (302, 'DDOCHI', 'KIM', 'KDDOCHI', 'AD_PRES', SYSDATE, 90);
-- 읽기 전용이라 추가 불가

UPDATE VIEW_EMP90
   SET HIRE_DATE = '23/10/10'
 WHERE EMPLOYEE_ID = 302;
-- 읽기 전용이라 수정 불가

  DROP TABLE BOOKORDER;
  DROP TABLE BOOK;
  DROP TABLE MEMBER;
  
-- [FORCE | NOFORCE]
CREATE OR REPLACE VIEW VIWE_MEMBER
    AS SELECT * 
       FROM MEMBER;
-- ORA-00942: table or view does not exist

CREATE OR REPLACE FORCE VIEW VIWE_MEMBER
    AS SELECT * 
       FROM MEMBER;
-- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.

CREATE TABLE MEMBER
      (USERID VARCHAR2(20));
      
SELECT * FROM VIWE_MEMBER;

-- 뷰 생성 : 컬럼에 별칭을 붙여 생성하면??
CREATE OR REPLACE VIEW VIEW_EMP(사번, 이름, 급여, 부서번호)
    AS SELECT EMPLOYEE_ID,
              FIRST_NAME,
              SALARY,
              DEPARTMENT_ID
         FROM EMPLOYEES;

SELECT * FROM VIEW_EMP;

SELECT *
  FROM VIEW_EMP
 WHERE DEPARTMENT_ID = 90;
 -- 컬럼 별칭으로 검색해야 함 아니면 오류!
 -- ORA-00904: "DEPARTMENT_ID": invalid identifier
 
SELECT *
  FROM VIEW_EMP
 WHERE 부서번호 = 90;
 
-- 그룹 함수를 이용해서 뷰를 생성하면... 
-- 1) 반드시 별칭을 사용해야한다
-- 2) 생성된 부에는 DML 사용이 불가하다
CREATE OR REPLACE VIEW VIEW_SAL
    AS SELECT DEPARTMENT_ID,
              SUM(SALARY),
              AVG(SALARY)
         FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID;
-- ORA-00998: must name this expression with a column alias
CREATE OR REPLACE VIEW VIEW_SAL
    AS SELECT DEPARTMENT_ID,
              SUM(SALARY) AS 급여총액,
              AVG(SALARY) AS 급여평균
         FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID;
 
DELETE FROM VIEW_SAL
 WHERE DEPARTMENT_ID = 30;
-- ORA-01732: data manipulation operation not legal on this view

-- JOIN을 뷰 생성
CREATE OR REPLACE VIEW VIEW_EMP_DEPT
    AS SELECT E.EMPLOYEE_ID,
              E.FIRST_NAME,
              E.DEPARTMENT_ID,
              D.DEPARTMENT_NAME
         FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
        
INSERT INTO VIEW_EMP_DEPT
VALUES (303,
        'HEEDONG',
        30,
        'PURCHASING');
-- 조인으로 생성된 뷰는 내용 추가 (INSERT INTO) 불가
-- ORA-01776: cannot modify more than one base table through a join view

UPDATE VIEW_EMP_DEPT
   SET FIRST_NAME = 'Jenifer'
 WHERE EMPLOYEE_ID = 301;
-- UPDATE SET 가능

DELETE FROM VIEW_EMP_DEPT
 WHERE EMPLOYEE_ID = 301;
-- DELETE FROM 가능


-- 급여가 높은 순으로 5명만 출력
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
  FROM EMPLOYEES
 ORDER BY SALARY DESC;
 
-- ROWNUM
CREATE TABLE TESTRN(
       USERID NUMBER(3) PRIMARY KEY,
       USERNAME VARCHAR2 (15)
       );
       
INSERT INTO TESTRN
VALUES (1, 'USER1');

INSERT INTO TESTRN
VALUES (2, 'USER2');

INSERT INTO TESTRN
VALUES (3, 'USER3');

INSERT INTO TESTRN
VALUES (4, 'USER4');

INSERT INTO TESTRN
VALUES (5, 'USER5');

INSERT INTO TESTRN
VALUES (10, 'USER10');

INSERT INTO TESTRN
VALUES (9, 'USER9');

INSERT INTO TESTRN
VALUES (8, 'USER8');

INSERT INTO TESTRN
VALUES (7, 'USER7');

INSERT INTO TESTRN
VALUES (6, 'USER6');

SELECT ROWNUM, TESTRN.* 
  FROM TESTRN;
  
SELECT ROWNUM, TESTRN.* 
  FROM TESTRN
 WHERE ROWNUM BETWEEN 1 AND 5;
 
SELECT ROWNUM, TESTRN.* 
  FROM TESTRN
 WHERE ROWNUM BETWEEN 2 AND 5;
 
SELECT * 
  FROM (SELECT ROWNUM, TESTRN.* 
          FROM TESTRN)
 WHERE ROWNUM BETWEEN 5  AND 10;
--> 별칭 지정
SELECT * 
  FROM (SELECT ROWNUM RN, TESTRN.* 
          FROM TESTRN)
 WHERE RN BETWEEN 5  AND 10; 
 
 -- 급여가 높은 순으로 5명만 출력
SELECT ROWNUM, EMPLOYEE_ID, FIRST_NAME, SALARY
  FROM EMPLOYEES
 ORDER BY SALARY DESC;
 
CREATE OR REPLACE VIEW VIEW_SAL_TOP5
    AS SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
         FROM EMPLOYEES
        ORDER BY SALARY DESC;

SELECT ROWNUM, E.*
  FROM VIEW_SAL_TOP5 E
 WHERE ROWNUM <6 ;
 
-- 서브쿼리로 풀기
SELECT ROWNUM, E.* 
  FROM (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
         FROM EMPLOYEES
        ORDER BY SALARY DESC) E
 WHERE ROWNUM BETWEEN 5  AND 10; 
 
--  입사일이 늦은 7명을 출력하세요.


CREATE OR REPLACE VIEW VIEW_HIREDATE_DESC
    AS SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
         FROM EMPLOYEES
        ORDER BY HIRE_DATE DESC;

SELECT ROWNUM, H.* FROM VIEW_HIREDATE_DESC H
 WHERE ROWNUM <=7;
 
SELECT ROWNUM, E.* 
  FROM (SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
         FROM EMPLOYEES
        ORDER BY HIRE_DATE DESC) E
 WHERE ROWNUM BETWEEN 1  AND 7; 
 
-- 입사일이 늦은 그 다음 7명 출력
SELECT *
  FROM (SELECT ROWNUM RN,  E. * FROM (
                SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE 
         FROM EMPLOYEES
        ORDER BY HIRE_DATE DESC) E)
 WHERE RN BETWEEN 8  AND 14;
 
 