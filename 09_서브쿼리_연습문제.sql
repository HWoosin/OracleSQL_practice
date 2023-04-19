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
/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/
select e.employee_id, concat(first_name, last_name)as name, e.department_id, d. department_name
from employees e left join departments d on e.department_id = d.department_id
order by employee_id asc;
/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
select e.employee_id, concat(first_name, last_name), e.department_id, 
(select d.department_name from departments d where e.department_id = d.department_id)
from employees e
order by employee_id asc;
/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/
select *from departments;
select *from locations;

select d.department_id, d.department_name, d.manager_id, l.location_id, l.postal_code, l.city
from departments d left join locations l
on d.location_id = l.location_id
order by department_id asc;
/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
select d.department_id, d.department_name, d.manager_id, 
(select l.location_id from locations l where d.location_id = l.location_id),
(select l.postal_code from locations l where d.location_id = l.location_id),
(select l.city from locations l where d.location_id = l.location_id)
from departments d
order by department_id asc;
/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/
select * from countries;
select *from locations;

select l.location_id, l.street_address, l.city, l.country_id, c.country_name
from locations l left join countries c on l.country_id = c.country_id
order by country_name asc;
/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
select l.location_id, l.street_address, l.city, l.country_id, 
(select c.country_name from countries c where l.country_id = c.country_id) as ctn
from locations l
order by ctn asc;

/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/
select * from
(select rownum as rn, tbl.*
from
(select 
    e.employee_id, e.first_name, e.phone_number,
    e.hire_date, d.department_id, d.department_name    
from employees e 
left join departments d on e.department_id = d.department_id
order by hire_date asc) tbl)
where rn <= 10;
/*
���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
*/
select e.last_name, e.job_id, e.department_id, d.department_name from employees e 
join departments d on e.department_id = d.department_id
where job_id ='SA_MAN';
/*
���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�.
*/
select tbl.*, d.department_name, d.manager_id
from departments d 
join 
    (select department_id, count(*)as t 
    from employees 
    group by department_id)tbl
on d.department_id = tbl.department_id
order by tbl.t desc;

/*
���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.
*/
select d.*, l.street_address, l.postal_code, NVL(tbl.result, 0)
from departments d
join locations l
on d.location_id = l.location_id
left join 
    (select 
        department_id, trunc(avg(salary)) as result
    from employees group by department_id
    )tbl
on d.department_id = tbl.department_id
;
/*
���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
����ϼ���.
*/
select *
    from
    (select rownum as rn, tbl2.*
    from
        (select d.*, l.street_address, l.postal_code, NVL(tbl.result, 0)
        from departments d
        join locations l
        on d.location_id = l.location_id
        left join 
            (select 
                department_id, trunc(avg(salary)) as result
            from employees group by department_id
            )tbl
    on d.department_id = tbl.department_id order by d.department_id desc) tbl2)
where rn < 11;