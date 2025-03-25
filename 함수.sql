-- 단일행 함수 예시
select userid, upper(name) as upper_name 
from usertbl;

-- 다중행 함수 예시
select addr, count(*) as user_count
from usertbl
group by addr;

-- 대소문자 변환
select userid, lower(userid) as lower_id, -- 소문자 변환
        upper(userid) as upper_id, -- 대문자 변환
        initcap(lower(userid)) as init_cap -- 첫글자만 대문자로 변환
from usertbl;

-- 문자열 길이
select name, length(name) as name_length, -- 이름의 문자 개수
        length(addr) as addr_length -- 주소의 문자 개수
from usertbl;

-- 문자열 추출
select name, substr(name, 1, 1) as first_char, -- 이름의 첫 글자
        substr(userid, 2) as userid_part -- userid의 두번째 문자부터 끝까지
from usertbl;

-- 문자 위치 찾기
select name, instr(name, '김') as position_kim -- '김'이 있는 위치 (없으면 0)
from usertbl;

-- 문자열 채우기
select userid, lpad(userid, 10, '*') as lpad_id, -- userid 왼쪽을 *로 10자리 채우기
        rpad(name, 10, '-') as rpad_name -- name 오른쪽을 -로 10자리 채우기
from usertbl;

-- 공백 제거
select trim('sql') as trim_result, -- 양쪽 공백 제거 : 'sql'
        ltrim('sql') as ltrim_result, -- 왼쪽 공백 제거 : 'sql'
        rtrim('sql') as rtrim_result -- 오른쪽 공백 제거 : 'sql'
from dual;

-- 문자열 치환
select name, replace(mobile1, null, '없음') as replace_null, -- null을 '없음'으로 대체
        replace(addr, '서울', 'SEOUL') as replace_addr -- '서울'을 'SEOUL'로 대체
from usertbl;

-- 문자열 연결
select name, concat(mobile1, '-') as part1, -- 휴대폰 국번과 '-' 연결
        concat(concat(mobile1, '-'), mobile2) as mobile, -- 국번 - 전화번호 형식으로 연결
        mobile1 || '-' || mobile2 as phone_number -- 연결 연산자 사용
from usertbl;

-- 반올림, 절삭
select prodname, price, round(price / 1000, 2) as round_thousands, -- 천 단위로 나누고 소수점 2자리 반올림
        trunc(price / 1000, 1) as trunc_thousands -- 천 단위로 나누고 소수점 1자리 절삭
from buytbl;

-- 올림, 내림
select prodname, price, ceil(price / 100) as ceil_hundreds, -- 백 단위로 나누고 올림
        floor(price / 100) as floor_hundreds -- 백 단위로 나누고 버림
from buytbl;

-- 나머지, 절대값
select prodname, price, amount, mod(price, 100) as remainder_100, -- 가격을 100으로 나눈 나머지
        abs(price - 500) as abs_diff_500 -- 가격과 500 차이의 절대값
from buytbl;

-- 부호 확인, 제곱, 제곱근
select prodname, price, sign(price - 100) as sign_price, -- 가격이 100보다 크면 1, 같으면 0, 작으면 -1
        power(amount, 2) as amount_squared, -- 수량의 제곱
        sqrt(price) as sqrt_price -- 가격의 제곱근
from buytbl;

-- 현재 날짜와 회원가입일 활용
select name, mdate, sysdate as today, -- 현재 날짜/시간
        current_date as current_date -- 현재 날짜
from usertbl;

-- 날짜 연산
select name, mdate, mdate + 7 as after_week, -- 가입 1주일 후
        mdate - 7 as before_week -- 가입 1주일 전
from usertbl;

-- 월 관련 함수
select name, mdate, add_months(mdate, 6) as after_6months, -- 가입 6개월 후
        months_between(sysdate, mdate) as months_since_join -- 가입 후 경과 월 수
from usertbl;

-- 요일, 말일 함수
select name, mdate, next_day(mdate, '금요일') as next_friday, -- 가입일 이후의 첫 금요일
        last_day(mdate) as last_day_of_month -- 가입월의 마지막 날짜
from usertbl;

-- 날짜 요소 추출
select name, mdate, extract(year from mdate) as join_year, -- 가입년도
        extract(month from mdate) as join_month, -- 가입 월
        extract(day from mdate) as join_day -- 가입 일
from usertbl;

-- 날짜 -> 문자 변환
select name, mdate, to_char(mdate, 'yyyy-mm-dd') as formatted_date, -- 'yyyy-mm-dd' 형식
        to_char(mdate, 'yyyy"년"mm"d월"dd"일"') as korean_date, --'yyyy"년"mm"d월"dd"일"' 형식
        to_char(mdate, 'yyyy/mm/dd hh24:mi:ss') as date_with_time -- 시간 포함 형식
from usertbl;

-- 숫자 -> 문자 변환
select prodname, price, amount, to_char(price, '999,999') as formatted_price, -- 1,000 형식
        to_char(price * amount, '999,999') as total, -- 수량*가격 천단위 구분
        to_char(price/1000, '0.00') as price_thousands -- 소수점 표시
from buytbl;

-- 문자 -> 숫자 변환
select to_number('1,000', '9,999') as number_result, -- 문자 '1,000'을 숫자 1000으로
        to_number('￦2,000', 'L9,999') as currency_to_number -- 통화 기호가 있는 문자를 숫자로
from dual;

-- 문자 -> 날짜 변환
select to_date('2025-12-25', 'yyyy-mm-dd') as christmas, -- 문자열을 날짜로
        to_date('20251225', 'yyyymmdd') as christmas_no_sep, -- 구분자 없는 문자열을 날짜로
        to_date('2025/12/25 14:30:00', 'yyyy/mm/dd hh24:mi:ss') as christmas_time -- 시간 포함
from dual;

-- NVL 함수
select name, mobile1, mobile2, nvl(mobile1, '없음') as nvl_mobile1 -- null이면 '없음' 반환
from usertbl;
