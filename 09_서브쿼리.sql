/*
#��������
-�������� ������� () �ȿ� �����
�������� ���� �������� 1�� ���Ͽ��� �Ѵ�.
-�������� ������ ���� ����� �ϳ� �ݵ�� ���� �Ѵ�.
-�ؼ� �� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.
*/

/* 'Nancy'�� �޿����� �޿��� ���� ����� �˻��ϴ� ����*/
select salary from employees where first_name='Nancy';

select * from employees 
where salary >(select salary from employees where first_name='Nancy');