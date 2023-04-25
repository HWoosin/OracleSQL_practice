
/*
after트리거 - insert, update, delete 작업 이후에 동작하는 트리거를 의미
before트리거 - insert, update, delete 작업 이전에 동작하는 트리거를 의미

:OLD = 참조 전 열의 값 (insert: 입력 전 자료, update: 수정전 자료, delete: 삭제될 값)
:NEW = 참조 후의 열의 값 (insert: 입력 할 자료, update: 수정 된 자료)

테이블에 update나 delete를 시도하면 수정, 또는 삭제된 데이터를 별도의 테이블에
보관해 놓는 형식으로 트리거를 많이 사용.
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
    update_date date default sysdate, --변경시간
    m_type varchar2(10), -- 변경 타입
    m_user varchar2(20) --변경한 사용자
);

--after트리거
CREATE OR REPLACE TRIGGER trg_user_backup
    AFTER UPDATE OR DELETE
    ON tbl_user
    FOR EACH ROW
DECLARE -- 사용할 변수를 선언하는 곳
    v_type VARCHAR2(10);
BEGIN
    IF UPDATING THEN -- UPDATING은 시스템 자체에서 상태에 대한 내용을 지원하는 빌트인 구문.
        v_type := '수정';
    ELSIF DELETING THEN
        v_type := '삭제';
    END IF;
    
    -- 본격적 실행 구문 작성.
    INSERT INTO tbl_user_backup
    VALUES(:OLD.id, :OLD.name, :OLD.address, sysdate, v_type, USER());
    
END;

-- 확인!
INSERT INTO tbl_user VALUES('test01', 'kim', '서울');
INSERT INTO tbl_user VALUES('test02', 'lee', '경기');
INSERT INTO tbl_user VALUES('test03', 'hong', '부산');

SELECT * FROM tbl_user;
SELECT * FROM tbl_user_backup;

UPDATE tbl_user SET address='인천' WHERE id='test01';
DELETE FROM tbl_user WHERE id = 'test02';

--before트리거
create or replace trigger trg_user_insert
    before insert
    on tbl_user
    for each row
begin
    :NEW.name := substr(:NEW.name,1,1) || '**';
end;

insert into tbl_user values('test04','메롱이','대전');

--------------------------------------------------------------------------------
/*
-트리거의 활용
insert -> 주문테이블 -> 주문 테이블 insert트리거 실행 (물품테이블 update)
*/

--주문 히스토리
create table order_history(
    history_no number(5) primary key,
    order_no number(5),
    product_no number(5),
    total number(10),
    price number(10)
);

-- 상품
drop table product;
create table product(
    product_no number(5) primary key,
    product_name varchar2(20),
    total number(5),
    price number(5)
);

create sequence order_history_seq nocache;
create sequence product_seq nocache;

insert into product values(product_seq.nextval, '피자',100,10000);
insert into product values(product_seq.nextval, '치킨',100,20000);
insert into product values(product_seq.nextval, '햄버거',100,5000);

select * from product;

--주문 히스토리에 데이터가 들어오면 실행.
create or replace trigger trg_order_history
    after insert
    on order_history
    for each row
declare
    v_total number;
    v_product_no number;
    
begin
    dbms_output.put_line('트리거실행');
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