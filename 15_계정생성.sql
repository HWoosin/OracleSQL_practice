--����� ���� Ȯ��
select * from all_users;
--���� ���� ���
create user user1 identified by user1;
/*
DCL: Grant(���Ѻο�), revoke(���� ȸ��)

CREATE USER -> �����ͺ��̽� ���� ���� ����
CREATE SESSION -> �����ͺ��̽� ���� ����
CREATE TABLE -> ���̺� ���� ����
CREATE VIEW -> �� ���� ����
CREATE SEQUENCE -> ������ ���� ����
ALTER ANY TABLE -> ��� ���̺� ������ �� �ִ� ����
INSERT ANY TABLE -> ��� ���̺��� �����͸� �����ϴ� ����.
SELECT ANY TABLE...

SELECT ON [���̺� �̸�] TO [���� �̸�] -> Ư�� ���̺� ��ȸ�� �� �ִ� ����.
INSERT ON....
UPDATE ON....

- �����ڿ� ���ϴ� ������ �ο��ϴ� ����.
RESOURCE, CONNECT, DBA TO [���� �̸�]
*/

grant create session to user1;
grant select on hr.employees to user1;
grant create table to user1;
grant connect, resource to user1;

revoke connect, resource from user1;

--����� ���� ����
--drop user [�����̸�] cascade;
--cascade ���� �� -> ���̺� or ������ �� ��ü�� �����Ѵٸ� �������� �ȵ�.
drop user user1 CASCADE;

/*
���̺� �����̽��� �����ͺ��̽� ��ü �� ���� �����Ͱ� ����Ǵ� �����Դϴ�.
���̺� �����̽��� �����ϸ� ������ ��ο� ���� ���Ϸ� ������ �뷮��ŭ��
������ ������ �ǰ�, �����Ͱ� ���������� ����˴ϴ�.
�翬�� ���̺� �����̽��� �뷮�� �ʰ��Ѵٸ� ���α׷��� ������������ �����մϴ�.
*/
select * from dba_tablespaces;

create user test1 identified by test1;

grant create session to test1;
grant connect, resource to test1;

--user_tablespace ���̺� �����̽��� �⺻ ���������� ����.
alter user test1 default tablespace user_tablespace
quota unlimited on user_tablespace;

--���̺� �����̽� ���� ��ü�� ��ü ����.
drop tablespace user_tablespace including contents;
--������ ���ϱ��� �ѹ��� �����ϴ� ��
drop tablespace user_tablespace including contents and datafiles;
