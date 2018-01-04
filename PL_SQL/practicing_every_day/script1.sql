SQL> create or replace procedure p1 (amu number)
  2  us
  3  
  4  
  5  
  6  .
SQL> create or replace procedure p1 (amu number)
  2  is
  3  	v_sal number;
  4  begin
  5  	select sal into v_sal
  6  	from emp
  7  	where empno = amu;
  8  
  9  	dbms_output.put_line(v_sal);
 10  end;
 11  /

Procedure created.

SQL> exec p1(7788)

PL/SQL procedure successfully completed.

SQL> set serveroutput on
SQL> exec p1(7788)
3000                                                                                                                                                                                                    

PL/SQL procedure successfully completed.

SQL> create or replace procedure p1(amu number)
  2  is
  3  	v_sal number;
  4  begin
  5  	select sal into v_sal
  6  	from emp
  7  	where empno = amu;
  8  
  9  	dbms_output.put_line(v_sal);
 10  exception
 11  	when others then
 12  		dbms_output.put_line('put some valid number');
 13  end;
 14  /

Procedure created.

SQL> exec p1(9999);
put some valid number                                                                                                                                                                                   

PL/SQL procedure successfully completed.

SQL> create or replace procedure p1(amu emp.empno%type)
  2  is
  3  	v_sal emp.sal%type;
  4  begin
  5  	select sal into v_sal
  6  	from emp
  7  	where empno = amu;
  8  
  9  	if v_sal < 2000 then
 10  		dbms_output.put_line('Low');
 11  	elsif v_sal < 4000 then
 12  		dbms_output.put_line('Mid');
 13  	else
 14  		dbms_output.put_line('High');
 15  	end if;
 16  end;
 17  /

Procedure created.

SQL> exec p1(7788);
Mid                                                                                                                                                                                                     

PL/SQL procedure successfully completed.

SQL> /* DML Test */
SQL> drop table t1 purge;
drop table t1 purge
           *
ERROR at line 1:
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired 


SQL> select * from t1;

no rows selected

SQL> create table t1 as select * from dept where 1=2;
create table t1 as select * from dept where 1=2
             *
ERROR at line 1:
ORA-00955: name is already used by an existing object 


SQL> 
SQL> select *
  2  from tab;

TNAME                                                        TABTYPE         CLUSTERID                                                                                                                  
------------------------------------------------------------ -------------- ----------                                                                                                                  
BIN$ZDpxW4znRQaFiY1LHn9vJQ==$0                               TABLE                                                                                                                                      
BONUS                                                        TABLE                                                                                                                                      
COUNTRIES                                                    TABLE                                                                                                                                      
D1                                                           TABLE                                                                                                                                      
DEPARTMENTS                                                  TABLE                                                                                                                                      
DEPT                                                         TABLE                                                                                                                                      
DUMMY                                                        TABLE                                                                                                                                      
E1                                                           TABLE                                                                                                                                      
EMP                                                          TABLE                                                                                                                                      
EMPLOYEES                                                    TABLE                                                                                                                                      
JOBS                                                         TABLE                                                                                                                                      
JOB_GRADES                                                   TABLE                                                                                                                                      
JOB_HISTORY                                                  TABLE                                                                                                                                      
LOCATIONS                                                    TABLE                                                                                                                                      
ME                                                           VIEW                                                                                                                                       
REGIONS                                                      TABLE                                                                                                                                      
SALGRADE                                                     TABLE                                                                                                                                      
SIMIN                                                        TABLE                                                                                                                                      
T                                                            TABLE                                                                                                                                      
T1                                                           TABLE                                                                                                                                      
T2                                                           TABLE                                                                                                                                      
T3                                                           TABLE                                                                                                                                      
T_BOOKS                                                      TABLE                                                                                                                                      
T_DEPT                                                       TABLE                                                                                                                                      
T_EMP                                                        TABLE                                                                                                                                      
T_MASTER                                                     TABLE                                                                                                                                      
T_TRANSACTION                                                TABLE                                                                                                                                      
V1                                                           VIEW                                                                                                                                       
V2                                                           VIEW                                                                                                                                       
V4                                                           VIEW                                                                                                                                       
V5                                                           VIEW                                                                                                                                       
V6                                                           VIEW                                                                                                                                       
비정규직사원                                                 VIEW                                                                                                                                       
정규직사원                                                   VIEW                                                                                                                                       
집계                                                         VIEW                                                                                                                                       

35 rows selected.

SQL> drop table t1 purge;
drop table t1 purge
           *
ERROR at line 1:
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired 


SQL> commit;

Commit complete.

SQL> drop table t1 purge;
drop table t1 purge
           *
ERROR at line 1:
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired 


SQL> spool off
