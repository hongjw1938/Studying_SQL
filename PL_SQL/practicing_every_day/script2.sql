SQL> drop table t1 purge;

Table dropped.

SQL> create table t1
  2  as
  3  select *
  4  from dept
  5  where 1=2; /*Always true condition*/
  6  
SQL> select * fromt1;
select * fromt1
         *
ERROR at line 1:
ORA-00923: FROM keyword not found where expected 


SQL> select * fromt 1;
select * fromt 1
         *
ERROR at line 1:
ORA-00923: FROM keyword not found where expected 


SQL> select * from t1;
select * from t1
              *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> create table t1
  2  as
  3  select *
  4  from dept
  5  where 1=2;

Table created.

SQL> create or replace procedure t1_insert
  2  (a t1.deptno%type,
  3  b t1.dname%type,
  4  c t1.loc%type)
  5  is
  6  begin
  7  	if c='평양' then
  8  		dbms_output.put_line(c || '불가');
  9  	else
 10  		insert into t1(deptno, dname, loc)
 11  		values (a,b,c);
 12  	end if;
 13  end;
 14  /

Procedure created.

SQL> exec t1_insert(10,'ACCOUNT', '평양');
평양불가                                                                                                                                                                                                

PL/SQL procedure successfully completed.

SQL> exec t1_insert(50,'ACCOUNT','개성');

PL/SQL procedure successfully completed.

SQL> select *
  2  from t1;

    DEPTNO DNAME                        LOC                                                                                                                                                             
---------- ---------------------------- --------------------------                                                                                                                                      
        50 ACCOUNT                      개성                                                                                                                                                            

SQL> create or replace procedure t1_loc_update(
  2  a t1.deptno%type,
  3  b t1.dname%type)
  4  is
  5  
  6  begin
  7  	update t1
  8  	set loc = b
  9  	where deptno = a;
 10  
 11  	if sql%notfound then 	/*using sql resource*/
 12  		dbms_output.put_line(a || 'department doesn't exist);
 13  	end if;
 14  end;
 15  /

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE T1_LOC_UPDATE:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
12/47    PLS-00103: Encountered the symbol "T" when expecting one of the                                                                                                                                
         following:                                                                                                                                                                                     
         ) , * & = - + < / > at in is mod remainder not rem =>                                                                                                                                          
         <an exponent (**)> <> or != or ~= >= <= <> and or like like2                                                                                                                                   
         like4 likec as between from using || member submultiset                                                                                                                                        
         The symbol ", was inserted before "T" to continue.                                                                                                                                             
                                                                                                                                                                                                        
SQL> l 12
 12* 		dbms_output.put_line(a || 'department doesn't exist);
SQL> l 11
 11* 	if sql%notfound then 	/*using sql resource*/
SQL> del 11
SQL> l 10
 10* 
SQL> i if sql%notfound then
SQL> r
  1  create or replace procedure t1_loc_update(
  2  a t1.deptno%type,
  3  b t1.dname%type)
  4  is
  5  
  6  begin
  7  	update t1
  8  	set loc = b
  9  	where deptno = a;
 10  
 11  if sql%notfound then
 12  		dbms_output.put_line(a || 'department doesn't exist);
 13  	end if;
 14* end;

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE T1_LOC_UPDATE:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
12/47    PLS-00103: Encountered the symbol "T" when expecting one of the                                                                                                                                
         following:                                                                                                                                                                                     
         ) , * & = - + < / > at in is mod remainder not rem =>                                                                                                                                          
         <an exponent (**)> <> or != or ~= >= <= <> and or like like2                                                                                                                                   
         like4 likec as between from using || member submultiset                                                                                                                                        
         The symbol ", was inserted before "T" to continue.                                                                                                                                             
                                                                                                                                                                                                        
SQL> l 12
 12* 		dbms_output.put_line(a || 'department doesn't exist);
SQL> c/doesn't/does not exist'
 12* 		dbms_output.put_line(a || 'department does not exist' exist);
SQL> r
  1  create or replace procedure t1_loc_update(
  2  a t1.deptno%type,
  3  b t1.dname%type)
  4  is
  5  
  6  begin
  7  	update t1
  8  	set loc = b
  9  	where deptno = a;
 10  
 11  if sql%notfound then
 12  		dbms_output.put_line(a || 'department does not exist' exist);
 13  	end if;
 14* end;

Warning: Procedure created with compilation errors.

SQL> l 12
 12* 		dbms_output.put_line(a || 'department does not exist' exist);
SQL> c/exist' exist/exist'
 12* 		dbms_output.put_line(a || 'department does not exist');
SQL> r
  1  create or replace procedure t1_loc_update(
  2  a t1.deptno%type,
  3  b t1.dname%type)
  4  is
  5  
  6  begin
  7  	update t1
  8  	set loc = b
  9  	where deptno = a;
 10  
 11  if sql%notfound then
 12  		dbms_output.put_line(a || 'department does not exist');
 13  	end if;
 14* end;

