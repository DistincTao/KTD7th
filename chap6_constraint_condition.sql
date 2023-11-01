---------------------------------------------------------------------------
-- 제약 조건
--- (1) NOT NULL 제약 조건

DROP TABLE EMP01;
CREATE TABLE EMP01
      (EMPNO NUMBER(4),
       ENAME VARCHAR2(10));

INSERT INTO EMP01 
VALUES(NULL, '둘리');

INSERT INTO EMP01 
VALUES(NULL, '도우너');

DROP TABLE EMP01;
CREATE TABLE EMP01
      (EMPNO NUMBER(4)NOT NULL,
       ENAME VARCHAR2(10) NOT NULL);

INSERT INTO EMP01  --> ORA-01400: cannot insert NULL into ("HR"."EMP01"."EMPNO")
VALUES(NULL, '둘리');

INSERT INTO EMP01 
VALUES(1001, '도우너');

-- (2) UNIQUE 제약 조건
DROP TABLE EMP01;
CREATE TABLE EMP01
      (EMPNO NUMBER(4)NOT NULL,
       ENAME VARCHAR2(10) UNIQUE);

INSERT INTO EMP01  --> ORA-01400: cannot insert NULL into ("HR"."EMP01"."EMPNO")
VALUES(1000, '둘리');

INSERT INTO EMP01 
VALUES(1001, '둘리'); --> ORA-00001: unique constraint (HR.SYS_C007018) violated

INSERT INTO EMP01
VALUES (1000, '도우너');

INSERT INTO EMP01
VALUES (1001, '희동이');
-- (3) PRIMARY KEY 제약 조건
DROP TABLE EMP01;
CREATE TABLE EMP01
      (EMPNO NUMBER(4)PRIMARY KEY,
       ENAME VARCHAR2(10) NOT NULL);

INSERT INTO EMP01
VALUES(1000, '둘리');

INSERT INTO EMP01
VALUES (1001, '도우너');

INSERT INTO EMP01
VALUES (1001, '희동이'); -- NOT NULL 은 아니지만 UNIQUE에서 제약에 걸림
---> ORA-00001: unique constraint (HR.SYS_C007020) violated
-- NOT NULL 이고, UNIQUE 한 값이기 때문에 이 컬럼을 통해 검색, 수정, 삭제하는 것이 좋다

-- EMP01 테이블에 SAL 컬럼을 추가하세요. NUMBER (6)
ALTER TABLE EMP01
   ADD (SAL NUMBER(6));
COMMIT; --> 영구 저장

-- 1000번 사원의 급여를 5000으로 하자
UPDATE EMP01
   SET SAL = 5000
 WHERE EMPNO = 1000;
 
ROLLBACK; --> 저장된 위치로 돌리기
COMMIT; --> 영구 저장

-- (4)FOREIGN KEY
-- 오류가 발생하는 경우
-- 1) 부서 번호가 부서 테이블(부모테이블)에 존재 하지 않는 값을 넣으려고 할 때
INSERT INTO EMPLOYEES
VALUES (207,
        'gilding',
        'Koh',
        'kgildong',
        NULL,
        SYSDATE,
        'IT_PROG',
        5000,
        NULL,
        115,
        280); --> ORA-02291: integrity constraint 
              -- (HR.EMP_DEPT_FK) violated - parent key not found

-- 2) 사원이 있는 부서를 삭제하려고 할 때
DELETE FROM DEPARTMENTS
 WHERE DEPARTMENT_ID = 60;
                --> ORA-02292: integrity constraint 
                -- (HR.EMP_DEPT_FK) violated - child record found

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID =60;

UPDATE EMPLOYEES
   SET DEPARTMENT_ID = 210;
-- ORA-00001: unique constraint (HR.JHIST_EMP_ID_ST_DATE_PK) violated
-- ORA-06512: at "HR.ADD_JOB_HISTORY", line 10
-- ORA-06512: at "HR.UPDATE_JOB_HISTORY", line 2
-- ORA-04088: error during execution of trigger 'HR.UPDATE_JOB_HISTORY'
UPDATE EMPLOYEES
   SET DEPARTMENT_ID = 210
 WHERE DEPARTMENT_ID = 60;

