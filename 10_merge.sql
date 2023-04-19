
--merge:테이블 병합
/*
update와 insert를 한방에 처리

한테이블에 해당하는 데이터가 있다면 update를,
없으면 insert로 처리.
*/
create table emps_it as (select * from employees where 1=2);
select * from emps_it;

insert into emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
values
    (105,'데이비드','김','DavidKIM','23/04/19','IT_PROG');
    
select * from employees
where job_id = 'IT_PROG';

merge into emps_it a --(머지를 할 타겟 테이블)
    using --병합시킬 데이터
        (select * from employees
        where job_id = 'IT_PROG')b -- 병합하고자 하는 데이터
    on --병합시킬 데이터의 연결 조건
        (a.employee_id = b.employee_id) --병합 조건
when matched then --조건에 일치하는 경우 타겟 테이블에 이렇게 실행해라
    update set
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
        /*
        delete만 단독으로 쓸 수는 없다.
        update 이후에 delete 작성이 가능
        update 된 대상을 delete하도록 설계되어 있기 때문에
        삭제할 대상 컬럼들을 동일한 값으로 일단 update를 진행하고
        delete의 where절에 아까 지정한 동일한 값을 지정해서 삭제
        */
        delete
            where a.employee_id = b.employee_id
when not matched then --조건에 일치하지 않는 경우 타겟 테이블에 이렇게 실행해라
    insert /*속성(컬럼)*/ values
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    
--------------------------------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '렉스', '박', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '니나', '최', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '흥민', '손', 'HMSON', '20/04/06', 'AD_VP');

/*
employees 테이블을 매번 빈번하게 수정되는 테이블이라고 가정.
기존의 데이터는 email, phone, salary, comm_pct, man_id, dept_id을
업데이트 하도록 처리
새로 유입된 데이터는 그대로 추가.
*/
merge into emps_it a
    using
        (select * from employees)b
    on
        (a.employee_id = b.employee_id)
when matched then
    update set
        a.email = b.email,
        a.phone_number = b.phone_number,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
when not matched then
    insert values
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    
select * from emps_it order by employee_id asc;   
rollback;
--------------------------------------------------------------------------------

select * from depts;


/*문제 1. 테이블의 다음내용 추가*/
INSERT INTO depts
    (department_id, department_name, location_id)
VALUES(280,'개발',1800);
INSERT INTO depts
    (department_id, department_name, location_id)
VALUES(290,'회계부',1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES(300,'재정',301,1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES(310,'인사',302,1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES(320,'영업',303,1700);

select * from depts;
/*문제 2. depts의 데이터를 수정
1. department_name 이 IT Support인 데이터의 department_name을 IT bank로 변경
2. department_id가 290인 데이터의 manager_id를 310로 변경
*/
update depts set department_name = 'IT BANK'
where department_name = 'IT Support';

update depts set manager_id = 310
where department_id = 290;

update depts set department_name = 'IT HELP' , manager_id = 303, location_id =1800
where department_name = 'IT Helpdesk';

update depts set manager_id = 301
where department_name = '회계부'or 
        department_name = '인사'or 
        department_name = '재정' or 
        department_name = '영업';
        
/*문제 3. 삭제의 조건은 항상 primary key로 합니다. 여기서 primary key는 department id라고 가정
1. 부서명 영업부를 삭제하세요
2. 부서명 NOC를 삭제하세요
*/
delete from depts where department_id =320;
delete from depts where department_id =220;

/*문제 4.*/
delete from depts where department_id > 200;
update depts set manager_id =100 where manager_id is not null;
select * from depts;

merge into depts a
    using
        (select * from departments)b
    on
        (a.department_id = b.department_id)
when matched then
    update set
        a.department_name = b.department_name,
        a.manager_id = b.manager_id,
        a.location_id = b.location_id

when not matched then
    insert values
    (b.department_id, b.department_name, b.manager_id, b.location_id);


/*문제 5.*/
create table jobs_it as (select * from jobs where min_salary >6000);
select *from jobs_it;

insert into jobs_it(job_id, job_title, min_salary, max_salary)
values ('IT_DEV','아이티개발팀',6000,20000);
insert into jobs_it(job_id, job_title, min_salary, max_salary)
values ('NET_DEV','네트워크개발팀',5000,20000);
insert into jobs_it(job_id, job_title, min_salary, max_salary)
values ('SEC_DEV','보안개발팀',6000,19000);

merge into jobs_it a
    using
        (select * from jobs
        where min_salary > 0)b
    on
        (a.job_id = b.job_id)
when matched then
    update set
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary

when not matched then
    insert values
    (b.job_id, b.job_title, b.min_salary, b.max_salary);