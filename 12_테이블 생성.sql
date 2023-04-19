/*
-number(2)-> ������ 2�ڸ����� ������ �� �ִ� ������ Ÿ��
-number(5,2) -> ������, �Ǽ��θ� ��ģ �� �ڸ��� 5�ڸ�, �Ҽ��� 2�ڸ�
-number -> ��ȣ�� ������ �� (38,0)���� �ڵ� �����˴ϴ�.
-varchar2(byte) -> ��ȣ �ȿ� ���� ���ڿ��� �ִ� ���̸� ����. (4000byte����)
-clob -> ��뷮 �ؽ�Ʈ ������ Ÿ�� (�ִ� 4Gbyte)
-blob -> ������ ��뷮 ��ü (�̹���, ���� ���� �� ���)
-Date -> bc 4712�� 1��1�� ~ ad 9999�� 12�� 31�ϱ��� ��������
*/
create table dept2(
    dept_no number(2),
    dept_name varchar2(14),
    loca varchar2(15),
    dept_date date,
    dept_bonus number(10)
);

select * from dept2;
desc dept2;

insert into dept2
values(40, '������', '����', sysdate, 2000000);

insert into dept2
values(400, '�濵����', '����', sysdate, 2000000);--precision(����)�� Ÿ���������� ŭ

insert into dept2
values(400, '�濵���������鼭���λ絵�ϰ��ѹ����ϰ�ϴ��ض�', '����', sysdate, 2000000);--precision(����)�� Ÿ���������� ŭ

--�÷� �߰�
alter table dept2
add (dept_count number(3));

--�� �̸� ����
alter table dept2
rename column dept_count to emp_count;

--�� �Ӽ� ����
alter table dept2
modify(emp_count number(4));
desc dept2;

alter table dept2
modify(dept_name varchar2(20));
desc dept2;

--�����ϰ����ϴ� �÷��� �����Ͱ� �̹� �����Ѵٸ� �׿� �´� Ÿ������ �����Ұ�.
alter table dept2
modify(dept_name number(20));

--�� ����
alter table dept2
drop column emp_count;

select *from dept2;

--���̺� �̸� ����
alter table dept2
rename to dept3;

select *from dept3;

--���̺� ���� (������ ���ܵΰ� ���ε����͸� ��� ����)
truncate table dept3;
select *from dept3;
drop table dept3;--���̺� ����