/*
trigger는 테이블에 부착된 형태로써, insert, update, delete작업이 수행될 때
특정 코드가 작동되도록 하는 구문.
view에는 부착이 불가능.

트리거를 만들 때 범위 지정하고 부분실행하기.
*/
create table tbl_test(
    id number(10),
    text varchar2(20)
);

create or replace trigger trg_test
    after delete or update -- 트리거의 발생시점. 삭제또는 수정 이후에 동작
    on tbl_test -- 트리거를 부착할 테이블
    for each row -- 각 행에 모두 적용. 생략시 한번만 실행
--declare 생략 가능
begin
    dbms_output.put_line('트리거가 동작함!'); --실행하고자 하는 코드를 begin~end에 넣음.
    
end;

insert into tbl_test values(1,'김철수');
update tbl_test set text ='김뽀삐' where id =1;
delete from tbl_test where id =1;