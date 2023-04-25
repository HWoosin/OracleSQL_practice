/*
프로시저명 guguProc
구구단을 전달 받아 해당 단수를 출력하는 procedure을 생성
*/
create or replace procedure guguProc 
   (g_num in number)
is

begin
    for j in 1..9
        loop
        dbms_output.put_line(g_num || 'x' ||j|| '=' || g_num*j);
        end loop;
end;

exec guguProc(3) ;

/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
*/
select * from depts;
create or replace procedure depts_proc
    (p_department_id in depts.department_id%type,
    p_department_name in depts.department_name%type,
    p_choose in varchar2
    )
is
    v_choose varchar2(20);
begin
      v_choose := p_choose;
                if v_choose = 'I' then --없다면 insert
                    insert into depts(department_id, department_name)
                    values(p_department_id, p_department_name);
                elsif v_choose = 'U' then
                    update depts set
                    department_name = p_department_name
                    where department_id = p_department_id;
                elsif v_choose = 'D' then
                    delete from depts where department_id = p_department_id;
                end if;
                dbms_output.put_line('오류없음');
                commit;
            exception
            when others then
            dbms_output.put_line('예외발생');
                rollback;
        
end;
exec depts_proc('133','마케팅부','I');

/*
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/
select * from employees;
create or replace procedure career_proc
    (p_employee_id in employees.employee_id%type,
    p_career out varchar2
    )
is
     v_cnt number := 0;
     v_career number := 0;
begin
    select
        count(*)
    into
        v_cnt
    from employees
    where employee_id = p_employee_id;
    
    if v_cnt = 0 then
        dbms_output.put_line(p_employee_id || '는 테이블에 존재하지 않는다.');
        return;
    end if;
    dbms_output.put_line(p_employee_id ||'의 근속년수는');
        select          
            (sysdate - employees.hire_date)/365
        into
            v_career --조회 결과를 대입
        from employees
        where employee_id = p_employee_id;
   
    p_career := v_career;
    commit;
end;

declare
    career number(5);
begin
    career_proc('101', career);
    dbms_output.put_line(career||'년 입니다.');
    exception 
    when others then
        dbms_output.put_line('알 수 없는 예외발생!');
end;

/*
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요

머지를 할 타겟 테이블 -> emps
병합시킬 데이터 -> 프로시저로 전달받은 employee_id를 dual에 select 때려서 비교.
*/
select * from emps;
create or replace procedure new_emp_proc
    (p_employee_id in emps.employee_id%type,
    p_last_name in emps.last_name%type,
    p_email in emps.email%type,
    p_hire_date in emps.hire_date%type,
    p_job_id in emps.job_id%type
    )
is
begin
        merge into emps a
        using 
            (select p_employee_id as employee_id from dual)b--dual이기 때문에 b.employee_id 라고 해서 못넣음
        on 
            (a.employee_id = b.employee_id)
    when matched then 
        update set
            a.last_name = p_last_name,
            a.email = p_email,
            a.hire_date = p_hire_date,
            a.job_id = p_job_id
    when not matched then 
        insert (a.employee_id, a.last_name,a.email,a.hire_date,a.job_id)values
        (p_employee_id, p_last_name,
        p_email, p_hire_date, p_job_id);
    commit;
end;

exec new_emp_proc(208,'woosin','13@naver.com',sysdate,133);
select * from emps;
