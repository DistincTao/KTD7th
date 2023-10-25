-- (3) 날짜 함수
------------------------------------------------------------------

-- 1)SYSDATE :  현재 날짜를 반환하는 함수
SELECT SYSDATE 
  FROM DUAL;
  
SELECT SYSDATE + 1 AS 내일
  FROM DUAL;
  
-- 사원들이 입사일로부터 현재까지 입사한지 며칠이 지났는지 구해보자
SELECT FIRST_NAME, 
       HIRE_DATE, 
       CEIL (SYSDATE - HIRE_DATE) || '일 지남' AS 근속일수
  FROM EMPLOYEES;
  
-- 2) MONTHS_BETWEEN ( ) : 두 날짜 사이의 간격을 개월 수로 계산하는 함수
SELECT FIRST_NAME, 
       HIRE_DATE, 
       CEIL (MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS 근무개월수
  FROM EMPLOYEES;
  
-- 3) ADD_MONTHS ( ): 개월수를 더하는 함수
SELECT FIRST_NAME,
       HIRE_DATE, 
       ADD_MONTHS(HIRE_DATE, 3)
  FROM EMPLOYEES;
  
-- 4) NEXT_DAY( ) : 해당 요일에 가장 가까운 날짜를 반환하는 함수
SELECT SYSDATE,
       NEXT_DAY(SYSDATE, '금요일')
  FROM DUAL;
  
-- 5) LAST_DAY ( ) : 해당 달의 마지막 날짜를 반환하는 함수
SELECT SYSDATE,
       LAST_DAY (SYSDATE)
  FROM DUAL;
  
-- 6) ROUND ( ) : 특정 기준으로 반올림 해주는 함수
SELECT SYSDATE,
       ROUND(SYSDATE, 'MONTH')
  FROM DUAL;
  
-- 7) TRANC ( ) : 특정 기준으로 버리는 함수
SELECT SYSDATE,
       TRUNC(SYSDATE, 'MONTH')
  FROM DUAL; 
  


