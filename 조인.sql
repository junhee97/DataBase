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
