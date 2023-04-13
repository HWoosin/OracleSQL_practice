--�� ��ȯ�Լ� TO_CHAR, TO_NUMBER, TO_DATE

--��¥�� ���ڷ� To_CHAR(��, ����)
SELECT
    to_char(sysdate)
FROM
    dual;

SELECT
    to_char(sysdate, 'yyyy-mm-dd dy pm hh:mi:ss')
FROM
    dual;

SELECT
    to_char(sysdate, 'yy-mm-dd hh24:mi:ss')
FROM
    dual;--24�ð���

--����ϰ� ���� ���ڸ� ""�� ���� ����
SELECT
    first_name,
    to_char(hire_date, 'yyyy"��" mm"��" dd"��"')
FROM
    employees;

--���ڸ� ���ڷ� TO_CHAR(��, ����)
SELECT
    to_char(20000, '99999')
FROM
    dual;
--�־��� �ڸ����� ���ڸ� ��� ǥ���� �� ��� ��� #���� ǥ���
SELECT
    to_char(20000, '9999')
FROM
    dual;

SELECT
    to_char(20000.25, '99999.9')
FROM
    dual;

SELECT
    to_char(salary, '$99,999')
FROM
    employees;

--���ڸ� ���ڷ� TO_NUMBER(��,����)
SELECT
    '2000' + 2000
FROM
    dual; --�ڵ� �� ��ȯ (���� -> ����)
SELECT
    TO_NUMBER('2000') + 2000
FROM
    dual;

SELECT
    '$3,300' + 2000
FROM
    dual;--����
SELECT
    TO_NUMBER('$3,300', '$9,999') + 2000
FROM
    dual;

--���ڸ� ��¥�� ��ȯ�ϴ� �Լ� TO_date(��, ����)
SELECT
    TO_DATE('2023-04-13')
FROM
    dual;

SELECT
    sysdate - TO_DATE('2021-03-26')
FROM
    dual;

SELECT
    TO_DATE('2020/12/25', 'yy-mm-dd')
FROM
    dual; 
--�־��� ���ڿ��� ��� ��ȯ�ؾ��Ѵ�.
SELECT
    TO_DATE('2021-03-31 12:33:50', 'yy-mm-dd hh:mi:ss')
FROM
    dual; 

--xxxx�� xx�� xx�� ���ڿ� �������� ��ȯ.
--��ȸ �÷����� dateInfo
SELECT
    to_char(TO_DATE('20050102'),
            'yyyy"��" mm"��" dd"��"') AS dateinfo
FROM
    dual;

--NULL ���� �Լ� NVL(�÷�, ��ȯ�� Ÿ�ٰ�)
SELECT
    NULL
FROM
    dual;

SELECT
    nvl(NULL, 0)
FROM
    dual;

SELECT
    first_name,
    nvl(commission_pct, 0) AS comm_pct
FROM
    employees;

--NULL ���� �Լ� NVL2(�÷�, null�� �ƴ� ��� ��, null�� ����� ��)
SELECT
    nvl2('abc', '�ξƴ�', '����')
FROM
    dual;

SELECT
    first_name,
    nvl2(commission_pct, 'true', 'false')
FROM
    employees;

SELECT
    first_name,
    commission_pct,
    nvl2(commission_pct, salary +(salary * commission_pct), salary) AS real_salary
FROM
    employees;

--DECODE(�÷� Ȥ�� ǥ����, �׸�1, ���1, �׸�2, ���2 ...... default)
SELECT
    decode('F', 'A', 'A�Դϴ�.', 'B', 'B�Դϴ�.',
           'C', 'C�Դϴ�.', '�𸣰ڴµ���!')
FROM
    dual;

SELECT
    job_id,
    salary,
    decode(job_id, 'IT_PROG', salary * 1.1, 'FI_MGR', salary * 1.2,
           'AD_VP', salary * 1.3) AS result
FROM
    employees;
    
--CASE WHEN THEN END
select
    first_name,
    job_id,
    salary,
    (case job_id
        when 'IT_PROG' then salary*1.1
        when 'FI_MGR' then salary*1.2
        when 'AD_VP' then salary*1.3
        when 'FI_ACCOUNT' then salary*1.4
        else salary
    end) AS result
from employees;

select * from employees;
/*���� 1.
�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 17�� �̻���
����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�
*/
select 
employee_id as �����ȣ, 
first_name||' '|| last_name as �����,
hire_date as �Ի�����,
trunc((sysdate-hire_date)/365,0) as �ټӳ��
from employees where trunc((sysdate-hire_date)/365,0) > 17 order by �ټӳ�� desc;
/*
���� 2.
EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
100�̶�� �������, 
120�̶�� �����ӡ�
121�̶�� ���븮��
122��� �����塯
�������� ���ӿ��� ���� ����մϴ�.
���� 1) department_id�� 50�� ������� ������θ� ��ȸ�մϴ�
*/
select first_name, manager_id, 
(case manager_id 
when 100 then '���'
when 120 then '����'
when 121 then '�븮'
when 122 then '����'
else '�ӿ�' 
end) as ����
from employees where department_id = 50;

-------------------------------------------------------------

select
    salary,
    employee_id,
    first_name,
    decode(
        salary,
        salary >=4000, 'A',
        salary >=3000 and salary <=3999, 'B',
        salary >=2000 and salary <=2999, 'C',
        salary >=1000 and salary <=1999, 'D',
        salary >=0 and salary <=999, 'E'
    )as grade
from employees
order by salary desc;

select
    salary,
    employee_id,
    first_name,
    decode(
        trunc(salary/1000),
        0,'E',
        1,'D',
        2,'C',
        3,'B',
        'A'
    )as grade
from employees
order by salary desc;

SELECT 
    salary,
    employee_id,
    first_name,
    (CASE
        WHEN salary BETWEEN 0 AND 999 THEN 'E'
        WHEN salary BETWEEN 1000 AND 1999 THEN 'D'
        WHEN salary BETWEEN 2000 AND 2999 THEN 'C'
        WHEN salary BETWEEN 3000 AND 3999 THEN 'B'
        ELSE 'A'
    END) AS grade
FROM employees
ORDER BY salary DESC;