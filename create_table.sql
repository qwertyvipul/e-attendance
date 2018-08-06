clear scr;

--WHEN FRESH SEQUENCE AND TABLE REQUIRED
drop table atd_log;
drop table atd_info;
drop table class_record;
drop table class_info;
drop table subject_info;
drop table batch_record;
drop table batch_info;
drop table teachers;
drop table students;
drop table users;

drop sequence batch_id_val;
drop sequence subject_id_val;
drop sequence class_id_val;
drop sequence atd_id_val;


--FOR USER VERIFICATION AND DETAILS
create table users (
	user_id int,
	first_name varchar(10),
	last_name varchar(10),
	account_type number(1),
	email_id varchar(20),
	password varchar(10),
	primary key(user_id, account_type)
);

--TEACHER DETAILS
create table teachers(
	teacher_id int,
	teacher_code varchar(10),
	primary key(teacher_id)
	--constraint fteachers_teacher_id foreign key(teacher_id) references users(user_id) on delete cascade
);

--STUDENT DETAILS
create table students(
	student_id int,
	year number(1),
	semester number(2),
	branch varchar(10),
	primary key(student_id)
	--constraint fstudents_student_id foreign key(student_id) references users(user_id) on delete cascade
);

--BATCH INFORMATION
create table batch_info(
	batch_id int,
	batch_code varchar(10),
	year number(1),
	semester number(2),
	primary key(batch_id)
);

--SEQUENCE FOR AUTO INCREMENT THE BATCH_ID VALUES
create sequence batch_id_val
minvalue 1
start with 1
increment by 1;

--STUDENTS IN A BATCH
create table batch_record(
	batch_id int,
	student_id int,
	serial_no number(4),
	primary key(batch_id, student_id),
	constraint fbatch_record_batch_id foreign key(batch_id) references batch_info(batch_id) on delete cascade,
	constraint fbatch_record_student_id foreign key(student_id) references students(student_id) on delete cascade
); 

--SUBJECTS BEING TAUGHT IN THE CLASSES
create table subject_info(
	subject_id int,
	subject_code varchar(10),
	subject_name varchar(15),
	primary key(subject_id)
);

--SEQUENCE FOR AUTO INCREMENT SUBJECT ID
create sequence subject_id_val
minvalue 1
start with 1
increment by 1;

--CLASSES IN THE BATCH TAKEN BY TEACHER TO TEACH SUBJECT
create table class_info(
	class_id int,
	batch_id int,
	subject_id int,
	teacher_id int,
	class_type varchar(1),
	primary key(class_id),
	constraint fclass_info_batch_id foreign key(batch_id) references batch_info(batch_id) on delete cascade,
	constraint fclass_info_subject_id foreign key(subject_id) references subject_info(subject_id) on delete cascade,
	constraint fclass_info_teacher_id foreign key(teacher_id) references teachers(teacher_id) on delete set null
);

create sequence class_id_val
minvalue 1
start with 1
increment by 1;

--STUDENTS OF THE BATCH ATTENDING THE CLASSES
create table class_record(
	class_id int,
	student_id int,
	primary key(class_id, student_id)
	--constraint fclass_record_student_id foreign key(student_id) references batch_record(student_id) on delete cascade
);

--ATTENDANCE INFORMATION
create table atd_info(
	atd_id int,
	class_id int,
	count number(1),
	log_date date,
	primary key(atd_id),
	constraint fatd_id_class_id foreign key(class_id) references class_info(class_id) on delete cascade
);

--SEQUENCE TO AUTO INCREMENT ATTENDANCE ID
create sequence atd_id_val
minvalue 1
start with 1
increment by 1;

--THE LOG OF THE ATTENDANCE
create table atd_log(
	atd_id int,
	student_id int,
	status number(1),
	primary key(atd_id, student_id),
	constraint fatd_log_atd_id foreign key(atd_id) references atd_info(atd_id) on delete cascade
	--constraint fatd_log_student_id foreign key(student_id) references class_record(student_id) on delete cascade
);
