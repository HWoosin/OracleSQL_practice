--����Ŀ�� ���� Ȯ��
show autocommit;
--����Ŀ�� ��
set autocommit on;
--����Ŀ�� ����
set autocommit off;
delete from emps where employee_id =304;

select *from emps;
insert into emps
    (employee_id, last_name, email, hire_date, job_id)
values
    (304,'lee','lee1234@naver.com', sysdate, 1800);
rollback;

--���̺� ����Ʈ ����.
--�ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����.
--ANSI ǥ�� ������ �ƴϱ� ������ ����x.
savepoint insert_park;

insert into emps
    (employee_id, last_name, email, hire_date, job_id)
values
    (305,'park','park1234@naver.com', sysdate, 1800);

rollback to savepoint insert_park;

--�������� ��� ������ ��������� ���������� �����ϸ鼭 Ʈ����� ����
--Ŀ���� ���Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� ����.
commit;