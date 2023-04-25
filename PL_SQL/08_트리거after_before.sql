
/*
afterƮ���� - insert, update, delete �۾� ���Ŀ� �����ϴ� Ʈ���Ÿ� �ǹ�
beforeƮ���� - insert, update, delete �۾� ������ �����ϴ� Ʈ���Ÿ� �ǹ�

:OLD = ���� �� ���� �� (insert: �Է� �� �ڷ�, update: ������ �ڷ�, delete: ������ ��)
:NEW = ���� ���� ���� �� (insert: �Է� �� �ڷ�, update: ���� �� �ڷ�)

���̺� update�� delete�� �õ��ϸ� ����, �Ǵ� ������ �����͸� ������ ���̺�
������ ���� �������� Ʈ���Ÿ� ���� ���.
*/

create table tbl_user(
    id varchar2(20) primary key,
    name varchar2(20),
    address varchar2(30)
);

create table tbl_user_backup(
    id varchar2(20) primary key,
    name varchar2(20),
    address varchar2(30),
    update_date date default sysdate, --����ð�
    m_type varchar2(10), -- ���� Ÿ��
    m_user varchar2(20) --������ �����
);

--afterƮ����
CREATE OR REPLACE TRIGGER trg_user_backup
    AFTER UPDATE OR DELETE
    ON tbl_user
    FOR EACH ROW
DECLARE -- ����� ������ �����ϴ� ��
    v_type VARCHAR2(10);
BEGIN
    IF UPDATING THEN -- UPDATING�� �ý��� ��ü���� ���¿� ���� ������ �����ϴ� ��Ʈ�� ����.
        v_type := '����';
    ELSIF DELETING THEN
        v_type := '����';
    END IF;
    
    -- ������ ���� ���� �ۼ�.
    INSERT INTO tbl_user_backup
    VALUES(:OLD.id, :OLD.name, :OLD.address, sysdate, v_type, USER());
    
END;

-- Ȯ��!
INSERT INTO tbl_user VALUES('test01', 'kim', '����');
INSERT INTO tbl_user VALUES('test02', 'lee', '���');
INSERT INTO tbl_user VALUES('test03', 'hong', '�λ�');

SELECT * FROM tbl_user;
SELECT * FROM tbl_user_backup;

UPDATE tbl_user SET address='��õ' WHERE id='test01';
DELETE FROM tbl_user WHERE id = 'test02';

--beforeƮ����
create or replace trigger trg_user_insert
    before insert
    on tbl_user
    for each row
begin
    :NEW.name := substr(:NEW.name,1,1) || '**';
end;

insert into tbl_user values('test04','�޷���','����');

--------------------------------------------------------------------------------
/*
-Ʈ������ Ȱ��
insert -> �ֹ����̺� -> �ֹ� ���̺� insertƮ���� ���� (��ǰ���̺� update)
*/

--�ֹ� �����丮
create table order_history(
    history_no number(5) primary key,
    order_no number(5),
    product_no number(5),
    total number(10),
    price number(10)
);

-- ��ǰ
drop table product;
create table product(
    product_no number(5) primary key,
    product_name varchar2(20),
    total number(5),
    price number(5)
);

create sequence order_history_seq nocache;
create sequence product_seq nocache;

insert into product values(product_seq.nextval, '����',100,10000);
insert into product values(product_seq.nextval, 'ġŲ',100,20000);
insert into product values(product_seq.nextval, '�ܹ���',100,5000);

select * from product;

--�ֹ� �����丮�� �����Ͱ� ������ ����.
create or replace trigger trg_order_history
    after insert
    on order_history
    for each row
declare
    v_total number;
    v_product_no number;
    
begin
    dbms_output.put_line('Ʈ���Ž���');
    select
        :NEW.total
    into
        v_total
    from dual;
    
    v_product_no := :new.product_no;
    
    update product set total = total- v_total
    where product_no = v_product_no;
end;

insert into order_history values(order_history_seq.nextval,200,1,5,50000);
insert into order_history values(order_history_seq.nextval,200,2,1,20000);

select * from product;