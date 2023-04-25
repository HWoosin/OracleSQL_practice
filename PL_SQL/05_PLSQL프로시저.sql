--프로시저(procedure) -> void 메서드 유사
--특정한 로직을 처리하고 결과값을 반환하지 않는 코드 덩어리 (쿼리)
--하지만 프로시저를 통해서 값을 리턴하는 방법도 있다.

set serveroutput on; /*출력문 활성화.*/
drop procedure p_test;
--매개값(인수) 없는 프로시저
create procedure p_test
is -- 선언부
    v_msg varchar2(30) := 'Hello Procedure!';
begin
    dbms_output.put_line(v_msg);
end;

EXEC p_test; --프로시저 호출문

--IN 입력값을 전달받는 파라미터
create procedure my_new_job_proc
    (p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_sal in jobs.min_salary%type,
    p_max_sal in jobs.max_salary%type
    )
is

begin
    insert into jobs(job_id, job_title, min_salary, max_salary)
    values(p_job_id, p_job_title, p_min_sal, p_max_sal);
    commit;
end;

exec my_new_job_proc('job1','test job1',7777,9999);

select *from jobs;

--job_id를 확신해서
-- 이미 존재하는 데이터라면 수정, 없다면 새롭게 추가

create or replace procedure my_new_job_proc --기존 구조 수정.
    (p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_sal in jobs.min_salary%type,
    p_max_sal in jobs.max_salary%type
    )
is
    v_cnt number := 0;
begin
    --동일한 job_id가 있는지부터 체크
    --이미 존재한다면1, 존재하지않는다면 0 -> v_cnt에 저장
    select
        count(*)
    into
        v_cnt
    from jobs
    where job_id = p_job_id;
    
    if v_cnt = 0 then --없다면 insert
        insert into jobs(job_id, job_title, min_salary, max_salary)
        values(p_job_id, p_job_title, p_min_sal, p_max_sal);
    else --있다면 update
        update jobs set job_title = p_job_title,
        min_salary = p_min_sal, max_salary = p_max_sal
        where job_id = p_job_id;
    end if;
    commit;
end;
select *from jobs;
exec my_new_job_proc('job3','test job3',20000,30000);

--매개값(인수)의 디폴트 값(기본값) 설정
create or replace procedure my_new_job_proc --기존 구조 수정.
    (p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_sal in jobs.min_salary%type :=0 ,
    p_max_sal in jobs.max_salary%type :=1000
    )
is
    v_cnt number := 0;
begin
    --동일한 job_id가 있는지부터 체크
    --이미 존재한다면1, 존재하지않는다면 0 -> v_cnt에 저장
    select
        count(*)
    into
        v_cnt
    from jobs
    where job_id = p_job_id;
    
    if v_cnt = 0 then --없다면 insert
        insert into jobs(job_id, job_title, min_salary, max_salary)
        values(p_job_id, p_job_title, p_min_sal, p_max_sal);
    else --있다면 update
        update jobs set job_title = p_job_title,
        min_salary = p_min_sal, max_salary = p_max_sal
        where job_id = p_job_id;
    end if;
    commit;
end;
select *from jobs;
exec my_new_job_proc('job5','test job5');

--------------------------------------------------------------------------------
--out, in out 매개변수 사용.
--out 변수를 사용하면 프로시저 바깥으로 값을 보낸다.
--out을 이용해서 보낸 값은 바깥 익명 블록에서 실행해야한다.

create or replace procedure my_new_job_proc --기존 구조 수정.
    (p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_sal in jobs.min_salary%type :=0 ,
    p_max_sal in jobs.max_salary%type :=1000,
    p_result out varchar2 -- 바깥쪽에서 출력을 하기 위한 변수
    )
is
    v_cnt number := 0;
    v_result varchar2(100) :='값이 없어서 insert 처리 되었습니다.';
