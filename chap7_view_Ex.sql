--뷰 연습 문제
--1. 사번, 이름, 부서명, 부서의 위치를 출력하는 뷰(VIEW_LOC)를 작성
CREATE OR REPLACE VIEW VIEW_LOC
    AS SELECT E.EMPNO, E.ENAME, D.DNAME, D.LOC
         FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO;

--2. 30번 부서의 소속사원의 이름, 입사일, 부서명을 출력하는 뷰(VIEW_DEPT30)을 작성
CREATE OR REPLACE VIEW VIEW_DEPT30
    AS SELECT E.ENAME, E.HIREDATE, D.DNAME
         FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO
          AND E.DEPTNO = 30;

--3. 부서별 최대 급여 정보를 가지는 뷰 (VIEW_DEPT-MAXSAL)을 작성
CREATE OR REPLACE VIEW VIEW_DEPT_MAXSAL
    AS SELECT DEPTNO 부서번호, MAX(SAL) 최대급여
         FROM EMP
 GROUP BY DEPTNO;

--4. 급여를 많이 받는 TOP3를 출력하는 뷰 (VIEW_SAL_TOP3)를 작성
CREATE OR REPLACE VIEW VIEW_SAL_TOP3
    AS SELECT ENAME, SAL
         FROM EMP
        ORDER BY SAL DESC;
        
SELECT ROWNUM, E.* 
  FROM VIEW_SAL_TOP3 E
 WHERE ROWNUM <= 3;
 
 
CREATE OR REPLACE VIEW VIEW_SAL_TOP3
    AS SELECT ROWNUM 등수, S.* 
         FROM (SELECT * 
                 FROM EMP 
               ORDER BY SAL DESC) S
 WHERE ROWNUM <=3;