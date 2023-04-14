--이너(내부) 조인
select *
from info i
inner join auth a
on i.auth_id = a.auth_id;

--오라클 (잘 안씀)
select *
from info i, auth a
where i.auth_id = a.auth_id;

-- auth_id 컬럼을 그냥 쓰면 모호하다 라고 한다.
-- 그 이유는 양쪽 테이블에 모두 존재하기 때문.
-- 이럴 때는, 컬럼에 테이블 이름을 붙이던지, 별칭을 써서 확실하게 지목을 하기.
select 
    a.auth_id, i.title, i.content, a.name
from info i
inner join auth a
on i.auth_id = a.auth_id;