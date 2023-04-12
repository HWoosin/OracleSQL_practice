--숫자함수
--ROUND(반올림)
--원하는 반올림 위치를 매개값으로 지정. 음수를 주는 것도 가능

Select round(3.1415,3), round(45.923,0), round(45.923,-1) from dual;

--TRUNC(절사)
--정해진 소수점 자리수까지 잘라낸다.
select trunc(3.1415,3), trunc(45.923,0), trunc(45.923,-1) from dual;

--ABS(절대값)
select abs(-34) from dual;

--CEIL(올림), FLOOR(내림)
select ceil(3.14), floor(3.14) from dual;

--MOD(나머지)
select 10/4, mod(10,4) from dual;

--날짜 함수
select sysdate from dual;
select systimestamp from dual;

--날짜도 연산이 가능
select sysdate + 1 from dual;

select first_name, sysdate - hire_date from employees;--일수

select first_name, hire_date, (sysdate - hire_date) / 7 as week from employees;--주수

select first_name, hire_date, (sysdate - hire_date) / 365 as year from employees;--년수

--날짜 반올림, 절사 
select round(sysdate) from dual;--정오를 기준으로 반올림
select round(sysdate, 'year') from dual;
select round(sysdate, 'month') from dual;
select round(sysdate, 'day') from dual;--주의 반이 지났냐 안지났냐(해당 주의 일요일 날짜)

select trunc(sysdate) from dual;
select trunc(sysdate, 'year') from dual;
select trunc(sysdate, 'month') from dual;
select trunc(sysdate, 'day') from dual; -- 일 기준으로 절사 (해당 주의 일요일 날짜)