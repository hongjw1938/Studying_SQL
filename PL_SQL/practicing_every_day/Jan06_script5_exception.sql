SQL> create or replace procedure p1(a number, b number)
  2  is
  3  begin
  4  	dbms_output.put_line(a/b);
  5  end;
  6  /

Procedure created.

SQL> exec p1(100,2)
50                                                                                                                                                                                                      

PL/SQL procedure successfully completed.

SQL> exec p1(100,0)
BEGIN p1(100,0); END;

*
ERROR at line 1:
ORA-01476: divisor is equal to zero
ORA-06512: at "ACE24.P1", line 4
ORA-06512: at line 1 


SQL> create or replace procedure p1(a number, b number
  2  )
  3  is
  4  begin
  5  	dbms_output.put_line(a/b);
  6  exception
  7  	when zero_divide then
  8  		dbms_output.put_line('You can not put 0 in divisor');
  9  end;
 10  /

Procedure created.

SQL> exec p1(100,0)
You can not put 0 in divisor                                                                                                                                                                            

PL/SQL procedure successfully completed.

SQL> create or replace procedure p1(a number, b varchar2)
  2  is
  3  	e_null exception;
  4  
  5  	pragma exception_init(e_null, -1400);
  6  begin
  7  	insert into t1
  8  	values (a,b);
  9  exception
 10  	when e_null then
 11  		dbms_output.put_line('You can not insert NULL value');
 12  end;
 13  /

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
7/2      PL/SQL: SQL Statement ignored                                                                                                                                                                  
7/14     PL/SQL: ORA-00947: not enough values                                                                                                                                                           
SQL> select *
  2  from t1;

     EMPNO ENAME                JOB                       MGR HIREDATE            SAL       COMM     DEPTNO                                                                                             
---------- -------------------- ------------------ ---------- ------------ ---------- ---------- ----------                                                                                             
      7369 SMITH                CLERK                    7902 17-DEC-80           960                    20                                                                                             
      7499 ALLEN                SALESMAN                 7698 20-FEB-81          1600        300         30                                                                                             
      7521 WARD                 SALESMAN                 7698 22-FEB-81          1250        500         30                                                                                             
      7566 JONES                MANAGER                  7839 02-APR-81          3570                    20                                                                                             
      7654 MARTIN               SALESMAN                 7698 28-SEP-81          1250       1400         30                                                                                             
      7698 BLAKE                MANAGER                  7839 01-MAY-81          2850                    30                                                                                             
      7782 CLARK                MANAGER                  7839 09-JUN-81          2450                    10                                                                                             
      7788 SCOTT                ANALYST                  7566 09-DEC-82          3600                    20                                                                                             
      7839 KING                 PRESIDENT                     17-NOV-81          5000                    10                                                                                             
      7844 TURNER               SALESMAN                 7698 08-SEP-81          1500          0         30                                                                                             
      7876 ADAMS                CLERK                    7788 12-JAN-83          1320                    20                                                                                             
      7900 JAMES                CLERK                    7698 03-DEC-81           950                    30                                                                                             
      7902 FORD                 ANALYST                  7566 03-DEC-81          3600                    20                                                                                             
      7934 MILLER               CLERK                    7782 23-JAN-82          1300                    10                                                                                             

14 rows selected.

SQL> drop table t1 purge;

Table dropped.

SQL> create table t1 (a number, b varchar2(20));

Table created.

SQL>  create or replace procedure p1(a number, b varchar2)
  2   is
  3      e_null exception;
  4  
  5      pragma exception_init(e_null, -1400);
  6   begin
  7      insert into t1
  8      values (a,b);
  9   exception
 10      when e_null then
 11              dbms_output.put_line('You can not insert NULL value');
 12   end;
 13   /

Procedure created.

SQL> exec p1(null, 'abc');

PL/SQL procedure successfully completed.

SQL> drop table t1 purge;

Table dropped.

SQL> create table t1 (a number not null, b varchar2(20));

Table created.

SQL> create or replace procedure p1(a number, b varchar2)
  2  is
  3     e_null exception;
  4  
  5     pragma exception_init(e_null, -1400);
  6  begin
  7     insert into t1
  8     values (a,b);
  9  exception
 10     when e_null then
 11             dbms_output.put_line('You can not insert NULL value');
 12  end;
 13  /

Procedure created.

SQL> exec p1(null, 'abc')
You can not insert NULL value                                                                                                                                                                           

PL/SQL procedure successfully completed.

SQL> create or replace package pack1
  2  is
  3  	e_null exception;
  4  	pragma exception_init(e_null, -1400);
  5  end;
  6  /

Package created.

SQL> craete or replace procedure p1(a number, b varchar2)
SP2-0734: unknown command beginning "craete or ..." - rest of line ignored.
SQL> is
SP2-0042: unknown command "is" - rest of line ignored.
SQL> create or replace procedure p1(a number, b varchar2)
  2  is
  3  begin
  4  	insert into t1
  5  	values (a,b);
  6  exception
  7  	when pack1.e_null then
  8             dbms_output.put_line('You can not insert NULL value');
  9  end;
 10  /

Procedure created.

SQL> exec p1(null,'a')
You can not insert NULL value                                                                                                                                                                           

PL/SQL procedure successfully completed.

SQL> insert into t1 values (null, 'a');
insert into t1 values (null, 'a')
                       *
ERROR at line 1:
ORA-01400: cannot insert NULL into ("ACE24"."T1"."A") 


SQL> create or replace procedure p1(a number, b varchar2)
  2  is
  3  begin
  4  	insert into t1
  5  	values (a,b);
  6  exception
  7  	when others then
  8  		dbms_output.put_line('Error Num : ' || sqlcode);
  9  		dbms_output.put_line('Error Bod : ' || sqlerrm);
 10  end;
 11  /

Procedure created.

SQL> exec p1(null, 'nike');
Error Num : -1400                                                                                                                                                                                       
Error Bod : ORA-01400: cannot insert NULL into ("ACE24"."T1"."A")                                                                                                                                       

PL/SQL procedure successfully completed.

SQL> create or replace procedure p1(a number)
  2  is
  3  	v_sal emp.sal%type;
  4  	e_too_low exception;
  5  begin
  6  	select sal into v_sal
  7  	from emp
  8  	where empno = a;
  9  
 10  	if v_sal < 1000 then
 11  		raise e_too_low;
 12  	end if;
 13  
 14  	dbms_output.put_line(v_sal);
 15  
 16  exception
 17  	when e_too_low then
 18  		dbms_output.put_line('His/Her salary is toooooooo low');
 19  end;
 20  /

Procedure created.

SQL> exec p1(7369)
His/Her salary is toooooooo low                                                                                                                                                                         

PL/SQL procedure successfully completed.

SQL> create or replace procedure p1(a number)
  2  is
  3  	v_sal emp.sal%type;
  4  	e_too_low exception;
  5  begin
  6  	select sal into v_sal
  7  	from emp
  8  	where empno = a;
  9  
 10  	if v_sal < 1000 then
 11  		raise_application_error(-20001, 'Salary is too low');
 12  	end if;
 13  
 14  	dbms_output.put_line(v_sal);
 15  end;
 16  /

Procedure created.

SQL> exec p1(7369)
BEGIN p1(7369); END;

*
ERROR at line 1:
ORA-20001: Salary is too low
ORA-06512: at "ACE24.P1", line 11
ORA-06512: at line 1 


SQL> spool off
