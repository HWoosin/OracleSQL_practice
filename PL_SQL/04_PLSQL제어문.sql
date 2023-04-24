--if
declare
    v_num1 number := 10;
    v_num2 number := 15;
begin
    if
        v_num1 >= v_num2
    then
        dbms_output.put_line(v_num1 || '이(가) 큰 수');
    else
        dbms_output.put_line(v_num2 || '이(가) 큰 수');
    end if;
end;

--elsif
declare
    v_salary number := 0;
    v_department_id number := 0;
begin
    v_department_id := round(dbms_random.value(10,120),-1);
    select
        salary
    into
        v_salary
    from employees
    where department_id = v_department_id
    and rownum =1; --첫째 값만 구해서 변수에 저장하기 위해
   
    dbms_output.put_line(v_salary);
   
    if v_salary <= 5000 then
        dbms_output.put_line('낮음');
    elsif v_salary <= 9000 then
        dbms_output.put_line('중간');
    else
        dbms_output.put_line('높음');
    end if;
end;

--case
declare
    v_salary number := 0;
    v_department_id number := 0;
begin
    v_department_id := round(dbms_random.value(10,120),-1);
    select
        salary
    into
        v_salary
    from employees
    where department_id = v_department_id
    and rownum =1; --첫째 값만 구해서 변수에 저장하기 위해
   
    dbms_output.put_line(v_salary);
    case
        when v_salary <= 5000 then
            dbms_output.put_line('낮음');
        when v_salary <= 9000 then
            dbms_output.put_line('중간');
        else
            dbms_output.put_line('높음');
    end case;
end;
--중첩if문
declare
    v_salary number := 0;
    v_department_id number := 0;
    v_commission number :=0;
begin
    v_department_id := round(dbms_random.value(10,120),-1);
    select
        salary, commission_pct
    into
        v_salary, v_commission
    from employees
    where department_id = v_department_id
    and rownum =1; --첫째 값만 구해서 변수에 저장하기 위해
   
    dbms_output.put_line(v_salary);
   
    if v_commission >0 then
        if v_commission >0.15 then
            dbms_output.put_line(v_salary * v_commission);
        end if;
    else
        dbms_output.put_line(v_salary);
    end if;
end;