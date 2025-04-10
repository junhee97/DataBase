create table tbl_member (
member_id number,
member_name varchar2(45),
member_identity varchar2(45),
member_grade varchar2(45),
member_addr varchar2(45),
member_phone varchar2(45)
);

create table tbl_book (
book_code number,
classification_id number,
book_author varchar2(45),
book_name varchar2(45),
publisher varchar2(45),
isrental char(1)
);

create table tbl_rental (
rental_id number,
book_code number,
member_id number
);

-- 1번 문제
alter table tbl_member add constraint pk_member_id primary key(member_id);

-- 2번 문제
alter table tbl_book add constraint pk_book_code primary key(book_code);

-- 3번 문제
alter table tbl_rental add constraint fk_book_code foreign key(book_code)
references tbl_book(book_code) on delete cascade;

-- 4번 문제
alter table tbl_rental add constraint fk_member_id foreign key(member_id)
references tbl_member(member_id) on delete cascade;

-- 5번 문제
insert into tbl_member values(111, 'aaa', '111', '일반', '대구', '010-111-2222');
insert into tbl_member values(222, 'bbb', '222', 'VIP', '울산', '010-111-2222');
insert into tbl_member values(333, 'ccc', '333', 'VIP', '인천', '010-111-2222');
insert into tbl_member values(444, 'ddd', '444', '일반', '부산', '010-111-2222');
insert into tbl_member values(555, 'eee', '555', 'VIP', '서울', '010-111-2222');
insert into tbl_member values(666, 'fff', '666', '일반', '경기', '010-111-2222');
select * from tbl_member;

-- 5번 문제
insert into tbl_book values(1010, 1, '윤성우', '열혈C', '오렌지미디어', 1);
insert into tbl_book values(1011, 1, '남궁성', 'JAVA의정석', '00미디어', 1);
insert into tbl_book values(1012, 1, '남길동', '이것이리눅스다', '한빛미디어', 1);
insert into tbl_book values(2010, 2, '데일카네기', '인간관계론', '00미디어', 1);
insert into tbl_book values(2011, 2, '홍길동', '미움받을용기', '00미디어', 1);
select * from tbl_book;

-- 5번 문제
insert into tbl_rental values(1, 1010, 111);
insert into tbl_rental values(2, 1011, 222);
insert into tbl_rental values(3, 1012, 333);
select * from tbl_rental;

-- 6번 문제
select constraint_name, constraint_type, r_constraint_name, table_name
from user_constraints
where table_name = 'TBL_MEMBER';

-- 6번 문제
select constraint_name, constraint_type, r_constraint_name, table_name
from user_constraints
where table_name = 'TBL_BOOK';

-- 6번 문제
select constraint_name, constraint_type, r_constraint_name, table_name
from user_constraints
where table_name = 'TBL_RENTAL';

-- 7번 문제
create index fk_member_id on tbl_rental(member_id);
create index fk_book_code on tbl_rental(book_code);

select index_name, column_name
from user_ind_columns
where table_name = 'TBL_RENTAL';

-- 8번 문제
create view ShowRental_view as
select r.rental_id, m.member_name, b.book_name
from tbl_rental r
inner join tbl_member m
on r.member_id = m.member_id
inner join tbl_book b
on r.book_code = b.book_code;

select * from ShowRental_view;

-- 서술형
CREATE TABLE tbl_review(
review_id number not null primary key,
book_code number,
member_id number,
rating number,
review_text VARCHAR2(255)
);

alter table tbl_review add constraint fk_member_id_review foreign key(member_id)
references tbl_member(member_id) on delete cascade;

alter table tbl_review add constraint fk_book_code_review foreign key(book_code)
references tbl_book(book_code) on delete cascade;