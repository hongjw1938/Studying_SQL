SQL> /*try record type*/

Session altered.

SQL> create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4  					job emp.job%type,
  5  					sal emp.sal%type);
  6  	r emp_record_type;
  7  begin
  8  	select ename, job, sal into r
  9  	from emp
 10  	where deptno = a;
 11  
 12  	dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
 13  end;
 14  /

Procedure created.

SQL> exec p1(10)
BEGIN p1(10); END;

*
ERROR at line 1:
ORA-01422: exact fetch returns more than requested number of rows
ORA-06512: at "ACE24.P1", line 8
ORA-06512: at line 1 


SQL> l 10
 10* 	where deptno = a;
SQL> c/deptno/empno;
 10* 	where empno = a;
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4  					job emp.job%type,
  5  					sal emp.sal%type);
  6  	r emp_record_type;
  7  begin
  8  	select ename, job, sal into r
  9  	from emp
 10  	where empno = a;
 11  
 12  	dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
 13* end;

Procedure created.

SQL> exec p1(7788);

PL/SQL procedure successfully completed.

SQL> /*Make exception process to handle the exeception*/

Procedure created.

SQL> l 12
 12* 	dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
SQL> i exception
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4  					job emp.job%type,
  5  					sal emp.sal%type);
  6  	r emp_record_type;
  7  begin
  8  	select ename, job, sal into r
  9  	from emp
 10  	where empno = a;
 11  
 12  	dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
 13  exception
 14* end;

Warning: Procedure created with compilation errors.

SQL> l 13
 13* exception
SQL> i when Too_many_rows then
SQL> l 14
 14* when Too_many_rows then
SQL> i dbms_output.put_line('You've fetched more than one row. Should use TABLE type value to handle this');
SQL> l 10
 10* 	where empno = a;
SQL> c/empno/deptno
 10* 	where deptno = a;
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4  					job emp.job%type,
  5  					sal emp.sal%type);
  6  	r emp_record_type;
  7  begin
  8  	select ename, job, sal into r
  9  	from emp
 10  	where deptno = a;
 11  
 12  	dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
 13  exception
 14  when Too_many_rows then
 15  dbms_output.put_line('You've fetched more than one row. Should use TABLE type value to handle this')
 16* end;

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
15/27    PLS-00103: Encountered the symbol "VE" when expecting one of the                                                                                                                               
         following:                                                                                                                                                                                     
         ) , * & = - + < / > at in is mod remainder not rem =>                                                                                                                                          
         <an exponent (**)> <> or != or ~= >= <= <> and or like like2                                                                                                                                   
         like4 likec as between from using || multiset member                                                                                                                                           
         submultiset                                                                                                                                                                                    
                                                                                                                                                                                                        
SQL> l 15
 15* dbms_output.put_line('You've fetched more than one row. Should use TABLE type value to handle this')
SQL> c/You've/You have
 15* dbms_output.put_line('You have fetched more than one row. Should use TABLE type value to handle this')
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4  					job emp.job%type,
  5  					sal emp.sal%type);
  6  	r emp_record_type;
  7  begin
  8  	select ename, job, sal into r
  9  	from emp
 10  	where deptno = a;
 11  
 12  	dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
 13  exception
 14  when Too_many_rows then
 15  dbms_output.put_line('You have fetched more than one row. Should use TABLE type value to handle this')
 16* end;

Warning: Procedure created with compilation errors.

SQL> show errors
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
16/1     PLS-00103: Encountered the symbol "END" when expecting one of                                                                                                                                  
         the following:                                                                                                                                                                                 
         := . ( % ;                                                                                                                                                                                     
         The symbol ";" was substituted for "END" to continue.                                                                                                                                          
                                                                                                                                                                                                        
SQL> l 15
 15* dbms_output.put_line('You have fetched more than one row. Should use TABLE type value to handle this')
SQL> c/this'>/this'>;
SP2-0023: String not found.
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4  					job emp.job%type,
  5  					sal emp.sal%type);
  6  	r emp_record_type;
  7  begin
  8  	select ename, job, sal into r
  9  	from emp
 10  	where deptno = a;
 11  
 12  	dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
 13  exception
 14  when Too_many_rows then
 15  dbms_output.put_line('You have fetched more than one row. Should use TABLE type value to handle this')
 16* end;

Warning: Procedure created with compilation errors.

SQL> create or replace procedure p1(a number)
  2  is
  3     TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4                                     job emp.job%type,
  5                                     sal emp.sal%type);
  6     r emp_record_type;
  7  begin
  8     select ename, job, sal into r
  9     from emp
 10     where deptno = a;
 11  
 12     dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
 13  exception
 14  when Too_many_rows then
 15  dbms_output.put_line('You have fetched more than one row. Should use TABLE type value to handle this');
 16  end;
 17  /

Procedure created.

SQL> exec p1(10)

