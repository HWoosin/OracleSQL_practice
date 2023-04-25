/*
���ν����� guguProc
�������� ���� �޾� �ش� �ܼ��� ����ϴ� procedure�� ����
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
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
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
                if v_choose = 'I' then --���ٸ� insert
                    insert into depts(department_id, department_name)
                    values(p_department_id, p_department_name);
                elsif v_choose = 'U' then
                    update depts set
                    department_name = p_department_name
                    where department_id = p_department_id;
                elsif v_choose = 'D' then
                    delete from depts where department_id = p_department_id;
                end if;
                dbms_output.put_line('��������');
                commit;
            exception
            when others then
            dbms_output.put_line('���ܹ߻�');
                rollback;
        
end;
exec depts_proc('133','�����ú�','I');

/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
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
        dbms_output.put_line(p_employee_id || '�� ���̺� �������� �ʴ´�.');
        return;
    end if;
    dbms_output.put_line(p_employee_id ||'�� �ټӳ����');
        select          
            (sysdate - employees.hire_date)/365
        into
            v_career --��ȸ ����� ����
        from employees
        where employee_id = p_employee_id;
   
    p_career := v_career;
    commit;
end;

declare
    career number(5);
begin
    career_proc('101', career);
    dbms_output.put_line(career||'�� �Դϴ�.');
    exception 
    when others then
        dbms_output.put_line('�� �� ���� ���ܹ߻�!');
end;

/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
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
            (select p_employee_id as employee_id from dual)b--dual�̱� ������ b.employee_id ��� �ؼ� ������
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
