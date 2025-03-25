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
