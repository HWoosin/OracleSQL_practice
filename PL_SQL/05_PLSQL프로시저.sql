--���ν���(procedure) -> void �޼��� ����
--Ư���� ������ ó���ϰ� ������� ��ȯ���� �ʴ� �ڵ� ��� (����)
--������ ���ν����� ���ؼ� ���� �����ϴ� ����� �ִ�.

set serveroutput on; /*��¹� Ȱ��ȭ.*/
drop procedure p_test;
--�Ű���(�μ�) ���� ���ν���
create procedure p_test
is -- �����
    v_msg varchar2(30) := 'Hello Procedure!';
begin
    dbms_output.put_line(v_msg);
end;

EXEC p_test; --���ν��� ȣ�⹮

--IN �Է°��� ���޹޴� �Ķ����
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

--job_id�� Ȯ���ؼ�
-- �̹� �����ϴ� �����Ͷ�� ����, ���ٸ� ���Ӱ� �߰�

create or replace procedure my_new_job_proc --���� ���� ����.
    (p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_sal in jobs.min_salary%type,
    p_max_sal in jobs.max_salary%type
    )
is
    v_cnt number := 0;
begin
    --������ job_id�� �ִ������� üũ
    --�̹� �����Ѵٸ�1, ���������ʴ´ٸ� 0 -> v_cnt�� ����
    select
        count(*)
    into
        v_cnt
    from jobs
    where job_id = p_job_id;
    
    if v_cnt = 0 then --���ٸ� insert
        insert into jobs(job_id, job_title, min_salary, max_salary)
        values(p_job_id, p_job_title, p_min_sal, p_max_sal);
    else --�ִٸ� update
        update jobs set job_title = p_job_title,
        min_salary = p_min_sal, max_salary = p_max_sal
        where job_id = p_job_id;
    end if;
    commit;
end;