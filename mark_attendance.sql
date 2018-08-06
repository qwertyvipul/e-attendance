clear scr;
--set serveroutput on;
/*
--SEARCH FOR YEARS USING TEACHER CODE
select distinct(bi.year)
from batch_info bi
inner join class_info ci
on (ci.batch_id = bi.batch_id)
inner join teachers t
on (ci.teacher_id = t.teacher_id and t.teacher_code = 'tc1');
*/

/*
--SEARCH FOR BATCHES UNDER THE TEACHER IN YEAR
select distinct(bi.batch_code)
from batch_info bi
inner join class_info ci
on (ci.batch_id = bi.batch_id and bi.year = 1)
inner join teachers t
on (ci.teacher_id = t.teacher_id and t.teacher_code = 'tc1');
*/

/*
--SEARCH FOR SUBJECTS UNDER THE TEACHER IN BATCH AND YEAR
select distinct(concat(si.subject_code, ci.class_type))
from subject_info si
inner join class_info ci
on(ci.subject_id = si.subject_id)
inner join batch_info bi
on(ci.batch_id = bi.batch_id and bi.year = 1 and bi.batch_code = 'B11')
inner join teachers t
on (ci.teacher_id = t.teacher_id and t.teacher_code = 'tc1');
*/

/*
--SSEARCH FOR THE CLASSES FOR THE SUBJECTS (LECTURE, TUTORIAL, PRACTICAl)
select ci.class_id
from class_info ci
inner join subject_info si
on(ci.subject_id = si.subject_id and concat(si.subject_code, ci.class_type) = 'sub1L')
inner join batch_info bi
on(ci.batch_id = bi.batch_id and bi.year = 1 and bi.batch_code = 'B11')
inner join teachers t
on (ci.teacher_id = t.teacher_id and t.teacher_code = 'tc1'); 
*/

/*
--STUDETS ATTENDING THE CLASS
select br.serial_no, cr,student_id
from batch_record br
inner join batch_info bi
on (bi.batch_id = br.batch_id)
inner join class_info ci
on (ci.batch_id = bi.batch_id and ci.class_id=1)
*/


declare
  sid students.student_id%type;
  cid class_info.class_id%type := 1;
  aid atd_info.atd_id%type;
  acount atd_info.count%type := 3;
  adate atd_info.log_date%type;
  roll atd_log.status%type := 1;
  
  cursor mark_info is --cursor to fetch the students list
    select br.student_id
    from batch_record br
    inner join batch_info bi
    on (bi.batch_id = br.batch_id)
    inner join class_info ci
    on (ci.batch_id = bi.batch_id and ci.class_id=cid);
begin
  aid := atd_id_val.nextval;
  adate := currentDate; --call to function to get date
  insert into atd_info(atd_id, class_id, count, log_date)
  values (aid, cid, acount, adate);
  open mark_info;
    loop
      fetch mark_info into sid;
      exit when mark_info%notfound;
      markRoll(aid, sid, roll); --call to procedure to mark attendance in log
    end loop;
  close mark_info;
end;
/