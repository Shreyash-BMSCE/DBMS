create table publisher(
name varchar(30),
address varchar(50),
phone varchar(10),
primary key(name));

create table book(
book_id int,
title varchar(30),
publisher_name varchar(50),
pub_year varchar(30),
primary key(book_id),
foreign key(publisher_name) references publisher(name) on delete cascade) ;

create table book_authors(
book_id int,
author_name varchar(30),
primary key(book_id,author_name),
foreign key(book_id) references book(book_id) on delete cascade);
create table library_branch(
branch_id int,
branch_name varchar(30),
address varchar(50),
primary key(branch_id));

create table book_copies(
book_id int,
branch_id int,
copies int,
primary key(book_id,branch_id),
foreign key(book_id)references book(book_id) on delete cascade ,
foreign key(branch_id)references library_branch(branch_id) on delete cascade);

create table card(
card_no int,
primary key(card_no));
create table book_lending(
book_id int,
branch_id int,
card_no int,
date_out date,
due_date date,
primary key(book_id,branch_id,card_no),
foreign key(book_id) references book(book_id) on delete cascade,
foreign key(branch_id) references library_branch(branch_id) on delete cascade,
foreign key(card_no) references card(card_no) on delete cascade);

INSERT INTO publisher VALUES ('shreyash','111111111','Japan');
INSERT INTO PUBLISHER VALUES ('shashank', '222222222', 'Bangalore');
INSERT INTO PUBLISHER VALUES ('sumanth', '3333333333','chennai');
INSERT INTO PUBLISHER VALUES ('suraj', '444444444', 'chennai');
INSERT INTO PUBLISHER VALUES ('shreyas','44444444',
'Japan');

INSERT INTO BOOK VALUES ('1','ada', 'shreyash','JAN-2017');
INSERT INTO BOOK VALUES ('2','evs', 'shreyash','JUN-2016');
INSERT INTO BOOK VALUES ('3','ada', 'shashank','SEP-2016');
INSERT INTO BOOK VALUES ('4','os', 'suraj','SEP-2015');
INSERT INTO BOOK VALUES ('5','dbms', 'shashank','MAY-2016');

INSERT INTO BOOK_AUTHORS VALUES ('1','shreyash');
INSERT INTO BOOK_AUTHORS VALUES ( '2','shreyash');
INSERT INTO BOOK_AUTHORS VALUES ( '3','sumanth');
INSERT INTO BOOK_AUTHORS VALUES ('4','naruto');
INSERT INTO BOOK_AUTHORS VALUES ('5','susuke');

INSERT INTO LIBRARY_BRANCH VALUES ('10','tokyo','Japan');
INSERT INTO LIBRARY_BRANCH VALUES ('11','nagoyama','Japan');
INSERT INTO LIBRARY_BRANCH VALUES ('12','hiroshima','Japan');
INSERT INTO LIBRARY_BRANCH VALUES ('13','mg road','Bangalore');
INSERT INTO LIBRARY_BRANCH VALUES ('14','jp nagar','bangalore');

INSERT INTO BOOK_COPIES VALUES ( 1, 9,11);
INSERT INTO BOOK_COPIES VALUES ( 2, 10,4);
INSERT INTO BOOK_COPIES VALUES ( 2, 10,1);
INSERT INTO BOOK_COPIES VALUES ( 3, 11,6);
INSERT INTO BOOK_COPIES VALUES ( 3, 12,5);
INSERT INTO BOOK_COPIES VALUES ( 4, 11,1);
INSERT INTO BOOK_COPIES VALUES ( 5, 12,3);


INSERT INTO CARD VALUES (100); 
INSERT INTO CARD VALUES (101);
INSERT INTO CARD VALUES (102);
INSERT INTO CARD VALUES (103);
INSERT INTO CARD VALUES (104);

INSERT INTO BOOK_LENDING VALUES ( 1, 9, 101,'11-JAN-20','01-FEB-20');
INSERT INTO BOOK_LENDING VALUES ( 3, 11, 101,'01-JAN-20','10-FEB-20');
INSERT INTO BOOK_LENDING VALUES ( 2, 10, 101,'11-FEB-20','11-MAR-20');
INSERT INTO BOOK_LENDING VALUES ( 4, 11, 101,'01-FEB-20','10-MAR-20');
INSERT INTO BOOK_LENDING VALUES ( 1, 11, 104,'11-MAR-20','22-APR-20');

select * from publisher;
select * from book;
select * from library_branch;
select * from book_copies;
select * from card;
select * from book_lending;


SELECT B.BOOK_ID, B.TITLE, B.PUBLISHER_NAME, A.AUTHOR_NAME,
C.COPIES, L.BRANCH_ID
FROM BOOK B, BOOK_AUTHORS A, BOOK_COPIES C, LIBRARY_BRANCH L
WHERE B.BOOK_ID=A.BOOK_ID
AND B.BOOK_ID=C.BOOK_ID
AND L.BRANCH_ID=C.BRANCH_ID;


SELECT CARD_NO
FROM BOOK_LENDING
WHERE DATE_OUT BETWEEN '01-JAN-2020' AND '01-JUL-2020'
GROUP BY CARD_NO
HAVING COUNT (*)>3;
delete from book where book_id=3;


CREATE VIEW V_PUBLICATION AS
SELECT PUB_YEAR
FROM BOOK;
select * FROM V_PUBLICATION;


CREATE VIEW V_BOOKS AS
SELECT B.BOOK_ID, B.TITLE, C.COPIES
FROM BOOK B, BOOK_COPIES C, LIBRARY_BRANCH L
WHERE B.BOOK_ID=C.BOOK_ID
AND C.BRANCH_ID=L.BRANCH_ID;


select * FROM V_BOOKS;
