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
아래의 문장은 에러 : 단일행 서브쿼리 즉, 하나의 행만 나오는 조건을 써야한다. 여러행 나오면 비교불가.
아니면 단일행 연산자 '='를 쓰지마, 다중행 연산자를 씁시다!! (IN, ANY, SOME, ALL, EXISTS 등등)
*/
select * from employees 
where job_id = (select job_id from employees where job_id ='IT_PROG'); --에러

--다중행 연산자
--IN: 목록의 어떤 값과 같은지 확인
select * from employees 
where job_id in (select job_id from employees where job_id ='IT_PROG');

--first_name이 David인 사람 중 가장 작은값보다 급여가 큰 사람을 조회
select salary from employees where first_name = 'David';

--ANY: 값을 서브쿼리에 의해 리턴된 각각의 값과 비교.
--하나라도 만족하면 됨
select concat(first_name, last_name), salary from employees 
where salary > any (select salary from employees where first_name = 'David');
--IN은 일치
select concat(first_name, last_name), salary from employees 
where salary IN (select salary from employees where first_name = 'David');

--ALL: 값을 서브쿼리에 의해 리턴된 값과 모두 비교해서
--모두 만족해야한다.
select concat(first_name, last_name), salary from employees 
where salary > ALL (select salary from employees where first_name = 'David');

--------------------------------------------------------------------------------

-- 스칼라 서브쿼리
-- select 구문에 서브쿼리가 오는 것. left outer join과 유사한 결과.
select e.first_name, d.department_name
from employees e 
left join departments d on e.department_id = d.department_id
order by first_name asc;

select e.first_name,
(select department_name from departments d where d.department_id = e.department_id )as department_name
from employees e
order by first_name asc;
/*
- 스칼라 서브쿼리가 조인보다 좋은 경우
: 함수처럼 한 레코드당 정확히 하나의 값만을 리턴할 때.
- 조인이 스칼라 서브쿼리보다 좋은 경우
: 조회할 데이터가 대용량인 경우, 해당 데이터가 수정, 삭제 등이 빈번한 경우
*/

--각 부서의 매니저 이름(join 과 스칼라)
select d.*, e.first_name from departments d 
left join employees e 
on d.manager_id = e.employee_id
order by d.manager_id asc;

select d.*,
(select first_name from employees e where e.employee_id = d.manager_id )as manager_name 
from departments d
order by d.manager_id asc;

-- 각 부서별 사원 수 뽑기(join 과 스칼라)
--내가 작성한join
select d.department_name,count(*) from departments d
left join employees e
on d.department_id = e.department_id
group by d.department_name,d.department_id;

select d.*,
(select count(*) from employees e 
where e.department_id = d.department_id group by department_id )
from departments d;

--------------------------------------------------------------------------------

--인라인 뷰(from 구문에 서브쿼리가 오는 것.)
-- 순번을 정해놓은 조회 자료를 범위를 지정해서 가지고 오는 경우.
select employee_id, first_name, salary
from employees
order by salary desc;
--salary로 정렬을 진행하면서 바로 ROWNUM 을 붙이면
--ROWNUM이 정렬이 되지 않는 상황이 발생
--ROWNUM이 먼저 붙고 정렬이 진행되기 때문. order by는 항상 마지막에 진행.
--정렬이 미리 진행된 자료에 ROWNUM을 붙여서 다시 조회하는 것이 좋다.

--rownum을 붙이고 나서 범위를 지정해서 조회하려고 하는데,
--범위 지정도 불가능하고, 지목할 수 없는 문제가 발생.
--이유: where절부터 먼저 실행하고 나서 rownum이 select 되기 때문에
--해결: rownum까지 붙여 놓고 다시 한번 자료를 select해서 범위를 지정해야 되겠다.
select rownum as rn, tbl.*
from (select employee_id, first_name, salary from employees order by salary desc) tbl
where rownum > 10 and rn <=20; --에러

/*
가장 안쪽 select 절에서 필요한 테이블 형식(인라인 뷰)생성
바깥쪽 select절에서 rownum을 붙여서 다시 조회
가장 바깥쪽 select 절에서는 이미 붙어있는 rownum의 범위를 지정해서 조회.

**sql의 실행 순서
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
        select '홍길동' as name, '20230418' as test from dual union all
        select '김철수', '20230301' from dual union all
        select '박영희', '20230401' from dual union all
        select '김뽀삐', '20230501' from dual union all
        select '박뚜띠', '20230601' from dual union all
        select '김테슽트', '20230701' from dual
        )
    )
where mm ='0418';
