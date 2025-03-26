-- JOIN
select name, birthyear, addr, prodname, groupname, price
from usertbl u
join buytbl b on u.userid = b.userid;

-- userid�� �� ���̺��� �����ϱ� ������ ���� �߻�(userid �տ� u, b �ٿ��� ���)
select u.userid, name, birthyear, addr, prodname, groupname, price
from usertbl u
join buytbl b on u.userid = b.userid;

-- ȸ���� �� ���� �ݾ�
select u.userid, name, sum(price * amount) as �ѱ��űݾ�
from usertbl u
join buytbl b on u.userid = b.userid
group by u.userid, name;

-- ��ǰ�� ���� ���� ������ ȸ��(���� ����)
select rownum as RN, name, �Ѽ���
from
(
    select name, sum(amount) as �Ѽ���
    from usertbl u
    join buytbl b on u.userid = b.userid
    group by name
    order by �Ѽ��� desc
)
where rownum = 1;

-- Ư�� ��ǰ ������ ȸ�� ��ȸ ? ��: ��å�� ������
select distinct name
from usertbl u
join buytbl b on u.userid = b.userid
where prodname = 'å';


-- LEFT OUTER JOIN
-- ��� ȸ���� �̸��� ���� ����(���� ��� NULL) ��ȸ
select name, prodName, price
from usertbl u
left join buytbl b on u.userid = b.userid;

-- ���Ű� ���� ȸ�� ã��(LEFT JOIN + WHERE NULL)
select u.userid, name
from usertbl u
left join buytbl b on u.userid = b.userid
where b.userid is null;

-- RIGHT OUTER JOIN
-- ���� ������ �ִ� ��� �����͸� �������� ȸ�� ���� ��ȸ
select name, prodname, price
from usertbl u
right join buytbl b on u.userid = b.userid;

-- FULL OUTER JOIN
select * from studenttbl;
select * from examtbl;

-- ��� �л��� ��� ���� ���� ��� (���� ������ NULL)
select name as �л��̸�, subject as ����, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid;

-- ������ �������� ���� �л� ã��
select name
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid
where e.studentid is null;

-- �������� �ʴ� �л�ID�� ������ ���� ��� ��ȸ
select examid, subject, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid
where s.studentid is null;

-- �л��� ���� ������ ���� ���� ���� �л��� �л� ���� ���� ��� ����
select s.studentid, name, subject, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid;

-- �л� �̸��� ���� ����/���� �Բ� ���(���� ��� ������ NULL)
select name, subject, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid;

-- CROSS JOIN
-- ��� ȸ���� ��� ��ǰ ���� ��ȸ
select name as ȸ����, prodname as ��ǰ��
from usertbl u
cross join buytbl b;

-- SELF JOIN
-- userTbl ������ ����⵵�� ���� ȸ������ ¦ ����� (�ڱ� �ڽ��� ����) - <> = !=
select a.name as ȸ��a, b.name as ȸ��b, a.birthyear
from usertbl a
join usertbl b on a.birthyear = b.birthyear
where a.userid <> b.userid;

-- ����� ������ ����
select e.name as ������, m.name as �����ڸ�, m.managerid as �������ǸŴ���
from userSelfTestTbl e
join userSelfTestTbl m on e.managerid = m.userid;

-- emptbl �߰�
select * from emptbl;

-- ������ �� ����� �̸� ���
select e.empname as ����, m.empname as ���
from emptbl e
left join emptbl m on e.managerid = m.empid;

-- ���������� 1�� �̻��� ��� ���
select m.empname as ���, count(*) as ���ϼ�
from emptbl e
join emptbl m on e.managerid = m.empid
group by m.empname;

-- Ư�� ���(���ǥ)�� ��� ���� ���
select e.empname
from emptbl e
join emptbl m on e.managerid = m.empid
where m.empname = '���ǥ';

-- ������ ����� ���� �Բ� ���
select e.empname as ����, e.position, m.empname as ���, m.position as �������
from emptbl e
left join emptbl m on e.managerid = m.empid;


-- Ex
-- INNER JOIN
-- 1 ��� ȸ���� �̸��� ������ ��ǰ��, �ܰ�, ���� ��ȸ (�������� ���� ȸ�� ����)
select name, prodname, price, amount
from usertbl u
join buytbl b on u.userid = b.userid;

-- 2 ȸ���� �� ���� �ݾ�(�ܰ� �� ������ ��) ���
select name, sum(price * amount) as �ѱ��űݾ�
from usertbl u
join buytbl b on u.userid = b.userid
group by name
order by �ѱ��űݾ� desc;

-- 3 'å'�� ������ ȸ�� �̸� �ߺ� ���� ��ȸ
select distinct name
from usertbl u
join buytbl b on u.userid = b.userid
where prodname = 'å';

