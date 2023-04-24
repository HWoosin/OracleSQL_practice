/*
#PL/SQL
-오라클에서 제공하는 SQL 프로그래밍 기능이다.
-일반적인 프로그래밍과는 차이가 있지만, 오라클 내보에서 적절한 처리를 위해
 적용해 줄 수 있는 절차지향적 코드 작성 방식.
-쿼리문의 집합으로 어떠한 동작을 일괄 처리하기 위한 용도로 사용.
*/

set serveroutput on; /*출력문 활성화.*/

declare --변수를 선언하는 구간 (선언부)
    emp_num number; --변수선언
begin --코드를 실행하는 시작 구간 (실행부)
    emp_num := 10; --대입연산자 :=
    DBMS_OUTPUT.put_line(emp_num);
    DBMS_OUTPUT.put_line('Hello pl/sql!');
end;    --PL/SQL이 끝나는 구간 (종료부)

--연산자
--일반 sql문의 모든 연산자의 사용이 가능하고,
-- **는 제곱을 의미한다.
declare
    a number := 2**2*3**2;
begin
    DBMS_OUTPUT.put_line('a:' || to_char(a));
end;

/*
-DML문
DDL문은 사용이 불가능하고, 일반적으로 sql문의 select 등을 사용하는데,
특이한 점은 select절에 아래에 into절을 사용해서 변수에 할당한다.
*/

declare
    v_emp_name varchar2(50); --사원명 변수
    v_dep_name varchar2(50); --부서명 변수
begin
    select
        e.first_name,
        d.department_name
    into
        v_emp_name, v_dep_name --조회 결과를 변수에 대입
    from employees e
    left join departments d
    on e.department_id = d.department_id
    where employee_id = 100;
    
    DBMS_OUTPUT.put_line(v_emp_name || ' ' || v_dep_name);   
end;

--해당 테이블과 같은 타입의 컬럼 변수를 선언 하려면
--테이블명. 컬럼명 %type을 사용함으로써 타입을 일일히 확인해야하는 번거로움을 방지가능
declare
    v_emp_name employees.first_name%type;
    v_dep_name departments.department_name%type;
begin
    select
        e.first_name,
        d.department_name
    into
        v_emp_name, v_dep_name --조회 결과를 변수에 대입
    from employees e
    left join departments d
    on e.department_id = d.department_id
    where employee_id = 100;
    
    DBMS_OUTPUT.put_line(v_emp_name || ' ' || v_dep_name);
end;