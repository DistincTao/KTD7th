--——— SQL 함수 연습문제 (** Scott 계정 이용) ———
--1. 사번이 짝수인 사원들의 사번, 이름, 직무 출력
SELECT EMPNO,
       ENAME,
       JOB
  FROM EMP
 WHERE MOD(EMPNO, 2) = 0;
--2. 'Smith'란 이름을 가진 사원의 사번, 이름, 급여, 커미션을 출력하라
--  1) initcap 이용
SELECT EMPNO,
       ENAME,
       SAL,
       COMM
  FROM EMP
 WHERE INITCAP(ENAME) = 'Smith';
--  2) upper 이용
SELECT EMPNO,
       ENAME,
       SAL,
       COMM
  FROM EMP
 WHERE ENAME = UPPER('Smith');
--3. 이름의 두번째 자리에 A 가 있는 사원의 사번, 이름, 직무을 출력
--   1) substr 이용
SELECT EMPNO,
       ENAME,
       JOB
  FROM EMP
  WHERE SUBSTR(ENAME, 2, 1) = 'A';
--   2) instr 이용
SELECT EMPNO,
       ENAME,
       JOB
  FROM EMP
  WHERE INSTR(ENAME, 'A') = 2;
--   3) like 이용
SELECT EMPNO,
       ENAME,
       JOB
  FROM EMP
  WHERE ENAME LIKE ('_A%');
--4. 이름이 K로 끝나는 사원의 사번, 이름, 직무 출력
SELECT EMPNO,
       ENAME,
       HIREDATE
  FROM EMP
  WHERE ENAME LIKE ('%K');
--5. 82년도에 입사한 사원의 사번, 이름, 입사일 출력
SELECT EMPNO,
       ENAME,
       HIREDATE
  FROM EMP
  WHERE HIREDATE >='82/01/01' AND HIREDATE <= '82/12/31';
  
  SELECT EMPNO,
       ENAME,
       HIREDATE
  FROM EMP
  WHERE SUBSTR (HIREDATE, 1, 2) = '82';
--6. 이름이 6글자 이상인 사원의 사번, 이름, 급여 출력
SELECT EMPNO,
       ENAME,
       SAL
  FROM EMP
  WHERE LENGTH(ENAME) >= 6;
--7. 모든 사원은 자신의 상관이 있다. 하지만 emp 테이블에 유일하게 상관이 없는 행이 있는데 그 사원의 mgr 컬럼에는 null이 있다. 
--   상관이 없는 사원만 출력하되 mgr 컬럼 값에 null대신 'CEO'를 출력하세요
SELECT EMPNO,
       ENAME,
       DECODE (MGR, NULL, 'CEO')
  FROM EMP
 WHERE MGR IS NULL;
 
SELECT EMPNO,
       ENAME,
       NVL (TO_CHAR(MGR), 'CEO')
  FROM EMP
 WHERE MGR IS NULL;
 
--8. 직무에 따라 급여를 인상하여 출력하도록 한다. 직무가 'analyst'인 사원은 5%, 'salesman'인 사원은 10%,
--  'manager'인 사원은 15%, 'clerk'인 사원은 20% 인상한다.
SELECT EMPNO,
       ENAME,
       JOB,
       SAL,
       DECODE (JOB, UPPER('analyst'), SAL * 1.05,
                    UPPER('salesman'), SAL * 1.1,
                    UPPER('manager'), SAL * 1.15,
                    UPPER('clerk'), SAL * 1.2) AS "인상된 월급"
  FROM EMP;

--9. 직업의 종류가 몇개인지 즉, 중복되지 않은 직업의 수를 카운트 하세요
SELECT COUNT (DISTINCT jOB) AS "직업의 수"
  FROM EMP;
--10. 부서별 사원의 수와 커미션을 받는 사원의 수를 카운트 하세요.
SELECT DEPTNO,
       COUNT(*) AS "부서별 사원수",
       COUNT(COMM) AS "커미션 수령자" 
  FROM EMP
 GROUP BY DEPTNO;
