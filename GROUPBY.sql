select * from usertbl;
select * from buytbl;

-- ����ں� ���� �Ѿ� ���
select userid, price, amount from buytbl;

select userid, sum(price * amount) as �ѱ��ž�
from buytbl 
group by userid;

-- ����ں� ���� Ƚ�� ���
select userid, count(*) as ����Ƚ��
from buytbl
group by userid;

-- ������ ����� �� ���
SELECT addr, COUNT(*) AS ����ڼ�
FROM userTbl
group by addr;

-- ��ǰ �׷캰 �Ǹ� �ݾ� �հ�
select groupname, sum(price * amount) as �Ǹž�
from buytbl
where groupname is not null
group by groupname;

-- ����⵵ ���� ����� �� order by asc/desc (��������/��������)
select birthyear, count(*) as �ο���
from usertbl
group by birthyear
order by birthyear;

-- ORDER BY
-- �������� ASC
select name , mdate from usertbl order by mdate;
select name , mdate from usertbl order by name;

-- �������� DESC
select name , mdate from usertbl order by mdate desc;
select name , mdate from usertbl order by name desc;

-- ���� + ����
select name, height from usertbl order by height desc, name asc;

-- �������� + ROWNUM - �ึ�� �ο��Ǵ� num
select * from (select rownum as RN, usertbl.* from usertbl) where rn = 2;
select * from (select rownum as RN, usertbl.* from usertbl)
where rn >= 2 and rn <= 4;


-- EX
select * from usertbl;
select * from buytbl;

-- 1
select addr, count(*) as ����ڼ�
from usertbl
group by addr;

-- 2
select userid, sum(price * amount) as �ѱ��ž�
from buytbl
group by userid;

-- 3
-- COALESCE
select coalesce(groupname, '�̺з�') as ��ǰ�׷�, sum(amount) as �Ǹż���
from buytbl
group by groupname;
-- NVL
select nvl(groupname, '�̺з�') as ��ǰ�׷�, sum(amount) as �Ǹż���
from buytbl
group by groupname;
-- CASE - IS NULL THEN (CASE END)
select
    case 
        when groupname is null then '�̺з�'
        else groupname
    end as ��ǰ�׷�, sum(amount) as �Ǹż���
from buytbl
group by groupname;

-- 4
select birthyear, avg(height) as ���Ű
from usertbl
group by birthyear;

-- 5
select prodname, count(*) as ����Ƚ��, sum(price * amount) as �ѱ��ž�
from buytbl
group by prodname
order by ����Ƚ�� desc;

-- 6
select coalesce(mobile1, '���Է�') as ��Ż�, count(*) as �����ڼ�
from usertbl
group by mobile1;

-- 7 
select u.addr as ����, sum(b.price * b.amount) as �ѱ��ž�
from usertbl u
join buytbl b on u.userid = b.userid
group by u.addr;

-- 8
select userid, count(distinct groupname) as ��ǰ��������
from buytbl
group by userid;

select userid, groupname, count(groupname)
from buytbl
group by userid, groupname;

-- 9
-- EXTRACT ��¥ ���� ���� �Լ�
select extract(year from mdate) as ���Կ�����, count(*) as �����ڼ�
from usertbl
group by extract(year from mdate);
-- SUBSTR ���ڿ� �ڸ���
select substr(mdate,1,2) as ���Կ�����, count(*) as �����ڼ�
from usertbl
group by substr(mdate,1,2);

-- 10
select (2023-u.birthyear) as ����, sum(b.price * b.amount) as �����Ѿ�
from usertbl u
join buytbl b on u.userid = b.userid
group by (2023-u.birthyear)
order by ����;

SELECT FLOOR((2023 - u.birthYear) / 10) * 10 AS ���ɴ�, 
       SUM(b.price * b.amount) AS �����Ѿ�
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID
GROUP BY FLOOR((2023 - u.birthYear) / 10) * 10
ORDER BY ���ɴ�;
