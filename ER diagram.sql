CREATE TABLE course(
      course_number     integer        NOT NULL,
	  title             varchar(15)    NOT NULL,
	  year              integer        NOT NULL,
	  CONSTRAINT  pk_course PRIMARY KEY (course_number,year)
);
----at most once per year.

CREATE TABLE student(
     
	student_id         integer       NOT NULL,
	name               varchar(20)   NOT NULL,
	CONSTRAINT  pk_student PRIMARY KEY (student_id)
);
CREATE TABLE exam (
	 assessment_id       integer      NOT NULL,
     course_number      integer       NOT NULL,
	 year               integer       NOT NULL,
	 date               date          NOT NULL,
	 duration           integer       NOT NULL,
	 exam_mark          integer       NOT NULL,
	 student_id          integer      NOT NULL,
     CONSTRAINT  pk_exam PRIMARY KEY (assessment_id, course_number,student_id,year,exam_mark),
  	 CONSTRAINT  fk_student FOREIGN KEY (student_id),
     CONSTRAINT  fk_exam_course FOREIGN KEY (course_number,year)  REFERENCES course(course_number,year)

);
--------At most one exam per course is being held.

CREATE TABLE assignment(
	 assessment_id       integer      NOT NULL,
	 course_number      integer       NOT NULL,
	 year               integer       NOT NULL,
	 assignment_number  integer       NOT NULL,
	 due_date           date          NOT NULL,
	 assignment_mark     integer       NOT NULL,
	 student_id          integer      NOT NULL,
	 CONSTRAINT   pk_assign  PRIMARY KEY (assessment_id,student_id,course_number,year,assignment_number,assignment_mark),
	 CONSTRAINT  fk_student FOREIGN KEY (student_id),
	 CONSTRAINT   fk_assign_course  FOREIGN KEY (course_number,year)   REFERENCES course(course_number,year)
);
-------there can be multiple per course

CREATE TABLE assessment(
	assessment_id       integer      NOT NULL,
	total_mark          integer      NOT NULL,
	course_number       integer      NOT NULL,
	year                integer      NOT NULL,
	CONSTRAINT   pk_assess  PRIMARY KEY (assessment_id,course_number,year),
	CONSTRAINT  fk_assessment_course FOREIGN KEY (course_number,year)  REFERENCES exam(course_number,year),
    CONSTRAINT   pk_assign  PRIMARY KEY (assessment_id,course_number,year,assignment_number,assignment_mark)
)


CREATE TABLE enroll(
     course_number   integer   NOT NULL,
	 year            integer   NOT NULL,
	 student_id      integer   NOT NULL,
	 total_mark      integer   NOT NULL,
	 CONSTRAINT  pk_enroll   PRIMARY KEY (course_number,year,student_id),
	 CONSTRAINT  fk_enroll_course FOREIGN KEY (course_number,year)  REFERENCES course(course_number,year),
	 CONSTRAINT  fk_enroll_student FOREIGN KEY (student_id)  REFERENCES student(student_id)
);



select student_id, sum(assignment_mark)as total_assignment,exam_mark,total
from student, course, assessment, assignment 
where course =xxx and year ==2012 and total = total_assignment + exam_mark 
group by student_id 


