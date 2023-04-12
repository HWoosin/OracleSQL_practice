-- lower(�ҹ���), initcap(�ձ��ڸ� �빮��), upper(�빮��)
SELECT
    *
FROM
    dual;

/*
dual�̶�� ���̺��� sys�� �����ϴ� ����Ŭ�� ���� ���̺�μ�,
���� �� �࿡ �� �÷��� ��� �ִ� dummy ���̺� �Դϴ�.
�Ͻ����� ��� �����̳� ��¥ ���� � �ַ� ���.
���� ����ڰ� ������ �� �ִ�.
*/
SELECT
    'abcDEF',
    lower('abcDEF'),
    upper('abcDEF')
FROM
    dual;

SELECT
    last_name,
    lower(last_name),
    initcap(last_name),
    upper(last_name)
FROM
    employees;

SELECT
    last_name
FROM
    employees
WHERE
    lower(last_name) = 'austin';
    
--length(����), instr(���� ã��, ������ 0�� ��ȯ, ������ �ε��� ��)
select 'abcdef', length('abcdef'), instr('abcdef','a')
from dual;

select
    first_name, length(first_name), instr(first_name,'a')
from employees;

--substr(���ڿ� �ڸ���), concat(���� ����) 1���� ����.
select 'abcdef' as ex,
substr('abcdef',1,4),concat('abc','def') from dual;

select first_name,substr(first_name,1,3),concat(first_name, last_name) from employees;

--LPAD, RPAD (��, ���� �������ڿ��� ä���)
select LPAD('abc',10,'*'), RPAD('abc',10,'*') from dual;

-- LTRIM(), RTRIM(), TRIM() ��������
-- LTRIM(param1, param2) -> param2�� ���� param1���� ã�Ƽ� ����. (���ʺ���)
-- RTRIM(param1, param2) -> param2�� ���� param1���� ã�Ƽ� ����. (�����ʺ���)

select LTRIM('javascript_java','java') from dual;
select RTRIM('javascript_java','java') from dual;
select TRIM('    java    ') from dual;

--replace()
select replace('my dream is a president', 'president', 'programmer') from dual;
select replace('my dream is a president', ' ', '') from dual;
select replace(replace('my dream is a president', 'president', 'programmer'),' ','') 
from dual;

select replace(concat('hello',' world!'),'!','?')from dual;

/*
���� 1.
EMPLOYEES ���̺� ���� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
*/
select concat(first_name, last_name) as name, replace(hire_date, '/','')as hireDate from employees
order by name asc;

/*
���� 2.
EMPLOYEES ���̺� ���� phone_number�÷��� ###.###.####���·� ����Ǿ� �ִ�
���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���
*/
select replace(phone_number,substr(phone_number,1,4),'(02)') from employees;

/*
���� 3. 
EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
*/
select * from employees;

select rpad(substr(first_name,1,3),length(first_name),'*') as name,
lpad(salary,10,'*') as salary 
from employees
where lower(job_id) = 'it_prog';