-- ������
select * from usertbl where name ='���ȣ';

-- ������ + ���迬����
select * from usertbl where birthyear >= 1970 and height >= 182;
select * from usertbl where birthyear >= 1970 or height >= 182;

-- ������ + BETWEEN
select * from usertbl where birthyear >= 1970 and birthyear <= 1980;
select * from usertbl where birthyear between 1970 and 1980;

-- IN
select name,height FROM usertbl WHERE addr in('�泲','����','���');
select * from usertbl where mobile1 in ('010','011');

-- LIKE % (��繮��, �������� x) / _ (��繮��, _��ŭ�� ����)
select * from usertbl where name like '��%';
select * from usertbl where name like '_���';

-- NULL CHECK (IS NULL / IS NOT NULL)
select * from usertbl where mobile2 is null;
select * from usertbl where mobile2 is not null;

-- DISTINCT (�ߺ� ����)
select addr from usertbl;
select distinct addr from usertbl;

-- ALIAS ��Ī
select name, addr, mobile1 || mobile2 as phone from usertbl;


-- EX
select * from buytbl;

-- 1
select * from buytbl where amount >= 5 ;

-- 2
select userid, prodname from buytbl where price between 50 and 500 ;

-- 3
select * from buytbl where amount >= 10 or price >= 100 ;

-- 4
select * from buytbl where userid like 'K%';

-- 5
select * from buytbl where groupname in ('����','����');

-- 6
select * from buytbl where prodname = 'å' or trim(userid) like '%W';
