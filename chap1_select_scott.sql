-- 1. 사원 테이블의 직무가 한번씩만 출력되도록 SQL을 작성
SELECT DISTINCT JOB
  FROM EMP;
-- 2. 사원테이블의 모든 정보를 출력하는 SQL
SELECT *
  FROM EMP;
-- 3. 사원이 이름, 급여, 입사일만을 출력하는 SQL
SELECT ENAME, SAL, HIREDATE
  FROM EMP;
-- 4. 사원들이 어떤 부서에 속해있는지 소속부서를 출력하되 중복되지 않고 한번씩만 출력
SELECT DISTINCT DEPTNO
  FROM EMP;
-- 5. EMP 테이블 중 부서 번호가 10번인 사원의 모든 정보 출력
SELECT *
  FROM EMP
 WHERE DEPTNO = 10;
-- 6. 사원 테이블 중 급여가 2000 미만인 사원의 정보 중에서 사번, 이름, 급여 출력
SELECT EMPNO, ENAME, SAL
  FROM EMP
 WHERE SAL < 2000;
-- 7. 이름이 miller인 사람의 사번, 이름, 직급을 출력
SELECT EMPNO, ENAME, JOB
  FROM EMP
 WHERE LOWER(ENAME) = 'miller';
-- 8. 커미션이 300 또는 500 또는 1400인 사원의 사번, 이름, 커미션을 출력
SELECT EMPNO, ENAME, COMM
  FROM EMP
 WHERE COMM IN (300, 500, 1400);
 
 SELECT EMPNO, ENAME, COMM
  FROM EMP
 WHERE COMM = 300 OR COMM = 500 OR COMM = 1400;
 
-- 9. 급여가 1500 과 2500 사이인 사원의 사번, 이름, 급여 출력
SELECT EMPNO, ENAME, SAL
  FROM EMP
 WHERE SAL >= 1500 AND SAL <= 2500;
 
SELECT EMPNO, ENAME, SAL
  FROM EMP
 WHERE SAL BETWEEN 1500 AND 2500;
 
-- 10. 이름에 A를 포함하지 않는 사원의 사번, 이름을 출력하세요
SELECT EMPNO, ENAME
  FROM EMP
 WHERE ENAME NOT LIKE '%A%';
 
-- 11. 자신의 직속상관이 없는 사원의 이름, 직급, 사번을 추력
SELECT ENAME, JOB, EMPNO
  FROM EMP
 WHERE MGR IS NULL;

-- 12. 사번, 이름 급여를 급여가 높은 순으로 출력
SELECT EMPNO, ENAME, SAL
  FROM EMP
 ORDER BY SAL DESC;
 
-- 13. 입사일이 가장 최근 순으로 사번, 이름, 입사일을 출력
SELECT EMPNO, ENAME, HIREDATE
  FROM EMP
 ORDER BY HIREDATE DESC;