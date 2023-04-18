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