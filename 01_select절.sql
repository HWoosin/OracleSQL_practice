--����Ŭ�� �ּ�
/*
������ �ּ�
����
*/

SELECT
    *
FROM
    employees;

SELECT
    employee_id,
    first_name,
    last_name
FROM
    employees;

SELECT
    email,
    phone_number,
    hire_date
FROM
    employees;

--�÷��� ��ȸ�ϴ� ��ġ���� */+- ���� ����

SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    salary + salary * 0.1 AS ������
FROM
    employees;

--NULL ���� Ȯ�� (���� 0�̳� �����̶��� �ٸ�����.)

SELECT
    department_id,
    commission_pct
FROM
    employees;

--alias(�÷���, ���̺���� �̸��� �����ؼ� ��ȸ.)

SELECT
    first_name AS �̸�,
    last_name  AS ��,
    salary     AS �޿�
FROM
    employees;
    
--����Ŭ�� Ȭ����ǥ�� ���ڸ� ǥ���ϰ�, ���ڿ� �ȿ� Ȭ����ǥ��
--ǥ���ϰ� �ʹٸ� ''�� �ι� �������� ����ȴ�.
--������ �����ϰ� �ʹٸ� ||�� ����Ѵ�.

SELECT
    first_name
    || ' '
    || last_name
    || '''s salary is $ '
    || salary AS �޿�����
FROM
    employees;
    
--DISTINCT (�ߺ� ���� ����)
select department_id from employees;
select distinct department_id from employees;

-- ROWNUM,ROWID
--(**�ο��: ������ ���� ��ȯ�Ǵ� �� ��ȣ�� ���)
--(�ο���̵�: �����ͺ��̽� ���� ���� �ּҸ� ��ȯ)

select ROWNUM, ROWID, employee_id from employees;