Procedure created.

SQL> exec t1_loc_update(10,'미금');
10department does not exist                                                                                                                                                                             

PL/SQL procedure successfully completed.

SQL> /* update test */
SQL> create or replace procedure t1_delete(
  2  a t1.deptno%type)
  3  is
  4  begin
  5  	delete from t1
  6  	where deptno = a;
  7  
  8  	if sql%notfound then
  9  		dbms_output.put_line(a || 'department does not exist');
 10  	end if;
 11  end;
 12  /

Procedure created.

SQL> exec t1_delete(50);

PL/SQL procedure successfully completed.

SQL> /* bind variable */
SQL> variable b_result number
SQL> begin
  2  	select (salary*12) + nvl(commission_pct,0) into :b_result
  3  	from employees where employee_id = 144;
  4  end;
  5  /

PL/SQL procedure successfully completed.

SQL> print b_result;

  B_RESULT                                                                                                                                                                                              
----------                                                                                                                                                                                              
     30000                                                                                                                                                                                              

SQL> declare
  2  	v_outer_variable varchar2(20) := 'GLOBAL VARIABLE';
  3  begin
  4  	declare
  5  		v_innser_variable varchar2(20) := 'LOCAL VARIABLE';
  6  	begin
  7  		dbms_output.put_line(v_inner_variable);
  8  		dbms_output.put_line(v_outer_variable);
  9  	end;
 10  
 11  	dbms_output.put_line(v_inner_variable);
 12  end;
 13  /
		dbms_output.put_line(v_inner_variable);
		                     *
ERROR at line 7:
ORA-06550: line 7, column 24:
PLS-00201: identifier 'V_INNER_VARIABLE' must be declared
ORA-06550: line 7, column 3:
PL/SQL: Statement ignored
ORA-06550: line 11, column 23:
PLS-00201: identifier 'V_INNER_VARIABLE' must be declared
ORA-06550: line 11, column 2:
PL/SQL: Statement ignored 


SQL> declare
  2  	v_outer_variable varchar2(20) := 'GLOBAL VARIABLE';
  3  begin
  4  	declare
  5  		v_inner_variable varchar2(20) := 'LOCAL VARIABLE';
  6  	begin
  7  		dbms_output.put_line(v_inner_variable);
  8  		dbms_output.put_line(v_outer_variable);
  9  	end;
 10  
 11  	dbms_output.put_line(v_inner_variable);
 12  end;
 13  /
	dbms_output.put_line(v_inner_variable);
	                     *
ERROR at line 11:
ORA-06550: line 11, column 23:
PLS-00201: identifier 'V_INNER_VARIABLE' must be declared
ORA-06550: line 11, column 2:
PL/SQL: Statement ignored 


SQL> declare
  2  	v_outer_variable varchar2(20) := 'GLOBAL VARIABLE';
  3  begin
  4  	declare
  5  		v_inner_variable varchar2(20) := 'LOCAL VARIABLE';
  6  	begin
  7  		dbms_output.put_line(v_inner_variable);
  8  		dbms_output.put_line(v_outer_variable);
  9  	end;
 10  
 11  	dbms_output.put_line(v_outer_variable);
 12  end;
 13  /
LOCAL VARIABLE                                                                                                                                                                                          
GLOBAL VARIABLE                                                                                                                                                                                         
GLOBAL VARIABLE                                                                                                                                                                                         

PL/SQL procedure successfully completed.

SQL> begin <<outer>>
  2  	declare
  3  		v_father_name varchar2(20) := 'Patrick';
  4  		v_date_of_birth DATE := '20-Apr-1972';
  5  	begin
  6  		declare
  7  			v_child_name varchar2(20) := 'Mike';
  8  			v_date_of_birth DATE := '12-Dec-2002';
  9  		begin
 10  			dbms_output.put_line('Father''s Name: '|| v_father_name);
 11  			dbms_output.put_line('Date of Birth :
 12  						|| outer.v_date_of_birth);
 13  
 14  			dbms_output.put_line('Child''s Name : ' ||v_child_name);
 15  			dbms_output.put_line('Date of Birth :
 16  						|| v_date_of_birth);
 17  		end;
 18  	end;
 19  end outer;
 20  /
			dbms_output.put_line('Child''s Name : ' ||v_child_name);
			                      *
ERROR at line 14:
ORA-06550: line 14, column 26:
PLS-00103: Encountered the symbol "CHILD" when expecting one of the following: 
) , * & = - + < / > at in is mod remainder not rem => 
<an exponent (**)> <> or != or ~= >= <= <> and or like like2 
like4 likec as between from using || multiset member 
submultiset 


