--SEQUENCE
--1. create_table.sql
--2. triggers.sql
--3. insert_records.sql
--4. functions.sql
--5. procedures.sql
--6. mark_attendance.sql //if needed change roll and count variable values
--7. select_everything.sql //to view records from all table


/*
--STUDENT (STUDENT ID = x) VIEWING THE ATTENDANCE
sview(x); --PROCEDURE CALL
*/

/*
--TEACHER (TEACHER ID = x) VIEW ATTENDANCE FOR CLASS (CLASS ID = y)
tview(x, y); --PROCEDURE CALL
*/


-----*****FAILED ATTEMPT*****-----
--** OBJECTIVE **--
-- 01. Teacher mark attendance
-- 02. Teacher view attendance of individual class and subject (merged classes)
-- 03. Student view attendance of individual class and subject (merged classes)
-- 04. Store attendance in a proper record for advanced analysis purposes
--** **--

--** BEGINNING OF THE PSEUDOCODE **--
-- 01. Login The user and after a loop of process ask to confirm login
-- IF TEACHER
  -- 01. Ask options to view the attendance or mark it
  -- IF MARK
    -- 01. Ask for year, batch, class, count
    -- 02. Display the student list of the desired class with serial numbers
    -- 03. 0 for absent and 1 for present anytime -1 to exit without saving else throw exception
    -- 04. Update the attendance in class_record and atd_info and atd_log
    
  -- IF VIEW
    -- 01. Ask for merge view or individual view
    -- IF MERGE
      -- 01. Ask the year, batch, subject
      -- 02. Display the student list total, present, absent, percent
    --IF INDIVIDUAL
      -- 01. Ask the year, batch, class
      -- 02. Display the student list total, present, absent, percent
      
-- IF STUDENT
  --01. Ask to view individual or merged view
  --IF MERGED
    --01. Show merged attendance for all the subjects
  --IF INDIVIDUAL
    --01. Show individual attendance for all the subjects
--** **--

