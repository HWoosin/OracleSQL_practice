--1. ������ �� 3���� ����ϴ� �͸� ����� ������. (��¹� 9���� ����)
declare
    a number:=3*1;
    b number:=3*2;
    c number:=3*3;
    d number:=3*4;
    e number:=3*5;
    f number:=3*6;
    g number:=3*7;
    h number:=3*8;
    i number:=3*9;
begin
    DBMS_OUTPUT.put_line('3 x 1=' || to_char(a));
    DBMS_OUTPUT.put_line('3 x 2=' || to_char(b));
    DBMS_OUTPUT.put_line('3 x 3=' || to_char(c));
    DBMS_OUTPUT.put_line('3 x 4=' || to_char(d));
    DBMS_OUTPUT.put_line('3 x 5=' || to_char(e));
    DBMS_OUTPUT.put_line('3 x 6=' || to_char(f));
    DBMS_OUTPUT.put_line('3 x 7=' || to_char(g));
    DBMS_OUTPUT.put_line('3 x 8=' || to_char(h));
    DBMS_OUTPUT.put_line('3 x 9=' || to_char(i));
      
end;


--2. employees���̺��� 201�� ����� �̸��� �̸��� �ּҸ� ����ϴ� �͸��� �����
declare
    emp_name varchar2(20);
    emp_email varchar2(20);
begin
    select
        first_name,
        email
    into emp_name,emp_email
    
    from employees
    where employee_id =201;
    DBMS_OUTPUT.put_line('name: '||emp_name || ' email: ' || emp_email);
end;


--3. employees���̺��� �����ȣ�� ���� ū����� ã�Ƴ� ��, �̹�ȣ +1������ 
-- �Ʒ��� ����� emps���̺� employee_id, last_name, email, hire_date, job_id��
-- �ű� �����ϴ� �͸� ����� ����� select�� ���Ŀ� insert�� ���.
/*
����� steven
�̸��� stevenjobs
�Ի����� ���ó�¥
job_id CEO
*/

declare
    emp_id varchar2(20); 
    emp_name varchar2(20);  
    emp_email varchar2(20);  
    emp_hire_date date; 
    emp_job_id varchar2(20); 
begin
    select Max(employee_id)
    into emp_id
    from employees;
    
    insert into emps(employee_id, last_name, email, hire_date, job_id)
    values (emp_id+1,'steven','stevenjobs',sysdate,'CEO');
    
end;
commit;

drop table emps;
create table emps as (select * from employees where 1=2);

select * from emps;