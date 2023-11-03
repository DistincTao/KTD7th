--  DCL
CREATE TABLE GOOTT
(USERID NUMBER(3), USERNAME VARCHAR2 (10),CONTENT VARCHAR2 (50)); 

INSERT INTO GOOTT
VALUES (80, 'TH', '비타민C 과다 섭취 중');

SELECT * FROM GOOTT;

COMMIT;

DELETE FROM GOOTT
WHERE USERNAME = 'HS';

ROLLBACK;

-- DML은 한번 실행 하면 복구 안됨
-- DDL은 마지막 COMMIT 위치까지 ROOLBACK 가능

UPDATE GOOTT
   SET CONTENT ='삭제 되었습니다.'
 WHERE USERID = 110;
--> UPDATE 후 COMMIT 을 하지 않으면 테이블에  LOCK이 걸려서 다른 사람의 수정 작업은 불가

COMMIT;

INSERT INTO GOOTT
VALUES (180, 'UNKNOWN', '아직도 목이 아파요');

SAVEPOINT AFTER_INSERT; --> 저장 지점 설정 

UPDATE GOOTT
   SET CONTENT = '기침'
 WHERE USERID = 80;
 
ROLLBACK TO AFTER_INSERT; --> 지정할 되돌릴 시점 지정
--> COMMIT 후에는 COMMIT을 한 지점이 SAVEPOINT로 지정됨

-- 문제) 
-- 다음의 쿼리문이 순서대로 실행되었다면, DB에 영구 반영되는 문장은 몇번? 1, 7, 9
--1. insert문 수행
--2. savepoint a;
--3. delete 문 수행
--4. savepoint b;
--5. update문 수행
--6. rollback to a;
--7. insert문 수행
--8. savepoint c;
--9. delete문 수행
--10. commit; 



