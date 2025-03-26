-- MemberTbl 만들기
create table MemberTbl(
Member_id int not null primary key,
Member_name varchar(45),
Member_identity varchar(45),
Member_grade varchar(45),
Member_addr varchar(45),
Member_phone varchar(45)
);

-- ClassificationTbl 만들기
create table ClassificationTbl(
Classification_id int not null primary key,
Classification_name varchar(45)
);

-- BookTbl 만들기
create table BookTbl(
Book_code int not null primary key,
Classification_id int not null,
book_author varchar(45),
book_name varchar(45),
publisher varchar(45),
isreserve number(3),
foreign key (Classification_id) references ClassificationTbl(Classification_id)
);

-- RentalTbl 만들기
create table RentalTbl(
Rental_id int not null primary key,
Book_code int not null,
Member_id int not null,
foreign key (Book_code) references BookTbl(Book_code),
foreign key (Member_id) references MemberTbl(Member_id)
);

-- ReserveTbl 만들기
create table ReserveTbl(
Rental_id int not null,
Member_id int not null,
Reserve_order varchar(45),
foreign key (Rental_id) references RentalTbl(Rental_id),
foreign key (Member_id) references MemberTbl(Member_id)
);

-- AppendixTbl 만들기
create table AppendixTbl(
Appendix_id int not null primary key,
Book_code int not null,
Appendix_name varchar(45),
foreign key (Book_code) references BookTbl(Book_code)
);