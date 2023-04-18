/*
#서브쿼리
-서브쿼리 사용방법은 () 안에 명시함
서브쿼리 절의 리턴행이 1줄 이하여야 한다.
-서브쿼리 절에는 비교할 대상이 하나 반드시 들어가야 한다.
-해석 할 때는 서브쿼리절 부터 먼저 해석하면 됩니다.
*/

/* 'Nancy'의 급여보다 급여가 많은 사람을 검색하는 문장*/
select salary from employees where first_name='Nancy';--12008의 값이 나옴

select * from employees 
where salary >(select salary from employees where first_name='Nancy');-- 그걸 여기서 조회함

--employee_id가 103번인 사람과 job_id가 동일한 사람을 검색하는 문장.
select job_id from employees where employee_id =103;-- IT_PROG

select * from employees 
where job_id = (select job_id from employees where employee_id =103);
/*
아래의 문장은 에러 : 단행 서브쿼리 즉, 하나의 행만 나오는 조건을 써야한다. 여러행 나오면 비교불가.
아니면 '='를 쓰지마
*/
select * from employees 
where job_id = (select job_id from employees where job_id ='IT_PROG');

