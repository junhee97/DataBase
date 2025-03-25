-- ������ �Լ� ����
select userid, upper(name) as upper_name 
from usertbl;

-- ������ �Լ� ����
select addr, count(*) as user_count
from usertbl
group by addr;

-- ��ҹ��� ��ȯ
select userid, lower(userid) as lower_id, -- �ҹ��� ��ȯ
        upper(userid) as upper_id, -- �빮�� ��ȯ
        initcap(lower(userid)) as init_cap -- ù���ڸ� �빮�ڷ� ��ȯ
from usertbl;

-- ���ڿ� ����
select name, length(name) as name_length, -- �̸��� ���� ����
        length(addr) as addr_length -- �ּ��� ���� ����
from usertbl;

-- ���ڿ� ����
select name, substr(name, 1, 1) as first_char, -- �̸��� ù ����
        substr(userid, 2) as userid_part -- userid�� �ι�° ���ں��� ������
from usertbl;

-- ���� ��ġ ã��
select name, instr(name, '��') as position_kim -- '��'�� �ִ� ��ġ (������ 0)
from usertbl;

-- ���ڿ� ä���
select userid, lpad(userid, 10, '*') as lpad_id, -- userid ������ *�� 10�ڸ� ä���
        rpad(name, 10, '-') as rpad_name -- name �������� -�� 10�ڸ� ä���
from usertbl;

-- ���� ����
select trim('sql') as trim_result, -- ���� ���� ���� : 'sql'
        ltrim('sql') as ltrim_result, -- ���� ���� ���� : 'sql'
        rtrim('sql') as rtrim_result -- ������ ���� ���� : 'sql'
from dual;

-- ���ڿ� ġȯ
select name, replace(mobile1, null, '����') as replace_null, -- null�� '����'���� ��ü
        replace(addr, '����', 'SEOUL') as replace_addr -- '����'�� 'SEOUL'�� ��ü
from usertbl;

-- ���ڿ� ����
select name, concat(mobile1, '-') as part1, -- �޴��� ������ '-' ����
        concat(concat(mobile1, '-'), mobile2) as mobile, -- ���� - ��ȭ��ȣ �������� ����
        mobile1 || '-' || mobile2 as phone_number -- ���� ������ ���
from usertbl;

-- �ݿø�, ����
select prodname, price, round(price / 1000, 2) as round_thousands, -- õ ������ ������ �Ҽ��� 2�ڸ� �ݿø�
        trunc(price / 1000, 1) as trunc_thousands -- õ ������ ������ �Ҽ��� 1�ڸ� ����
from buytbl;

-- �ø�, ����
select prodname, price, ceil(price / 100) as ceil_hundreds, -- �� ������ ������ �ø�
        floor(price / 100) as floor_hundreds -- �� ������ ������ ����
from buytbl;

-- ������, ���밪
select prodname, price, amount, mod(price, 100) as remainder_100, -- ������ 100���� ���� ������
        abs(price - 500) as abs_diff_500 -- ���ݰ� 500 ������ ���밪
from buytbl;

-- ��ȣ Ȯ��, ����, ������
select prodname, price, sign(price - 100) as sign_price, -- ������ 100���� ũ�� 1, ������ 0, ������ -1
        power(amount, 2) as amount_squared, -- ������ ����
        sqrt(price) as sqrt_price -- ������ ������
from buytbl;

-- ���� ��¥�� ȸ�������� Ȱ��
select name, mdate, sysdate as today, -- ���� ��¥/�ð�
        current_date as current_date -- ���� ��¥
from usertbl;

-- ��¥ ����
select name, mdate, mdate + 7 as after_week, -- ���� 1���� ��
        mdate - 7 as before_week -- ���� 1���� ��
from usertbl;

-- �� ���� �Լ�
select name, mdate, add_months(mdate, 6) as after_6months, -- ���� 6���� ��
        months_between(sysdate, mdate) as months_since_join -- ���� �� ��� �� ��
from usertbl;

-- ����, ���� �Լ�
select name, mdate, next_day(mdate, '�ݿ���') as next_friday, -- ������ ������ ù �ݿ���
        last_day(mdate) as last_day_of_month -- ���Կ��� ������ ��¥
from usertbl;

-- ��¥ ��� ����
select name, mdate, extract(year from mdate) as join_year, -- ���Գ⵵
        extract(month from mdate) as join_month, -- ���� ��
        extract(day from mdate) as join_day -- ���� ��
from usertbl;

-- ��¥ -> ���� ��ȯ
select name, mdate, to_char(mdate, 'yyyy-mm-dd') as formatted_date, -- 'yyyy-mm-dd' ����
        to_char(mdate, 'yyyy"��"mm"d��"dd"��"') as korean_date, --'yyyy"��"mm"d��"dd"��"' ����
        to_char(mdate, 'yyyy/mm/dd hh24:mi:ss') as date_with_time -- �ð� ���� ����
from usertbl;

-- ���� -> ���� ��ȯ
select prodname, price, amount, to_char(price, '999,999') as formatted_price, -- 1,000 ����
        to_char(price * amount, '999,999') as total, -- ����*���� õ���� ����
        to_char(price/1000, '0.00') as price_thousands -- �Ҽ��� ǥ��
from buytbl;

-- ���� -> ���� ��ȯ
select to_number('1,000', '9,999') as number_result, -- ���� '1,000'�� ���� 1000����
        to_number('��2,000', 'L9,999') as currency_to_number -- ��ȭ ��ȣ�� �ִ� ���ڸ� ���ڷ�
from dual;

-- ���� -> ��¥ ��ȯ
select to_date('2025-12-25', 'yyyy-mm-dd') as christmas, -- ���ڿ��� ��¥��
        to_date('20251225', 'yyyymmdd') as christmas_no_sep, -- ������ ���� ���ڿ��� ��¥��
        to_date('2025/12/25 14:30:00', 'yyyy/mm/dd hh24:mi:ss') as christmas_time -- �ð� ����
from dual;

-- NVL �Լ�
select name, mobile1, mobile2, nvl(mobile1, '����') as nvl_mobile1 -- null�̸� '����' ��ȯ
from usertbl;
