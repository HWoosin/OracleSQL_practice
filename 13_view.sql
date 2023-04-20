/*
view�� �������� �ڷḸ ���� ���� ����ϴ� ���� ���̺��� ����.
��� �⺻���̺�� ������ ���� ���̺��̱� ������
�ʿ��� �÷��� ������ �θ� ������ ������ ����.
��� �������̺�� ���� �����Ͱ� ���������� ����� ���´� �ƴϴ�.
�並 ���ؼ� �����Ϳ� �����ϸ� ���������ʹ� �����ϰ� ��ȣ�ɼ� �ִ�.
*/

select * from user_sys_privs;

--�ܼ� ��
--���� �÷� �̸��� �Լ� ���� ����ǥ�����̸� �ȵȴ�.
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
        first_name || ' ' || last_name as name,--�ݵ�� �÷��� �̸��� ��Ȯ�� ���ٰ�
        job_id,
        salary
    from employees
    where department_id =60
);

select * from view_emp;
drop view viwe_emp;

--���պ�
--���� ���̺��� �����Ͽ� �ʿ��� �����͸� �����ϰ� ���� Ȯ���� ���� ���.
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

--���� ���� (create or replace view ����)
--���� �̸����� �ش� ������ ����ϸ� �����Ͱ� ����Ǹ鼭 ���Ӱ� ������

create or replace view view_emp_dept_jobs as(
    select
        e.employee_id,
        e.first_name || ' ' || last_name as name,
        d.department_name,
        j.job_title,
        e.salary --�߰�
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
order by avg(salary) desc; --sql������ Ȯ���� ª����.

--�� ����
drop view view_emp;

/*
view�� insert�� �Ͼ�� ��� ���� ���̺��� �ݿ��� �ȴ�.
�׷��� view�� insert, update, delete�� ���� ��������� ������.
���� ���̺��� not null�� ��� view�� insert�� �Ұ���.
view���� ����ϴ� �÷��� ������ ��쿡�� �ȵ�.
*/
--name �̶�� ���� �����ؼ� insert �ȵ�
insert into view_emp_dept_jobs
values(300,'test','test','test',10000);

--join�� ���� ��� �ѹ��� ������ �� ����. ���� �ٸ����̺��� ���̱� ������.
insert into view_emp_dept_jobs
    (employee_id, department_name, job_title, salary)
values(300,'test','test',10000);

--���� ���̺��� null�� ������� �ʴ� �÷� ������ �� �� ����.
insert into view_emp
    (employee_id, job_id, salary)
values(300,'test',10000);

--with check option - > ���� ���� �÷�
-- ���ǿ� ���Ǿ��� �÷����� �並 ���ؼ� ������ �� ���� ���ִ� Ű����
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

--�б� ���� �� -> with read only (dml ������ ���� -> select�� ���)
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