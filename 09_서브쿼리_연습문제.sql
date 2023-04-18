/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���
*/
select * from employees where salary >(select avg(salary) from employees);
select count(*) from employees where salary >(select avg(salary) from employees);
select * from employees where salary > (select avg(salary) from employees where job_id = 'IT_PROG');
/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
*/
select * from employees e where e.department_id IN (select department_id from departments d where manager_id = 100);
/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/
select * from employees e where manager_id > any (select manager_id from employees e2 where first_name = 'Pat');
select * from employees e where manager_id in (select manager_id from employees e2 where first_name = 'James');
/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
*/
select * from 
    (select rownum as rn, tbl.*
    from 
    (select concat(first_name, last_name) as name from employees order by first_name desc) tbl
    )
where rn >40 and rn <51;

/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
�Ի����� ����ϼ���.
*/
select * from 
    (select rownum as rn, tbl.*
    from 
    (select employee_id, concat(first_name, last_name)as name , phone_number, hire_date from employees order by hire_date asc) tbl
    )
where rn >30 and rn <41;