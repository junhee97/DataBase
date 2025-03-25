select * from usertbl;
select * from buytbl;

-- 사용자별 구매 총액 계산
select userid, price, amount from buytbl;

select userid, sum(price * amount) as 총구매액
from buytbl 
group by userid;

-- 사용자별 구매 횟수 계산
select userid, count(*) as 구매횟수
from buytbl
group by userid;

-- 지역별 사용자 수 계산
SELECT addr, COUNT(*) AS 사용자수
FROM userTbl
group by addr;

-- 제품 그룹별 판매 금액 합계
select groupname, sum(price * amount) as 판매액
from buytbl
where groupname is not null
group by groupname;

-- 출생년도 기준 사용자 수 order by asc/desc (오름차순/내림차순)
select birthyear, count(*) as 인원수
from usertbl
group by birthyear
order by birthyear;

-- ORDER BY
-- 오름차순 ASC
select name , mdate from usertbl order by mdate;
select name , mdate from usertbl order by name;

-- 내림차순 DESC
select name , mdate from usertbl order by mdate desc;
select name , mdate from usertbl order by name desc;

-- 오름 + 내림
select name, height from usertbl order by height desc, name asc;

-- 서브쿼리 + ROWNUM - 행마다 부여되는 num
select * from (select rownum as RN, usertbl.* from usertbl) where rn = 2;
select * from (select rownum as RN, usertbl.* from usertbl)
where rn >= 2 and rn <= 4;


-- EX
select * from usertbl;
select * from buytbl;

-- 1
select addr, count(*) as 사용자수
from usertbl
group by addr;

-- 2
select userid, sum(price * amount) as 총구매액
from buytbl
group by userid;

-- 3
-- COALESCE
select coalesce(groupname, '미분류') as 제품그룹, sum(amount) as 판매수량
from buytbl
group by groupname;
-- NVL
select nvl(groupname, '미분류') as 제품그룹, sum(amount) as 판매수량
from buytbl
group by groupname;
-- CASE - IS NULL THEN (CASE END)
select
    case 
        when groupname is null then '미분류'
        else groupname
    end as 제품그룹, sum(amount) as 판매수량
from buytbl
group by groupname;

-- 4
select birthyear, avg(height) as 평균키
from usertbl
group by birthyear;

-- 5
select prodname, count(*) as 구매횟수, sum(price * amount) as 총구매액
from buytbl
group by prodname
order by 구매횟수 desc;

-- 6
select coalesce(mobile1, '미입력') as 통신사, count(*) as 가입자수
from usertbl
group by mobile1;

-- 7 
select u.addr as 지역, sum(b.price * b.amount) as 총구매액
from usertbl u
join buytbl b on u.userid = b.userid
group by u.addr;

-- 8
select userid, count(distinct groupname) as 제품의종류수
from buytbl
group by userid;

select userid, groupname, count(groupname)
from buytbl
group by userid, groupname;

-- 9
-- EXTRACT 날짜 정보 추출 함수
select extract(year from mdate) as 가입연도별, count(*) as 가입자수
from usertbl
group by extract(year from mdate);
-- SUBSTR 문자열 자르기
select substr(mdate,1,2) as 가입연도별, count(*) as 가입자수
from usertbl
group by substr(mdate,1,2);

-- 10
select (2023-u.birthyear) as 연령, sum(b.price * b.amount) as 구매총액
from usertbl u
join buytbl b on u.userid = b.userid
group by (2023-u.birthyear)
order by 연령;

SELECT FLOOR((2023 - u.birthYear) / 10) * 10 AS 연령대, 
       SUM(b.price * b.amount) AS 구매총액
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID
GROUP BY FLOOR((2023 - u.birthYear) / 10) * 10
ORDER BY 연령대;
