/*
#��������
-�������� ������� () �ȿ� �����
�������� ���� �������� 1�� ���Ͽ��� �Ѵ�.
-�������� ������ ���� ����� �ϳ� �ݵ�� ���� �Ѵ�.
-�ؼ� �� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.
*/

/* 'Nancy'�� �޿����� �޿��� ���� ����� �˻��ϴ� ����*/
select salary from employees where first_name='Nancy';--12008�� ���� ����

select * from employees 
where salary >(select salary from employees where first_name='Nancy');-- �װ� ���⼭ ��ȸ��

--employee_id�� 103���� ����� job_id�� ������ ����� �˻��ϴ� ����.
select job_id from employees where employee_id =103;-- IT_PROG

select * from employees 
where job_id = (select job_id from employees where employee_id =103);
/*
�Ʒ��� ������ ���� : ������ �������� ��, �ϳ��� �ุ ������ ������ ����Ѵ�. ������ ������ �񱳺Ұ�.
�ƴϸ� ������ ������ '='�� ������, ������ �����ڸ� ���ô�!! (IN, ANY, SOME, ALL, EXISTS ���)
*/
select * from employees 
where job_id = (select job_id from employees where job_id ='IT_PROG'); --����

--������ ������
--IN: ����� � ���� ������ Ȯ��
select * from employees 
where job_id in (select job_id from employees where job_id ='IT_PROG');

--first_name�� David�� ��� �� ���� ���������� �޿��� ū ����� ��ȸ
select salary from employees where first_name = 'David';

--ANY: ���� ���������� ���� ���ϵ� ������ ���� ��.
--�ϳ��� �����ϸ� ��
select concat(first_name, last_name), salary from employees 
where salary > any (select salary from employees where first_name = 'David');
--IN�� ��ġ
select concat(first_name, last_name), salary from employees 
where salary IN (select salary from employees where first_name = 'David');

--ALL: ���� ���������� ���� ���ϵ� ���� ��� ���ؼ�
--��� �����ؾ��Ѵ�.
select concat(first_name, last_name), salary from employees 
where salary > ALL (select salary from employees where first_name = 'David');

--------------------------------------------------------------------------------

-- ��Į�� ��������
-- select ������ ���������� ���� ��. left outer join�� ������ ���.
select e.first_name, d.department_name
from employees e 
left join departments d on e.department_id = d.department_id
order by first_name asc;

select e.first_name,
(select department_name from departments d where d.department_id = e.department_id )as department_name
from employees e
order by first_name asc;
/*
- ��Į�� ���������� ���κ��� ���� ���
: �Լ�ó�� �� ���ڵ�� ��Ȯ�� �ϳ��� ������ ������ ��.
- ������ ��Į�� ������������ ���� ���
: ��ȸ�� �����Ͱ� ��뷮�� ���, �ش� �����Ͱ� ����, ���� ���� ����� ���
*/

--�� �μ��� �Ŵ��� �̸�(join �� ��Į��)
select d.*, e.first_name from departments d 
left join employees e 
on d.manager_id = e.employee_id
order by d.manager_id asc;

select d.*,
(select first_name from employees e where e.employee_id = d.manager_id )as manager_name 
from departments d
order by d.manager_id asc;

-- �� �μ��� ��� �� �̱�(join �� ��Į��)
--���� �ۼ���join
select d.department_name,count(*) from departments d
left join employees e
on d.department_id = e.department_id
group by d.department_name,d.department_id;

select d.*,
(select count(*) from employees e 
where e.department_id = d.department_id group by department_id )
from departments d;

--------------------------------------------------------------------------------

--�ζ��� ��(from ������ ���������� ���� ��.)
-- ������ ���س��� ��ȸ �ڷḦ ������ �����ؼ� ������ ���� ���.
select employee_id, first_name, salary
from employees
order by salary desc;
--salary�� ������ �����ϸ鼭 �ٷ� ROWNUM �� ���̸�
--ROWNUM�� ������ ���� �ʴ� ��Ȳ�� �߻�
--ROWNUM�� ���� �ٰ� ������ ����Ǳ� ����. order by�� �׻� �������� ����.
--������ �̸� ����� �ڷῡ ROWNUM�� �ٿ��� �ٽ� ��ȸ�ϴ� ���� ����.

--rownum�� ���̰� ���� ������ �����ؼ� ��ȸ�Ϸ��� �ϴµ�,
--���� ������ �Ұ����ϰ�, ������ �� ���� ������ �߻�.
--����: where������ ���� �����ϰ� ���� rownum�� select �Ǳ� ������
--�ذ�: rownum���� �ٿ� ���� �ٽ� �ѹ� �ڷḦ select�ؼ� ������ �����ؾ� �ǰڴ�.
select rownum as rn, tbl.*
from (select employee_id, first_name, salary from employees order by salary desc) tbl
where rownum > 10 and rn <=20; --����

/*
���� ���� select ������ �ʿ��� ���̺� ����(�ζ��� ��)����
�ٱ��� select������ rownum�� �ٿ��� �ٽ� ��ȸ
���� �ٱ��� select �������� �̹� �پ��ִ� rownum�� ������ �����ؼ� ��ȸ.

**sql�� ���� ����
from -> where -> group by -> having -> select -> order by
*/
select * from
    (select rownum as rn, tbl.*
    from 
    (select employee_id, first_name, salary from employees order by salary desc) tbl
    )
where rn > 10 and rn <=20;

select *from
    (
    select
        to_char(to_date(test,'YY/MM/DD'),'MMDD')as mm, name 
        from
        (
        select 'ȫ�浿' as name, '20230418' as test from dual union all
        select '��ö��', '20230301' from dual union all
        select '�ڿ���', '20230401' from dual union all
        select '��ǻ�', '20230501' from dual union all
        select '�ڶѶ�', '20230601' from dual union all
        select '���ך�Ʈ', '20230701' from dual
        )
    )
where mm ='0418';
