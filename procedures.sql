clear scr;

--MARKING THE ATTENDANCE
create or replace procedure markRoll(aid in atd_info.atd_id%type, sid in students.student_id%type, roll in atd_log.status%type) as
begin
	insert into atd_log(atd_id, student_id, status)
	values(aid, sid, roll);
end;
/

--STUDENT VIEWING THE ATTENDANCE
create or replace procedure sview(sid in students.student_id%type) as
begin
	declare
		cid class_info.class_id%type;
		ctype class_info.class_type%type;
		subcode subject_info.subject_code%type;
		subject varchar(10);
		cursor sviewCid is
			select ci.class_id, concat(si.subject_code, ci.class_type)
			from class_info ci
			inner join class_record cr
			on(ci.class_id = cr.class_id and cr.student_id = sid)
			inner join subject_info si
			on(ci.subject_id = si.subject_id);
	begin
		open sviewCid;
		loop
			fetch sviewCid into cid, subject;
			exit when sviewCid%notfound;
			declare
				total number(3):=0;
				present number(3):=0;
				absent number(3):=0;
				percent number(5, 2):=0;
				aid atd_info.atd_id%type;
				acount atd_info.count%type;
				status atd_log.status%type;
				cursor sviewAid is
					select ai.atd_id, ai.count, al.status
					from atd_info ai
					inner join atd_log al
					on(ai.atd_id = al.atd_id and ai.class_id = cid and al.student_id = sid);
			begin
				open sviewAid;
				loop
					fetch sviewAid into aid, acount, status;
					exit when sviewAid%notfound;
					if(status=0) then
						absent := (absent + acount);
						total := (total + acount);
					else
						present := (present + acount);
						total := (total + acount);
					end if;
				end loop;
				close sviewAid;
				dbms_output.put('Subject = '||subject||'; Total = ' ||total||'; Present = '||present||'; Absent = '||absent);
				percent := present/total*100;
				dbms_output.put_line('; Percent = '||percent);
			end;
		end loop;
		close sviewCid;
	end;
end;
/


--STUDENT ATTENDANCE FOR CLASS ID
create or replace procedure sviewcid(sid in students.student_id%type, cid in class_info.class_id%type) as
begin
	declare
		total number(3):=0;
		present number(3):=0;
		absent number(3):=0;
		percent number(5, 2):=0;
		aid atd_info.atd_id%type;
		acount atd_info.count%type;
		status atd_log.status%type;
		cursor sviewAid is
			select ai.atd_id, ai.count, al.status
			from atd_info ai
			inner join atd_log al
			on(ai.atd_id = al.atd_id and ai.class_id = cid and al.student_id = sid);
	begin
		open sviewAid;
		loop
			fetch sviewAid into aid, acount, status;
			exit when sviewAid%notfound;
			if(status=0) then
				absent := (absent + acount);
				total := (total + acount);
			else
				present := (present + acount);
				total := (total + acount);
			end if;
		end loop;
		close sviewAid;
		dbms_output.put('Student = '||sid||'; Total = ' ||total||'; Present = '||present||'; Absent = '||absent);
		percent := present/total*100;
		dbms_output.put_line('; Percent = '||percent);
	end;
end;
/


--TEACHER VIEWING THE ATTENDANCE
create or replace procedure tview(cid in class_info.class_id%type) as
begin
	declare
		sid students.student_id%type;
		cursor tviewSid is
			select cr.student_id 
      from class_info ci
      inner join class_record cr
      on(ci.class_id = cr.class_id and ci.class_id = cid);
	begin
		open tviewSid;
		loop
			fetch tviewSid into sid;
			exit when tviewSid%notfound;
				sviewcid(sid, cid);
		end loop;
		close tviewSid;
	end;
end;
/

--FOR INSERTION IN BATCH_INFO
/*
create or replace procedure insertBatchInfo(batchCode in batch_info.batch_code%type, year in batch_info.year%type, semester in batch_info.semester%type) as
begin
	insert into batch_info values (batch_id_val.nextval, batchCode, year, semester);
end;
/
*/

--FOR INSERTION IN BATCH INFO INCLUDING BATCH ID
create or replace procedure insertBatchInfoCustom(bid in batch_info.batch_id%type, batchCode in batch_info.batch_code%type, year in batch_info.year%type, semester in batch_info.semester%type) as
begin
	insert into batch_info values (bid, batchCode, year, semester);
