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

-- 1�� ����
alter table tbl_member add constraint pk_member_id primary key(member_id);
desc tbl_member;

-- 2�� ����
alter table tbl_book add constraint pk_book_code primary key(book_code);
desc tbl_book;

-- 3�� ����
alter table tbl_rental add constraint fk_book_code foreign key(book_code)
references tbl_book(book_code) on delete cascade;
desc tbl_rental;

-- 4�� ����
alter table tbl_rental add constraint fk_member_id foreign key(member_id)
references tbl_member(member_id) on delete cascade;
desc tbl_rental;

-- 5�� ����
insert into tbl_member values(111, 'aaa', '111', '�Ϲ�', '�뱸', '010-111-2222');
insert into tbl_member values(222, 'bbb', '222', 'VIP', '���', '010-111-2222');
insert into tbl_member values(333, 'ccc', '333', 'VIP', '��õ', '010-111-2222');
insert into tbl_member values(444, 'ddd', '444', '�Ϲ�', '�λ�', '010-111-2222');
insert into tbl_member values(555, 'eee', '555', 'VIP', '����', '010-111-2222');
insert into tbl_member values(666, 'fff', '666', '�Ϲ�', '���', '010-111-2222');
select * from tbl_member;

-- 5�� ����
insert into tbl_book values(1010, 1, '������', '����C', '�������̵��', 1);
insert into tbl_book values(1011, 1, '���ü�', 'JAVA������', '00�̵��', 1);
insert into tbl_book values(1012, 1, '���浿', '�̰��̸�������', '�Ѻ��̵��', 1);
insert into tbl_book values(2010, 2, '����ī�ױ�', '�ΰ������', '00�̵��', 1);
insert into tbl_book values(2011, 2, 'ȫ�浿', '�̿�������', '00�̵��', 1);
select * from tbl_book;

-- 5�� ����
insert into tbl_rental values(1, 1010, 111);
insert into tbl_rental values(2, 1011, 222);
insert into tbl_rental values(3, 1012, 333);
select * from tbl_rental;

-- 6�� ����
select constraint_name, constraint_type, search_condition, r_constraint_name
from user_constraints
where table_name = 'TBL_MEMBER';

-- 6�� ����
select constraint_name, constraint_type, search_condition, r_constraint_name
from user_constraints
where table_name = 'TBL_BOOK';

-- 6�� ����
select constraint_name, constraint_type, search_condition, r_constraint_name
from user_constraints
where table_name = 'TBL_RENTAL';