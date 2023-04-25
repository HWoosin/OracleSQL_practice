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