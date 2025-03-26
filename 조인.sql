-- JOIN
select name, birthyear, addr, prodname, groupname, price
from usertbl u
join buytbl b on u.userid = b.userid;

-- userid가 두 테이블에서 존재하기 때문에 에러 발생(userid 앞에 u, b 붙여서 사용)
select u.userid, name, birthyear, addr, prodname, groupname, price
from usertbl u
join buytbl b on u.userid = b.userid;

-- 회원별 총 구매 금액
select u.userid, name, sum(price * amount) as 총구매금액
from usertbl u
join buytbl b on u.userid = b.userid
group by u.userid, name;

-- 상품을 가장 많이 구매한 회원(수량 기준)
select rownum as RN, name, 총수량
from
(
    select name, sum(amount) as 총수량
    from usertbl u
    join buytbl b on u.userid = b.userid
    group by name
    order by 총수량 desc
)
where rownum = 1;

-- 특정 물품 구매한 회원 조회 ? 예: “책” 구매자
select distinct name
from usertbl u
join buytbl b on u.userid = b.userid
where prodname = '책';


-- LEFT OUTER JOIN
-- 모든 회원의 이름과 구매 내역(없는 경우 NULL) 조회
select name, prodName, price
from usertbl u
left join buytbl b on u.userid = b.userid;

-- 구매가 없는 회원 찾기(LEFT JOIN + WHERE NULL)
select u.userid, name
from usertbl u
left join buytbl b on u.userid = b.userid
where b.userid is null;

-- RIGHT OUTER JOIN
-- 구매 내역이 있는 모든 데이터를 기준으로 회원 정보 조회
select name, prodname, price
from usertbl u
right join buytbl b on u.userid = b.userid;

-- FULL OUTER JOIN
select * from studenttbl;
select * from examtbl;

-- 모든 학생과 모든 시험 정보 출력 (누락 정보는 NULL)
select name as 학생이름, subject as 과목, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid;

-- 시험을 응시하지 않은 학생 찾기
select name
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid
where e.studentid is null;

-- 존재하지 않는 학생ID로 응시한 시험 기록 조회
select examid, subject, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid
where s.studentid is null;

-- 학생과 시험 정보를 묶어 성적 없는 학생과 학생 없는 시험 모두 보기
select s.studentid, name, subject, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid;

-- 학생 이름과 시험 과목/점수 함께 출력(시험 기록 없으면 NULL)
select name, subject, score
from studenttbl s
full outer join examtbl e on s.studentid = e.studentid;

-- CROSS JOIN
-- 모든 회원과 모든 상품 조합 조회
select name as 회원명, prodname as 상품명
from usertbl u
cross join buytbl b;

-- SELF JOIN
-- userTbl 내에서 출생년도가 같은 회원끼리 짝 지어보기 (자기 자신은 제외) - <> = !=
select a.name as 회원a, b.name as 회원b, a.birthyear
from usertbl a
join usertbl b on a.birthyear = b.birthyear
where a.userid <> b.userid;

-- 사원과 관리자 연결
select e.name as 직원명, m.name as 관리자명, m.managerid as 관리자의매니저
from userSelfTestTbl e
join userSelfTestTbl m on e.managerid = m.userid;

-- emptbl 추가
select * from emptbl;

-- 직원과 그 상사의 이름 출력
select e.empname as 직원, m.empname as 상사
from emptbl e
left join emptbl m on e.managerid = m.empid;

-- 부하직원이 1명 이상인 상사 목록
select m.empname as 상사, count(*) as 부하수
from emptbl e
join emptbl m on e.managerid = m.empid
group by m.empname;

-- 특정 상사(김대표)의 모든 직원 출력
select e.empname
from emptbl e
join emptbl m on e.managerid = m.empid
where m.empname = '김대표';

-- 직원과 상사의 직급 함께 출력
select e.empname as 직원, e.position, m.empname as 상사, m.position as 상사직급
from emptbl e
left join emptbl m on e.managerid = m.empid;


-- Ex
-- INNER JOIN
-- 1 모든 회원의 이름과 구매한 상품명, 단가, 수량 조회 (구매하지 않은 회원 제외)
select name, prodname, price, amount
from usertbl u
join buytbl b on u.userid = b.userid;

-- 2 회원별 총 구매 금액(단가 × 수량의 합) 출력
select name, sum(price * amount) as 총구매금액
from usertbl u
join buytbl b on u.userid = b.userid
group by name
order by 총구매금액 desc;

-- 3 '책'을 구매한 회원 이름 중복 없이 조회
select distinct name
from usertbl u
join buytbl b on u.userid = b.userid
where prodname = '책';

-- 4 2010년 이후 가입한 회원이 구매한 상품 내역 조회
select name, mdate, prodname
from usertbl u
join buytbl b on u.userid = b.userid
where extract(year from mdate) >= 2010;

-- 5 상품을 가장 많이 구매한 회원(수량 기준) 1명만 출력
select rownum as RN, name, 총수량
from
(
    select name, sum(amount) as 총수량
    from usertbl u
    join buytbl b on u.userid = b.userid
    group by name
    order by 총수량 desc
)
where rownum = 1;

-- 6 키가 175 이상인 회원 중 구매한 상품이 있는 경우 이름, 상품명 출력
select name, prodname
from usertbl u
join buytbl b on u.userid = b.userid
where height >= 175;

-- 7 상품 분류(groupName)별로 총 매출액(단가×수량) 출력
select groupname, sum(price * amount) as 총매출액
from buytbl
group by groupname;

-- 8 서울 지역에 사는 회원이 구매한 상품명과 수량 출력
select prodname, amount
from usertbl u
join buytbl b on u.userid = b.userid
where addr = '서울';

-- 9 물품별 구매 회원 수(중복 없이) 출력
select prodname, count(distinct userid) as 구매회원수
from buytbl
group by prodname;

-- 10 회원별 평균 구매 단가(소수점 2자리 반올림) 출력
select name, round(avg(price), 2) as 평균구매단가
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
select name, nvl(sum(price * amount), 0) as 총금액
from usertbl u
left join buytbl b on u.userid = b.userid
group by name
order by 총금액 desc;

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

-- FULL OUTER JOIN(studenttbl + examtbl 사용)
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
select a.name as 이름1, b.name as 이름2, a.addr as 지역
from usertbl a
join usertbl b on a.addr = b.addr
where a.name <> b.name;

select a.name as 이름1, b.name as 이름2, a.addr as 지역
from usertbl a
join userTbl B on A.addr = B.addr and a.name < b.name;

-- 2
select a.name as 이름1, b.name as 이름2, a.height as 키1, b.height as 키2
from usertbl a
join usertbl b on a.height < b.height;

-- 3
select a.name as 이름1, b.name as 이름2, a.birthyear
from usertbl a
join usertbl b on a.birthyear = b.birthyear
where a.name <> b.name;

select a.name as 이름1, b.name as 이름2, a.birthyear
from usertbl a
join usertbl b on a.birthyear = b.birthyear and a.name < b.name;

-- 4
select a.name as 이름1, b.name as 이름2, a.mdate
from usertbl a
join usertbl b on a.mdate = b.mdate
where a.userid <> b.userid;

select a.name as 이름1, b.name as 이름2, a.mdate
from usertbl a
join usertbl b on a.mdate = b.mdate and a.userid < b.userid;

-- 5
select a.name as 이름1, b.name as 이름2, a.height
from usertbl a
join usertbl b on a.height = b.height
where a.name <> b.name;

select a.name as 이름1, b.name as 이름2, a.height
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