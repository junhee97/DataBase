-- 구매 금액 합계가 1000 이상인 사용자 조회
select userid, sum(price * amount) as 총구매액
from buytbl
group by userid
having sum(price * amount) >= 1000;

-- 평균 키가 175 이상인 지역 조회
select addr, avg(height) as 평균키
from usertbl
group by addr
having avg(height) >= 175;

-- 총 구매 횟수가 3회 이상이고 총 구매액이 100 이상인 사용자
select userid, count(*) as 구매횟수, sum(price * amount) as 총구매액
from buytbl
group by userid
having count(*) >= 3 and sum(price * amount) >= 100;

-- 사용자 지역별, 제품 그룹별 구매액 합계
select u.addr, nvl(b.groupname, '미분류') as 제픔그룹, sum(b.price * b.amount) as 총구매액
from usertbl u
join buytbl b on u.userid = b.userid
group by u.addr, b.groupname;

-- 지역별, 연도별 회원가입 수
select addr, extract(year from mdate) as 가입년도, count(*) as 회원가입수
from usertbl
group by addr, extract(year from mdate)
order by addr, 가입년도;

-- ROLLUP
select groupname, sum(price * amount) as 판매액
from buytbl
group by rollup(groupname);
--
select groupname, prodname, sum(price * amount) as 판매액
from buytbl
group by rollup(groupname, prodname);

-- CUBE
select groupname, prodname, sum(price * amount) as 판매액
from buytbl
group by cube(groupname, prodname);

-- GROUPING SETS
select groupname, prodname, sum(price * amount) as 판매액
from buytbl
where groupname is not null
group by grouping sets((groupname), (prodname),());

-- UNION ALL
select groupname, null as prodname, sum(price * amount) as 판매액
from buytbl
where groupname is not null
group by groupname
union all
select null as groupname, prodname, sum(price * amount) as 판매액
from buytbl
where groupname is not null
group by prodname;

-- EX
select * from usertbl;
select * from buytbl;

-- 1
select userid, sum(price * amount) as 총구매액
from buytbl
group by userid
having sum(price * amount) >=1000;

-- 2
select addr, count(*) as 가입자수
from usertbl
group by addr
having count(*) >= 2;

-- 3
select prodname, avg(price * amount) as 평균구매액
from buytbl
group by prodname
having avg(price * amount) >= 100;

-- 4
select birthyear,  avg(height) as 평균키
from usertbl
group by birthyear
having avg(height) >= 175;

-- 5
select userid, sum(amount) as 구매제품수
from buytbl
group by userid
having sum(amount) >= 2;

-- 6
select u.addr, sum(b.price * b.amount) as 구매총액
from usertbl u
join buytbl b on u.userid = b.userid
group by u.addr
having sum(b.price * b.amount) >= 200;

-- 7
select userid, count(*) as 구매횟수, sum(price * amount) as 총구매액
from buytbl
group by userid
having count(*) >= 3 and sum(price * amount) >= 500;

-- 8
select addr, avg(height) as 평균키
from usertbl
group by addr
having avg(height) = (
    select max(평균키)
    from (
        select addr, avg(height) as 평균키
        from usertbl
        group by addr
        )
);

select * from (select addr, avg(height) as 평균키 from usertbl group by addr)
where 평균키 = (select max(avg(height)) as 평균키 from usertbl group by addr);

-- 9
select userid, avg(price * amount) as 구매금액
from buytbl
group by userid
having avg(price * amount) > (
    select avg(price * amount)
    from buytbl
);

-- 10
select userid, a.addr, 구매총액, 지역별평균구매액
from
    (select u.addr, u.userid, sum(b.price * b.amount) as 구매총액
      from usertbl u
      join buytbl b on u.userid = b.userid
       group by u.addr, u.userid) a
join
    (select u2.addr, avg(b2.price * b2.amount) as 지역별평균구매액
      from usertbl u2
      join buytbl b2 on u2.userid = b2.userid
      group by u2.addr) c 
on a.addr = c.addr
where 구매총액 >= 지역별평균구매액;


select aa.addr,userid,총액,지역별평균
from 
(
    -- 같은 지역(addr)에 사는 사용자들 중 구매 총액
    select addr ,u.userid, sum(amount*price) as 총액
    from userTbl u
    join buyTbl b 
    on u.userid=b.userid
    group by addr,u.userid
) aa
join
(
    --지역별 구매평균
    select addr,avg(amount*price) as 지역별평균
    from userTbl u
    join buyTbl b
    on u.userid=b.userid
    group by addr
) bb
on aa.addr=bb.addr
where aa.총액>=bb.지역별평균;