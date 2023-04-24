--While ��

declare
    v_num number := 3;
    v_count number :=1;
begin
    while v_count <= 10
    loop
        dbms_output.put_line(v_num);
        v_count := v_count+1;
    end loop;

end;

--Ż�⹮
declare
    v_num number := 3;
    v_count number :=1;
begin
    while v_count <= 10
    loop
        dbms_output.put_line(v_num);
        exit when v_count = 5;
        v_count := v_count+1;
    end loop;

end;

--for��

declare
    v_num number :=3;
begin
    for i in 1..9
    loop
        dbms_output.put_line(v_num || 'x' ||i|| '=' || v_num*i);
    end loop;
end;

declare
    v_num number :=3;
begin
    for i in 1..9
    loop
        continue when i = 5;
        dbms_output.put_line(v_num || 'x' ||i|| '=' || v_num*i);
    end loop;
end;


-- 1. ��� �������� ����ϴ� �͸� ��� ����� (2~9��)
declare
    i number :=1;
begin
    for i in 2..9
    loop
        for j in 1..9
        loop
        dbms_output.put_line(i || 'x' ||j|| '=' || i*j);
        end loop;
    end loop;
end;

-- 2. insert�� 300 �� �����ϴ� �͸� ����� ó��.
-- board��� �̸��� ���̺��� �����. (bno, writer, title �÷��� ����)
-- bno�� sequence�� �÷��ְ�, writer�� title�� ��ȣ�� �ٿ��� insert����.
-- ex) 1, test1, title1
create sequence board_sequence
    start with 1
    INCREMENT by 1;
drop sequence board_sequence;  

create table board (
    bno number(3),
    writer varchar2(20),
    title varchar2(20)
);
select * from board;
drop table board;
declare
    i number :=0;
begin
    for i in 1..300
    loop
        insert into board
        values(board_sequence.nextval,'test'||i,'title'||i);
    end loop;
end;