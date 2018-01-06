
create or replace procedure p1(a emp.deptno%type)
is
	cursor d1(d_deptno emp.deptno%type) is
		select *
		from dept
		where deptno = d_deptno;

	cursor c1(d_deptno emp.deptno%type) is
		select *
		from emp 
		where deptno = d_deptno;
begin
	for val in d1(a) loop	
		dbms_output.put_line(chr(10));
		dbms_output.put_line('부서이름 : ' || val.dname);
		dbms_output.put_line('지    역 : ' || val.loc);
		dbms_output.put_line(chr(13));
		
		dbms_output.put_line('EMPNO ENAME       JOB');
		dbms_output.put_line('----- ----------- --------');

		for val2 in c1(a) loop
			dbms_output.put_line(rpad(val2.empno, 6, ' ') ||
				rpad(val2.ename, 10, ' ') || rpad(val2.job, 6, ' '));
		end loop;
	end loop;

end;
/