-- 서브 쿼리
-- 김경호보다 키가 큰 사용자 조회
select userid, name, height
from usertbl
where height > (select height from usertbl where name = '김경호');

-- 경남 지역에 사는 사용자와 같은 키를 가진 사용자 조회
select userid, name, addr, height
from usertbl
where height in (select height from usertbl where addr = '경남');

select userid, name, addr, height
from usertbl
where height >= any(select height from usertbl where addr = '경남');

select userid, name, addr, height
from usertbl
where height >= all(select height from usertbl where addr = '경남');

-- 주소별로 가장 키가 큰 사람들 조회
select userid, name, addr, height
from usertbl
where (addr, height) in (select addr, max(height) from usertbl group by addr);

-- 각 사용자의 구매 총액 계산
select u.userid, name,
        (select sum(price * amount)from buytbl b where b.userid = u.userid) AS 총구매액
from usertbl u;


-- Ex
-- 1 서울 지역에 거주하는 회원 중, 전체 평균 키보다 큰 회원의 이름과 키를 조회하는 SQL문을 작성하시오.
select name, height
from usertbl
where addr = '서울' and height > (select avg(height) from usertbl);

-- 2 물품을 한 번이라도 구매한 적이 있는 회원의 이름과 주소를 조회하는 SQL문을 작성하시오.
select name, addr
from usertbl
where userid in (select userid from buytbl);

-- 3 ‘전자’ 분류 상품 중 가장 비싼 상품을 구매한
--  회원의 이름과 상품명, 가격을 조회하는 SQL문을 작성하시오.
select name, prodname, price
from usertbl u
join buytbl b on u.userid = b.userid
where groupname = '전자' and price = (select max(price) from buytbl);

-- 4 각 회원이 구매한 총 금액(price × amount)의 평균보다 더 많이 구매한
--  회원의 이름과 총 구매 금액을 조회하는 SQL문을 작성하시오.
select userid, 총금액
from
(
    select userid, sum(price * amount) as 총금액
    from buytbl
    group by userid
)
where 총금액 > (select avg(총금액) from (
                                    select sum(price * amount) as 총금액
                                    from buytbl
                                    group by userid
                                    )
);

-- 5 한 번도 물건을 구매한 적 없는 회원의 이름과 가입일을 조회하는 SQL문을 작성하시오.
select name, mdate
from usertbl
where userid not in (select userid from buytbl);

-- 6 청바지를 구매한 회원들과 같은 지역에 사는 다른 회원들의 이름과 지역을 조회하는 SQL문을 작성하시오
select name, addr
from usertbl
where addr in (
    select addr
    from usertbl
    where userid in (
        select userid
        from buytbl 
        where prodname = '청바지'
    )
);

-- 7 각 회원의 userID와 그 회원이 구매한 가장 비싼 물품의 이름과 가격을 조회하는 SQL문을 작성하시오.
select userid, prodname, price
from buytbl
where (userid, price) in (select userid, max(price) from buytbl group by userid);

-- 8 ‘운동화’를 구매한 회원의 수보다 더 많은 회원이 있는 지역명을 조회하는 SQL문을 작성하시오.
select addr
from usertbl
group by addr
having count(userid) > (select count(userid) from buytbl where prodname = '운동화');

-- 9 자신이 구매한 상품 중 ‘책’보다 비싼 상품을 구매한 회원의 이름과 상품명을 조회하는 SQL문을 작성하시오.
select distinct name, prodname
from usertbl u
join buytbl b on u.userid = b.userid
where b.price > (select max(price) from buytbl where prodname = '책');


-- 10 모든 회원의 평균 키보다 키가 작은 회원이 구매한 상품의 이름과 수량을 조회하는 SQL문을 작성하시오.