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