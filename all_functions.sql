clear scr;

--FETCH SYSTEM DATE
create or replace function currentDate
return atd_info.log_date%type as
  cdate atd_info.log_date%type;
  cursor fetchDate is
    select sysdate from dual;
begin
  open fetchDate;
    fetch fetchDate into cdate;
    return cdate;
  close fetchDate;
end;
/