-- 4 2010�� ���� ������ ȸ���� ������ ��ǰ ���� ��ȸ
select name, mdate, prodname
from usertbl u
join buytbl b on u.userid = b.userid
where extract(year from mdate) >= 2010;

-- 5 ��ǰ�� ���� ���� ������ ȸ��(���� ����) 1�� ���
select rownum as RN, name, �Ѽ���
from
(
    select name, sum(amount) as �Ѽ���
    from usertbl u
    join buytbl b on u.userid = b.userid
    group by name
    order by �Ѽ��� desc
)
where rownum = 1;

-- 6 Ű�� 175 �̻��� ȸ�� �� ������ ��ǰ�� �ִ� ��� �̸�, ��ǰ�� ���
select name, prodname
from usertbl u
join buytbl b on u.userid = b.userid
where height >= 175;

-- 7 ��ǰ �з�(groupName)���� �� �����(�ܰ�������) ���
select groupname, sum(price * amount) as �Ѹ����
from buytbl
group by groupname;

-- 8 ���� ������ ��� ȸ���� ������ ��ǰ��� ���� ���
select prodname, amount
from usertbl u
join buytbl b on u.userid = b.userid
where addr = '����';

-- 9 ��ǰ�� ���� ȸ�� ��(�ߺ� ����) ���
select prodname, count(distinct userid) as ����ȸ����
from buytbl
group by prodname;

-- 10 ȸ���� ��� ���� �ܰ�(�Ҽ��� 2�ڸ� �ݿø�) ���
select name, round(avg(price), 2) as ��ձ��Ŵܰ�
from usertbl u
join buytbl b on u.userid = b.userid
group by name;


-- OUTER JOIN

-- LEFT JOIN
-- 1
select name, prodname, price
from usertbl u
left join buytbl b on u.userid = b.userid;

-- 2
select name, u.userid
from usertbl u
left join buytbl b on u.userid = b.userid
where b.userid is null;

-- 3
select addr, name, amount
from usertbl u
left join buytbl b on u.userid = b.userid;

select addr, name, sum(amount)
from usertbl u
left join buytbl b on u.userid = b.userid
group by addr, name;

-- 4
select name, nvl(sum(price * amount), 0) as �ѱݾ�
from usertbl u
left join buytbl b on u.userid = b.userid
group by name
order by �ѱݾ� desc;

-- 5
select name, height, prodname
from usertbl u
left join buytbl b on u.userid = b.userid
where height >= 170;

-- RIGHT JOIN
-- 1
select name, prodname
from usertbl u
right join buytbl b on u.userid = b.userid;

-- 2
select prodname, price
from usertbl u
right join buytbl b on u.userid = b.userid
where u.userid is null;

-- 3
select prodname, height
from usertbl u
right join buytbl b on u.userid = b.userid;

-- 4
select prodname, addr
from usertbl u
right join buytbl b on u.userid = b.userid;

-- 5
select mdate, prodname
from usertbl u
right join buytbl b on u.userid = b.userid;

-- FULL OUTER JOIN(studenttbl + examtbl ���)
-- 1
select name, subject, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid;

-- 2
select name
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid
where e.studentid is null;

-- 3
select examid, subject, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid
where s.studentid is null;

-- 4
select s.studentid, name, subject, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid;

-- 5
select name, subject, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid;


-- SELF JOIN
-- 1
select a.name as �̸�1, b.name as �̸�2, a.addr as ����
from usertbl a
join usertbl b on a.addr = b.addr
where a.name <> b.name;

select a.name as �̸�1, b.name as �̸�2, a.addr as ����
from usertbl a
join userTbl B on A.addr = B.addr and a.name < b.name;

-- 2
select a.name as �̸�1, b.name as �̸�2, a.height as Ű1, b.height as Ű2
from usertbl a
join usertbl b on a.height < b.height;

-- 3
select a.name as �̸�1, b.name as �̸�2, a.birthyear
from usertbl a
join usertbl b on a.birthyear = b.birthyear
where a.name <> b.name;

select a.name as �̸�1, b.name as �̸�2, a.birthyear
from usertbl a
join usertbl b on a.birthyear = b.birthyear and a.name < b.name;

-- 4
select a.name as �̸�1, b.name as �̸�2, a.mdate
from usertbl a
join usertbl b on a.mdate = b.mdate
where a.userid <> b.userid;

select a.name as �̸�1, b.name as �̸�2, a.mdate
from usertbl a
join usertbl b on a.mdate = b.mdate and a.userid < b.userid;

-- 5
select a.name as �̸�1, b.name as �̸�2, a.height
from usertbl a
join usertbl b on a.height = b.height
where a.name <> b.name;

select a.name as �̸�1, b.name as �̸�2, a.height
from usertbl a
join usertbl b on a.height = b.height and a.name < b.name;


-- NATURAL JOIN
select name, prodname
from usertbl u
natural join buytbl b;

-- USING
select name, prodname
from usertbl u
join buytbl b using(userid);