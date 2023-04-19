/*
-number(2)-> 정수를 2자리까지 저장할 수 있는 숫자형 타입
-number(5,2) -> 정수부, 실수부를 합친 총 자리수 5자리, 소수점 2자리
-number -> 괄호를 생략할 시 (38,0)으로 자동 지정됩니다.
-varchar2(byte) -> 괄호 안에 들어올 문자열의 최대 길이를 지정. (4000byte까지)
-clob -> 대용량 텍스트 데이터 타입 (최대 4Gbyte)
-blob -> 이진형 대용량 객체 (이미지, 파일 저장 시 사용)
-Date -> bc 4712년 1월1일 ~ ad 9999년 12월 31일까지 지정가능
*/
create table dept2(
    dept_no number(2),
    dept_name varchar2(14),
    loca varchar2(15),
    dept_date date,
    dept_bonus number(10)
);

select * from dept2;
desc dept2;

insert into dept2
values(40, '영업부', '서울', sysdate, 2000000);

insert into dept2
values(400, '경영지원', '수원', sysdate, 2000000);--precision(정도)가 타입지정보다 큼

insert into dept2
values(400, '경영지원같으면서도인사도하고총무도하고니다해라', '서울', sysdate, 2000000);--precision(정도)가 타입지정보다 큼

--컬럼 추가
alter table dept2
add (dept_count number(3));

--열 이름 수정
alter table dept2
rename column dept_count to emp_count;

--열 속성 수정
alter table dept2
modify(emp_count number(4));
desc dept2;

alter table dept2
modify(dept_name varchar2(20));
desc dept2;

--변경하고자하는 컬럼에 데이터가 이미 존재한다면 그에 맞는 타입으로 변경할것.
alter table dept2
modify(dept_name number(20));

--열 삭제
alter table dept2
drop column emp_count;

select *from dept2;

--테이블 이름 변경
alter table dept2
rename to dept3;

select *from dept3;

--테이블 삭제 (구조는 남겨두고 내부데이터만 모두 삭제)
truncate table dept3;
select *from dept3;
drop table dept3;--테이블 삭제