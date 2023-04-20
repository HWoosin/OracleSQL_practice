drop table dept3;
--������ (���������� �����ϴ� ���� ����� �ִ� ��ü)

create sequence dept3_seq
    start with 1 -- ���۰� (�⺻���� ������ �� �ּҰ�, ������ �� �ִ밪)
    INCREMENT by 1 -- ������ (����� ����, ������ ����, �⺻�� 1)
    maxvalue 10 -- �ִ밪(�⺻���� ���� 1027, �����϶� -1)
    minvalue 1 -- �ּҰ�(�⺻�� ���� 1, ������ �� -1028)
    nocache --ĳ�ø޸� ��� ���� (cache)
    nocycle -- ��ȯ���� (nocycle�� �⺻, ��ȯ��Ű���� cycle)
    ;

create table dept3 (
    dept_no number(2) primary key,
    dept_name varchar2(14),
    loca varchar2(13),
    dept_date date
);
--������ ����ϱ� (NextVal, CurrVal)
insert into dept3
values(dept3_seq.nextval,'test','test',sysdate);

select * from dept3;

select dept3_seq.currval from dual;

--������ ���� (���� ���� ����)
--START WITH�� ������ �Ұ���.
alter sequence dept3_seq Maxvalue 10; --�ִ밪 ����
alter sequence dept3_seq increment by -1; --����������
alter sequence dept3_seq Minvalue 0; --�ּҰ� ����
drop table dept3;

--������ ���� �ٽ� ó������ ������ ���
select dept3_seq.currval from dual;
alter sequence dept3_seq increment by -9;

drop sequence dept3_seq;

/*
- index
index�� primary key, unique ���� ���ǿ��� �ڵ����� �����ǰ�,
��ȸ�� ������ �� �ִ� hint ������ �մϴ�.
index�� ��ȸ�� ������ ������, �������ϰ� ���� �ε����� �����ؼ�
����ϸ� ������ ���� ���ϸ� ����ų �� �ֽ��ϴ�.
���� �ʿ��� ���� index�� ����ϴ� ���� �ٶ����մϴ�.
*/

select * from employees where salary = 12008;

--�ε��� �߰�
create index emp_salary_idx on employees(salary);

drop index emp_salary_idx;

--�������� �ε����� ����ϴ� hint���
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

--�ε��� �̸� ����
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
--������ �ε����� ������ ���Բ� ����.
--INDEX, ASC, DESC�� �߰��ؼ� ������, ������ ������ ���Բ� ���� �ڴ�.

select *from
    (
    select /*+ index_desc(tbl_board tbl_board_idx)*/
    rownum as rn, bno, writer 
    from tbl_board
    )
where rn >10 and rn <21;

/*
- �ε����� ����Ǵ� ��� 
1. �÷��� WHERE �Ǵ� �������ǿ��� ���� ���Ǵ� ���
2. ���� �������� ���� �����ϴ� ���
3. ���̺��� ������ ���
4. Ÿ�� �÷��� ���� ���� null���� �����ϴ� ���.
5. ���̺��� ���� �����ǰ�, �̹� �ϳ� �̻��� �ε����� ������ �ִ� ��쿡��
 �������� �ʽ��ϴ�.
*/