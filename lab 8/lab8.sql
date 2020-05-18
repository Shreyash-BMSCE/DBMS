CREATE TABLE student_1(
     regno VARCHAR(15),
     name VARCHAR(20),
     major VARCHAR(20),
     bdate DATE,
     PRIMARY KEY (regno) );


CREATE TABLE course(
     courseno INT,
     cname VARCHAR(20),
     dept VARCHAR(20),
     PRIMARY KEY (courseno) );
CREATE TABLE enroll(
     regno VARCHAR(15),
     courseno INT,
     sem INT,
     marks INT,
     PRIMARY KEY (regno,courseno),
     FOREIGN KEY (regno) REFERENCES student_1 (regno),
     FOREIGN KEY (courseno) REFERENCES course (courseno) );

CREATE TABLE text(
     book_isbn INT,
     book_title VARCHAR(20),
     publisher VARCHAR(20),
     author VARCHAR(20),
     PRIMARY KEY (book_isbn) );


CREATE TABLE book_adoption(
     courseno INT,
     sem INT,
     book_isbn INT,
     PRIMARY KEY (courseno,book_isbn),
     FOREIGN KEY (courseno) REFERENCES course (courseno),
     FOREIGN KEY (book_isbn) REFERENCES text(book_isbn) );
     
     INSERT INTO student_1 VALUES('1pe11cs001','a','jr','24-aug-1994');
     INSERT INTO student_1 VALUES('1pe11cs002','b','sr','24-sep-1993');
     INSERT INTO student_1 VALUES('1pe11cs003','c','sr','27-nov-1993');
     INSERT INTO student_1 VALUES('1pe11cs004','d','sr','13-apr-1993');
     INSERT INTO student_1 VALUES('1pe11cs005','e','jr','24-aug-1994');
    delete from student_1 where  regno = '1pe11cs001';
    select * from student_1;

INSERT INTO course VALUES (111,'OS','CSE');
     INSERT INTO course VALUES(112,'EC','CSE');
   INSERT INTO course VALUES  (113,'SS','ISE');
    INSERT INTO course VALUES (114,'DBMS','CSE');
    INSERT INTO course VALUES (115,'SIGNALS','ECE');
update course set dept = 'ECE' where courseno = 112; 
select * from course;

INSERT INTO text VALUES(10,'DATABASE SYSTEMS','PEARSON','SCHIELD');
     INSERT INTO text VALUES(900,'OPERATING SYS','PEARSON','LELAND');
   INSERT INTO text VALUES  (901,'CIRCUITS','HALL INDIA','BOB');
    INSERT INTO text VALUES (902,'SYSTEM SOFTWARE','PETERSON','JACOB');
    INSERT INTO text VALUES (903,'SCHEDULING','PEARSON','PATIL');
    INSERT INTO text VALUES (904,'DATABASE SYSTEMS','PEARSON','JACOB');
    INSERT INTO text VALUES (905,'DATABASE MANAGER','PEARSON','BOB');
    INSERT INTO text VALUES (906,'SIGNALS','HALL INDIA','SUMIT');
select * from text;


INSERT INTO enroll VALUES ('1pe11cs001',115,3,100);
   INSERT INTO enroll VALUES  ('1pe11cs002',114,5,100);
  INSERT INTO enroll VALUES   ('1pe11cs003',113,5,100);
   INSERT INTO enroll VALUES  ('1pe11cs004',111,5,100);
    INSERT INTO enroll VALUES ('1pe11cs005',112,3,100);
    select * from enroll;
delete from enroll where  regno = '1pe11cs001';


INSERT INTO book_adoption values (111,5,900);
INSERT INTO book_adoption values(111,5,903);
INSERT INTO book_adoption values(111,5,904);
INSERT INTO book_adoption values(112,3,901);
INSERT INTO book_adoption values(113,3,10);
INSERT INTO book_adoption values(114,5,905);
INSERT INTO book_adoption values(113,5,902);
INSERT INTO book_adoption values(115,3,906);
delete from book_adoption where  courseno = '115';
   select * from book_adoption;
drop table book_adoption;

SELECT c.courseno,t.book_isbn,t.book_title
     FROM course c,book_adoption ba,text t
     WHERE c.courseno=ba.courseno
     AND ba.book_isbn=t.book_isbn
     AND c.dept='CSE'
     AND 2<(
     SELECT COUNT(book_isbn)
     FROM book_adoption b
     WHERE c.courseno=b.courseno)
     ORDER BY t.book_title;
     
SELECT DISTINCT c.dept
     FROM course c
     WHERE c.dept IN
     ( SELECT c.dept
     FROM course c,book_adoption b,text t
     WHERE c.courseno=b.courseno
     AND t.book_isbn=b.book_isbn
     AND t.publisher='PEARSON')
     AND c.dept NOT IN
     (SELECT c.dept
     FROM course c,book_adoption b,text t
     WHERE c.courseno=b.courseno
     AND t.book_isbn=b.book_isbn
     AND t.publisher != 'PEARSON');
