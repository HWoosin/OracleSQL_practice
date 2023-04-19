--insert
--테이블 구조확인
desc departments;

--insert 첫번째 방법 (모든 컬럼 데이터를 한 번에 지정)
insert into departments
values(290,'영업부',100,2300);

select *from departments;
rollback; --실행 시점을 다시 뒤로 되돌리는 키워드

--insert의 두 번째 방법 (직접 컬럼을 지정하고 저장, NOT NULL 확인하기)
insert into departments
    (department_id, department_name, location_id)
values
    (290,'개발부',1700);

--사본 테이블 생성
--사본 테이블을 생성할 때 그냥 생성하면 -> 조회된 데이터까지 모두 복사
--where절에 false값(1=2)지정하면 -> 테이블의 구조만 복사하고 데이터는 복사x
create table managers as
(select employee_id, first_name, job_id, hire_date
from employees where 1 = 2);

--insert (서브쿼리)
insert into managers
(select employee_id, first_name, job_id, hire_date from employees);

select * from managers;
drop table managers;

--------------------------------------------------------------------------------
--update
create table emps as (select * from employees);
select * from emps;

/*
CTAS를 사용하면 제약조건은 NOT NULL말고는 복사되지 않는다.
제약조건은 업무 규칙을 지키는 데이터만 저장하고, 그렇지 않은 것들이
DB에 저장되는 것을 방지하는 목적으로 사용
*/

--update를 진행할 때는 누구를 수정할 지 잘 지목해야한다.
--그렇지 않으면 수정 대상이 테이블 전체로 지목된다.
update emps set salary = 30000;

update emps set salary = 30000
where employee_id = 100;

select * from emps;

update emps set salary = salary + salary *0.1
where employee_id = 100;

update emps set phone_number ='010.3885.5154', manager_id = 102
where employee_id = 100;

--UPDATE(서브쿼리)
update emps
    set (job_id, salary, manager_id)=
    (select job_id, salary, manager_id
    from emps
    where employee_id =100)
where employee_id =101;
rollback;
--delete
delete from emps
where employee_id = 103;
select * from emps;

--사본 테이블 생성
create table depts as (select * from departments);
select *from depts;

--delete (서브쿼리)
delete from emps
where department_id = (select department_id from depts where department_id =100);

delete from emps
where department_id = (select department_id from depts where department_name ='IT');

