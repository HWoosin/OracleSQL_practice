drop table members;

create table members(
    mem_id varchar2(20) primary key,
    mem_pw varchar2(20) not null,
    mem_name varchar2(20) not null,
    mem_age number(2),
    mem_regdate date default sysdate
);

select * from members;