DELETE FROM DEPARTMENT WHERE DEPARTMENT_ID = 60;
--> ORA-02292: integrity constraint 
-- (HR.EMP_DEPT_FK) violated - child record foun
-- 다른 테이블에 등록되어 있는 값이 있으면 삭제가 안됨

-- 부서 테이블과 사원 테이블을 만들어 보자
CREATE TABLE DEPT01
      (DEPTNO NUMBER(2) PRIMARY KEY,
       DNAME VARCHAR2(10) NOT NULL);

CREATE TABLE EMP01
      (EMPNO NUMBER(4) PRIMARY KEY,
       ENAME VARCHAR2(10) NOT NULL,
       DEPTNO NUMBER(2) NOT NULL REFERENCES DEPT01(DEPTNO));
       
INSERT INTO DEPT01
VALUES (10, '총무부');

INSERT INTO DEPT01
VALUES (20, 'IT');

INSERT INTO EMP01
VALUES (1000, '둘리', 30); -->ORA-02291: integrity constraint (HR.SYS_C007026) violated
                          -- - parent key not found
INSERT INTO EMP01
VALUES (1000, '둘리', 10);
INSERT INTO EMP01
VALUES (1001, '영희', 20);

SELECT * FROM DEPT01;
SELECT * FROM EMP01;

UPDATE EMP01
   SET DEPTNO = 10
 WHERE DEPTNO = 20;
 
DELETE FROM DEPT01
 WHERE DEPTNO = 20;
 
  DROP TABLE DEPT01; -- ORA-02449: unique/primary keys in table referenced by foreign keys
                     --> FOREIGN KEY로 참조된 테이블이 있을 경우 삭제 불가
  DROP TABLE EMP01;
  DROP TABLE DEPT01;
  
-- (5) CHECK 제약 조건
CREATE TABLE EMP01
      (EMPNO NUMBER(4) PRIMARY KEY,
       ENAME VARCHAR2(10) NOT NULL,
       GENDER CHAR(1) CHECK (GENDER IN ('M', 'F', 'U')));

INSERT INTO EMP01
VALUES (1000, '홍길동', 'm'); --> 대소문자를 구분해서 오류 발생
                   -- ORA-02290: check constraint (HR.SYS_C007028) violated 
       
INSERT INTO EMP01
VALUES (1000, '홍길동', 'M');

INSERT INTO EMP01
VALUES (1001, '홍길서', 'F');

DROP TABLE EMP01;

CREATE TABLE MEMBER
      (USERID VARCHAR2(10) PRIMARY KEY,
       PASSWORD VARCHAR2 (20) NOT NULL,
       AGE NUMBER(3) CHECK (AGE BETWEEN 20 AND 150));
    
INSERT INTO MEMBER
VALUES ('DOLLY', '1234', 10); --> ORA-02290: check constraint (HR.SYS_C007031) violated

INSERT INTO MEMBER
VALUES ('DOLLY', '1234', 20);

INSERT INTO MEMBER
VALUES ('DONER', '1234', 100);

INSERT INTO MEMBER
VALUES ('MYCALL', '1234', 150);

INSERT INTO MEMBER
VALUES ('DOOLYMOM', '1234', 200);
--> ORA-02290: check constraint (HR.SYS_C007031) violated

DROP TABLE MEMBER;

-- (6) DEFAULT 
CREATE TABLE DEPT01
      (DEPTNO NUMBER(3) PRIMARY KEY,
       DNAME VARCHAR2(10),
       LOC VARCHAR2(16) DEFAULT 'SEOUL');
       
INSERT INTO DEPT01(DEPTNO, DNAME) 
VALUES (10, '개발부'); --> 기입하지 않으면 DEFAULT 값으로 입력됨

INSERT INTO DEPT01
VALUES (20, '총무부', NULL); --> 명시적으로 NULL로 지정

-- 제약 조건 이름 기술하기
-- -> [TABLE]_[COLUMN]_[제약조건]
-- 필수 조건은 아니지만 만들어 주는 것이 좋다!
-- 지정해 주지 않으면 ORACLE에서 알아서 지정을 함
CREATE TABLE DEPT01 (
       DEPTNO NUMBER(2) CONSTRAINT DEPT01_DEPTNO_PK PRIMARY KEY,
       DNAME VARCHAR2(10) CONSTRAINT DEPT01_DNAME_NN NOT NULL,
       LOC VARCHAR2(16) DEFAULT 'SEOUL'
       );
       
