/*
view는 제한적인 자료만 보기 위해 사용하는 가상 테이블의 개념.
뷰는 기본테이블로 유도된 가상 테이블이기 때문에
필요한 컬럼만 저장해 두면 관리가 용이해 진다.
뷰는 가상테이블로 실제 데이터가 물리적으로 저장된 형태는 아니다.
뷰를 통해서 데이터에 접근하면 원본데이터는 안전하게 보호될수 있다.
*/

select * from user_sys_privs;

--단순 뷰
--뷰의 컬럼 이름은 함수 같은 가상표현식이면 안된다.
select
    employee_id,
    first_name || ' ' || last_name,
    job_id,
    salary
from employees
where department_id =60;

create view view_emp as (
    select
        employee_id,
        first_name || ' ' || last_name as name,--반드시 컬럼의 이름을 정확히 해줄것
        job_id,
        salary
    from employees
    where department_id =60
);

select * from view_emp;
drop view viwe_emp;

--복합뷰
--여러 테이블을 조인하여 필요한 데이터만 저장하고 빠를 확인을 위해 사용.
create view view_emp_dept_jobs as(
    select
        e.employee_id, e.first_name || ' ' || last_name as name,
        d.department_name,
        j.job_title
    from employees e 
    left join departments d
    on e.department_id = d.department_id
    left join jobs j
    on e.job_id = j.job_id
)
order by employee_id asc;

select * from view_emp_dept_jobs;

--뷰의 수정 (create or replace view 구문)
--동일 이름으로 해당 구문을 사용하면 데이터가 변경되면서 새롭게 생성됨

create or replace view view_emp_dept_jobs as(
    select
        e.employee_id,
        e.first_name || ' ' || last_name as name,
        d.department_name,
        j.job_title,
        e.salary --추가
    from employees e 
    left join departments d
    on e.department_id = d.department_id
    left join jobs j
    on e.job_id = j.job_id
)
order by employee_id asc;

select 
    job_title,
    avg(salary)
from view_emp_dept_jobs
group by job_title
order by avg(salary) desc; --sql구문이 확실히 짧아짐.

--뷰 삭제
drop view view_emp;

/*
view에 insert가 일어나는 경우 실제 테이블에도 반영이 된다.
그래서 view의 insert, update, delete은 많은 제약사항이 따른다.
원본 테이블이 not null인 경우 view에 insert가 불가능.
view에서 사용하는 컬럼이 가상열인 경우에도 안됨.
*/
--name 이라는 가상열 존재해서 insert 안됨
insert into view_emp_dept_jobs
values(300,'test','test','test',10000);

--join된 뷰의 경우 한번에 수정할 수 없다. 각자 다른테이블의 열이기 때문에.
insert into view_emp_dept_jobs
    (employee_id, department_name, job_title, salary)
values(300,'test','test',10000);

--원본 테이블의 null을 허용하지 않는 컬럼 때문에 들어갈 수 없다.
insert into view_emp
    (employee_id, job_id, salary)
values(300,'test',10000);

--with check option - > 조건 제약 컬럼
-- 조건에 사용되어진 컬럼값은 뷰를 통해서 변경할 수 없게 해주는 키워드
create or replace view view_emp_test as (
    select 
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    from employees where department_id =60
)
with check option constraint view_emp_test_ck;

select * from view_emp_test;

update view_emp_test
set department_id = 100
where employee_id = 106;

--읽기 전용 뷰 -> with read only (dml 연산을 막음 -> select만 허용)
create or replace view view_emp_test as (
    select 
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    from employees where department_id =60
)
with read only;

select * from view_emp_test;

update view_emp_test
set job_id = 'test'
where employee_id = 106;