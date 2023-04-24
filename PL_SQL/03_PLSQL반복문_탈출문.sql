--While 문

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

--탈출문
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

--for문

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


-- 1. 모든 구구단을 출력하는 익명 블록 만들기 (2~9단)
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

-- 2. insert를 300 번 실행하는 익명 블록을 처리.
-- board라는 이름의 테이블을 만들기. (bno, writer, title 컬럼이 존재)
-- bno는 sequence로 올려주고, writer와 title에 번호를 붙여서 insert진행.
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