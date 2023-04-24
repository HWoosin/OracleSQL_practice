--연동을 위한 sql문입니다. 230423
drop table members;
--create user hr identified by hr;
--alter user hr account unlock identified by hr;
create table members(
    mem_id varchar2(20) primary key,
    mem_pw varchar2(20) not null,
    mem_name varchar2(20) not null,
    mem_age number(2),
    mem_regdate date default sysdate
);
alter table members add(email varchar2(20));

select * from members;
