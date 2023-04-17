/*
���� 1.
-EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
-EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
*/
select * from employees;
select * from employees e inner join departments d on e.department_id = d.department_id;--106
select * from employees e left outer join departments d on e.department_id = d.department_id;--107
select * from employees e right outer join departments d on e.department_id = d.department_id;--122
select * from employees e full outer join departments d on e.department_id = d.department_id;--123
/*
���� 2.
-EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
*/
select concat(first_name, last_name)as name, e.department_id from employees e 
inner join departments d on e.department_id = d.department_id where employee_id = 200;
/*
���� 3.
-EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
HINT) � �÷����� ���� ����� �ִ��� Ȯ��
*/
select * from jobs;
select * from employees;
select concat(first_name, last_name)as name, e.job_id, j.job_title 
from employees e inner join jobs j on e.job_id = j.job_id order by e.first_name asc;
/*
���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
*/
select * from job_history;
select * from JOBS j left outer join JOB_HISTORY jh on j.job_id = jh.job_id;
/*
���� 5.
--Steven King�� �μ����� ����ϼ���.
*/
select concat(first_name, last_name)as name, d.department_name from employees e 
inner join departments d on e.department_id = d.department_id where first_name = 'Steven' and last_name ='King';
/*
���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
*/
select * from employees e 
cross join departments d;

/*
���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
*/
select * from departments;
select * from employees;
select * from locations;
select employee_id, concat(first_name, last_name)as name, salary, d.department_name, l.city
from employees e join departments d on e.department_id = d.department_id 
join locations l on d.location_id = l.location_id
where e.job_id ='SA_MAN';
/*
���� 8.
-- employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
����ϼ���.
*/
select * from employees e join jobs j on e.job_id = j.job_id where job_title = 'Stock Manager' or job_title = 'Stock Clerk';
/*
���� 9.
-- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
*/
select d.department_name, e.employee_id 
from departments d left outer join employees e on e.department_id = d.department_id where e.employee_id is null;
/*
���� 10. 
-join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
*/
select e1.first_name ,e2.first_name as manager_name
from employees e1 join employees e2 on e1.manager_id = e2.employee_id; 
/*
���� 11. 
--6. EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
*/
select e1.employee_id, e1.first_name, e1.manager_id, e2.first_name as manager_name, e2.salary as manager_salary
from employees e1 left join employees e2 on e1.manager_id = e2.employee_id
where e2.manager_id is not null
order by e2.salary desc; 