--11. emp테이블에서 사원 이름이 다섯 글자 이상이고, 여섯글자 미만인 사원 정보를 출력한다.
--   masking_empno 열에는 사원 번호 앞 두 자리와 뒷자리를 * 기호로 출력합니다.
--   그리고 masking_ename열에는 이름의 첫 글자만 보여주고 나머지 글자 수 만큼 *기호로 출력하세요.
SELECT EMPNO,
       RPAD(SUBSTR (EMPNO, 1, 2), 4, '*') AS masking_empno,
       ENAME,
       RPAD(SUBSTR(ENAME, 1, 1),LENGTH(ENAME), '*') AS masking_ename
  FROM EMP
 WHERE LENGTH(ENAME) = 5;
       
--12.  emp테이블에서 사원들의 평균 근무일 수는 21.5일이다. 하루 근무 시간을 8시간으로 보았을 때
--  사원들의 하루 급여(Day_pay)와 시급 (time_pay)를 계산하여 결과를 출력한다.
--  단, 하루 급여는 소수점 세번째 자리에서 버리고, 시급은 두번째 소수점에서 반올림하세요.
SELECT EMPNO,
       ENAME,
       SAL,
       TRUNC (SAL / 21.5, 3) AS Day_pay,
       ROUND (SAL / 21.5 / 8, 2) AS time_pay
  FROM EMP;
--
--13. emp테이블에서 사원들은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 
--  사원들이 정직원이 되는 날짜를 yyyy-mm-dd형식으로 출력하세요. 단, 커미션이 없는 사원의 커미션은 N/A로 출력하세요.
SELECT EMPNO,
       ENAME,
       HIREDATE,
       TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'yyyy-mm-dd'),
       NVL (TO_CHAR(COMM), 'N/A')
  FROM EMP;
--14. emp테이블의 모든 사원을 대상으로 직속 상관의 사원 번호를 다음과 같은 조건을 기준으로 변환해서 chg_mgr열에 출력하세요.
-- * 직속 상관의 사원 번호가 전재하지 않을 경우 : 0000
-- * 직속 상관의 사원 번호 앞 두 자리가 75인 경우 : 5555
-- * 직속 상관의 사원 번호 앞 두 자리가 76인 경우 : 6666
-- * 직속 상관의 사원 번호 앞 두 자리가 77인 경우 : 7777
-- * 직속 상관의 사원 번호 앞 두 자리가 78인 경우 : 8888
-- * 그외 직속 상관 사원 번호의 경우: 본래 직속 상관의 사원 번호 그대로 출력
SELECT EMPNO,
       ENAME,
       MGR,
  CASE WHEN MGR IS NULL THEN '0000'
       WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
       WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
       WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
       WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
       ELSE TO_CHAR(MGR)
   END AS chg_mgr
  FROM EMP;


--15. emp테이블을 이용하여 부서 번호(DEPTNO), 평균 급여(AVG_SAL), 최고급여 (MAX_SAL),
--      최저급여(MIN_SAL), 사원수 (CNT)를 출력하세요. 
--      단, 평균 급여는 소수점을 제외하고 각 부서번호 별로 출력하세요.
SELECT DEPTNO,
       TRUNC(AVG(SAL), 0) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
  FROM EMP
 GROUP BY DEPTNO;
--
--16. 같은 직책(JOB)에 종사하는 사원이 3명 이상인 직책과 인원수를 출력하세요.
SELECT JOB,
       COUNT(*)
  FROM EMP
 GROUP BY JOB
 HAVING COUNT(*) >= 3;
--17. 사원들의 입사 연도(YYYY)를 기준으로 부서별로 몇 명이 입사했는지 출력하세요.
SELECT TO_CHAR(HIREDATE, 'YYYY') AS "입사연도",
       DEPTNO,
       COUNT(*)
  FROM EMP
 GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;
  