SQL> begin <<outer>>
  2  	declare
  3  		v_father_name varchar2(20) := 'Patrick';
  4  		v_date_of_birth DATE := '20-Apr-1972';
  5  	begin
  6  		declare
  7  			v_child_name varchar2(20) := 'Mike';
  8  			v_date_of_birth DATE := '12-Dec-2002';
  9  		begin
 10  			dbms_output.put_line('Father''s Name: '|| v_father_name);
 11  			dbms_output.put_line('Date of Birth :
 12  						|| outer.v_date_of_birth);
 13  
 14  			dbms_output.put_line('Child''s Name : ' ||v_child_name);
 15  			dbms_output.put_line('Date of Birth : '
 16  						|| v_date_of_birth);
 17  		end;
 18  	end;
 19  end outer;
 20  /
ERROR:
ORA-01756: 단일 인용부를 지정해 주십시오 


SQL> begin <<outer>>
  2  	declare
  3  		v_father_name varchar2(20) := 'Patrick';
  4  		v_date_of_birth DATE := '20-Apr-1972';
  5  	begin
  6  		declare
  7  			v_child_name varchar2(20) := 'Mike';
  8  			v_date_of_birth DATE := '12-Dec-2002';
  9  		begin
 10  			dbms_output.put_line('Father''s Name: '|| v_father_name);
 11  			dbms_output.put_line('Date of Birth : '
 12  						|| outer.v_date_of_birth);
 13  
 14  			dbms_output.put_line('Child''s Name : ' ||v_child_name);
 15  			dbms_output.put_line('Date of Birth : '
 16  						|| v_date_of_birth);
 17  		end;
 18  	end;
 19  end outer;
 20  /
Father's Name: Patrick                                                                                                                                                                                  
Date of Birth : 20-APR-72                                                                                                                                                                               
Child's Name : Mike                                                                                                                                                                                     
Date of Birth : 12-DEC-02                                                                                                                                                                               

PL/SQL procedure successfully completed.

SQL> begin <<outer>>
  2  	declare
  3  		v_sal	number(7,2) := 60000;
  4  		v_comm  number(7,2) := v_sal * 0.20;
  5  		v_message varchar2(255) := 'eligible for commission';
  6  	begin
  7  		declare
  8  			v_sal	number(7,2) := 50000;
  9  			v_comm  number(7,2) := 0;
 10  			v_total_comp number(7,2) := v_sal + v_comm;
 11  		begin
 12  			v_message := 'CLERK not' || v_message;
 13  
 14  			dbms_output.put_line(v_message); /*1*/
 15  			dbms_output.put_line(v_comm);	 /*3*/
 16  			dbms_output.put_line(outer.v_comm); /*4*/
 17  
 18  
 19  			outer.v_comm := v_sal * 0.30;
 20  		end;
 21  	v_message := 'SALESMAN' || v_message;
 22  	dbms_output.put_line(v_total);			/*2*/
 23  	dbms_output.put_line(v_comm);			/*5*/
 24  	dbms_output.put_line(v_message);		/*6*/
 25  	end;
 26  end outer;
 27  /
	dbms_output.put_line(v_total);			/*2*/
	                     *
ERROR at line 22:
ORA-06550: line 22, column 23:
PLS-00201: identifier 'V_TOTAL' must be declared
ORA-06550: line 22, column 2:
PL/SQL: Statement ignored 


SQL> 
SQL> 	/*
SQL> 		1 : CLERK no eligible for commission
SQL> 		2 : not accessible
SQL> 		3 : 0
SQL> 		4 : 12000
SQL> 		5 : 15000
SQL> 		6 : SALESMANCLERK not eligible for commssion
SQL> 	*/
SQL> begin <<outer>>
  2  	declare
  3  		v_sal	number(7,2) := 60000;
  4  		v_comm  number(7,2) := v_sal * 0.20;
  5  		v_message varchar2(255) := 'eligible for commission';
  6  	begin
  7  		declare
  8  			v_sal	number(7,2) := 50000;
  9  			v_comm  number(7,2) := 0;
 10  			v_total_comp number(7,2) := v_sal + v_comm;
 11  		begin
 12  			v_message := 'CLERK not' || v_message;
 13  
 14  			dbms_output.put_line(v_message); /*1*/
 15  			dbms_output.put_line(v_comm);	 /*3*/
 16  			dbms_output.put_line(outer.v_comm); /*4*/
 17  
 18  
 19  			outer.v_comm := v_sal * 0.30;
 20  		end;
 21  	v_message := 'SALESMAN' || v_message;
 22  	dbms_output.put_line(v_comm);			/*5*/
 23  	dbms_output.put_line(v_message);		/*6*/
 24  	end;
 25  end outer;
 26  /
CLERK noteligible for commission                                                                                                                                                                        
0                                                                                                                                                                                                       
12000                                                                                                                                                                                                   
15000                                                                                                                                                                                                   
SALESMANCLERK noteligible for commission                                                                                                                                                                

PL/SQL procedure successfully completed.

SQL> 
SQL> 	/*
SQL> 		1 : CLERK no eligible for commission
SQL> 		2 : not accessible
SQL> 		3 : 0
SQL> 		4 : 12000
SQL> 		5 : 15000
SQL> 		6 : SALESMANCLERK not eligible for commssion
SQL> 	*/
SQL> spool off
