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