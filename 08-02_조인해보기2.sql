--�̳�(����) ����
select *
from info i
inner join auth a
on i.auth_id = a.auth_id;

--����Ŭ (�� �Ⱦ�)
select *
from info i, auth a
where i.auth_id = a.auth_id;

-- auth_id �÷��� �׳� ���� ��ȣ�ϴ� ��� �Ѵ�.
-- �� ������ ���� ���̺� ��� �����ϱ� ����.
-- �̷� ����, �÷��� ���̺� �̸��� ���̴���, ��Ī�� �Ἥ Ȯ���ϰ� ������ �ϱ�.
select 
    a.auth_id, i.title, i.content, a.name
from info i
inner join auth a
on i.auth_id = a.auth_id;

--�ʿ��� �����͸� ��ȸ�ϰڴ�! ��� �Ѵٸ�
--where ������ ���� �Ϲ� ������ �ɾ� �ֽø� �˴ϴ�.
select 
    a.auth_id, i.title, i.content, a.name
from info i
inner join auth a
on i.auth_id = a.auth_id
where a.name = '�̼���';

--�ƿ���(�ܺ�) ����
select * from info i left outer join auth a
on i.auth_id = a.auth_id;

select * from info i left join auth a
on i.auth_id = a.auth_id;

--���� ���̺�� ���� ���̺� �����͸� ��� �о� �ߺ��� �����ʹ� �����Ǵ� �ܺ�����.
select * from info i full join auth a
on i.auth_id = a.auth_id;

--CROSS JOIN�� JOIN������ �������� �ʱ� ������
--�ܼ��� ��� �÷��� ���� JOIN�� ���� (���� ������� �ʴ´�.)
select * from info cross join auth
order by id asc;

-- ������ ���̺� ���� -> Ű ���� ã�Ƽ� ������ �����ؼ� ����ȴ�.
select * from employees e
left join departments d on e.department_id = d.department_id
left join locations loc on d.location_id = loc.location_id;

/*
- ���̺� ��Ī a, i�� �̿��Ͽ� left outer join ���.
- info, auth ���̺� ���
- job Į���� scientist�� ����� id, title, content, job ���.
*/
select i.id, i.title, i.content, a.job 
from auth a left outer join info i
on i.auth_id = a.auth_id
where a.job = 'scientist';

--���� �����̶� ���� ���̺� ������ ������ ���մϴ�.
--���� ���̺� �÷��� ���� ������ �����ϴ� ���� ��Ī���� ������ �� ����մϴ�.
SELECT
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.employee_id
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id;