CREATE TABLE EMP01 (
       EMPNO NUMBER(4) CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY,
       ENAME VARCHAR2(10) CONSTRAINT EMP01_ENAME_NN NOT NULL,
       EMAIL VARCHAR2(20) CONSTRAINT EMP01_EMAIL_UK UNIQUE,
       GENDER VARCHAR2(5) CONSTRAINT EMP01_GENDER_CK CHECK (GENDER IN ('MALE', 'FEMALE')),
       DEPTNO NUMBER(2) CONSTRAINT EMP01_DEPTNO_FK REFERENCES DEPT01(DEPTNO)
       );
       
INSERT INTO DEPT01
VALUES (10, '총무부', 'busan');

INSERT INTO EMP01
VALUES (1000, 'DOOLY', 'ddooly', 'MALE', 10);

INSERT INTO EMP01
VALUES (1001, 'DOOLY', 'dooly', 'MALE', 20);
-- >ORA-02291: integrity constraint (HR.EMP01_DEPTNO_FK) violated - parent key not found

SELECT * FROM USER_CONSTRAINTS; --> 모든 테이블의 제약 조건 명을 확인 가능

DROP TABLE EMP01;
DROP TABLE DEPT01;

CREATE TABLE DEPT01 (
       DEPTNO NUMBER(4),
       DNAME VARCHAR2(20),
       LOC VARCHAR2(10),
       CONSTRAINT DEPT01_DEPTNO_PK PRIMARY KEY (DEPTNO),
       CONSTRAINT DEPT01_DNAME_UK UNIQUE (DNAME)
       );
DROP TABLE EMP01;

CREATE TABLE EMP01 (
       EMPNO NUMBER(4) CONSTRAINT EMP01_EMPNO_CK CHECK (EMPNO > 100), 
       ENAME VARCHAR2(10) CONSTRAINT EMP01_ENAME_NN NOT NULL,
       SALARY NUMBER(5),
       DEPTNO NUMBER(4),
       CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO),
       CONSTRAINT EMP01_ENAME_CK CHECK (SALARY > 0),
       CONSTRAINT EMP01_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT01 (DEPTNO)
       );
       
INSERT INTO DEPT01
VALUES (10, '총무부', '부산');

INSERT INTO DEPT01
VALUES (20, '개발부', '서울');

INSERT INTO EMP01 VALUES (90, 'DOOLY', 5000, 20);
--> ORA-02290: check constraint (HR.EMP01_EMPNO_CK) violated
-- 추가적으로 CONSTRAINT를 적용 가능
INSERT INTO EMP01 VALUES (101, 'DOOLY', 5000, 20);
INSERT INTO EMP01 VALUES (102, 'MYCALL', 7000, 10);

----------------------------------------------------------------------------
-- 복합키로 PRIMARY KEY를 사용해야 하는 이유
----------------------------------------------------------------------------
-- 1) 복합키
CREATE TABLE MEMBER (
       EMAIL VARCHAR2(40),
       PASSWD VARCHAR2(50) CONSTRAINT MEMBER_PASSWD_NN NOT NULL,
       MEMNAME VARCHAR2(10) CONSTRAINT MEMBER_MEMNAME_NN NOT NULL,
       MOBILE CHAR(13),
       ADDR VARCHAR2(50),
       CONSTRAINT MEMBER_COMBO_PK PRIMARY KEY (EMAIL, MOBILE)
       );

-- 회원 가입
INSERT INTO MEMBER 
VALUES ('a@abc.com',
        '1234',
        '홍길동',
        '010-5555-1234',
        NULL);
        
INSERT INTO MEMBER 
VALUES ('a@abc.com',
        '1234',
        '청길동',
        '010-5555-1234',
        NULL); -- > ORA-00001: unique constraint (HR.MEMBER_COMBO_PK) violated

INSERT INTO MEMBER 
VALUES ('a@abc.com',
        '1234',
        '청길동',
        '010-5555-4567',
        NULL); --> 둘 다 다르면 안되지만 둘 중 하나만 다르면 가능