begin
    --동일한 job_id가 있는지부터 체크
    --이미 존재한다면1, 존재하지않는다면 0 -> v_cnt에 저장
    select
        count(*)
    into
        v_cnt
    from jobs
    where job_id = p_job_id;
    
    if v_cnt = 0 then --없다면 insert
        insert into jobs(job_id, job_title, min_salary, max_salary)
        values(p_job_id, p_job_title, p_min_sal, p_max_sal);
    else --기존에 존재하는 데이터라면 결과를 추출.
        select
            p_job_id ||'의 최대 연봉:'|| max_salary || ', 최소연봉: ' || min_salary
        into
            v_result --조회 결과를 대입
        from jobs
        where job_id = p_job_id;
    end if;
    
    --out 매개변수에 결과를 할당.
    p_result := v_result;
    commit;
end;
select * from jobs;
declare
    str varchar2(100);
begin
    my_new_job_proc('job1', 'test_job1', 2000, 8000, str);
    dbms_output.put_line(str);
    
    my_new_job_proc('CEO', 'test_CEO', 20000, 80000, str);
    dbms_output.put_line(str);
end;

--------------------------------------------------------------------------------
--in out을 동시에 처리
create or replace procedure my_parameter_test_proc
    (
    --반환 불가. 받는 용도로만 활용
    p_var1 in varchar2,
    --out 변수는 프로시저가 끝나기 전까지 값의 할당이 안됨.
    --끝나야만 out이 가능
    p_var2 out varchar2,
    --in, out이 둘다 가능함.
    p_var3 in out varchar2
    )
is

begin
    dbms_output.put_line('p_var1: '||p_var1); --당연히 됨
    dbms_output.put_line('p_var2: '||p_var2); --값이 전달되진않음
    dbms_output.put_line('p_var3:'||p_var3); --in의 성질을 가지고 있다.
    
    --p_var1 := '결과1'; in변수는 값 할당 자체가 불가. 전달받는 용도로만 가능,
    p_var2 := '결과2';
    p_var3 := '결과3';
end;

declare
    v_var1 varchar2(10) := 'value1';
    v_var2 varchar2(10) := 'value2';
    v_var3 varchar2(10) := 'value3';
begin
    my_parameter_test_proc(v_var1,v_var2,v_var3);
    
    dbms_output.put_line('v_var1: '|| v_var1);
    dbms_output.put_line('v_var2: '|| v_var2);
    dbms_output.put_line('v_var3: '|| v_var3);
end;

--------------------------------------------------------------------------------

--return
create or replace procedure my_new_job_proc --기존 구조 수정.
    (p_job_id in jobs.job_id%type,
    p_result out varchar2 -- 바깥쪽에서 출력을 하기 위한 변수
    )
is
    v_cnt number := 0;
    v_result varchar2(100) :='값이 없어서 insert 처리 되었습니다.';
begin
    select
        count(*)
    into
        v_cnt
    from jobs
    where job_id = p_job_id;
    
    if v_cnt = 0 then --없다면 insert
        dbms_output.put_line(p_job_id || '는 테이블에 존재하지 않는다.');
        return; --프로시저강제종료.
    end if;
        select
            p_job_id ||'의 최대 연봉:'|| max_salary || ', 최소연봉: ' || min_salary
        into
            v_result --조회 결과를 대입
        from jobs
        where job_id = p_job_id;
   
    
    --out 매개변수에 결과를 할당.
    p_result := v_result;
    commit;
end;

select * from jobs;
declare
    str varchar2(100);
begin
    my_new_job_proc('IT_PROG', str);
    dbms_output.put_line(str);
end;

--예외처리
declare
    v_num number := 0;
begin
    v_num := 10/0;
/*
others 자이레 예외의 타입을 작성해준다.
access_into_null -> 객체 초기화가 되어 있지 않은 상태에서 사용
no_data_found -> select into시 데이터가 한 건도 없을 때
zero_divide -> 0으로 나눌 때
value_error -> 수치 또는 값 오류
invalid_number -> 문자를 숫자로 변환할 때 실패한 경우
*/
exception 
    when zero_divide then
        dbms_output.put_line('0으로 나눌 수 없습니다.');
        dbms_output.put_line('sql error code:' || sqlcode);
        dbms_output.put_line('sql error msg:' || sqlerrm);
    when other then
        dbms_output.put_line('알 수 없는 예외발생!');
end;
