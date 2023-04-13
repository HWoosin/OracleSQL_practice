--형 변환함수 TO_CHAR, TO_NUMBER, TO_DATE

--날짜를 문자로 To_CHAR(값, 형식)
SELECT
    to_char(sysdate)
FROM
    dual;

SELECT
    to_char(sysdate, 'yyyy-mm-dd dy pm hh:mi:ss')
FROM
    dual;

SELECT
    to_char(sysdate, 'yy-mm-dd hh24:mi:ss')
FROM
    dual;--24시간제

--사용하고 싶은 문자를 ""로 묶어 전달
SELECT
    first_name,
    to_char(hire_date, 'yyyy"년" mm"월" dd"일"')
FROM
    employees;

--숫자를 문자로 TO_CHAR(값, 형식)
SELECT
    to_char(20000, '99999')
FROM
    dual;
--주어진 자릿수에 숫자를 모두 표기할 수 없어서 모두 #으로 표기됨
SELECT
    to_char(20000, '9999')
FROM
    dual;

SELECT
    to_char(20000.25, '99999.9')
FROM
    dual;

SELECT
    to_char(salary, '$99,999')
FROM
    employees;

--문자를 숫자로 TO_NUMBER(값,형식)
SELECT
    '2000' + 2000
FROM
    dual; --자동 현 변환 (문자 -> 숫자)
SELECT
    TO_NUMBER('2000') + 2000
FROM
    dual;

SELECT
    '$3,300' + 2000
FROM
    dual;--에러
SELECT
    TO_NUMBER('$3,300', '$9,999') + 2000
FROM
    dual;

--문자를 날짜로 변환하는 함수 TO_date(값, 형식)
SELECT
    TO_DATE('2023-04-13')
FROM
    dual;

SELECT
    sysdate - TO_DATE('2021-03-26')
FROM
    dual;

SELECT
    TO_DATE('2020/12/25', 'yy-mm-dd')
FROM
    dual; 
--주어진 문자열을 모두 변환해야한다.
SELECT
    TO_DATE('2021-03-31 12:33:50', 'yy-mm-dd hh:mi:ss')
FROM
    dual; 

--xxxx년 xx월 xx일 문자열 형식으로 변환.
--조회 컬럼명은 dateInfo
SELECT
    to_char(TO_DATE('20050102'),
            'yyyy"년" mm"월" dd"일"') AS dateinfo
FROM
    dual;

--NULL 제거 함수 NVL(컬럼, 변환할 타겟값)
SELECT
    NULL
FROM
    dual;

SELECT
    nvl(NULL, 0)
FROM
    dual;

SELECT
    first_name,
    nvl(commission_pct, 0) AS comm_pct
FROM
    employees;

--NULL 제거 함수 NVL2(컬럼, null이 아닐 경우 값, null일 경우의 값)
SELECT
    nvl2('abc', '널아님', '널임')
FROM
    dual;

SELECT
    first_name,
    nvl2(commission_pct, 'true', 'false')
FROM
    employees;

SELECT
    first_name,
    commission_pct,
    nvl2(commission_pct, salary +(salary * commission_pct), salary) AS real_salary
FROM
    employees;

--DECODE(컬럼 혹은 표현식, 항목1, 결과1, 항목2, 결과2 ...... default)
SELECT
    decode('F', 'A', 'A입니다.', 'B', 'B입니다.',
           'C', 'C입니다.', '모르겠는데요!')
FROM
    dual;

SELECT
    job_id,
    salary,
    decode(job_id, 'IT_PROG', salary * 1.1, 'FI_MGR', salary * 1.2,
           'AD_VP', salary * 1.3) AS result
FROM
    employees;
    
--CASE WHEN THEN END
select
    first_name,
    job_id,
    salary,
    (case job_id
        when 'IT_PROG' then salary*1.1
        when 'FI_MGR' then salary*1.2
        when 'AD_VP' then salary*1.3
        when 'FI_ACCOUNT' then salary*1.4
        else salary
    end) AS result
from employees;

select * from employees;
/*문제 1.
현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 17년 이상인
사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다
*/
select 
employee_id as 사원번호, 
first_name||' '|| last_name as 사원명,
hire_date as 입사일자,
trunc((sysdate-hire_date)/365,0) as 근속년수
from employees where trunc((sysdate-hire_date)/365,0) > 17 order by 근속년수 desc;
/*
문제 2.
EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
100이라면 ‘사원’, 
120이라면 ‘주임’
121이라면 ‘대리’
122라면 ‘과장’
나머지는 ‘임원’ 으로 출력합니다.
조건 1) department_id가 50인 사람들을 대상으로만 조회합니다
*/
select first_name, manager_id, 
(case manager_id 
when 100 then '사원'
when 120 then '주임'
when 121 then '대리'
when 122 then '과장'
else '임원' 
end) as 직급
from employees where department_id = 50;

-------------------------------------------------------------

select
    salary,
    employee_id,
    first_name,
    decode(
        salary,
        salary >=4000, 'A',
        salary >=3000 and salary <=3999, 'B',
        salary >=2000 and salary <=2999, 'C',
        salary >=1000 and salary <=1999, 'D',
        salary >=0 and salary <=999, 'E'
    )as grade
from employees
order by salary desc;

select
    salary,
    employee_id,
    first_name,
    decode(
        trunc(salary/1000),
        0,'E',
        1,'D',
        2,'C',
        3,'B',
        'A'
    )as grade
from employees
order by salary desc;

SELECT 
    salary,
    employee_id,
    first_name,
    (CASE
        WHEN salary BETWEEN 0 AND 999 THEN 'E'
        WHEN salary BETWEEN 1000 AND 1999 THEN 'D'
        WHEN salary BETWEEN 2000 AND 2999 THEN 'C'
        WHEN salary BETWEEN 3000 AND 3999 THEN 'B'
        ELSE 'A'
    END) AS grade
FROM employees
ORDER BY salary DESC;