INSERT INTO MEMBER 
VALUES ('b@abc.com',
        '1234',
        '황길동',
        '010-5555-4567',
        NULL); --> 둘 다 다르면 안되지만 둘 중 하나만 다르면 가능
        
-- 로그인
SELECT * FROM MEMBER
 WHERE EMAIL = 'b@abc.com' AND PASSWD = '1234'; -- 로그인 성공

SELECT COUNT(*) FROM MEMBER
 WHERE EMAIL = 'b@abc.com' AND PASSWD = '1234'; -- 1

-- 
SELECT * FROM MEMBER
 WHERE EMAIL = 'b@abc.com' AND PASSWD = '123'; -- 로그인 실패
 
SELECT COUNT(*) FROM MEMBER
 WHERE EMAIL = 'b@abc.com' AND PASSWD = '123'; -- 0
 
-- 2) ALTER TABLE로 제약 조건 추가
-- ALTER TABLE 테이블명
--   ADD [CONSTRAINT 제약 조건 이름] 제약 조건 (COLUMN명);

 ALTER TABLE MEMBER
   ADD GENDER CHAR(3);
   
 ALTER TABLE MEMBER
   ADD CONSTRAINT MEMBER_GENDER_CK CHECK (GENDER IN ('남', '여'));

-- ADDR 컬럼에 NOT NULL 제약 조건을 수정
 ALTER TABLE MEMBER
MODIFY ADDR CONSTRAINT MEMBER_ADDR_NN NOT NULL;
--> ORA-02296: cannot enable (HR.MEMBER_ADDR_NN) - null values found
-- 이미 NULL 값이 있어서 바꿔지지 않는다.

UPDATE MEMBER
   SET ADDR = '서울 구로';

 ALTER TABLE MEMBER
MODIFY ADDR CONSTRAINT MEMBER_ADDR_NN NOT NULL;
-- NULL 값을 모두 다른 값으로 변경 후 제약 조건 변경(추가) 가능

-- 3) 제약 조건 제거하기
-- ALTER TABLE 테이블명
--  DROP CONSTRAINT 제약 조건 이름;

 ALTER TABLE MEMBER
  DROP CONSTRAINT MEMBER_ADDR_NN;

-- 4) 제약 조건 일시적 비활성화
--  ALTER TABLE 테이블명
-- DISABLE CONSTRAINT 제약 조건 이름;

 ALTER TABLE MEMBER
DISABLE CONSTRAINT MEMBER_MEMNAME_NN;

INSERT INTO MEMBER
VALUES ('c@abc.com', '1234', NULL, '010-5555-1231', '서울 구로', '남');

-- 5) 제약 조건 일시적 활성화
--  ALTER TABLE 테이블명
-- ENSABLE CONSTRAINT 제약 조건 이름;

 ALTER TABLE MEMBER
ENABLE CONSTRAINT MEMBER_MEMNAME_NN;
--> 비활성화 되어 있는 상태에서 추가된 NULL로 인해 재 활성화 불가
--> ORA-02293: cannot validate (HR.MEMBER_MEMNAME_NN) - check constraint violated

UPDATE MEMBER
   SET MEMNAME = '흑길동'
 WHERE EMAIL = 'c@abc.com';
 
  ALTER TABLE MEMBER
ENABLE CONSTRAINT MEMBER_MEMNAME_NN;

-- 제약 조건을 비활성화 하면 제약조건을 위반한 컬롬의 값도 저장 될 수 있다.
-- 하지만, 제약 조건을 다시 활성화 하면, 재약 조건을 위반한 컬럼의 값 때문에 다시 활성화 되지 않는다.
-- 이때는 제약조건을 위반한 컬럼의 값을 제약조건을 지키도록 수정한 뒤 활성화 한다.

CREATE TABLE MEMBER (
       USERID VARCHAR2(12),
       PWD VARCHAR2(20) CONSTRAINT MEMBER_PWD_NN NOT NULL,
       CONSTRAINT MEMBER_USERID_PK PRIMARY KEY (USERID)
       );

INSERT INTO MEMBER
VALUES ('GILDONG', '1234');

