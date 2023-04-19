
--merge:���̺� ����
/*
update�� insert�� �ѹ濡 ó��

�����̺� �ش��ϴ� �����Ͱ� �ִٸ� update��,
������ insert�� ó��.
*/
create table emps_it as (select * from employees where 1=2);
select * from emps_it;

insert into emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
values
    (105,'���̺��','��','DavidKIM','23/04/19','IT_PROG');
    
select * from employees
where job_id = 'IT_PROG';

merge into emps_it a --(������ �� Ÿ�� ���̺�)
    using --���ս�ų ������
        (select * from employees
        where job_id = 'IT_PROG')b -- �����ϰ��� �ϴ� ������
    on --���ս�ų �������� ���� ����
        (a.employee_id = b.employee_id) --���� ����
when matched then --���ǿ� ��ġ�ϴ� ��� Ÿ�� ���̺� �̷��� �����ض�
    update set
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
        /*
        delete�� �ܵ����� �� ���� ����.
        update ���Ŀ� delete �ۼ��� ����
        update �� ����� delete�ϵ��� ����Ǿ� �ֱ� ������
        ������ ��� �÷����� ������ ������ �ϴ� update�� �����ϰ�
        delete�� where���� �Ʊ� ������ ������ ���� �����ؼ� ����
        */
        delete
            where a.employee_id = b.employee_id
when not matched then --���ǿ� ��ġ���� �ʴ� ��� Ÿ�� ���̺� �̷��� �����ض�
    insert /*�Ӽ�(�÷�)*/ values
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    
--------------------------------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '����', '��', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '�ϳ�', '��', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '���', '��', 'HMSON', '20/04/06', 'AD_VP');

/*
employees ���̺��� �Ź� ����ϰ� �����Ǵ� ���̺��̶�� ����.
������ �����ʹ� email, phone, salary, comm_pct, man_id, dept_id��
������Ʈ �ϵ��� ó��
���� ���Ե� �����ʹ� �״�� �߰�.
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


/*���� 1. ���̺��� �������� �߰�*/
INSERT INTO depts
    (department_id, department_name, location_id)
VALUES(280,'����',1800);
INSERT INTO depts
    (department_id, department_name, location_id)
VALUES(290,'ȸ���',1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES(300,'����',301,1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES(310,'�λ�',302,1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES(320,'����',303,1700);

select * from depts;
/*���� 2. depts�� �����͸� ����
1. department_name �� IT Support�� �������� department_name�� IT bank�� ����
2. department_id�� 290�� �������� manager_id�� 310�� ����
*/
update depts set department_name = 'IT BANK'
where department_name = 'IT Support';

update depts set manager_id = 310
where department_id = 290;

update depts set department_name = 'IT HELP' , manager_id = 303, location_id =1800
where department_name = 'IT Helpdesk';

update depts set manager_id = 301
where department_name = 'ȸ���'or 
        department_name = '�λ�'or 
        department_name = '����' or 
        department_name = '����';
        
/*���� 3. ������ ������ �׻� primary key�� �մϴ�. ���⼭ primary key�� department id��� ����
1. �μ��� �����θ� �����ϼ���
2. �μ��� NOC�� �����ϼ���
*/
delete from depts where department_id =320;
delete from depts where department_id =220;

/*���� 4.*/
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


/*���� 5.*/
create table jobs_it as (select * from jobs where min_salary >6000);
select *from jobs_it;

insert into jobs_it(job_id, job_title, min_salary, max_salary)
values ('IT_DEV','����Ƽ������',6000,20000);
insert into jobs_it(job_id, job_title, min_salary, max_salary)
values ('NET_DEV','��Ʈ��ũ������',5000,20000);
insert into jobs_it(job_id, job_title, min_salary, max_salary)
values ('SEC_DEV','���Ȱ�����',6000,19000);

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