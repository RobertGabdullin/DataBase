drop table if exists teacher, teacher_course, book;

create table teacher(
	teacher_name varchar(40) primary key, 
	school varchar(40),
	grade int
);

insert into teacher(teacher_name, school, grade)
values
('Chad Russell', 'Horizon Education Institute', 1),
('E.F.Codd', 'Horizon Education Institute', 1),
('Jones Smith', 'Horizon Education Institute', 1),
('Adam Baker', 'Bright Institution', 2);

create table book(
	book_name varchar(50) primary key,
	publisher varchar(40)
);

insert into book(book_name, publisher)
values
('Learning and teaching in early childhood', 'BOA Editions'),
('Preschool,N56', 'Taylor & Francis Publishing'),
('Early Childhood Education N9', 'Prentice Hall'),
('Know how to educate: guide for Parents and', 'McGraw Hill');

create table teacher_course(
	teacher_name varchar(40) references teacher(teacher_name),
	course varchar(40),
	room varchar(10),
	book_name varchar(50) references book(book_name),
	loanDate date,
	primary key(teacher_name, course)
);

insert into teacher_course(teacher_name, course, room, book_name, loanDate)
values
('Chad Russell', 'Logical thinking', '1.A01', 'Learning and teaching in early childhood', TO_DATE('09/09/2010', 'DD/MM/YYYY')),
('Chad Russell', 'Wrtting', '1.A01', 'Preschool,N56', TO_DATE('05/05/2010', 'DD/MM/YYYY')),
('Chad Russell', 'Numerical Thinking', '1.A01', 'Learning and teaching in early childhood', TO_DATE('05/05/2010', 'DD/MM/YYYY')),
('E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', 'Early Childhood Education N9', TO_DATE('06/05/2010', 'DD/MM/YYYY')),
('E.F.Codd', 'Numerical Thinking', '1.B01', 'Learning and teaching in early childhood', TO_DATE('06/05/2010', 'DD/MM/YYYY')),
('Jones Smith', 'Wrtting', '1.A01', 'Learning and teaching in early childhood', TO_DATE('09/09/2010', 'DD/MM/YYYY')),
('Jones Smith', 'English', '1.A01', 'Know how to educate: guide for Parents and', TO_DATE('05/05/2010', 'DD/MM/YYYY')),
('Adam Baker', 'Logical thinking', '2.B01', 'Know how to educate: guide for Parents and', TO_DATE('18/12/2010', 'DD/MM/YYYY')),
('Adam Baker', 'Numerical Thinking', '2.B01', 'Learning and teaching in early childhood', TO_DATE('06/05/2010', 'DD/MM/YYYY'));

/* Uncomment when necessary the second query */

select school, publisher, count(*) as cnt
from teacher join teacher_course on teacher.teacher_name = teacher_course.teacher_name
			 join book on teacher_course.book_name = book.book_name
group by school, publisher 
order by cnt desc;

/* select school, teacher.teacher_name, book_name
from teacher_course join teacher on teacher.teacher_name = teacher_course.teacher_name
where (school, loanDate) in (select school, min(loanDate) 
							from (teacher_course join teacher on teacher.teacher_name = teacher_course.teacher_name) group by school)
*/