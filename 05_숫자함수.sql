--�����Լ�
--ROUND(�ݿø�)
--���ϴ� �ݿø� ��ġ�� �Ű������� ����. ������ �ִ� �͵� ����

Select round(3.1415,3), round(45.923,0), round(45.923,-1) from dual;

--TRUNC(����)
--������ �Ҽ��� �ڸ������� �߶󳽴�.
select trunc(3.1415,3), trunc(45.923,0), trunc(45.923,-1) from dual;

--ABS(���밪)
select abs(-34) from dual;

--CEIL(�ø�), FLOOR(����)
select ceil(3.14), floor(3.14) from dual;

--MOD(������)
select 10/4, mod(10,4) from dual;

--��¥ �Լ�
select sysdate from dual;
select systimestamp from dual;

--��¥�� ������ ����
select sysdate + 1 from dual;

select first_name, sysdate - hire_date from employees;--�ϼ�

select first_name, hire_date, (sysdate - hire_date) / 7 as week from employees;--�ּ�

select first_name, hire_date, (sysdate - hire_date) / 365 as year from employees;--���

--��¥ �ݿø�, ���� 
select round(sysdate) from dual;--������ �������� �ݿø�
select round(sysdate, 'year') from dual;
select round(sysdate, 'month') from dual;
select round(sysdate, 'day') from dual;--���� ���� ������ ��������(�ش� ���� �Ͽ��� ��¥)

select trunc(sysdate) from dual;
select trunc(sysdate, 'year') from dual;
select trunc(sysdate, 'month') from dual;
select trunc(sysdate, 'day') from dual; -- �� �������� ���� (�ش� ���� �Ͽ��� ��¥)