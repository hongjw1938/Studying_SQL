SQL> create view as v1
  2  
SQL> 
SQL> create or replace view v1 as
  2  select ename, job, sal
  3  from emp;

View created.

SQL> create or replace procedure p1(a number)
  2  is
  3  	r v1%rowtype;
  4  begin
  5  	select ename, job, sal into r
  6  	from emp
  7  	where empno = a;
  8  end;
  9  /

Procedure created.

SQL> exec p1(7788);

PL/SQL procedure successfully completed.

SQL> 
SQL> /* BULK COLLECT INTO */
SQL> 
SQL> 
SQL> create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_record_type IS TABLE OF emp%rowtype
  4  	INDEX BY PLS_INTEGER;
  5  
  6  	r emp_record_type;
  7  begin
  8  	select * BULK COLLECT INTO r
  9  	from emp
 10  	where deptno = a;
 11  
 12  	for i in r.first .. r.last
 13  		dbms_output.put_line(r(i).ename || ' ' || r(i).job || ' ' || r(i).sal );
 14  	end loop;
 15  end;
 16  /

Warning: Procedure created with compilation errors.

SQL> l 12
 12* 	for i in r.first .. r.last
SQL> a loop
 12* 	for i in r.first .. r.lastloop
SQL> c/lastloop/last loop
 12* 	for i in r.first .. r.last loop
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_record_type IS TABLE OF emp%rowtype
  4  	INDEX BY PLS_INTEGER;
  5  
  6  	r emp_record_type;
  7  begin
  8  	select * BULK COLLECT INTO r
  9  	from emp
 10  	where deptno = a;
 11  
 12  	for i in r.first .. r.last loop
 13  		dbms_output.put_line(r(i).ename || ' ' || r(i).job || ' ' || r(i).sal );
 14  	end loop;
 15* end;

Procedure created.

SQL> exec p1(10)
CLARK MANAGER 2450                                                                                                                                                                                      
KING PRESIDENT 5000                                                                                                                                                                                     
MILLER CLERK 1300                                                                                                                                                                                       

PL/SQL procedure successfully completed.

SQL> 
SQL> 
SQL> l 13
 13* 		dbms_output.put_line(r(i).ename || ' ' || r(i).job || ' ' || r(i).sal );
SQL> d 13
SP2-0042: unknown command "d 13" - rest of line ignored.
SQL> del 13
SQL> l 12
 12* 	for i in r.first .. r.last loop
SQL> i dbms_output.put_line(r(i).*);
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_record_type IS TABLE OF emp%rowtype
  4  	INDEX BY PLS_INTEGER;
  5  
  6  	r emp_record_type;
  7  begin
  8  	select * BULK COLLECT INTO r
  9  	from emp
 10  	where deptno = a;
 11  
 12  	for i in r.first .. r.last loop
 13  dbms_output.put_line(r(i).*)
 14  	end loop;
 15* end;

Warning: Procedure created with compilation errors.

SQL> create or replace procedure p1(a number)
  2  is
  3     TYPE emp_record_type IS TABLE OF emp%rowtype
  4     INDEX BY PLS_INTEGER;
  5  
  6     r emp_record_type;
  7  begin
  8     select * BULK COLLECT INTO r
  9     from emp
 10     where deptno = a;
 11  
 12     for i in r.first .. r.last loop
 13  		dbms_output.put_line(r(i).*);
 14  	end loop;
 15  end;
 16  /

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
13/29    PLS-00103: Encountered the symbol "*" when expecting one of the                                                                                                                                
         following:                                                                                                                                                                                     
         <an identifier> <a double-quoted delimited-identifier>                                                                                                                                         
         current delete exists prior                                                                                                                                                                    
         The symbol "<an identifier> was inserted before "*" to continue.                                                                                                                               
                                                                                                                                                                                                        
