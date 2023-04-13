
--집합 연산자
--UNION(합집합 중복x), UNION ALL(합집합 중복 O), INTERSECT(교집합), MINUS(차집합)
--위 아래 column 개수와 데이터 타입이 정확히 일치해야 한다.

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

