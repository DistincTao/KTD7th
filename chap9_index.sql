select * from employees
where employee_id = 100;

select * from employees
where phone_number = '515.123.4567';

select * from employees
where first_name = 'Steven';

drop table members;
create table members
(
memberId number primary key,
first_name varchar2(10) not null,
last_name varchar2(10) not null,
email varchar2(10),
phone_number varchar2(20),
regDate date
);

insert into members values (1, 'dooly', 'kim', 'dkim', '010-555-1234', '23/10/01');
insert into members values(2, 'ddhoci', 'lee', 'ddlee', '101-555-1133', '23/10/31');
insert into members values(3, 'gildong', 'choi', 'gchoi', '010-555-1233', '23/10/31');

select * from members;
select * from user_indexes
where table_name ='MEMBERS';

-- 인덱스 생성
create index regDate_idx
on members (regDate);

select * from members
where email ='dkim';

select * from members
where regDate = '23/10/01';

-- 다중속성 인덱스 생성
create index name_idx
on members (first_name, last_name);

select * from members
where first_name = 'dooly';