SQL> 
SQL> 
SQL> 
SQL> /* Exercise! */
SQL> 
SQL> create or replace procedure p1(a number)
  2  is
  3  	TYPE dept_rec_type is record (d_name dept.dname%type,
  4  				      d_loc  dept.loc%type);
  5  	d dept_rec_type;
  6  
  7  	TYPE emp_rec_type IS TABLE OF emp%rowtype
  8  	INDEX BY PLS_INTEGER;
  9  
 10  	r emp_rec_type;
 11  
 12  begin
 13  	select dname, loc INTO d
 14  	from dept
 15  	where deptno = a;
 16  
 17  	select * BULK COLLECT INTO r
 18  	from emp
 19  	where deptno = a;
 20  
 21  	dbms_output.put_line(chr(13));
 22  	dbms_output.put_line('Department''s name : '  || d.d_name);
 23  	dbms_output.put_line('Location          : ' || d.d_loc);
 24  	dbms_output.put_line(chr(13));
 25  	dbms_output.put_line('EMPNO    ENAME           JOB       ');
 26  	dbms_output.put_line('-------- --------------- ----------' );
 27  
 28  	for i in r.first .. r.last loop
 29  		dbms_output.put_line(rpad(r(i).empno,10, ' ') || rpad(r(i).ename,15,' ') || rpad(r(i).job, 10, ' '));
 30  	end loop;
 31  end;
 32  /

Procedure created.

SQL> exec p1(10)

                                                                                                                                                                                                       
Department's name : ACCOUNTING                                                                                                                                                                          
Location          : NEW YORK                                                                                                                                                                            

                                                                                                                                                                                                       
EMPNO    ENAME           JOB                                                                                                                                                                            
-------- --------------- ----------                                                                                                                                                                     
7782      CLARK          MANAGER                                                                                                                                                                        
7839      KING           PRESIDENT                                                                                                                                                                      
7934      MILLER         CLERK                                                                                                                                                                          

PL/SQL procedure successfully completed.

SQL> create or replace view v1
  2  as
  3  select e.empno, e.ename, e.job, d.dname, d.loc, d.deptno
  4  from emp e, dept d
  5  where e.deptno = d.deptno;

View created.

SQL> 
SQL> 
SQL> create or replace procedure p1(a number)
  2  is
  3  
  4  	TYPE v_rec_type IS TABLE OF v1%rowtype
  5  	INDEX BY PLS_INTEGER;
  6  
  7  	r v_rec_type;
  8  
  9  begin
 10  
 11  	select * BULK COLLECT INTO r
 12  	from v1
 13  	where deptno = a;
 14  
 15  	dbms_output.put_line(chr(13));
 16  	dbms_output.put_line('Department''s name : '  || r(1).dname);
 17  	dbms_output.put_line('Location          : ' || r(1).loc);
 18  	dbms_output.put_line(chr(13));
 19  	dbms_output.put_line('EMPNO     ENAME           JOB       ');
 20  	dbms_output.put_line('--------  --------------- ----------' );
 21  
 22  	for i in r.first .. r.last loop
 23  		dbms_output.put_line(rpad(r(i).empno,10, ' ') || rpad(r(i).ename,16,' ') || rpad(r(i).job, 10, ' '));
 24  	end loop;
 25  end;
 26  /

Procedure created.

SQL> exec p1(10)

                                                                                                                                                                                                       
Department's name : ACCOUNTING                                                                                                                                                                          
Location          : NEW YORK                                                                                                                                                                            

                                                                                                                                                                                                       
EMPNO     ENAME           JOB                                                                                                                                                                           
--------  --------------- ----------                                                                                                                                                                    
7782      CLARK           MANAGER                                                                                                                                                                       
7839      KING            PRESIDENT                                                                                                                                                                     
7934      MILLER          CLERK                                                                                                                                                                         

PL/SQL procedure successfully completed.

SQL> 
SQL> 
SQL> 
SQL> /* How to see source of my resources */
SQL> @desc user_source;
 Name                          Null?    Type
 ----------------------------- -------- --------------------
 NAME                                   VARCHAR2(30)
 TYPE                                   VARCHAR2(12)
 LINE                                   NUMBER
 TEXT                                   VARCHAR2(4000)

SQL> select *
  2  from user_source
  3  where name like 'P%';

NAME                                                         TYPE                           LINE                                                                                                        
------------------------------------------------------------ ------------------------ ----------                                                                                                        
TEXT                                                                                                                                                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
P1                                                           PROCEDURE                         1                                                                                                        
procedure p1(a number)                                                                                                                                                                                  
                                                                                                                                                                                                        
P1                                                           PROCEDURE                         2                                                                                                        
is                                                                                                                                                                                                      
                                                                                                                                                                                                        
