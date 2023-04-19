/*
문제 1.
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 수를 출력하세요
-EMPLOYEES 테이블에서 job_id가 IT_PROG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요
*/
select * from employees where salary >(select avg(salary) from employees);
select count(*) from employees where salary >(select avg(salary) from employees);
select * from employees where salary > (select avg(salary) from employees where job_id = 'IT_PROG');
/*
문제 2.
-DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id와
EMPLOYEES테이블에서 department_id가 일치하는 모든 사원의 정보를 검색하세요.
*/
select * from employees e where e.department_id IN (select department_id from departments d where manager_id = 100);
/*
문제 3.
-EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요
-EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 같은 모든 사원의 데이터를 출력하세요.
*/
select * from employees e where manager_id > any (select manager_id from employees e2 where first_name = 'Pat');
select * from employees e where manager_id in (select manager_id from employees e2 where first_name = 'James');
/*
문제 4.
-EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 행 번호, 이름을 출력하세요
*/
select * from 
    (select rownum as rn, tbl.*
    from 
    (select concat(first_name, last_name) as name from employees order by first_name desc) tbl
    )
where rn >40 and rn <51;

/*
문제 5.
-EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 행 번호, 사원id, 이름, 번호, 
입사일을 출력하세요.
*/
select * from 
    (select rownum as rn, tbl.*
    from 
    (select employee_id, concat(first_name, last_name)as name , phone_number, hire_date from employees order by hire_date asc) tbl
    )
where rn >30 and rn <41;
/*
문제 6.
employees테이블 departments테이블을 left 조인하세요
조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
조건) 직원아이디 기준 오름차순 정렬
*/
select e.employee_id, concat(first_name, last_name)as name, e.department_id, d. department_name
from employees e left join departments d on e.department_id = d.department_id
order by employee_id asc;
/*
문제 7.
문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
*/
select e.employee_id, concat(first_name, last_name), e.department_id, 
(select d.department_name from departments d where e.department_id = d.department_id)
from employees e
order by employee_id asc;
/*
문제 8.
departments테이블 locations테이블을 left 조인하세요
조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
조건) 부서아이디 기준 오름차순 정렬
*/
select *from departments;
select *from locations;

select d.department_id, d.department_name, d.manager_id, l.location_id, l.postal_code, l.city
from departments d left join locations l
on d.location_id = l.location_id
order by department_id asc;
/*
문제 9.
문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
*/
select d.department_id, d.department_name, d.manager_id, 
(select l.location_id from locations l where d.location_id = l.location_id),
(select l.postal_code from locations l where d.location_id = l.location_id),
(select l.city from locations l where d.location_id = l.location_id)
from departments d
order by department_id asc;
/*
문제 10.
locations테이블 countries 테이블을 left 조인하세요
조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
조건) country_name기준 오름차순 정렬
*/
select * from countries;
select *from locations;

select l.location_id, l.street_address, l.city, l.country_id, c.country_name
from locations l left join countries c on l.country_id = c.country_id
order by country_name asc;
/*
문제 11.
문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
*/
select l.location_id, l.street_address, l.city, l.country_id, 
(select c.country_name from countries c where l.country_id = c.country_id) as ctn
from locations l
order by ctn asc;

/*
문제 12. 
employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 1-10번째 데이터만 출력합니다
조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 부서아이디, 부서이름 을 출력합니다.
조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.
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
문제 13. 
--EMPLOYEES 과 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의 LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요.
*/
select e.last_name, e.job_id, e.department_id, d.department_name from employees e 
join departments d on e.department_id = d.department_id
where job_id ='SA_MAN';
/*
문제 14
--DEPARTMENT테이블에서 각 부서의 ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
--인원수 기준 내림차순 정렬하세요.
--사람이 없는 부서는 출력하지 뽑지 않습니다.
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
문제 15
--부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요.
--부서별 평균이 없으면 0으로 출력하세요.
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
문제 16
-문제 15 결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 ROWNUM을 붙여 1-10데이터 까지만
출력하세요.
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