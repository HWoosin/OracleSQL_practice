/*
trigger�� ���̺� ������ ���·ν�, insert, update, delete�۾��� ����� ��
Ư�� �ڵ尡 �۵��ǵ��� �ϴ� ����.
view���� ������ �Ұ���.

Ʈ���Ÿ� ���� �� ���� �����ϰ� �κн����ϱ�.
*/
create table tbl_test(
    id number(10),
    text varchar2(20)
);

create or replace trigger trg_test
    after delete or update -- Ʈ������ �߻�����. �����Ǵ� ���� ���Ŀ� ����
    on tbl_test -- Ʈ���Ÿ� ������ ���̺�
    for each row -- �� �࿡ ��� ����. ������ �ѹ��� ����
--declare ���� ����
begin
    dbms_output.put_line('Ʈ���Ű� ������!'); --�����ϰ��� �ϴ� �ڵ带 begin~end�� ����.
    
end;

insert into tbl_test values(1,'��ö��');
update tbl_test set text ='��ǻ�' where id =1;
delete from tbl_test where id =1;