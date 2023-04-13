
--���� ������
--UNION(������ �ߺ�x), UNION ALL(������ �ߺ� O), INTERSECT(������), MINUS(������)
--�� �Ʒ� column ������ ������ Ÿ���� ��Ȯ�� ��ġ�ؾ� �Ѵ�.

select
    employee_id, first_name
from employees
where hire_date like '04%'
union
select
    employee_id, first_name
from employees
where department_id = 20;

select
    employee_id, first_name
from employees
where hire_date like '04%'
union all
select
    employee_id, first_name
from employees
where department_id = 20;

select
    employee_id, first_name
from employees
where hire_date like '04%'
intersect
select
    employee_id, first_name
from employees
where department_id = 20;

select
    employee_id, first_name
from employees
where hire_date like '04%'
minus -- A-B
select
    employee_id, first_name
from employees
where department_id = 20;

