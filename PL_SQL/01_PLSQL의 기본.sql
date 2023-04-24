/*
#PL/SQL
-����Ŭ���� �����ϴ� SQL ���α׷��� ����̴�.
-�Ϲ����� ���α׷��ְ��� ���̰� ������, ����Ŭ �������� ������ ó���� ����
 ������ �� �� �ִ� ���������� �ڵ� �ۼ� ���.
-�������� �������� ��� ������ �ϰ� ó���ϱ� ���� �뵵�� ���.
*/

set serveroutput on; /*��¹� Ȱ��ȭ.*/

declare --������ �����ϴ� ���� (�����)
    emp_num number; --��������
begin --�ڵ带 �����ϴ� ���� ���� (�����)
    emp_num := 10; --���Կ����� :=
    DBMS_OUTPUT.put_line(emp_num);
    DBMS_OUTPUT.put_line('Hello pl/sql!');
end;    --PL/SQL�� ������ ���� (�����)

--������
--�Ϲ� sql���� ��� �������� ����� �����ϰ�,
-- **�� ������ �ǹ��Ѵ�.
declare
    a number := 2**2*3**2;
begin
    DBMS_OUTPUT.put_line('a:' || to_char(a));
end;

/*
-DML��
DDL���� ����� �Ұ����ϰ�, �Ϲ������� sql���� select ���� ����ϴµ�,
Ư���� ���� select���� �Ʒ��� into���� ����ؼ� ������ �Ҵ��Ѵ�.
*/

declare
    v_emp_name varchar2(50); --����� ����
    v_dep_name varchar2(50); --�μ��� ����
begin
    select
        e.first_name,
        d.department_name
    into
        v_emp_name, v_dep_name --��ȸ ����� ������ ����
    from employees e
    left join departments d
    on e.department_id = d.department_id
    where employee_id = 100;
    
    DBMS_OUTPUT.put_line(v_emp_name || ' ' || v_dep_name);   
end;

--�ش� ���̺�� ���� Ÿ���� �÷� ������ ���� �Ϸ���
--���̺��. �÷��� %type�� ��������ν� Ÿ���� ������ Ȯ���ؾ��ϴ� ���ŷο��� ��������
declare
    v_emp_name employees.first_name%type;
    v_dep_name departments.department_name%type;
begin
    select
        e.first_name,
        d.department_name
    into
        v_emp_name, v_dep_name --��ȸ ����� ������ ����
    from employees e
    left join departments d
    on e.department_id = d.department_id
    where employee_id = 100;
    
    DBMS_OUTPUT.put_line(v_emp_name || ' ' || v_dep_name);
end;