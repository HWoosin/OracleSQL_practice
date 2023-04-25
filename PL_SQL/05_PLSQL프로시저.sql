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
select *from jobs;
exec my_new_job_proc('job3','test job3',20000,30000);

--�Ű���(�μ�)�� ����Ʈ ��(�⺻��) ����
create or replace procedure my_new_job_proc --���� ���� ����.
    (p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_sal in jobs.min_salary%type :=0 ,
    p_max_sal in jobs.max_salary%type :=1000
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
select *from jobs;
exec my_new_job_proc('job5','test job5');

--------------------------------------------------------------------------------
--out, in out �Ű����� ���.
--out ������ ����ϸ� ���ν��� �ٱ����� ���� ������.
--out�� �̿��ؼ� ���� ���� �ٱ� �͸� ��Ͽ��� �����ؾ��Ѵ�.

create or replace procedure my_new_job_proc --���� ���� ����.
    (p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_sal in jobs.min_salary%type :=0 ,
    p_max_sal in jobs.max_salary%type :=1000,
    p_result out varchar2 -- �ٱ��ʿ��� ����� �ϱ� ���� ����
    )
is
    v_cnt number := 0;
    v_result varchar2(100) :='���� ��� insert ó�� �Ǿ����ϴ�.';
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
    else --������ �����ϴ� �����Ͷ�� ����� ����.
        select
            p_job_id ||'�� �ִ� ����:'|| max_salary || ', �ּҿ���: ' || min_salary
        into
            v_result --��ȸ ����� ����
        from jobs
        where job_id = p_job_id;
    end if;
    
    --out �Ű������� ����� �Ҵ�.
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
--in out�� ���ÿ� ó��
create or replace procedure my_parameter_test_proc
    (
    --��ȯ �Ұ�. �޴� �뵵�θ� Ȱ��
    p_var1 in varchar2,
    --out ������ ���ν����� ������ ������ ���� �Ҵ��� �ȵ�.
    --�����߸� out�� ����
    p_var2 out varchar2,
    --in, out�� �Ѵ� ������.
    p_var3 in out varchar2
    )
is

begin
    dbms_output.put_line('p_var1: '||p_var1); --�翬�� ��
    dbms_output.put_line('p_var2: '||p_var2); --���� ���޵�������
    dbms_output.put_line('p_var3:'||p_var3); --in�� ������ ������ �ִ�.
    
    --p_var1 := '���1'; in������ �� �Ҵ� ��ü�� �Ұ�. ���޹޴� �뵵�θ� ����,
    p_var2 := '���2';
    p_var3 := '���3';
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
create or replace procedure my_new_job_proc --���� ���� ����.
    (p_job_id in jobs.job_id%type,
    p_result out varchar2 -- �ٱ��ʿ��� ����� �ϱ� ���� ����
    )
is
    v_cnt number := 0;
    v_result varchar2(100) :='���� ��� insert ó�� �Ǿ����ϴ�.';
begin
    select
        count(*)
    into
        v_cnt
    from jobs
    where job_id = p_job_id;
    
    if v_cnt = 0 then --���ٸ� insert
        dbms_output.put_line(p_job_id || '�� ���̺� �������� �ʴ´�.');
        return; --���ν�����������.
    end if;
        select
            p_job_id ||'�� �ִ� ����:'|| max_salary || ', �ּҿ���: ' || min_salary
        into
            v_result --��ȸ ����� ����
        from jobs
        where job_id = p_job_id;
   
    
    --out �Ű������� ����� �Ҵ�.
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

--����ó��
declare
    v_num number := 0;
begin
    v_num := 10/0;
/*
others ���̷� ������ Ÿ���� �ۼ����ش�.
access_into_null -> ��ü �ʱ�ȭ�� �Ǿ� ���� ���� ���¿��� ���
no_data_found -> select into�� �����Ͱ� �� �ǵ� ���� ��
zero_divide -> 0���� ���� ��
value_error -> ��ġ �Ǵ� �� ����
invalid_number -> ���ڸ� ���ڷ� ��ȯ�� �� ������ ���
*/
exception 
    when zero_divide then
        dbms_output.put_line('0���� ���� �� �����ϴ�.');
        dbms_output.put_line('sql error code:' || sqlcode);
        dbms_output.put_line('sql error msg:' || sqlerrm);
    when other then
        dbms_output.put_line('�� �� ���� ���ܹ߻�!');
end;
