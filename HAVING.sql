-- ���� �ݾ� �հ谡 1000 �̻��� ����� ��ȸ
select userid, sum(price * amount) as �ѱ��ž�
from buytbl
group by userid
having sum(price * amount) >= 1000;

-- ��� Ű�� 175 �̻��� ���� ��ȸ
select addr, avg(height) as ���Ű
from usertbl
group by addr
having avg(height) >= 175;

-- �� ���� Ƚ���� 3ȸ �̻��̰� �� ���ž��� 100 �̻��� �����
select userid, count(*) as ����Ƚ��, sum(price * amount) as �ѱ��ž�
from buytbl
group by userid
having count(*) >= 3 and sum(price * amount) >= 100;

-- ����� ������, ��ǰ �׷캰 ���ž� �հ�
select u.addr, nvl(b.groupname, '�̺з�') as ���ı׷�, sum(b.price * b.amount) as �ѱ��ž�
from usertbl u
join buytbl b on u.userid = b.userid
group by u.addr, b.groupname;

-- ������, ������ ȸ������ ��
select addr, extract(year from mdate) as ���Գ⵵, count(*) as ȸ�����Լ�
from usertbl
group by addr, extract(year from mdate)
order by addr, ���Գ⵵;

-- ROLLUP
select groupname, sum(price * amount) as �Ǹž�
from buytbl
group by rollup(groupname);
--
select groupname, prodname, sum(price * amount) as �Ǹž�
from buytbl
group by rollup(groupname, prodname);

-- CUBE
select groupname, prodname, sum(price * amount) as �Ǹž�
from buytbl
group by cube(groupname, prodname);

-- GROUPING SETS
select groupname, prodname, sum(price * amount) as �Ǹž�
from buytbl
where groupname is not null
group by grouping sets((groupname), (prodname),());

-- UNION ALL
select groupname, null as prodname, sum(price * amount) as �Ǹž�
from buytbl
where groupname is not null
group by groupname
union all
select null as groupname, prodname, sum(price * amount) as �Ǹž�
from buytbl
where groupname is not null
group by prodname;

-- EX
select * from usertbl;
select * from buytbl;

-- 1
select userid, sum(price * amount) as �ѱ��ž�
from buytbl
group by userid
having sum(price * amount) >=1000;

-- 2
select addr, count(*) as �����ڼ�
from usertbl
group by addr
having count(*) >= 2;

-- 3
select prodname, avg(price * amount) as ��ձ��ž�
from buytbl
group by prodname
having avg(price * amount) >= 100;

-- 4
select birthyear,  avg(height) as ���Ű
from usertbl
group by birthyear
having avg(height) >= 175;

-- 5
select userid, sum(amount) as ������ǰ��
from buytbl
group by userid
having sum(amount) >= 2;

-- 6
select u.addr, sum(b.price * b.amount) as �����Ѿ�
from usertbl u
join buytbl b on u.userid = b.userid
group by u.addr
having sum(b.price * b.amount) >= 200;

-- 7
select userid, count(*) as ����Ƚ��, sum(price * amount) as �ѱ��ž�
from buytbl
group by userid
having count(*) >= 3 and sum(price * amount) >= 500;

-- 8
select addr, avg(height) as ���Ű
from usertbl
group by addr
having avg(height) = (
    select max(���Ű)
    from (
        select addr, avg(height) as ���Ű
        from usertbl
        group by addr
        )
);

select * from (select addr, avg(height) as ���Ű from usertbl group by addr)
where ���Ű = (select max(avg(height)) as ���Ű from usertbl group by addr);

-- 9
select userid, avg(price * amount) as ���űݾ�
from buytbl
group by userid
having avg(price * amount) > (
    select avg(price * amount)
    from buytbl
);

-- 10
select userid, a.addr, �����Ѿ�, ��������ձ��ž�
from
    (select u.addr, u.userid, sum(b.price * b.amount) as �����Ѿ�
      from usertbl u
      join buytbl b on u.userid = b.userid
       group by u.addr, u.userid) a
join
    (select u2.addr, avg(b2.price * b2.amount) as ��������ձ��ž�
      from usertbl u2
      join buytbl b2 on u2.userid = b2.userid
      group by u2.addr) c 
on a.addr = c.addr
where �����Ѿ� >= ��������ձ��ž�;


select aa.addr,userid,�Ѿ�,���������
from 
(
    -- ���� ����(addr)�� ��� ����ڵ� �� ���� �Ѿ�
    select addr ,u.userid, sum(amount*price) as �Ѿ�
    from userTbl u
    join buyTbl b 
    on u.userid=b.userid
    group by addr,u.userid
) aa
join
(
    --������ �������
    select addr,avg(amount*price) as ���������
    from userTbl u
    join buyTbl b
    on u.userid=b.userid
    group by addr
) bb
on aa.addr=bb.addr
where aa.�Ѿ�>=bb.���������;