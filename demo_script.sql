clear scr;



-----*****FAILED ATTEMPT*****-----
/*
declare
	userSession integer:=0;
begin
	userSession := &Enter_1_to_start_OR_0_to_exit;
	<< session_loop >>
	while userSession = 1 loop
		declare
			login integer:=0;
		begin
			<< login_loop >>
			while login ~= -1 loop
				declare
					loginChoice integer;
				begin
					if(login=0) then
						accountType := &Enter_Account_Type;
						userid := &Enter_User_Id;
						password := &Enter_Password;
						login:= loginCheck(accountType, userid, password);
						if (login=0) then
							loginChoice:= &Enter_1_to_continue_OR_0_to_exit;
							if (loginChoice=1) then
								login:=0;
							else
								login:=-1;
							end if;
						end if
					elsif(login=1) then
						dbms_output.put_line('Teacher Logged In');
					elsif(login=2) then
						dbms_output.put_line('Student Logged In');
					else
						login:=-1;
					end if;
			end loop login_loop;
	end loop session_loop;
end;
/
*/