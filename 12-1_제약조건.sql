
-- ���̺� ������ ��������
-- ���̺� ������ �������� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű)
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL: null�� ������� ����.
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷�
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���.

DROP TABLE dept2;

-- �÷� ���� ���� ���� (�÷� ���𸶴� �������� ����)
CREATE TABLE dept2 (
    dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

-- ���̺� ���� ���� ����(��� �� ���� �� ���������� ���ϴ� ���)
CREATE TABLE dept2(
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1),
    
    CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

-- �ܷ� Ű(foreign key)�� �θ����̺�(�������̺�)�� ���ٸ� INSERT�� �Ұ���
INSERT INTO dept2
VALUES(10, 'gg', 4000, 100000, 'M'); -- ����

-- �ֿ� Ű(primary key)�� ������ �ĺ��ڿ��� �մϴ�.
INSERT INTO dept2
VALUES(20, 'hh', 1900, 100000, 'M');

UPDATE dept2
SET loca = 4000
WHERE dept_no = 10; -- ����(�ܷ�Ű �������� ����)

UPDATE dept2
SET loca = 4000
WHERE loca = 1800; -- ����(�ܷ�Ű �������� ����)

-- ���� ���� ����
-- ���� ������ �߰�, ������ �����մϴ�. ������ �ȵ˴ϴ�.
-- �����Ϸ��� �����ϰ� ���ο� �������� �߰��ϼž� �մϴ�.

DROP TABLE dept2;

CREATE TABLE dept2(
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

--pk �߰�
alter table dept2 add constraint dept_no_pk primary key(dept_no);
--fk �߰�
alter table dept2 add constraint dept2_loca_locid_fk
foreign key(loca) references locations(location_id);
--check �߰�
alter table dept2 add CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'));
--unique �߰�
alter table dept2 add CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);
--not null�� �� �������·� ����.
alter table dept2 modify dept_bonus number(10) not null;

--���� ���� ���� (�������� �̸�����)
alter table dept2 drop constraint dept_no_pk;

--�������� Ȯ��
select * from user_constraints
where table_name = 'DEPT2';



/*���� 1*/
drop table members;
create table members(
    M_NAME varchar2(3) not null,
    M_NUM number(1) constraint mem_memnum_pk primary key,
    REG_DATE date not null constraint mem_redate_uk unique,
    GENDER varchar2(1) constraint mem_gender CHECK(GENDER IN('M', 'F')),
    LOCA number(20) constraint mem_loca_loc_locid_fk references locations(location_id)
);
select * from user_constraints
where table_name ='MEMBERS';

insert into members values ('AAA', 1, '2018-07-01','M',1800);
insert into members values ('BBB', 2, '2018-07-02','F',1900);
insert into members values ('CCC', 3, '2018-07-03','M',2000);
insert into members values ('DDD', 4, sysdate,'M',2000);

/*���� 2*/
select *from locations;

select m.m_name, m.m_num, l.street_address, l.location_id
from members m join locations l 
on m.loca =l.location_id
order by m_num asc;





