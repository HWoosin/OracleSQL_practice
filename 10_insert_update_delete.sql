--insert
--���̺� ����Ȯ��
desc departments;

--insert ù��° ��� (��� �÷� �����͸� �� ���� ����)
insert into departments
values(290,'������',100,2300);

select *from departments;
rollback; --���� ������ �ٽ� �ڷ� �ǵ����� Ű����

--insert�� �� ��° ��� (���� �÷��� �����ϰ� ����, NOT NULL Ȯ���ϱ�)
insert into departments
    (department_id, department_name, location_id)
values
    (290,'���ߺ�',1700);

--�纻 ���̺� ����
--�纻 ���̺��� ������ �� �׳� �����ϸ� -> ��ȸ�� �����ͱ��� ��� ����
--where���� false��(1=2)�����ϸ� -> ���̺��� ������ �����ϰ� �����ʹ� ����x
create table managers as
(select employee_id, first_name, job_id, hire_date
from employees where 1 = 2);

--insert (��������)
insert into managers
(select employee_id, first_name, job_id, hire_date from employees);

select * from managers;
drop table managers;

--------------------------------------------------------------------------------
--update
create table emps as (select * from employees);
select * from emps;

/*
CTAS�� ����ϸ� ���������� NOT NULL����� ������� �ʴ´�.
���������� ���� ��Ģ�� ��Ű�� �����͸� �����ϰ�, �׷��� ���� �͵���
DB�� ����Ǵ� ���� �����ϴ� �������� ���
*/

--update�� ������ ���� ������ ������ �� �� �����ؾ��Ѵ�.
--�׷��� ������ ���� ����� ���̺� ��ü�� ����ȴ�.
update emps set salary = 30000;

update emps set salary = 30000
where employee_id = 100;

select * from emps;

update emps set salary = salary + salary *0.1
where employee_id = 100;

update emps set phone_number ='010.3885.5154', manager_id = 102
where employee_id = 100;

--UPDATE(��������)
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

--�纻 ���̺� ����
create table depts as (select * from departments);
select *from depts;

--delete (��������)
delete from emps
where department_id = (select department_id from depts where department_id =100);

delete from emps
where department_id = (select department_id from depts where department_name ='IT');

