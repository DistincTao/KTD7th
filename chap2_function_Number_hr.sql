-- (2) 숫자 함수
------------------------------------------------------------------

-- 1) ABS ( ) : 절대값을 구하는 함수
SELECT ABS(-15) 
  FROM DUAL;

-- 2)-1 FLOOR ( ) : 소수점 아래를 버림
-- FLOOR([숫자(필수)])
SELECT FLOOR (3.141592) 
  FROM DUAL;

-- 2)-2 CEIL ( ) : 소수점 아래를 올림
-- CEIL([숫자(필수)])
SELECT CEIL (3.141592) 
  FROM DUAL;

-- 3) ROUND ( ) : 소수점 아래(특정 자리수에서)를 반올림
-- ROUND([숫자(필수)], [반올림 위치(선택) - default 0])
SELECT ROUND (3.141592, 2) 
  FROM DUAL;

SELECT ROUND (3.141593, 4)
  FROM DUAL;
  
SELECT ROUND (314.1593, -2) -- (-)는 정수방향으로 카운트
  FROM DUAL;
  
SELECT ROUND (3.141593, 0) -- DEFAULT 값
  FROM DUAL;
  
-- 4) TRUNC ( ) : 특정 자릿수에서 잘라내는 함수 (반올림 하지 않음)
-- TRUNC([숫자(필수)], [버림 위치(선택) - default 0])
SELECT TRUNC (3.141592, 2) 
  FROM DUAL;
  
SELECT TRUNC (3.141592, 4) 
  FROM DUAL;
  
SELECT TRUNC (314.1592, -2) 
  FROM DUAL; -- (-)는 정수방향으로 카운트

-- 5) MOD( ) : 나머지 값을 반환
-- MOD([나눗셈 될 숫자(필수)], [나눌 숫자(필수)])
SELECT MOD(34, 2) 
  FROM DUAL;
  
SELECT MOD(34, 3)
  FROM DUAL;

-- 6) SIGN ( ) : 양수(1 반환), 음수(-1 반환), 0(0 반환)을 구분
SELECT SIGN(10) 
  FROM DUAL;
  
SELECT SIGN(-10) 
  FROM DUAL;
  
SELECT SIGN(0) 
  FROM DUAL;

-- 7) POWER ( ) : 거듭제곱 A^B
SELECT POWER (2, 3) 
  FROM DUAL;
  
SELECT POWER (4, 3) 
  FROM DUAL;
  
-- 8) SQRT( ) : 제곱근
SELECT SQRT(9) FROM DUAL;
SELECT SQRT(10) FROM DUAL;

-- 문제) 사원들의 연봉을 구하려 한다.
-- 연봉 = (월급 * 12) + (COMM * 월급 * 12)
-- 연봉을 구해서 소수점 이하 2자리까지만 출력
-- 연봉 컬럼의 컬럼명은 ANNUAL SALARY
SELECT EMPLOYEE_ID, 
       FIRST_NAME, 
       ROUND((1 + COMMISSION_PCT) * (SALARY * 12), 2) AS "annual salary"
  FROM employees;

