--오토커밋 여부 확인
show autocommit;
--오토커밋 온
set autocommit on;
--오토커밋 오프
set autocommit off;
delete from emps where employee_id =304;

select *from emps;
insert into emps
    (employee_id, last_name, email, hire_date, job_id)
values
    (304,'lee','lee1234@naver.com', sysdate, 1800);
rollback;

--세이브 포인트 생성.
--롤백할 포인트를 직접 이름을 붙여서 지정.
--ANSI 표준 문법이 아니기 때문에 권장x.
savepoint insert_park;

insert into emps
    (employee_id, last_name, email, hire_date, job_id)
values
    (305,'park','park1234@naver.com', sysdate, 1800);

rollback to savepoint insert_park;

--보류중인 모든 데이터 변경사항을 영구적으로 적용하면서 트랜잭션 종료
--커밋한 이후에는 어떠한 방법을 사용하더라도 되돌릴 수 없다.
commit;