PL/SQL procedure successfully completed.

SQL> set serveroutput on
SQL> exec p1(10)
You have fetched more than one row. Should use TABLE type value to handle this                                                                                                                          

PL/SQL procedure successfully completed.

SQL> 
SQL> 
SQL> 
SQL> /* Now go back to prior way */
SQL> 
SQL> 
SQL> del 14 15
SQL> l 10
 10*    where deptno = a;
SQL> c/deptno/empno
 10*    where empno = a;
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3     TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4                                     job emp.job%type,
  5                                     sal emp.sal%type);
  6     r emp_record_type;
  7  begin
  8     select ename, job, sal into r
  9     from emp
 10     where empno = a;
 11  
 12     dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
 13  exception
 14* end;

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
14/1     PLS-00103: Encountered the symbol "END" when expecting one of                                                                                                                                  
         the following:                                                                                                                                                                                 
         pragma when                                                                                                                                                                                    
                                                                                                                                                                                                        
SQL> del 13
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3     TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4                                     job emp.job%type,
  5                                     sal emp.sal%type);
  6     r emp_record_type;
  7  begin
  8     select ename, job, sal into r
  9     from emp
 10     where empno = a;
 11  
 12     dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
 13* end;

Procedure created.

SQL> exec p1(7788)
SCOTT ANALYST 3000                                                                                                                                                                                      

PL/SQL procedure successfully completed.

SQL> 
SQL> 
SQL> 
SQL> /* Try use package*/
SQL> 
SQL> create or replace package pack1
  2  is
  3  	TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4  					job emp.job%type,
  5  					sal emp.sal%type)
  6  end;
  7  /

Warning: Package created with compilation errors.

SQL> show errors
Errors for PACKAGE PACK1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
6/1      PLS-00103: Encountered the symbol "END" when expecting one of                                                                                                                                  
         the following:                                                                                                                                                                                 
         ;                                                                                                                                                                                              
         The symbol ";" was substituted for "END" to continue.                                                                                                                                          
                                                                                                                                                                                                        
SQL> l 4
  4* 					job emp.job%type,
SQL>  create or replace package pack1
  2   is
  3      TYPE emp_record_type IS RECORD (ename emp.ename%type,
  4                                      job emp.job%type,
  5                                      sal emp.sal%type);
  6  end;
  7  /

Package created.

SQL> create or replace procedure p1(a number)
  2  is
  3  	r pack1.emp_record_type;
  4  begin
  5  	select ename, job, sal into r
  6  	from emp
  7  	where empno = a;
  8  
  9  	dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
 10  end;
 11  /

Procedure created.

SQL> exec p1(7788);
SCOTT ANALYST 3000                                                                                                                                                                                      

PL/SQL procedure successfully completed.

SQL> 
SQL> 
SQL> /* Try use %rowtype*/
SQL> 
SQL> drop package pack1;

Package dropped.

SQL> l 2
SP2-0226: Invalid line number 
SQL> create or replace procedure p1(a number)
  2  is
  3  	r emp%rowtype;
  4  begin
  5  	select ename, empno, job, sal into r
  6  	from emp
  7  	where empno = a;
  8  
  9  	dbms_output.put_line(r.ename || ' ' || r.empno || ' ' || r.job || ' ' || r.sal);
 10  end;
 11  /

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
5/2      PL/SQL: SQL Statement ignored                                                                                                                                                                  
6/2      PL/SQL: ORA-00913: too many values                                                                                                                                                             
SQL> select *
  2  from emp
  3  where empno = 7788;

     EMPNO ENAME                JOB                       MGR HIREDATE            SAL       COMM     DEPTNO                                                                                             
---------- -------------------- ------------------ ---------- ------------ ---------- ---------- ----------                                                                                             
      7788 SCOTT                ANALYST                  7566 09-DEC-82          3000                    20                                                                                             

SQL> create or replace procedure p1(a number)
  2  is
  3  	r emp%rowtype;
  4  begin
  5  	select ename, job, sal into r
  6  	from emp
  7  	where empno = a;
  8  	dbms_output.put_line(r.ename || ' ' || r.empno || ' ' || r.job || ' ' || r.sal);
  9  end;
 10  /

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
5/2      PL/SQL: SQL Statement ignored                                                                                                                                                                  
6/2      PL/SQL: ORA-00913: too many values                                                                                                                                                             
SQL> l 5
  5* 	select ename, job, sal into r
