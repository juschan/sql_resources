/* create table */
CREATE TABLE student(
	student_id int,
	student_name varchar(20),
	country_of_origin varchar(30)
);

/* row operations */
INSERT INTO student (student_id, student_name, country_of_origin) VALUES ( 101, 'John', 'Thailand');
INSERT INTO student (student_id, student_name, country_of_origin) VALUES ( 201, 'Mary', 'Indonesia');
INSERT INTO student (student_id, student_name, country_of_origin) VALUES ( 202, 'Amir', 'Singapore');
INSERT INTO student (student_id, student_name, country_of_origin) VALUES ( 203, 'Jane', 'Singapore');
INSERT INTO student (student_id, student_name, country_of_origin) VALUES ( 204, 'Ali', 'Malaysia');
INSERT INTO student (student_id, student_name, country_of_origin) VALUES ( 205, 'Wong', 'Malaysia');


/* unique column, no empty cells */

ALTER TABLE student RENAME TO student_old; 
CREATE TABLE student(
	student_id int UNIQUE NOT NULL,
	student_name varchar(20) NOT NULL,
	country_of_origin varchar(30) NOT NULL,
	CONSTRAINT student_id_unique UNIQUE (student_id)
);
INSERT INTO student 
SELECT * FROM student_old;


/* primary key */
ALTER TABLE student RENAME TO student_old2; 
CREATE TABLE student(
	student_id int PRIMARY KEY,
	student_name varchar(20) NOT NULL,
	country_of_origin varchar(30) NOT NULL
);
INSERT INTO student 
SELECT * FROM student_old2;

/* foreign key */
CREATE TABLE student_subject (
	stud_id int,
	subject varchar(20),
	test_score int
);

INSERT INTO student_subject VALUES (201,'Math',46);
INSERT INTO student_subject VALUES (201,'Accounting',78);
INSERT INTO student_subject VALUES (202,'Math',67);
INSERT INTO student_subject VALUES (202,'Accounting',52);
INSERT INTO student_subject VALUES (203,'Art',97);
INSERT INTO student_subject VALUES (203,'Accounting',55);
INSERT INTO student_subject VALUES (204,'Art',64);
INSERT INTO student_subject VALUES (204,'Math',80);
INSERT INTO student_subject VALUES (205,'Art',71);
INSERT INTO student_subject VALUES (205,'Accounting',50);

ALTER TABLE student_subject RENAME TO student_subject_old; 
CREATE TABLE student_subject(
	stud_id int,
	subject varchar(20) NOT NULL,
	test_score int NOT NULL,
	FOREIGN KEY(stud_id) REFERENCES student(student_id)
);
INSERT INTO student_subject 
SELECT * FROM student_subject_old;




/*union all*/
CREATE TABLE acquired_student(
	student_id int PRIMARY KEY,
	student_name varchar(20) NOT NULL,
	country_of_origin varchar(30) NOT NULL
);
INSERT INTO student (student_id, student_name, country_of_origin) VALUES ( 301, 'Meili', 'Thailand');
INSERT INTO student (student_id, student_name, country_of_origin) VALUES ( 302, 'Zelda', 'France');
INSERT INTO student (student_id, student_name, country_of_origin) VALUES ( 303, 'Oscar', 'Germany');

SELECT student_id, student_name, country_of_origin FROM student 
UNION ALL
SELECT student_id, student_name, country_of_origin FROM acquired_student;

/* views */
CREATE VIEW monitor_students AS
SELECT student_id, student_name, subject, test_score
FROM student_subject
LEFT JOIN student 
ON student_subject.stud_id = student.student_id
WHERE student_subject.test_score < 50;


/* window function */
SELECT stud_id, AVG(test_score)
FROM student_subject
GROUP BY stud_id;

SELECT *, 
AVG(test_score) OVER() AS overall_avg_score
FROM student_subject;

SELECT *, 
AVG(test_score) OVER(PARTITION BY stud_id) AS overall_avg_score
FROM student_subject;

SELECT *, 
ROW_NUMBER() OVER(PARTITION BY subject ORDER BY test_score DESC) AS subject_ranking
FROM student_subject;