end;
/

--FOR INSERTION IN BATCH RECORD
create or replace procedure insertBatchRecord(bid in batch_record.batch_id%type, sid in batch_record.student_id%type, serial in batch_record.serial_no%type) as
begin
	insert into batch_record values (bid, sid, serial);
end;
/

--FOR INSERTION INTO SUBJECT INFO
/*
create or replace procedure insertSubjectInfo(subCode in subject_info.subject_code%type, subName in subject_info.subject_name%type) as
begin
	insert into subject_info values (subject_id_val.nextval, subCode, subName);
end;
/
*/

/*
--FOR INSERTION INTO CLASS INFO
create or replace procedure insertClassInfo(bid in class_info.batch_id%type, subid in class_info.subject_id%type, tid in class_info.teacher_id%type, ctype in class_info.class_type%type) as
begin
	insert into class_info values (class_id_val.nextval, bid, subid, tid, ctype);
end;
/
*/

--FOR INSERTION IN CLASS INFO INCLUDING CLASS ID
create or replace procedure insertClassInfoCustom(cid in class_info.class_id%type, bid in class_info.batch_id%type, subid in class_info.subject_id%type, tid in class_info.teacher_id%type, ctype in class_info.class_type%type) as
begin
	insert into class_info values (cid, bid, subid, tid, ctype);
end;
/

--FOR INSERTION IN CLASS RECORD
create or replace procedure insertClassRecord(cid in class_record.class_id%type, sid in class_record.student_id%type) as
begin
	insert into class_record values (cid, sid);
end;
/

/*
--FOR INSERTION IN ATD INFO
create or replace procedure insertAtdInfo(cid in atd_info.class_id%type, acount in atd_info.count%type) as
begin
	declare
		logDate atd_info.log_date%type := currentDate;
	begin
		insert into atd_info values(atd_id_val.nextval, cid, acount, logDate);
	end;
end;
/
*/

--FOR INSERTION IN ATD INFO INCLUDING ATD ID
create or replace procedure insertAtdInfoCustom(aid in atd_info.atd_id%type, cid in atd_info.class_id%type, acount in atd_info.count%type) as
begin
	declare
		logDate atd_info.log_date%type := currentDate;
	begin
		insert into atd_info values(aid, cid, acount, logDate);
	end;
end;
/

--FOR INSERTION IN ATD LOG
create or replace procedure insertAtdLog(aid in atd_log.atd_id%type, sid in atd_log.student_id%type, astatus in atd_log.status%type) as
begin
	insert into atd_log values(aid, sid, astatus);
end;
/

--TO TRACK ATTENDANCE FOR STUDENT IN CLASS
create or replace procedure trackStudentInClass(cid in class_info.class_id%type, sid in students.student_id%type) as
begin
	declare
		aid atd_info.atd_id%type;
		adate atd_info.log_date%type;
		astatus atd_log.status%type;
		apstatus varchar(20);
		cursor tsic is
			select ai.atd_id, ai.log_date, al.status
			from atd_info ai
			inner join atd_log al
			on(ai.atd_id = al.atd_id and ai.class_id = cid and al.student_id = sid);
	begin
		open tsic;
		loop
			fetch tsic into aid, adate, astatus;
			exit when tsic%notfound;
			if(astatus = 0) then
				apstatus := 'Absent';
			else
				apstatus := 'Present';
			end if;
				
			dbms_output.put_line('Attendance Id = '||aid||'; Date = '||adate||'; Status = '||apstatus);
		end loop;
		close tsic;
	end;
end;
/

--TO VIEW ATTENDANCE SUMMARY FOR ANY ATD ID
create or replace procedure viewSummary(aid in atd_info.atd_id%type) as
begin
	declare 
		sid atd_log.student_id%type;
		astatus atd_log.status%type;
		apstatus varchar(20);
		cursor vsfetch is
			select student_id, status from atd_log where atd_id = aid;
	begin
		open vsfetch;
		loop
			fetch vsfetch into sid, astatus;
			exit when vsfetch%notfound;
			if(astatus = 0) then
				apstatus := 'Absent';
			else
				apstatus := 'Present';
			end if;
			dbms_output.put_line('Student Id = '||sid||'; Status = '||apstatus);
		end loop;
		close vsfetch;
	end;
end;
/
	