P1                                                           PROCEDURE                         3                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                        
P1                                                           PROCEDURE                         4                                                                                                        
	TYPE v_rec_type IS TABLE OF v1%rowtype                                                                                                                                                                 
                                                                                                                                                                                                        
P1                                                           PROCEDURE                         5                                                                                                        
	INDEX BY PLS_INTEGER;                                                                                                                                                                                  
                                                                                                                                                                                                        
P1                                                           PROCEDURE                         6                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                        
P1                                                           PROCEDURE                         7                                                                                                        
	r v_rec_type;                                                                                                                                                                                          
                                                                                                                                                                                                        
P1                                                           PROCEDURE                         8                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                        
P1                                                           PROCEDURE                         9                                                                                                        
begin                                                                                                                                                                                                   
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        10                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        11                                                                                                        
	select * BULK COLLECT INTO r                                                                                                                                                                           
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        12                                                                                                        
	from v1                                                                                                                                                                                                
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        13                                                                                                        
	where deptno = a;                                                                                                                                                                                      
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        14                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        15                                                                                                        
	dbms_output.put_line(chr(13));                                                                                                                                                                         
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        16                                                                                                        
	dbms_output.put_line('Department''s name : '  || r(1).dname);                                                                                                                                          
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        17                                                                                                        
	dbms_output.put_line('Location          : ' || r(1).loc);                                                                                                                                              
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        18                                                                                                        
	dbms_output.put_line(chr(13));                                                                                                                                                                         
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        19                                                                                                        
	dbms_output.put_line('EMPNO     ENAME           JOB       ');                                                                                                                                          
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        20                                                                                                        
	dbms_output.put_line('--------  --------------- ----------' );                                                                                                                                         
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        21                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        22                                                                                                        
	for i in r.first .. r.last loop                                                                                                                                                                        
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        23                                                                                                        
		dbms_output.put_line(rpad(r(i).empno,10, ' ') || rpad(r(i).ename,16,' ') || rpad(r(i).job, 10, ' '));                                                                                                 
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        24                                                                                                        
	end loop;                                                                                                                                                                                              
                                                                                                                                                                                                        
P1                                                           PROCEDURE                        25                                                                                                        
end;                                                                                                                                                                                                    
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                         1                                                                                                        
procedure print_table( p_query in varchar2 )                                                                                                                                                            
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                         2                                                                                                        
AUTHID CURRENT_USER                                                                                                                                                                                     
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                         3                                                                                                        
is                                                                                                                                                                                                      
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                         4                                                                                                        
    l_theCursor     integer default dbms_sql.open_cursor;                                                                                                                                               
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                         5                                                                                                        
    l_columnValue   varchar2(4000);                                                                                                                                                                     
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                         6                                                                                                        
    l_status        integer;                                                                                                                                                                            
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                         7                                                                                                        
    l_descTbl       dbms_sql.desc_tab;                                                                                                                                                                  

NAME                                                         TYPE                           LINE                                                                                                        
------------------------------------------------------------ ------------------------ ----------                                                                                                        
TEXT                                                                                                                                                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                         8                                                                                                        
    l_colCnt        number;                                                                                                                                                                             
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                         9                                                                                                        
begin                                                                                                                                                                                                   
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        10                                                                                                        
    execute immediate                                                                                                                                                                                   
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        11                                                                                                        
    'alter session set                                                                                                                                                                                  
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        12                                                                                                        
        nls_date_format=''dd-mon-yyyy hh24:mi:ss'' ';                                                                                                                                                   
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        13                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        14                                                                                                        
    dbms_sql.parse(  l_theCursor,  p_query, dbms_sql.native );                                                                                                                                          
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        15                                                                                                        
    dbms_sql.describe_columns                                                                                                                                                                           
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        16                                                                                                        
    ( l_theCursor, l_colCnt, l_descTbl );                                                                                                                                                               
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        17                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        18                                                                                                        
    for i in 1 .. l_colCnt loop                                                                                                                                                                         
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        19                                                                                                        
        dbms_sql.define_column                                                                                                                                                                          
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        20                                                                                                        
        (l_theCursor, i, l_columnValue, 4000);                                                                                                                                                          
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        21                                                                                                        
    end loop;                                                                                                                                                                                           
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        22                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        23                                                                                                        
    l_status := dbms_sql.execute(l_theCursor);                                                                                                                                                          
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        24                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        25                                                                                                        
    while ( dbms_sql.fetch_rows(l_theCursor) > 0 ) loop                                                                                                                                                 
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        26                                                                                                        
        for i in 1 .. l_colCnt loop                                                                                                                                                                     
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        27                                                                                                        
            dbms_sql.column_value                                                                                                                                                                       
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        28                                                                                                        
            ( l_theCursor, i, l_columnValue );                                                                                                                                                          
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        29                                                                                                        
            dbms_output.put_line                                                                                                                                                                        
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        30                                                                                                        
            ( rpad( l_descTbl(i).col_name, 30 )                                                                                                                                                         
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        31                                                                                                        
              || ': ' ||                                                                                                                                                                                
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        32                                                                                                        
              l_columnValue );                                                                                                                                                                          
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        33                                                                                                        
        end loop;                                                                                                                                                                                       
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        34                                                                                                        
        dbms_output.put_line( '-----------------' );                                                                                                                                                    
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        35                                                                                                        
    end loop;                                                                                                                                                                                           
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        36                                                                                                        
    execute immediate                                                                                                                                                                                   
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        37                                                                                                        
        'alter session set nls_date_format=''dd-MON-rr'' ';                                                                                                                                             
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        38                                                                                                        
exception                                                                                                                                                                                               
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        39                                                                                                        

