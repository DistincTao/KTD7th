-- 게시판 테이블 생성
create table board 
(
no number(6) primary key,
title varchar2(100),
writer varchar2(20)
);

insert into board values(1, '감기조심', 'dooly');
insert into board values(2, '감기조심2', 'dochi');
insert into board values(3, '감기조심3', 'huidong');
select * from board;
select max(no)+1 from board;

drop table board;

-- 시퀀스 생성
-- create sequence 시퀀스명
-- [start with n]  -- 시쿼스의 시작 값
-- [increment by n] -- 증가하거나 감소하는 값
-- [maxvalue n | nomaxvalue] -- 최대값
-- [minvalue n | nominvalue] -- 최소값
-- [cycle | nocycle] -- cycle을 지정하면 최대값 까지 증가가 완료된 후 최소값부터 다시 시작
-- [cache n | nocache] -- 오라클 서버가 미리 지정하고 메모리에 확보할 값

create sequence seq_board
start with 1
increment by 1;

select * from user_sequences;

insert into board values(seq_board.nextval, 'title1', 'dooly');
insert into board values(seq_board.nextval, 'title2', 'ddochi');
insert into board values(seq_board.nextval, 'title3', 'huidong');
select * from board;

select seq_board.currval from dual;
select seq_board.nextval from dual; -- 참조하는 것만으로 시퀀스 값이 증가한다.
insert into board values(seq_board.nextval, 'title4', 'michol');
select seq_board.nextval from dual;
insert into board values(seq_board.nextval, 'title5', 'gildong');
-- product테이블 생성
create table product (
    serialNo varchar2(10) primary key,
    prodName varchar2(14)
);
-- 시퀀스 생성
create sequence seq_prod
start with 1
increment by 1
maxvalue 5
cycle
cache 2;

select to_char(sysdate,'yymmdd') from dual;
insert into product values(
    to_char(sysdate,'yymmdd') || '-' || seq_prod.nextval, '모니터');
);
select * from product;
insert into product values(
    to_char(sysdate,'yymmdd') || '-' || seq_prod.nextval, '모니터');
);
select seq_prod.currval from dual;
select seq_prod.nextval from dual;
-- 5까지 자동 증가하다가 더 이상 데이터는 추가 되지 않는다. (unique제약조건 위반)

-- 시퀀스 수정
alter sequence seq_prod
nocycle;

insert into product values(
    to_char(sysdate,'yymmdd') || '-' || seq_prod.nextval, '모니터');
 
-- 시퀀스 삭제
drop sequence seq_prod;
    
-- 인덱스
select * from user_indexes;
select * from user_indexes
where table_name = 'EMPLOYEES';

select * from employees
where employee_id = 100;


    