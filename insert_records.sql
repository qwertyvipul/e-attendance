clear scr;


--WHEN FRESH RECORDS REQUIRED
delete from atd_log;
delete from atd_info;
delete from class_record;
delete from class_info;
delete from subject_info;
delete from batch_record;
delete from batch_info;
delete from teachers;
delete from students;
delete from users;


--INSERTING BATCHES IN THE BATCH_INFO
begin
	insert into batch_info(batch_id, batch_code, year, semester)
	values(batch_id_val.nextval, 'B11', 1, 1);
  insert into batch_info(batch_id, batch_code, year, semester)
	values(batch_id_val.nextval, 'B12', 1, 1);
  insert into batch_info(batch_id, batch_code, year, semester)
	values(batch_id_val.nextval, 'B13', 1, 1);
  insert into batch_info(batch_id, batch_code, year, semester)
	values(batch_id_val.nextval, 'B41', 1, 1);
end;
/


declare 
	i integer;
	id varchar(2);
	email varchar(20);
begin
	--INSERTING INTO USERS (ACCOUNT TYPE = 1 IS TEACHER)
	<< i_loop >>
	for i in 1..10 loop

		id := to_char(i);
		email := concat('user', id);
		email := concat(email, '@mail.box');

		insert into 
		users(user_id, first_name, last_name, account_type, email_id, password)
		values (i, 'user', id, 1, email, id); 
		
		--INSERTION IN TEACHERS TABLE
		insert into teachers (teacher_id, teacher_code)
		values(i, concat('tc', id));

  end loop i_loop;

	--INSERTING INTO USERS (ACCOUNT TYPE = 2 IS STUDENT)
	<< i_loop >>
		for i in 11..40 loop

		id := to_char(i);
		email := concat('user', id);
		email := concat(email, '@mail.box');

		insert into 
		users(user_id, first_name, last_name, account_type, email_id, password)
		values (i, 'user', id, 2, email, id); 
		
		--INSERTING IN STUDENTS TABLE
		if(i between 11 and 20) then
    
			if(mod(i, 10) between 1 and 3) then
				insert into students(student_id, semester, year, branch)
				values (i, 1, 1, 'COE'); --COE BRANCH
			elsif(mod(i, 10) between 4 and 6) then
				insert into students(student_id, semester, year, branch)
				values (i, 1, 1, 'CML'); --CML
			else
				insert into students(student_id, semester, year, branch)
				values (i, 1, 1, 'CAG'); --CAG
			end if;
      
		elsif(i between 21 and 30) then
    
			if(mod(i, 10) between 1 and 3) then
				insert into students(student_id, semester, year, branch)
				values (i, 1, 1, 'ECE');
			elsif(mod(i, 10) between 4 and 6) then
				insert into students(student_id, semester, year, branch)
				values (i, 1, 1, 'ENC');
			else
				insert into students(student_id, semester, year, branch)
				values (i, 1, 1, 'EEA');
			end if;
      
		else
    
			if(mod(i, 10) between 1 and 3) then
				insert into students(student_id, semester, year, branch)
				values (i, 1, 1, 'MEE');
			elsif(mod(i, 10) between 4 and 6) then
				insert into students(student_id, semester, year, branch)
				values (i, 1, 1, 'CVL');
			else
				insert into students(student_id, semester, year, branch)
				values (i, 1, 1, 'MER');
			end if;
      
		end if;
	end loop i_loop;
end;
/


--INSERTING STUDENTS INTO BATCH_RECORD
declare 
	serial integer;
	s_id students.student_id%type;
	b_id batch_info.batch_id%type;
	cursor b_info is 
		select batch_id from batch_info where batch_code in ('B11', 'B12', 'B13'); --CURSOR FOR STORING THE BATCH ID
	cursor s_info is
		select student_id from students where student_id between 11 and 20; --CURSOR FOR STUDENT LIST FROM STUDENS TABLE
begin 
	open b_info; --OPEN CURSOR
		fetch b_info into b_id;
		open s_info;
		loop
			fetch s_info into s_id;
			exit when s_info%notfound;
			serial := mod(s_id, 10);
			
			if(serial=0) then
				serial:=10;
				insert into batch_record(batch_id, student_id, serial_no) --INSERTION INTO BATCH RECORD
				values (b_id, s_id, serial);
			else
				insert into batch_record(batch_id, student_id, serial_no)
				values (b_id, s_id, serial);
			end if;
		end loop;
		close s_info; 
	close b_info; --CLOSE CURSOR
end;
/

--INSERTION IN SUBJECTS TABLE
declare
	i integer;
	subid varchar2(2);
	code varchar2(10);
	sname varchar2(255);
begin
	<< i_loop >>
	for i in 1..5 loop
		subid := to_char(i);
		code := concat('sub', subid);
		sname := concat('subject_', subid);
		
		insert into subject_info(subject_id, subject_code, subject_name)
		values (subject_id_val.nextval, code, sname);
	end loop i_loop;
end;
/		

--INSERTION INTO CLASS INFO
declare
	tid teachers.teacher_id%type;
	bid batch_info.batch_id%type;
	sub_id subject_info.subject_id%type;
	
	cursor b11 is
		select batch_id from batch_info where batch_code = 'B11'; --CURSOR FOR BATCH ID
		
	cursor tc1 is
		select teacher_id from teachers where teacher_code = 'tc1'; --CURSOR FOR TEACHER ID
		
	cursor sub1 is
		select subject_id from subject_info where subject_code = 'sub1'; --CURSOR FOR SUBJECT ID

begin
	open b11;
		fetch b11 into bid;
		
		open tc1;
			fetch tc1 into tid;
			
			open sub1;
				fetch sub1 into sub_id;
			
				--INSERTION INTO CLASS INFO
				insert into class_info(class_id, batch_id, subject_id, teacher_id, class_type)
				values(class_id_val.nextval, bid, tid, sub_id, 'L');
				
			close sub1;
		close tc1;
	close b11;
end;
/

--INSERTING STUDENTS IN CLASS RECORD
declare
	cid class_info.class_id%type;
	bid batch_info.batch_id%type;
	cursor classid is	--CURSOR FOR CLASS ID
		select ci.class_id, bi.batch_id
		from class_info ci
		inner join subject_info si
		on (ci.subject_id = si.subject_id and si.subject_code='sub1')
		inner join batch_info bi
		on (ci.batch_id = bi.batch_id and bi.batch_code='B11')
		inner join teachers t
		on (ci.teacher_id = t.teacher_id and t.teacher_code='tc1');
begin
	open classid;
	loop
		fetch classid into cid, bid;
		exit when classid%notfound;
		
		declare
			sid students.student_id%type;
			cursor brecord is --CURSOR FOR STUDENTS ID FROM BATCH RECORD
				select student_id from batch_record
				where batch_id = bid;
		begin
			open brecord;
			loop
				fetch brecord into sid;
				exit when brecord%notfound;
				
				insert into class_record (class_id, student_id) --INSERTION IN CLASS RECORD
				values (cid, sid);
			end loop;
		end;
	end loop;
end;
/