NAME                                                         TYPE                           LINE                                                                                                        
------------------------------------------------------------ ------------------------ ----------                                                                                                        
TEXT                                                                                                                                                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    when others then                                                                                                                                                                                    
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        40                                                                                                        
      execute immediate                                                                                                                                                                                 
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        41                                                                                                        
          'alter session set nls_date_format=''dd-MON-rr'' ';                                                                                                                                           
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        42                                                                                                        
      raise;                                                                                                                                                                                            
                                                                                                                                                                                                        
PRINT_TABLE                                                  PROCEDURE                        43                                                                                                        
end;                                                                                                                                                                                                    
                                                                                                                                                                                                        

68 rows selected.

SQL> 
SQL> 
SQL> 
SQL> /* Exercise Bind Variable*/
SQL> 
SQL> variable b_sal number
SQL> 
SQL> begin
  2  	select sal into :b_sal
  3  	from emp
  4  	where empno = 7788;
  5  end;
  6  /

PL/SQL procedure successfully completed.

SQL> print b_sal;

     B_SAL                                                                                                                                                                                              
----------                                                                                                                                                                                              
      3000                                                                                                                                                                                              

SQL> variable b_ann_sal number;
SQL> declare
  2  	v_empno emp.empno%type := &sv_empno;
  3  begin
  4  	select sal*12+nvl(comm,0) into :b_ann_sal
  5  	from emp
  6  	where empno = v_empno;
  7  end;
  8  /
Enter value for sv_empno: 7788
old   2: 	v_empno emp.empno%type := &sv_empno;
new   2: 	v_empno emp.empno%type := 7788;

PL/SQL procedure successfully completed.

SQL> print b_ann_sal;

 B_ANN_SAL                                                                                                                                                                                              
----------                                                                                                                                                                                              
     36000                                                                                                                                                                                              

SQL> select *
  2  from emp
  3  where sal+nvl(comm,0) >= :b_ann_sal;

no rows selected

SQL> select *
  2  from emp
  3  where sal*12+nvl(comm,0) >= :b_ann_sal;

     EMPNO ENAME                JOB                       MGR HIREDATE            SAL       COMM     DEPTNO                                                                                             
---------- -------------------- ------------------ ---------- ------------ ---------- ---------- ----------                                                                                             
      7788 SCOTT                ANALYST                  7566 09-DEC-82          3000                    20                                                                                             
      7839 KING                 PRESIDENT                     17-NOV-81          5000                    10                                                                                             
      7902 FORD                 ANALYST                  7566 03-DEC-81          3000                    20                                                                                             

SQL> create or replace procedure p1(a in emp.empno%type,
  2  				    b out emp.ename%type,
  3  				    c out emp.sal%type)
  4  is
  5  begin
  6  	select ename, sal into b, c
  7  	from emp
  8  	where empno = a;
  9  end;
 10  /

Procedure created.

SQL> variable b_ename varchar2(30)
SQL> variable b_sal number
SQL> exec p1(7788, :b_ename, :b_sal);

PL/SQL procedure successfully completed.

