--그룹 함수 AVG, MAX, MIN, SUM, COUNT

select
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
from employees;

select count(*) from employees; --총 행 데이터의 수
select count(first_name) from employees;
select count(commission_pct) from employees; --null이 아닌 행의 수
select count(manager_id) from employees; --null이 아닌 행의 수

--부서별로 그룹화, 그룹함수의 사용
select
    department_id,
    avg(salary)
from employees group by department_id;

--주의할 점, 그룹함수는 일반 컬럼과 동시에 그냥 출력할 수는 없다.
select
    department_id,
    avg(salary)
from employees;

--GROUP BY 절을 사용할 때 GROUP절에 묶이지 않으면 다른 컬럼을 조회할 수 없다.
select
    job_id,
    department_id,
    avg(salary)
from employees group by department_id;

--GROUP BY 절 2개 이상 사용.
select
    job_id,
    department_id,
    avg(salary)
from employees group by department_id, job_id
order by department_id;

--GROUP BY 를 통해 그룹화를 할 때 조건을 걸 경우 HAVING을 사용.
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

--부서 아이다가 50 이상인 것들을 그룹화 시키고, 그룹 월급 평균이 5000 이상만 조회
select
    department_id,
    avg(salary) as 평균
from employees
where department_id  >= 50
group by department_id 
having avg(salary) >= 5000
order by department_id desc;