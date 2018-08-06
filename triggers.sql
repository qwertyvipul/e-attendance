clear scr;
--WHEN A USER IS INSERTED OR UPDATED
CREATE OR REPLACE TRIGGER show_inserted_updated_users
AFTER INSERT OR UPDATE ON users
FOR EACH ROW BEGIN
  dbms_output.put_line('USER DETAILS :');
  dbms_output.put('User Id = '|| :NEW.user_id);
  dbms_output.put('; First Name = '|| :NEW.first_name);
  dbms_output.put('; Last Name = '|| :NEW.last_name);
  dbms_output.put('; Account Type = '|| :NEW.account_type);
  dbms_output.put('; Email Id = '|| :NEW.email_id);
  dbms_output.put_line('; Password = '|| :NEW.password);
end;
/

--WHEN A TEACHER IS INSERTED OR UPDATED
CREATE OR REPLACE TRIGGER show_inserted_updated_teachers
AFTER INSERT OR UPDATE ON teachers
FOR EACH ROW BEGIN
  dbms_output.put_line('TEACHER DETAILS :');
  dbms_output.put('Teacher Id = '|| :NEW.teacher_id);
  dbms_output.put_line('; Teacher Code = '|| :NEW.teacher_code);
end;
/

--WHEN A STUDENT IS INSERTED OR UPDATED
CREATE OR REPLACE TRIGGER show_inserted_updated_students
AFTER INSERT OR UPDATE ON students
FOR EACH ROW BEGIN
  dbms_output.put_line('STUDENT DETAILS :');
  dbms_output.put('Student Id = '|| :NEW.student_id);
  dbms_output.put('; Year = '|| :NEW.year);
  dbms_output.put('; Semester = '|| :NEW.semester);
  dbms_output.put_line('; Branch = '|| :NEW.branch);
end;
/

--WHEN A BATCH_INFO IS UPDATED
CREATE OR REPLACE TRIGGER show_updated_batch_info
AFTER INSERT OR UPDATE ON batch_info
FOR EACH ROW BEGIN
  dbms_output.put_line('BATCH INFO :');
  dbms_output.put('Batch Id = '|| :NEW.batch_id);
  dbms_output.put('; Batch Code = '|| :NEW.batch_code);
  dbms_output.put('; Year = '|| :NEW.year);
  dbms_output.put_line('; Semester = '|| :NEW.semester);
end;
/

--WHEN A CLASS RECORD IS UPDATED OR INSERTED
create or replace trigger show_updated_crecord
after insert or update on class_record
for each row begin
  dbms_output.put_line('CLASS RECORD :');
  dbms_output.put('CLASS ID = '|| :NEW.class_id);
  dbms_output.put_line('; STUDENT ID = '|| :NEW.student_id);
end;
/

--WHEN ATTENDANCE MARKED IN LOG
create or replace trigger show_new_log_info
after insert or update on atd_log
for each row begin
  dbms_output.put_line('ATTENDANCE LOG :');
  dbms_output.put('ATTENDANCE ID = '|| :NEW.atd_id);
  dbms_output.put('; STUDENT ID = '|| :NEW.student_id);
  dbms_output.put_line('; STATUS = '|| :NEW.status);
end;
/