SQL> set autoprint on
SQL> exec p1(7788, :b_ename, :b_sal);

PL/SQL procedure successfully completed.


     B_SAL                                                                                                                                                                                              
----------                                                                                                                                                                                              
      3000                                                                                                                                                                                              


B_ENAME                                                                                                                                                                                                 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SCOTT                                                                                                                                                                                                   

SQL> /* Exercise */
SQL> 
SQL> 
SQL> create or replace procedure up_emp_avg_sal(a t_dept.deptno%type)
  2  is
  3     TYPE emp_rec_type IS RECORD
  4     (deptno t_dept.deptno%type,
  5      dname t_dept.dname%type,
  6      sal  t_emp.sal%type);
  7  
  8     TYPE emp_rec_table_type IS TABLE OF emp_rec_type
  9     INDEX BY PLS_INTEGER;
 10  
 11     rec emp_rec_table_type;
 12     avg_sal number;
 13  begin
 14     select avg(sal) into avg_sal
 15     from t_emp
 16     where deptno = a;
 17  
 18     /*update every salary of employees*/
 19  
 20     update t_emp
 21     set sal = avg_sal
 22     where deptno = a;
 23  
 24     select td.deptno, td.dname, avg_sal as avs BULK COLLECT INTO rec
 25     from t_dept td
 26     where td.deptno = a;
 27  
 28     for i in rec.first .. rec.last loop
 29             dbms_output.put_line(rec(i).deptno || ' ' || rec(i).dname || ' ' || round(avg_sal));
 30     end loop;
 31  end;
 32  /

Procedure created.

SQL> exec p1(10)
BEGIN p1(10); END;

      *
ERROR at line 1:
ORA-06550: line 1, column 7:
PLS-00306: wrong number or types of arguments in call to 'P1'
ORA-06550: line 1, column 7:
PL/SQL: Statement ignored 


SQL> exec up_emp_avg_sal(10)
10 ACCOUNTING 1600                                                                                                                                                                                      

PL/SQL procedure successfully completed.

SQL> 
SQL> /*another way*/

Procedure created.

SQL> 
SQL> 
SQL> create or replace procedure up_emp_avg_sal(a t_dept.deptno%type)
  2  is
  3  
  4  
  5  /

Warning: Procedure created with compilation errors.

SQL> SQL> create or replace procedure up_emp_avg_sal(a t_dept.deptno%type)
SP2-0734: unknown command beginning "SQL> creat..." - rest of line ignored.
SQL>   2  is
SQL>   3     TYPE emp_rec_type IS RECORD (deptno t_dept.deptno%type,
SQL>   4                                  dname t_dept.dname%type,
SQL>   5                                  sal t_emp.sal%type);
SQL>   6     r emp_rec_type;
SQL>   7  begin
SQL>   8     select td.deptno, td.dname, round(avg(te.sal)) as avg_sal INTO r
SQL>   9     from t_dept td, t_emp te
SQL>  10     where td.deptno = te.deptno
SQL>  11     and td.deptno = a
SQL>  12     group by td.deptno, td.dname;
SQL>  13
SP2-0226: Invalid line number 
SQL>  14     dbms_output.put_line(r.deptno || ' ' || r.dname || ' ' || r.sal);
SQL>  15
SP2-0226: Invalid line number 
SQL>  16  end;
SQL>  17  /
SQL> 
SQL> 
SQL> 
SQL> 
SQL> create or replace procedure up_emp_avg_sal(a t_dept.deptno%type)
  2  is
  3     TYPE emp_rec_type IS RECORD (deptno t_dept.deptno%type,
  4                                  dname t_dept.dname%type,
  5                                  sal t_emp.sal%type);
  6     r emp_rec_type;
  7  begin
  8     select td.deptno, td.dname, round(avg(te.sal)) as avg_sal INTO r
  9     from t_dept td, t_emp te
 10     where td.deptno = te.deptno
 11     and td.deptno = a
 12     group by td.deptno, td.dname;
 13  
 14     dbms_output.put_line(r.deptno || ' ' || r.dname || ' ' || r.sal);
 15  
 16  end;
 17  /

Procedure created.

SQL> exec up_emp_avg_sal(10)
10 ACCOUNTING 1600                                                                                                                                                                                      

PL/SQL procedure successfully completed.

SQL> spool off
