--�׷� �Լ� AVG, MAX, MIN, SUM, COUNT

select
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
from employees;

select count(*) from employees; --�� �� �������� ��
select count(first_name) from employees;
select count(commission_pct) from employees; --null�� �ƴ� ���� ��
select count(manager_id) from employees; --null�� �ƴ� ���� ��

--�μ����� �׷�ȭ, �׷��Լ��� ���
select
    department_id,
    avg(salary)
from employees group by department_id;

--������ ��, �׷��Լ��� �Ϲ� �÷��� ���ÿ� �׳� ����� ���� ����.
select
    department_id,
    avg(salary)
from employees;

--GROUP BY ���� ����� �� GROUP���� ������ ������ �ٸ� �÷��� ��ȸ�� �� ����.
select
    job_id,
    department_id,
    avg(salary)
from employees group by department_id;

--GROUP BY �� 2�� �̻� ���.
select
    job_id,
    department_id,
    avg(salary)
from employees group by department_id, job_id
order by department_id;

--GROUP BY �� ���� �׷�ȭ�� �� �� ������ �� ��� HAVING�� ���.
select
    department_id,
    avg(salary)
from employees group by department_id
having sum(salary) > 100000;

select
    job_id,
    count(*)
from employees
group by job_id
having count(*) >= 10;

--�μ� ���̴ٰ� 50 �̻��� �͵��� �׷�ȭ ��Ű��, �׷� ���� ����� 5000 �̻� ��ȸ
select
    department_id,
    avg(salary) as ���
from employees
where department_id  >= 50
group by department_id 
having avg(salary) >= 5000
order by department_id desc;

select * from employees;
/*
���� 1.
��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���
*/
select job_id, count(job_id) from employees group by job_id;
select job_id, avg(salary)as ��� from employees group by job_id order by ��� desc;
/*
���� 2.
��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
*/
select to_char(hire_date,'yyyy'), count(*) from employees group by to_char(hire_date,'yyyy');
/*
���� 3.
�޿��� 5000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 7000�̻��� �μ��� ���
*/
select department_id, avg(salary) from employees where salary >= 5000 group by department_id having avg(salary)>=7000 ;
/*
���� 4.
��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���
*/
select department_id, trunc(avg(salary + salary*commission_pct),2), sum(salary + salary*commission_pct), count(*) 
from employees 
where commission_pct is not null 
group by department_id;
