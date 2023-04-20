drop table dept3;
--시퀀스 (순차적으로 증가하는 값을 만들어 주는 객체)

create sequence dept3_seq
    start with 1 -- 시작값 (기본값은 증가할 때 최소값, 감소할 때 최대값)
    INCREMENT by 1 -- 증가값 (양수면 증가, 음수면 감소, 기본값 1)
    maxvalue 10 -- 최대값(기본값은 증가 1027, 감소일때 -1)
    minvalue 1 -- 최소값(기본값 증가 1, 감소일 때 -1028)
    nocache --캐시메모리 사용 여부 (cache)
    nocycle -- 순환여부 (nocycle이 기본, 순환시키려면 cycle)
    ;

create table dept3 (
    dept_no number(2) primary key,
    dept_name varchar2(14),
    loca varchar2(13),
    dept_date date
);
--시퀀스 사용하기 (NextVal, CurrVal)
insert into dept3
values(dept3_seq.nextval,'test','test',sysdate);

select * from dept3;

select dept3_seq.currval from dual;

--시퀀스 수정 (직접 수정 가능)
--START WITH은 수정이 불가능.
alter sequence dept3_seq Maxvalue 10; --최대값 증가
alter sequence dept3_seq increment by -1; --증가값변경
alter sequence dept3_seq Minvalue 0; --최소값 변경
drop table dept3;

--시퀀스 값을 다시 처음으로 돌리는 방법
select dept3_seq.currval from dual;
alter sequence dept3_seq increment by -9;

drop sequence dept3_seq;

/*
- index
index는 primary key, unique 제약 조건에서 자동으로 생성되고,
조회를 빠르게 해 주는 hint 역할을 합니다.
index는 조회를 빠르게 하지만, 무작위하게 많은 인덱스를 생성해서
사용하면 오히려 성능 부하를 일으킬 수 있습니다.
정말 필요할 때만 index를 사용하는 것이 바람직합니다.
*/

select * from employees where salary = 12008;

--인덱스 추가
create index emp_salary_idx on employees(salary);

drop index emp_salary_idx;

--시퀀스와 인덱스를 사용하는 hint방법
CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE TABLE tbl_board(
    bno NUMBER(10) PRIMARY KEY,
    writer VARCHAR2(20)
);

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'admin');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'hong');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'kim');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'admin');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'hong');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'kim');

SELECT * FROM

COMMIT;

--인덱스 이름 변경
alter index sys_c007058
rename to tbl_board_idx;

select *from
(
    select rownum as rn, a.*
    from
        (SELECT * FROM tbl_board
        order by bno desc) a
    )
where rn >10 and rn <21;

--/*+ INDEX(table_name iondex_name)*/
--지정된 인덱스를 강제로 쓰게끔 지정.
--INDEX, ASC, DESC를 추가해서 내림차, 오름차 순으로 쓰게끔 지정 자능.

select *from
    (
    select /*+ index_desc(tbl_board tbl_board_idx)*/
    rownum as rn, bno, writer 
    from tbl_board
    )
where rn >10 and rn <21;

/*
- 인덱스가 권장되는 경우 
1. 컬럼이 WHERE 또는 조인조건에서 자주 사용되는 경우
2. 열이 광범위한 값을 포함하는 경우
3. 테이블이 대형인 경우
4. 타겟 컬럼이 많은 수의 null값을 포함하는 경우.
5. 테이블이 자주 수정되고, 이미 하나 이상의 인덱스를 가지고 있는 경우에는
 권장하지 않습니다.
*/