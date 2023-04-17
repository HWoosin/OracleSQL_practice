/*
#서브쿼리
-서브쿼리 사용방법은 () 안에 명시함
서브쿼리 절의 리턴행이 1줄 이하여야 한다.
-서브쿼리 절에는 비교할 대상이 하나 반드시 들어가야 한다.
-해석 할 때는 서브쿼리절 부터 먼저 해석하면 됩니다.
*/

select salary from employees where first_name='Nancy';

select * from employees where salary >12008;