SELECT 5 + 3 
  FROM EMPLOYEES;
SELECT 5 + 3 
  FROM DUAL;
DESC dual;
DESC employees;
-- (1) 문자 함수 
------------------------------------------------------
-- 1) LOWER( ) :  소문자 변환
SELECT 'DataBase', LOWER('DataBase') 
  FROM DUAL;

-- 이름이 lex인 사원의 모든 정보를 출력하자
SELECT *
  FROM employees
 WHERE LOWER(first_name) = 'lex';
 
-- 2) UPPER( ) : 대문자 변환
SELECT 'DataBase', UPPER('DataBase') 
  FROM DUAL;

-- 이름이  LEX 사원의 모든 정보를 출력하자
SELECT *
  FROM employees
 WHERE UPPER(first_name) = 'LEX';
 
-- 직무가 'it_prog'인 사원의 모든 정보를 출력
SELECT *
  FROM employees
 WHERE LOWER(job_id) = 'it_prog';
 
SELECT *
  FROM employees
 WHERE job_id = UPPER('it_prog');
 
-- 3) INITCAP ( ) : 첫글자만 대문자로 변환 (나머지는 소문자)
SELECT 'DataBase', INITCAP('DataBase') 
  FROM DUAL;

-- 이름이 'LEX' 인 사원의 모든 정보를 출력
SELECT *
  FROM employees
 where first_name = INITCAP('LEX');
 
-- 4) 문자를 연결하는 CONCAT 함수 (문자열을 2개만 연결 가능)
SELECT CONCAT('data', 'base') 
  FROM DUAL;
--SELECT CONCAT('data', 'base', 'sql') FROM DUAL; => Error
SELECT CONCAT('data', CONCAT('base', 'sql')) FROM DUAL;
SELECT 'data' || 'base' || 'oracle' 
  FROM DUAL;

-- 모든 사원의 이름과 성을 합하여 이름 , 성으로 출력하고, column 명을 full name으로 바꾸기

--SELECT CONCAT (last_name, first_name) AS fullName
--  FROM employees;
  
SELECT last_name || ',' || first_name AS fullName
  FROM employees;
  
-- 5) length ( ) : 문자열 길이(글자수)를 구하는 함수
SELECT LENGTH ('database') FROM dual;
SELECT LENGTH ('데이터베이스') FROM dual;
SELECT LENGTHB ('database') FROM dual; -- 바이트수
SELECT LENGTHB ('데이터베이스') FROM dual; -- 바이트수 (한글 : 한글자당 3 byte)

-- 이름이 6글자 이하인 사원들의 이름을 소문자로 출력
SELECT LOWER(first_name)
  FROM employees
 WHERE LENGTH (first_name) <= 6;
 
-- 6) SUBSTR ( ) : 문자열의 일부를 추출하는 함수
-- SUBSTR(대상, 시작 위치, 추출할 갯수)
SELECT SUBSTR('database', 1, 3) FROM DUAL; -- 1부터 3글자 추출
SELECT SUBSTR('database', -4, 3) FROM dual; -- (-) 번쨰는 문자열의 끝부터 시작

-- 입사 연도가 2005년인 사원들의 모든 정보를 출력
-- SUBSTR() 함수를 이용
SELECT *
FROM employees
WHERE SUBSTR(hire_date, 1, 2) = '05';

-- 이름의 마지막 글자가 EL로 끝나는 사원들의 모든 정보를 출력하자
SELECT *
  FROM employees
 WHERE SUBSTR(first_name, -2, 2) = 'el';

SELECT *
  FROM employees
 WHERE first_name like '%el';
 
-- 7) INSRT ( ) : 특정 문자의 위치를 구하는 함수
--INSRT(대상문자열, 찾을 문자열, [찾기 시작하는 위치])
SELECT INSTR('database', 'b') 
  FROM dual;
SELECT INSTR('database', 'a') 
  FROM dual;
SELECT INSTR('database', 'a', 3) 
  FROM dual; -- 3번째 위치부터 찾기 시작

-- 이름의 세번째 자리가 i 인 사원의 모든 정보를 출력
-- like ' '
SELECT *
  FROM employees
 WHERE first_name like '__i%';
-- SUBSTR ()
SELECT *
  FROM employees
 WHERE SUBSTR(first_name, 3, 1) = 'i';
-- INSTR ()
SELECT *
  FROM employees
 WHERE INSTR(first_name, 'i') = 3;
 
-- 8) TRIM( ) : 특정 문자를 잘라주는 함수
SELECT TRIM('a' FROM 'aaaaaDataBaseaaaa') 
  FROM dual;
  
SELECT TRIM(' ' FROM'    DataBase    ') 
  FROM dual;

-- 8)-1 TRIM ([삭제 옵션], 삭제할 문자 FROM 대상문자열);
-- 삭제 옵션 : LEADING (왼쪽 문자를 지움) | TRAILING (오른쪽 문자를 지움)
--         : BOTH (양쪽 문자를 지움)

SELECT '[' || TRIM(LEADING '_' FROM '__database__') || ']' 
  FROM DUAL;
  
SELECT '[' || TRIM(TRAILING '_' FROM '__database__') || ']' 
  FROM DUAL;
  
SELECT '[' || TRIM(BOTH '_' FROM '__database__') || ']' 
  FROM DUAL;

-- 8)-2 LTRIM( ) | RTRIM( ) 
-- LTRIM([원본 문자열 데이터(필수)], [삭제할 문자 집합(선택) - default ' '])
-- RTRIM([원본 문자열 데이터(필수)], [삭제할 문자 집합(선택) - default ' '])
SELECT '00011000', 
       LTRIM ('00011000', '0') 
  FROM DUAL;
  
SELECT '00011000', 
       RTRIM ('00011000', '0') 
  FROM DUAL;

SELECT 111 
  FROM DUAL; -- 숫자 : 오른쪽 정렬
  
SELECT '111' 
  FROM DUAL; -- 문자 : 왼쪽 정렬

-- 9) REPLACE ( )
-- REPLACE([문자열 데이터 또는 열 이름(필수)], [찾는 문자(필수)], [대체할 문자(선택) - default ''])
SELECT '010-1234-5555', 
       REPLACE('010-1234-5555', '-', '') 
  FROM DUAL;
  
SELECT '010-1234-5555', 
       REPLACE('010-1234-5555', '-') 
  FROM DUAL;

-- 10) LPAD( ) | RPAD ( )
-- LPAD([문자열 데이터 또는 열이름(필수)], [데이터의 자릿수(필수)], [빈 공간을 채울 문자(선택) - default ' '])
-- RPAD([문자열 데이터 또는 열이름(필수)], [데이터의 자릿수(필수)], [빈 공간을 채울 문자(선택) - default ' '])
SELECT LPAD('database', 10, '$') 
  FROM DUAL;
  
SELECT RPAD('database', 10, '$') 
  FROM DUAL;
  