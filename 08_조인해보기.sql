/*
#�����̶�?
-���� �ٸ� ���̺��� ������ ���谡 �����Ͽ�
1�� �̻��� ���̺��� �����͸� ��ȸ�ϱ� ���� ����Ѵ�.

select �÷�����Ʈ from ���� ����� �Ǵ� ���̺�(1�� �̻�)
where ���� ���� -> ����Ŭ ����
*/

--employees ���̺��� �μ� id�� ��ġ�ϴ� department ���̺��� �μ� id�� ã�Ƽ�
--select ���Ͽ� �ִ� �÷����� ����ϴ� ������.
--����Ŭ ����

select 
    first_name, last_name, hire_date,
    salary, job_id, e.department_id, department_name
from employees e
inner join departments d 
on e.department_id = d.department_id; --ansi ǥ�� ����

/*
������ ���̺� ���������� �����ϴ� �÷��� ��쿡��
���̺� �̸��� �����ص� ����.
�ؼ��� ��Ȯ���� ���� ���̺� �̸��� �ۼ��ϼż� �Ҽ��� ǥ���� �ִ°��� �ٶ���
���̺� �̸��� �ʹ� �� �ÿ��� ALIAS�� �ۼ��Ͽ� Ī�Ѵ�.
�� ���̺� ��� ������ �ִ� �÷��� ��� �ݵ�� ����� ��� �Ѵ�.
*/

--3���� ���̺��� �̿��� �������� (inner join)
--��������: �� ���̺� ��ο��� ��ġ�ϴ� ���� ���� �ุ ��ȯ

select
    e.first_name, e.last_name, e.department_id,
    d.department_name,
    j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;

select
    e.first_name, e.last_name,
    d.department_id, d.department_name, j.job_title, loc.city
from 
    employees e,
    departments d,
    jobs j,
    locations loc
where
    e.department_id = d.department_id --4
and
    e.job_id = j.job_id --3
and
    d.location_id = loc.location_id --2
and
    loc.state_province='California'; --1

/*
1. loc ���̺��� province = 'California' ���ǿ� �´� ���� �������
2. location_id ���� ���� ���� ������ �����͸� departments���� ã�Ƽ� ����
3. ���� ����� ������ department_id�� ���� employees ���̺��� �����͸� ã�Ƽ� ����
4. ���� ����� jobs ���̺��� ���Ͽ� �����ϰ� ���� ����� ���.
*/

--�ܺ� ����
/*
��ȣ ���̺��� ��ġ�Ǵ� ������ ����Ǵ� ���� ���ΰ��� �ٸ���
��� �� ���̺� ���� ���� ������ �ش� row���� ��ȸ ����� ��� ���ԵǴ� ������ ���Ѵ�.
*/
select 
    first_name, last_name, hire_date,
    salary, job_id, e.department_id, d.department_name
from employees e, departments d, locations loc
where e.department_id = d.department_id(+)
and d.location_id = loc.location_id;

/*
employees ���̺��� �����ϰ�, departments ���̺��� �������� �ʾƵ� 
(+)�� ���� ���� ���̺��� �������� �Ͽ� departments ���̺��� ���ο� �����϶��
�ǹ̸� �ο��ϱ� ���� ��ȣ�� ���δ�.
�ܺ� ������ ����ߴ���, ���Ŀ� ���� ������ ����ϸ� ���� ������ �켱������ �ν�.
*/

/*
-- �ܺ� ���� ���� �� ��� ���ǿ� (+)�� �ٿ��� �ܺ� ������ ������.
-- �Ϲ� ���ǿ��� (+)�� ������ ������ �ܺ� ������ Ǯ���� ������ �߻�.(������ ����)
*/

select
    e.employee_id, e.first_name,
    e.department_id,
    j.start_date, j.end_date, j.job_id
from employees e, job_history j
where e.employee_id = j.employee_id(+)
and j.department_id(+) = 80;