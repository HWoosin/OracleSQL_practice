/*
#��������
-�������� ������� () �ȿ� �����
�������� ���� �������� 1�� ���Ͽ��� �Ѵ�.
-�������� ������ ���� ����� �ϳ� �ݵ�� ���� �Ѵ�.
-�ؼ� �� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.
*/

/* 'Nancy'�� �޿����� �޿��� ���� ����� �˻��ϴ� ����*/
select salary from employees where first_name='Nancy';--12008�� ���� ����

select * from employees 
where salary >(select salary from employees where first_name='Nancy');-- �װ� ���⼭ ��ȸ��

--employee_id�� 103���� ����� job_id�� ������ ����� �˻��ϴ� ����.
select job_id from employees where employee_id =103;-- IT_PROG

select * from employees 
where job_id = (select job_id from employees where employee_id =103);
/*
�Ʒ��� ������ ���� : ���� �������� ��, �ϳ��� �ุ ������ ������ ����Ѵ�. ������ ������ �񱳺Ұ�.
�ƴϸ� '='�� ������
*/
select * from employees 
where job_id = (select job_id from employees where job_id ='IT_PROG');

