-- 문제) 서부쿼리 연습 문제
-- 1) Smith 와 동일한 직무를 가진 사원의 이름과 직무 출력
-- Smith는 빼고 출력
SELECT ENAME,
       JOB
  FROM EMP
 WHERE JOB = 
      (SELECT JOB
         FROM EMP 
        WHERE ENAME = 'SMITH') 
--    AND SAL > 800;
AND ENAME <> UPPER('SMITH');
       
--2) 부서별로 가장 급여를 많이 받는 사원의 정보를 출력
SELECT EMPNO,
       ENAME,
       SAL
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);
--3) 직무가 saleman인 사원이 받는 급여 중 최소 급여보다 많이 받는 사원의 이름과 급여를 출력하되 
--부서번호가 20번인 사원은 제외하여 출력
SELECT ENAME,
       SAL
  FROM EMP
 WHERE SAL > ANY 
      (SELECT SAL 
         FROM EMP 
        WHERE JOB = UPPER('SALESMAN'))
   AND DEPTNO != 20;
--4) 직무가 saleman인 사원이 받는 급여 중 최대 급여보다 많이 받는 사원의 이름과 급여를 출력하되,
--부서번호가 30인 사원은 제외하여 출력
SELECT ENAME,
       SAL
  FROM EMP
 WHERE SAL > ALL 
      (SELECT SAL 
         FROM EMP
        WHERE JOB = UPPER('SALESMAN'))
   AND DEPTNO != 30;