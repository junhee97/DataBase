-- 조건절
select * from usertbl where name ='김경호';

-- 조건절 + 관계연산자
select * from usertbl where birthyear >= 1970 and height >= 182;
select * from usertbl where birthyear >= 1970 or height >= 182;

-- 조건절 + BETWEEN
select * from usertbl where birthyear >= 1970 and birthyear <= 1980;
select * from usertbl where birthyear between 1970 and 1980;

-- IN
select name,height FROM usertbl WHERE addr in('경남','전남','경북');
select * from usertbl where mobile1 in ('010','011');

-- LIKE % (모든문자, 길이제한 x) / _ (모든문자, _만큼의 길이)
select * from usertbl where name like '김%';
select * from usertbl where name like '_재범';

-- NULL CHECK (IS NULL / IS NOT NULL)
select * from usertbl where mobile2 is null;
select * from usertbl where mobile2 is not null;

-- DISTINCT (중복 제거)
select addr from usertbl;
select distinct addr from usertbl;

-- ALIAS 별칭
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
select * from buytbl where groupname in ('서적','전자');

-- 6
select * from buytbl where prodname = '책' or trim(userid) like '%W';