SQL> c/ename, job, sal/*
  5* 	select * into r
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3  	r emp%rowtype;
  4  begin
  5  	select * into r
  6  	from emp
  7  	where empno = a;
  8  	dbms_output.put_line(r.ename || ' ' || r.empno || ' ' || r.job || ' ' || r.sal);
  9* end;

Procedure created.

SQL> exec p1(7788)
SCOTT 7788 ANALYST 3000                                                                                                                                                                                 

PL/SQL procedure successfully completed.

SQL>  create or replace procedure p1(a number)
  2   is
  3      r emp%rowtype;
  4   begin
  5      select ename, job, sal into r
  6      from emp
  7      where empno = a;
  8      dbms_output.put_line(r.ename || ' ' || r.job || ' ' || r.sal);
  9  end;
 10  /

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
5/5      PL/SQL: SQL Statement ignored                                                                                                                                                                  
6/5      PL/SQL: ORA-00913: too many values                                                                                                                                                             
SQL> 
SQL> 
SQL> 
SQL> /*try sequence with anonymous block of PL/SQL */

Warning: Procedure created with compilation errors.

SQL> create sesquence seq_test
  2  start with 1
  3  increment by 1
  4  maxvalue 100
  5  ;
create sesquence seq_test
       *
ERROR at line 1:
ORA-00901: invalid CREATE command 


SQL> l 1
  1* create sesquence seq_test
SQL> c/sesquence/sequence
  1* create sequence seq_test
SQL> r
  1  create sequence seq_test
  2  start with 1
  3  increment by 1
  4  maxvalue 100
  5* 

Sequence created.

SQL> drop table t1 purge;

Table dropped.

SQL> create table t1 (a number, b varchar2(10);
create table t1 (a number, b varchar2(10)
                                        *
ERROR at line 1:
ORA-00907: missing right parenthesis 


SQL> create table t1 (a number, b varchar2(10));

Table created.

SQL> insert t1 (seq_test.currval, 'first');
insert t1 (seq_test.currval, 'first')
       *
ERROR at line 1:
ORA-00925: missing INTO keyword 


SQL> insert into t1 values (seq_test.currval, 'first');
insert into t1 values (seq_test.currval, 'first')
                       *
ERROR at line 1:
ORA-08002: sequence SEQ_TEST.CURRVAL is not yet defined in this session 


SQL> insert into t1 values (seq_test.nextval, 'first');

1 row created.

SQL> select *
  2  from t1;

         A B                                                                                                                                                                                            
---------- --------------------                                                                                                                                                                         
         1 first                                                                                                                                                                                        

SQL> /* deferred segment creation is not working in this version maybe */
SQL> 
SQL> declare
  2  	a number;
  3  begin
  4  	select seq_test into a
  5  	from dual;
  6  end;
  7  /
	select seq_test into a
	       *
ERROR at line 4:
ORA-06550: line 4, column 9:
PL/SQL: ORA-00904: "SEQ_TEST": invalid identifier
ORA-06550: line 4, column 2:
PL/SQL: SQL Statement ignored 


SQL> l 4
  4* 	select seq_test into a
SQL> c/test/test.nextval
  4* 	select seq_test.nextval into a
SQL> r
  1  declare
  2  	a number;
  3  begin
  4  	select seq_test.nextval into a
  5  	from dual;
  6* end;

PL/SQL procedure successfully completed.

SQL> l 5
  5* 	from dual;
SQL> i dbms_output.put_line(a);
SQL> r
  1  declare
  2  	a number;
  3  begin
  4  	select seq_test.nextval into a
  5  	from dual;
  6  dbms_output.put_line(a)
  7* end;
end;
*
ERROR at line 7:
ORA-06550: line 7, column 1:
PLS-00103: Encountered the symbol "END" when expecting one of the following: 
:= . ( % ;
The symbol ";" was substituted for "END" to continue. 


SQL>  declare
  2      a number;
  3   begin
  4      select seq_test.nextval into a
  5      from dual;
  6   dbms_output.put_line(a);
  7  end;
  8  /
3                                                                                                                                                                                                       

PL/SQL procedure successfully completed.

SQL> 
SQL> /*recheck sequence*/
4                                                                                                                                                                                                       

PL/SQL procedure successfully completed.

SQL> drop sequence seq_test;

Sequence dropped.

SQL> create sequence seq_test
  2  ;

Sequence created.

SQL> drop table t1 purge;

Table dropped.

SQL> create table t1 (a number ,b varchar2(10));

Table created.

SQL> insert into t1 values (seq_test.nextval, 'first');

1 row created.

SQL> insert into t1 values (seq_test.nextval, 'second');

1 row created.

SQL> select *
  2  from t1;

         A B                                                                                                                                                                                            
---------- --------------------                                                                                                                                                                         
         1 first                                                                                                                                                                                        
         2 second                                                                                                                                                                                       

SQL> declare
  2  	a number;
  3  begin
  4  	select seq_test.nextval into a
  5  	from dual;
  6  
  7  	dbms_output.put_line(a);
  8  end;
  9  /
3                                                                                                                                                                                                       

PL/SQL procedure successfully completed.

SQL> drop sequence seq_test;

Sequence dropped.

SQL> drop table t1 purge;

Table dropped.

SQL> spool off