INSERT INTO MEMBER
VALUES ('DOOLY', '1234');

CREATE TABLE BOARD (
       BOARDNO NUMBER(10),
       WRITER VARCHAR2(12),
       TITLE VARCHAR2(40),
       CONSTRAINT BOARD_BOARDNO_PK PRIMARY KEY (BOARDNO),
       CONSTRAINT BOARD_WRITER_FK FOREIGN KEY (WRITER) 
                  REFERENCES MEMBER (USERID)
                  ON DELETE CASCADE
       );
       
INSERT INTO BOARD
VALUES (1, 'DOOLY', '아싸1등');

INSERT INTO BOARD
VALUES (2, 'GILDING', '1등 놓첬네');

INSERT INTO BOARD
VALUES (3, 'DOOLY', '아 배고프당');

DELETE FROM MEMBER 
 WHERE USERID = 'DOOLY';

  DROP TABLE BOARD; --> 자식 먼저 삭제
  DROP TABLE MEMBER; --> 자식 삭제 후 부모 삭제

CREATE TABLE MEMBER (
       USERID VARCHAR2(12),
       PWD VARCHAR2(20) CONSTRAINT MEMBER_PWD_NN NOT NULL,
       CONSTRAINT MEMBER_USERID_PK PRIMARY KEY (USERID)
       );

CREATE TABLE BOARD (
       BOARDNO NUMBER(10),
       WRITER VARCHAR2(12),
       TITLE VARCHAR2(40),
       CONSTRAINT BOARD_BOARDNO_PK PRIMARY KEY (BOARDNO),
       CONSTRAINT BOARD_WRITER_FK FOREIGN KEY (WRITER) 
                  REFERENCES MEMBER (USERID)
                  ON DELETE SET NULL
       );

INSERT INTO MEMBER
VALUES ('DOOLY', '1234');

INSERT INTO MEMBER
VALUES ('GILDONG', '1234');

INSERT INTO BOARD
VALUES (1, 'DOOLY', '벌써 점심시간이 지나다니....');

INSERT INTO BOARD
VALUES (2, 'GILDONG', '슬슬 졸리네...');

INSERT INTO BOARD
VALUES (3, 'DOOLY', '낮잠이나 잘까?');

DELETE FROM MEMBER
 WHERE USERID  = 'DOOLY';
 
  DROP TABLE BOARD;
  DROP TABLE MEMBER;

------------------------------------------------------------------------------
-- 연습 문제
------------------------------------------------------------------------------
CREATE TABLE MEMBER(
       ID VARCHAR2(20),
       PASSWORD VARCHAR2(40),
       REGNO VARCHAR2(13) CONSTRAINT MEMBER_REGNO_NN NOT NULL,
       MOBILE VARCHAR2(13),
       ADDRESS VARCHAR2(100),
       CONSTRAINT MEMBER_ID_PK PRIMARY KEY (ID),
       CONSTRAINT MEMBER_REGNO_UK UNIQUE (REGNO),
       CONSTRAINT MEMBER_MOBILE_UK UNIQUE (MOBILE)
       );

CREATE TABLE BOOK(
       CODE NUMBER(4),
       TITLE VARCHAR2(50) CONSTRAINT BOOK_TITLE_NN NOT NULL,
       COUNT NUMBER(6),
       PRICE NUMBER(10),
       PUBLISH VARCHAR2(50),
       CONSTRAINT BOOK_CODE_PK PRIMARY KEY (CODE)
       );
       
CREATE TABLE BOOKORDER(
       NO VARCHAR(10),
       ID VARCHAR2(20) CONSTRAINT BOOKORDER_ID_NN NOT NULL,
       CODE NUMBER(4) CONSTRAINT BOOKORDER_CODE_NN NOT NULL,
       COUNT NUMBER(6),
       ORDERDATE DATE,
       CONSTRAINT BOOKORDER_NO_PK PRIMARY KEY (NO),
       CONSTRAINT BOOKORDER_ID_FK FOREIGN KEY (ID)
                  REFERENCES MEMBER (ID),
       CONSTRAINT BOOKORDER_CODE_FK FOREIGN KEY (CODE)
                  REFERENCES BOOK (CODE)        
       );

