-- ���� ����
-- ���ȣ���� Ű�� ū ����� ��ȸ
select userid, name, height
from usertbl
where height > (select height from usertbl where name = '���ȣ');

-- �泲 ������ ��� ����ڿ� ���� Ű�� ���� ����� ��ȸ
select userid, name, addr, height
from usertbl
where height in (select height from usertbl where addr = '�泲');

select userid, name, addr, height
from usertbl
where height >= any(select height from usertbl where addr = '�泲');

select userid, name, addr, height
from usertbl
where height >= all(select height from usertbl where addr = '�泲');

-- �ּҺ��� ���� Ű�� ū ����� ��ȸ
select userid, name, addr, height
from usertbl
where (addr, height) in (select addr, max(height) from usertbl group by addr);

-- �� ������� ���� �Ѿ� ���
select u.userid, name,
        (select sum(price * amount)from buytbl b where b.userid = u.userid) AS �ѱ��ž�
from usertbl u;


-- Ex
-- 1 ���� ������ �����ϴ� ȸ�� ��, ��ü ��� Ű���� ū ȸ���� �̸��� Ű�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select name, height
from usertbl
where addr = '����' and height > (select avg(height) from usertbl);

-- 2 ��ǰ�� �� ���̶� ������ ���� �ִ� ȸ���� �̸��� �ּҸ� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select name, addr
from usertbl
where userid in (select userid from buytbl);

-- 3 �����ڡ� �з� ��ǰ �� ���� ��� ��ǰ�� ������
--  ȸ���� �̸��� ��ǰ��, ������ ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select name, prodname, price
from usertbl u
join buytbl b on u.userid = b.userid
where groupname = '����' and price = (select max(price) from buytbl);

-- 4 �� ȸ���� ������ �� �ݾ�(price �� amount)�� ��պ��� �� ���� ������
--  ȸ���� �̸��� �� ���� �ݾ��� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select userid, �ѱݾ�
from
(
    select userid, sum(price * amount) as �ѱݾ�
    from buytbl
    group by userid
)
where �ѱݾ� > (select avg(�ѱݾ�) from (
                                    select sum(price * amount) as �ѱݾ�
                                    from buytbl
                                    group by userid
                                    )
);

-- 5 �� ���� ������ ������ �� ���� ȸ���� �̸��� �������� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select name, mdate
from usertbl
where userid not in (select userid from buytbl);

-- 6 û������ ������ ȸ����� ���� ������ ��� �ٸ� ȸ������ �̸��� ������ ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�
select name, addr
from usertbl
where addr in (
    select addr
    from usertbl
    where userid in (
        select userid
        from buytbl 
        where prodname = 'û����'
    )
);

-- 7 �� ȸ���� userID�� �� ȸ���� ������ ���� ��� ��ǰ�� �̸��� ������ ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select userid, prodname, price
from buytbl
where (userid, price) in (select userid, max(price) from buytbl group by userid);

-- 8 ���ȭ���� ������ ȸ���� ������ �� ���� ȸ���� �ִ� �������� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select addr
from usertbl
group by addr
having count(userid) > (select count(userid) from buytbl where prodname = '�ȭ');

-- 9 �ڽ��� ������ ��ǰ �� ��å������ ��� ��ǰ�� ������ ȸ���� �̸��� ��ǰ���� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select distinct name, prodname
from usertbl u
join buytbl b on u.userid = b.userid
where b.price > (select max(price) from buytbl where prodname = 'å');


-- 10 ��� ȸ���� ��� Ű���� Ű�� ���� ȸ���� ������ ��ǰ�� �̸��� ������ ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.