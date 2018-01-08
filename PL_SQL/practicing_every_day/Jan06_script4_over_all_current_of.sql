SQL> select sessiontimezone from dual;

SESSIONTIMEZONE                                                                                                                                                                                         
------------------------------------------------------------------------------------------------------------------------------------------------------                                                  
+09:00                                                                                                                                                                                                  

SQL> alter session set time_zone = '-07:00';

Session altered.

SQL> select sessiontimezone from dual;

SESSIONTIMEZONE                                                                                                                                                                                         
------------------------------------------------------------------------------------------------------------------------------------------------------                                                  
-07:00                                                                                                                                                                                                  

SQL> alter session set time_zone = '09:00';

Session altered.

SQL> select sessiontimezone from dual;

SESSIONTIMEZONE                                                                                                                                                                                         
------------------------------------------------------------------------------------------------------------------------------------------------------                                                  
+09:00                                                                                                                                                                                                  

SQL> select systimestamp d1, current_timestamp d2 from dual;

D1                                                                          D2                                                                                                                          
--------------------------------------------------------------------------- ---------------------------------------------------------------------------                                                 
06-JAN-18 02.58.23.581000 PM +09:00                                         06-JAN-18 02.58.23.581000 PM +09:00                                                                                         

SQL> alter session set time_zone = '-07:00';

Session altered.

SQL> select systimestamp d1, current_timestamp d2 from dual;

D1                                                                          D2                                                                                                                          
--------------------------------------------------------------------------- ---------------------------------------------------------------------------                                                 
06-JAN-18 02.58.51.349000 PM +09:00                                         05-JAN-18 10.58.51.349000 PM -07:00                                                                                         

SQL> alter session set time_zone = '09:00';

Session altered.

SQL> create table t
  2  (no number(8),
  3  news varchar2(30),
  4  col1 date,
  5  col2 timestamp,
  6  col3 timestamp with time zone,
  7  col4 timestamp with local time zone)
  8  ;
create table t
             *
ERROR at line 1:
ORA-00955: name is already used by an existing object 


SQL> drop table t purge;

Table dropped.

SQL> r
  1* drop table t purge
drop table t purge
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> create table t
  2  (no number(8),
  3  news varchar2(30),
  4  col1 date,
  5  col2 timestamp,
  6  col3 timestamp with time zone,
  7  col4 timestamp with local time zone)
  8  ;

Table created.

SQL> exec print_table('select * from t');

PL/SQL procedure successfully completed.

SQL> set serveroutput on
SQL> exec print_table('select * from t');

PL/SQL procedure successfully completed.

SQL> insert into t values (1000, 'Win!', sysdate, sysdate, sysdate, sysdate);

1 row created.

SQL> exec print_table('select * from t');
NO                            : 1000                                                                                                                                                                    
NEWS                          : Win!                                                                                                                                                                    
COL1                          : 06-jan-2018 15:03:44                                                                                                                                                    
COL2                          : 06-JAN-18 03.03.44.000000 PM                                                                                                                                            
COL3                          : 06-JAN-18 03.03.44.000000 PM +09:00                                                                                                                                     
COL4                          : 06-JAN-18 03.03.44.000000 PM                                                                                                                                            
-----------------                                                                                                                                                                                       

PL/SQL procedure successfully completed.

SQL> alter session set time_zone = '-07:00';

Session altered.

SQL> exec print_table('select * from t');
NO                            : 1000                                                                                                                                                                    
NEWS                          : Win!                                                                                                                                                                    
COL1                          : 06-jan-2018 15:03:44                                                                                                                                                    
COL2                          : 06-JAN-18 03.03.44.000000 PM                                                                                                                                            
COL3                          : 06-JAN-18 03.03.44.000000 PM +09:00                                                                                                                                     
COL4                          : 05-JAN-18 11.03.44.000000 PM                                                                                                                                            
-----------------                                                                                                                                                                                       

PL/SQL procedure successfully completed.

SQL> alter session set time_zone = '09:00';

Session altered.

SQL> exec print_table('select * from t');
NO                            : 1000                                                                                                                                                                    
NEWS                          : Win!                                                                                                                                                                    
COL1                          : 06-jan-2018 15:03:44                                                                                                                                                    
COL2                          : 06-JAN-18 03.03.44.000000 PM                                                                                                                                            
COL3                          : 06-JAN-18 03.03.44.000000 PM +09:00                                                                                                                                     
COL4                          : 06-JAN-18 03.03.44.000000 PM                                                                                                                                            
-----------------                                                                                                                                                                                       

PL/SQL procedure successfully completed.

SQL> exec print_table('select col1,col2, col3, col4 + interval '1' day
ERROR:
ORA-01756: 단일 인용부를 지정해 주십시오 


SQL> exec print_table('select col1,col2, col3, col4 + interval ''1'' day from t');
COL1                          : 06-jan-2018 15:03:44                                                                                                                                                    
COL2                          : 06-JAN-18 03.03.44.000000 PM                                                                                                                                            
COL3                          : 06-JAN-18 03.03.44.000000 PM +09:00                                                                                                                                     
COL4+INTERVAL'1'DAY           : 07-JAN-18 03.03.44.000000000 PM                                                                                                                                         
-----------------                                                                                                                                                                                       

PL/SQL procedure successfully completed.

SQL> select col1,
  2  
SQL> select 	col1,
  2  		col1 + 17 + 6/24 + 38/1440 + 29/86400,
  3  		col2
  4  		col2 + interval '17 6:38:29' day to second
  5  from t;
		col2 + interval '17 6:38:29' day to second
		     *
ERROR at line 4:
ORA-00923: FROM keyword not found where expected 


SQL> select 	col1,
  2  		col1 + 17 + 6/24 + 38/1440 + 29/86400,
  3  		col2,
  4  		col2 + interval '17 6:38:29' day to second
  5  from t;

COL1         COL1+17+6/24 COL2                                                                        COL2+INTERVAL'176:38:29'DAYTOSECOND                                                               
------------ ------------ --------------------------------------------------------------------------- ---------------------------------------------------------------------------                       
06-JAN-18    23-JAN-18    06-JAN-18 03.03.44.000000 PM                                                23-JAN-18 09.42.13.000000000 PM                                                                   

SQL> create or replace procedure dash
  2  is
  3  begin
  4  	dbms_output.put_line('-------------------------');
  5  end;
  6  /

Procedure created.

SQL> begin
  2  	dash;
  3  
  4  	begin
  5  		dbms_output.put_line('1000');
  6  	end;
  7  
  8  	begin
  9  		dbms_output.put_line('2000');
 10  	end;
 11  
 12  	dash;
 13  end;
 14  /
-------------------------                                                                                                                                                                               
1000                                                                                                                                                                                                    
2000                                                                                                                                                                                                    
-------------------------                                                                                                                                                                               

PL/SQL procedure successfully completed.

SQL> <<outer>>
  2  declare
  3  	v_variable number := 123;
  4  begin
  5  	dbms_output.put_line(v_variable);
  6  
  7  	declare
  8  		v_variable := 234;
  9  
 10  	begin
 11  		dbms_output.put_line(v_variable);
 12  		dbms_output.put_line(outer.v_variable);
 13  	end;
 14  end;
 15  /
		v_variable := 234;
		           *
ERROR at line 8:
ORA-06550: line 8, column 14:
PLS-00103: Encountered the symbol "=" when expecting one of the following: 
constant exception <an identifier> 
<a double-quoted delimited-identifier> table long double ref 
char time timestamp interval date binary national character 
nchar
The symbol "<an identifier>" was substituted for "=" to continue. 


SQL> l 8
  8* 		v_variable := 234;
SQL> c/v_variable/v_variable number
  8* 		v_variable number := 234;
SQL> r
  1  <<outer>>
  2  declare
  3  	v_variable number := 123;
  4  begin
  5  	dbms_output.put_line(v_variable);
  6  
  7  	declare
  8  		v_variable number := 234;
  9  
 10  	begin
 11  		dbms_output.put_line(v_variable);
 12  		dbms_output.put_line(outer.v_variable);
 13  	end;
 14* end;
123                                                                                                                                                                                                     
234                                                                                                                                                                                                     
123                                                                                                                                                                                                     

PL/SQL procedure successfully completed.

SQL> select to_char(sal, 'L999,999.00', 'nls_currency = \')
  2  from emp;

TO_CHAR(SAL,'L999,999.00','NLS_CURRENCY=\'                                                                                                                                                              
------------------------------------------                                                                                                                                                              
              \800.00                                                                                                                                                                                   
            \1,600.00                                                                                                                                                                                   
            \1,250.00                                                                                                                                                                                   
            \2,975.00                                                                                                                                                                                   
            \1,250.00                                                                                                                                                                                   
            \2,850.00                                                                                                                                                                                   
            \2,450.00                                                                                                                                                                                   
            \3,000.00                                                                                                                                                                                   
            \5,000.00                                                                                                                                                                                   
            \1,500.00                                                                                                                                                                                   
            \1,100.00                                                                                                                                                                                   
              \950.00                                                                                                                                                                                   
            \3,000.00                                                                                                                                                                                   
            \1,300.00                                                                                                                                                                                   

14 rows selected.

SQL> select to_char(sal, 'L999,999.00', 'nls_iso_currency = france')
  2  from emp;

TO_CHAR(SAL,'L999,999.00','NLS_ISO_CURRENC                                                                                                                                                              
------------------------------------------                                                                                                                                                              
              $800.00                                                                                                                                                                                   
            $1,600.00                                                                                                                                                                                   
            $1,250.00                                                                                                                                                                                   
            $2,975.00                                                                                                                                                                                   
            $1,250.00                                                                                                                                                                                   
            $2,850.00                                                                                                                                                                                   
            $2,450.00                                                                                                                                                                                   
            $3,000.00                                                                                                                                                                                   
            $5,000.00                                                                                                                                                                                   
            $1,500.00                                                                                                                                                                                   
            $1,100.00                                                                                                                                                                                   
              $950.00                                                                                                                                                                                   
            $3,000.00                                                                                                                                                                                   
            $1,300.00                                                                                                                                                                                   

14 rows selected.

SQL> select to_char(sal, 'L999,999.00', 'nls_iso_currency = UK')
  2  from emp;
from emp
     *
ERROR at line 2:
ORA-12702: invalid NLS parameter string used in SQL function 


SQL> select to_char(sal, 'L999,999.00', 'nls_iso_currency = united kingdom')
  2  from emp;
from emp
     *
ERROR at line 2:
ORA-12702: invalid NLS parameter string used in SQL function 


SQL> select to_char(sal, 'L999,999.00', 'nls_iso_currency = british')
  2  from emp;
from emp
     *
ERROR at line 2:
ORA-12702: invalid NLS parameter string used in SQL function 


SQL> select *
  2  from emp
  3  where (deptno, hiredate) in (	select deptno, max(hiredate)
  4  					from emp
  5  					group by deptno);

     EMPNO ENAME                JOB                       MGR HIREDATE            SAL       COMM     DEPTNO                                                                                             
---------- -------------------- ------------------ ---------- ------------ ---------- ---------- ----------                                                                                             
      7934 MILLER               CLERK                    7782 23-JAN-82          1300                    10                                                                                             
      7876 ADAMS                CLERK                    7788 12-JAN-83          1100                    20                                                                                             
      7900 JAMES                CLERK                    7698 03-DEC-81           950                    30                                                                                             

SQL> select *
  2  from emp
  3  where rowid in (	select substr(max(to_char(hiredate, 'YYYY/MM/DD') || rowid), 11)
  4  			from emp
  5  			group by deptno)
  6  order by deptno;

     EMPNO ENAME                JOB                       MGR HIREDATE            SAL       COMM     DEPTNO                                                                                             
---------- -------------------- ------------------ ---------- ------------ ---------- ---------- ----------                                                                                             
      7934 MILLER               CLERK                    7782 23-JAN-82          1300                    10                                                                                             
      7876 ADAMS                CLERK                    7788 12-JAN-83          1100                    20                                                                                             
      7900 JAMES                CLERK                    7698 03-DEC-81           950                    30                                                                                             

SQL> select deptno, empno, ename ,sal
  2  from emp
  3  where rowid in (	select substr(min(to_char(sal, '000000') || rowid), 8)
  4  			from emp
  5  			group by deptno)
  6  order by deptno;

    DEPTNO      EMPNO ENAME                       SAL                                                                                                                                                   
---------- ---------- -------------------- ----------                                                                                                                                                   
        10       7934 MILLER                     1300                                                                                                                                                   
        20       7369 SMITH                       800                                                                                                                                                   
        30       7900 JAMES                       950                                                                                                                                                   

SQL> 
SQL> 
SQL> 
SQL> 
SQL> --explicit cursor
SQL> 
SQL> create or replace procedure p1 (a number)
  2  is
  3  	CURSOR c1 IS
  4  		select  empno, ename, job, sal
  5  		from emp
  6  		where deptno = a;
  7  
  8  	r c1%type;
  9  begin
 10  	OPEN c1;
 11  
 12  	loop
 13  		FETCH c1 INTO r;
 14  
 15  		exit when c1%notfound;
 16  
 17  		dbms_output.put_line(r.empno || ' ' || r.ename);
 18  
 19  	end loop;
 20  
 21  	CLOSE c1;
 22  end;
 23  /

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
8/4      PL/SQL: Item ignored                                                                                                                                                                           
8/4      PLS-00206: %TYPE must be applied to a variable, column, field or                                                                                                                               
         attribute, not to "C1"                                                                                                                                                                         
                                                                                                                                                                                                        
13/3     PL/SQL: SQL Statement ignored                                                                                                                                                                  
13/17    PLS-00320: the declaration of the type of this expression is                                                                                                                                   
         incomplete or malformed                                                                                                                                                                        
                                                                                                                                                                                                        
17/3     PL/SQL: Statement ignored                                                                                                                                                                      
17/24    PLS-00320: the declaration of the type of this expression is                                                                                                                                   
         incomplete or malformed                                                                                                                                                                        
                                                                                                                                                                                                        
SQL> l 8
  8* 	r c1%type;
SQL> c/type/rowtype
  8* 	r c1%rowtype;
SQL> r
  1  create or replace procedure p1 (a number)
  2  is
  3  	CURSOR c1 IS
  4  		select  empno, ename, job, sal
  5  		from emp
  6  		where deptno = a;
  7  
  8  	r c1%rowtype;
  9  begin
 10  	OPEN c1;
 11  
 12  	loop
 13  		FETCH c1 INTO r;
 14  
 15  		exit when c1%notfound;
 16  
 17  		dbms_output.put_line(r.empno || ' ' || r.ename);
 18  
 19  	end loop;
 20  
 21  	CLOSE c1;
 22* end;

Procedure created.

SQL> exec p1(10)
7782 CLARK                                                                                                                                                                                              
7839 KING                                                                                                                                                                                               
7934 MILLER                                                                                                                                                                                             

PL/SQL procedure successfully completed.

SQL> create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_ename_table_type TABLE IS OF emp.ename%type
  4  	INDEX BY PLS_INTEGER;
  5  
  6  	ename_tab emp_ename_table_type;
  7  begin
  8  	select ename BULK COLLECT INTO ename_tab
  9  	from emp
 10  	where deptno = a;
 11  
 12  	for i in ename_tab.first .. ename_tab.last loop
 13  		dbms_output.put_line(ename_tab(i) || ' ' || ename_tab(i));
 14  	end loop;
 15  end;
 16  /

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
3/28     PLS-00103: Encountered the symbol "TABLE" when expecting one of                                                                                                                                
         the following:                                                                                                                                                                                 
         ; is authid as force under                                                                                                                                                                     
                                                                                                                                                                                                        
SQL> l 3
  3* 	TYPE emp_ename_table_type TABLE IS OF emp.ename%type
SQL> c/TABLE IS/IS TABLE
  3* 	TYPE emp_ename_table_type IS TABLE OF emp.ename%type
SQL> R
  1  create or replace procedure p1(a number)
  2  is
  3  	TYPE emp_ename_table_type IS TABLE OF emp.ename%type
  4  	INDEX BY PLS_INTEGER;
  5  
  6  	ename_tab emp_ename_table_type;
  7  begin
  8  	select ename BULK COLLECT INTO ename_tab
  9  	from emp
 10  	where deptno = a;
 11  
 12  	for i in ename_tab.first .. ename_tab.last loop
 13  		dbms_output.put_line(ename_tab(i) || ' ' || ename_tab(i));
 14  	end loop;
 15* end;

Procedure created.

SQL> exec p1('SMITH');
BEGIN p1('SMITH'); END;

*
ERROR at line 1:
ORA-06502: PL/SQL: numeric or value error: character to number conversion error
ORA-06512: at line 1 


SQL> select *
  2  from emp;

     EMPNO ENAME                JOB                       MGR HIREDATE            SAL       COMM     DEPTNO                                                                                             
---------- -------------------- ------------------ ---------- ------------ ---------- ---------- ----------                                                                                             
      7369 SMITH                CLERK                    7902 17-DEC-80           800                    20                                                                                             
      7499 ALLEN                SALESMAN                 7698 20-FEB-81          1600        300         30                                                                                             
      7521 WARD                 SALESMAN                 7698 22-FEB-81          1250        500         30                                                                                             
      7566 JONES                MANAGER                  7839 02-APR-81          2975                    20                                                                                             
      7654 MARTIN               SALESMAN                 7698 28-SEP-81          1250       1400         30                                                                                             
      7698 BLAKE                MANAGER                  7839 01-MAY-81          2850                    30                                                                                             
      7782 CLARK                MANAGER                  7839 09-JUN-81          2450                    10                                                                                             
      7788 SCOTT                ANALYST                  7566 09-DEC-82          3000                    20                                                                                             
      7839 KING                 PRESIDENT                     17-NOV-81          5000                    10                                                                                             
      7844 TURNER               SALESMAN                 7698 08-SEP-81          1500          0         30                                                                                             
      7876 ADAMS                CLERK                    7788 12-JAN-83          1100                    20                                                                                             
      7900 JAMES                CLERK                    7698 03-DEC-81           950                    30                                                                                             
      7902 FORD                 ANALYST                  7566 03-DEC-81          3000                    20                                                                                             
      7934 MILLER               CLERK                    7782 23-JAN-82          1300                    10                                                                                             

14 rows selected.

SQL> exec p1(SMITH)
BEGIN p1(SMITH); END;

         *
ERROR at line 1:
ORA-06550: line 1, column 10:
PLS-00201: identifier 'SMITH' must be declared
ORA-06550: line 1, column 7:
PL/SQL: Statement ignored 


SQL> exec p1(10)
CLARK CLARK                                                                                                                                                                                             
KING KING                                                                                                                                                                                               
MILLER MILLER                                                                                                                                                                                           

PL/SQL procedure successfully completed.

SQL> 
SQL> --SQL%rowcound
SQL> 
SQL> drop table t1 purge;
drop table t1 purge
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> create table t1 as select * from emp;

Table created.

SQL> begin
  2  	update t1
  3  	set sal = sal * 1.2
  4  	where dpetno = 20;
  5  
  6  	dbms_output.put_line(sql%rowcount || 'rows have been modified
  7  ');
  8  end;
  9  /
	where dpetno = 20;
	      *
ERROR at line 4:
ORA-06550: line 4, column 8:
PL/SQL: ORA-00904: "DPETNO": invalid identifier
ORA-06550: line 2, column 2:
PL/SQL: SQL Statement ignored 


SQL> l 4
  4* 	where dpetno = 20;
SQL> c/dpetno/deptno
  4* 	where deptno = 20;
SQL> r
  1  begin
  2  	update t1
  3  	set sal = sal * 1.2
  4  	where deptno = 20;
  5  
  6  	dbms_output.put_line(sql%rowcount || 'rows have been modified
  7  ');
  8* end;
5rows have been modified
                                                                                                                                                                              


PL/SQL procedure successfully completed.

SQL> -- merge test
SQL> 
SQL> 
SQL> drop table t_transaction purge;

Table dropped.

SQL> drop table t_master purge;

Table dropped.

SQL> create table t_master
  2  as
  3  select *
  4  from emp
  5  where rownum <= 10;

Table created.

SQL> create table t_transaction
  2  as
  3  select *
  4  from emp;

Table created.

SQL> update t_transaction
  2  set sal = sal + 500
  3  where rownum <= 10;

10 rows updated.

SQL> select *
  2  from t_masterl
  3  select *
  4  from t_master;
select *
*
ERROR at line 3:
ORA-00933: SQL command not properly ended 


SQL> select *
  2  from t_master;

     EMPNO ENAME                JOB                       MGR HIREDATE            SAL       COMM     DEPTNO                                                                                             
---------- -------------------- ------------------ ---------- ------------ ---------- ---------- ----------                                                                                             
      7369 SMITH                CLERK                    7902 17-DEC-80           800                    20                                                                                             
      7499 ALLEN                SALESMAN                 7698 20-FEB-81          1600        300         30                                                                                             
      7521 WARD                 SALESMAN                 7698 22-FEB-81          1250        500         30                                                                                             
      7566 JONES                MANAGER                  7839 02-APR-81          2975                    20                                                                                             
      7654 MARTIN               SALESMAN                 7698 28-SEP-81          1250       1400         30                                                                                             
      7698 BLAKE                MANAGER                  7839 01-MAY-81          2850                    30                                                                                             
      7782 CLARK                MANAGER                  7839 09-JUN-81          2450                    10                                                                                             
      7788 SCOTT                ANALYST                  7566 09-DEC-82          3000                    20                                                                                             
      7839 KING                 PRESIDENT                     17-NOV-81          5000                    10                                                                                             
      7844 TURNER               SALESMAN                 7698 08-SEP-81          1500          0         30                                                                                             

10 rows selected.

SQL> select *
  2  from t_transaction;

     EMPNO ENAME                JOB                       MGR HIREDATE            SAL       COMM     DEPTNO                                                                                             
---------- -------------------- ------------------ ---------- ------------ ---------- ---------- ----------                                                                                             
      7369 SMITH                CLERK                    7902 17-DEC-80          1300                    20                                                                                             
      7499 ALLEN                SALESMAN                 7698 20-FEB-81          2100        300         30                                                                                             
      7521 WARD                 SALESMAN                 7698 22-FEB-81          1750        500         30                                                                                             
      7566 JONES                MANAGER                  7839 02-APR-81          3475                    20                                                                                             
      7654 MARTIN               SALESMAN                 7698 28-SEP-81          1750       1400         30                                                                                             
      7698 BLAKE                MANAGER                  7839 01-MAY-81          3350                    30                                                                                             
      7782 CLARK                MANAGER                  7839 09-JUN-81          2950                    10                                                                                             
      7788 SCOTT                ANALYST                  7566 09-DEC-82          3500                    20                                                                                             
      7839 KING                 PRESIDENT                     17-NOV-81          5500                    10                                                                                             
      7844 TURNER               SALESMAN                 7698 08-SEP-81          2000          0         30                                                                                             
      7876 ADAMS                CLERK                    7788 12-JAN-83          1100                    20                                                                                             
      7900 JAMES                CLERK                    7698 03-DEC-81           950                    30                                                                                             
      7902 FORD                 ANALYST                  7566 03-DEC-81          3000                    20                                                                                             
      7934 MILLER               CLERK                    7782 23-JAN-82          1300                    10                                                                                             

14 rows selected.

SQL> MERGE INTO t_master
  2  USING t_transaction t
  3  on (t_master.empno = t.empno)
  4  WHEN MATCHED THEN
  5  	UPDATE SET
  6  		t_master.sal = t.sal, t_master.comm = t.comm
  7  WHEN NOT MATCHED THEN
  8  	insert (t_master_empno, t_master.ename, t_master.sal)
  9  	values (t.empno, t.ename, t.sal);
	insert (t_master_empno, t_master.ename, t_master.sal)
	        *
ERROR at line 8:
ORA-00904: "T_MASTER_EMPNO": invalid identifier 


SQL> l 9
  9* 	values (t.empno, t.ename, t.sal)
SQL> l 8
  8* 	insert (t_master_empno, t_master.ename, t_master.sal)
SQL> c/t_master_empno/t_master.empno
  8* 	insert (t_master.empno, t_master.ename, t_master.sal)
SQL> r
  1  MERGE INTO t_master
  2  USING t_transaction t
  3  on (t_master.empno = t.empno)
  4  WHEN MATCHED THEN
  5  	UPDATE SET
  6  		t_master.sal = t.sal, t_master.comm = t.comm
  7  WHEN NOT MATCHED THEN
  8  	insert (t_master.empno, t_master.ename, t_master.sal)
  9* 	values (t.empno, t.ename, t.sal)

14 rows merged.

SQL> select *
  2  from t_master;

     EMPNO ENAME                JOB                       MGR HIREDATE            SAL       COMM     DEPTNO                                                                                             
---------- -------------------- ------------------ ---------- ------------ ---------- ---------- ----------                                                                                             
      7369 SMITH                CLERK                    7902 17-DEC-80          1300                    20                                                                                             
      7499 ALLEN                SALESMAN                 7698 20-FEB-81          2100        300         30                                                                                             
      7521 WARD                 SALESMAN                 7698 22-FEB-81          1750        500         30                                                                                             
      7566 JONES                MANAGER                  7839 02-APR-81          3475                    20                                                                                             
      7654 MARTIN               SALESMAN                 7698 28-SEP-81          1750       1400         30                                                                                             
      7698 BLAKE                MANAGER                  7839 01-MAY-81          3350                    30                                                                                             
      7782 CLARK                MANAGER                  7839 09-JUN-81          2950                    10                                                                                             
      7788 SCOTT                ANALYST                  7566 09-DEC-82          3500                    20                                                                                             
      7839 KING                 PRESIDENT                     17-NOV-81          5500                    10                                                                                             
      7844 TURNER               SALESMAN                 7698 08-SEP-81          2000          0         30                                                                                             
      7934 MILLER                                                                1300                                                                                                                   
      7902 FORD                                                                  3000                                                                                                                   
      7876 ADAMS                                                                 1100                                                                                                                   
      7900 JAMES                                                                  950                                                                                                                   

14 rows selected.

SQL> 
SQL> 
SQL> 
SQL> 
SQL> -- for
SQL> 
SQL> begin
  2  	for i in 1 .. 10 loop
  3  		i := i + 10;
  4  	dbms_output.put_line(i);
  5  	end loop;
  6  end;
  7  /
		i := i + 10;
		*
ERROR at line 3:
ORA-06550: line 3, column 3:
PLS-00363: expression 'I' cannot be used as an assignment target
ORA-06550: line 3, column 3:
PL/SQL: Statement ignored 


SQL> -- It is impossible to initialize value i which is used as counting condition in for loop
SQL> 
SQL> -- Then what if I want to show only odd number between 1 .. 10?
SQL> 
SQL> begin
  2  	for i in 1..10 loop
  3  		if mod(i,2) <> 0 then
  4  			dbms_output.put_line(i);
  5  		end if;
  6  	end loop;
  7  end;
  8  /
1                                                                                                                                                                                                       
3                                                                                                                                                                                                       
5                                                                                                                                                                                                       
7                                                                                                                                                                                                       
9                                                                                                                                                                                                       

PL/SQL procedure successfully completed.

SQL> -- Also, what if I want to show that result in only one line?
SQL> 
SQL> begin
  2  	for i in 1 .. 10 loop
  3  		if mod(i, 2) <> 0 then
  4  			dbms_output.put(i);
  5  		end if;
  6  	end loop;
  7  	dbms_output.new_line;
  8  end;
  9  /
13579                                                                                                                                                                                                   

PL/SQL procedure successfully completed.

SQL> 
SQL> 
SQL> 
SQL> -- Let's use Cursor
SQL> 
SQL> create or replace procedure p1(a number)
  2  is
  3  	curesor c1 is
  4  		select *
  5  		from emp
  6  		where deptno = a
  7  		order by sal desc;
  8  	r c1%rowtype;
  9  begin
 10  	open c1;
 11  
 12  	loop
 13  		fetch c1 into r;
 14  
 15  		exit when c1%notfound or c1%rowcound > 3;
 16  
 17  		dbms_output.put_line(r.empno || ' ' || r.ename || ' ' || r.sal);
 18  	end loop;
 19  
 20  	close c1;
 21  end;
 22  /

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
3/13     PLS-00103: Encountered the symbol "IS" when expecting one of the                                                                                                                               
         following:                                                                                                                                                                                     
         := . ( @ % ; not null range default character                                                                                                                                                  
                                                                                                                                                                                                        
21/4     PLS-00103: Encountered the symbol "end-of-file" when expecting                                                                                                                                 
         one of the following:                                                                                                                                                                          
         end not pragma final instantiable order overriding static                                                                                                                                      
         member constructor map                                                                                                                                                                         
                                                                                                                                                                                                        
SQL> l 3
  3* 	curesor c1 is
SQL> c/curesor/cursor
  3* 	cursor c1 is
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3  	cursor c1 is
  4  		select *
  5  		from emp
  6  		where deptno = a
  7  		order by sal desc;
  8  	r c1%rowtype;
  9  begin
 10  	open c1;
 11  
 12  	loop
 13  		fetch c1 into r;
 14  
 15  		exit when c1%notfound or c1%rowcound > 3;
 16  
 17  		dbms_output.put_line(r.empno || ' ' || r.ename || ' ' || r.sal);
 18  	end loop;
 19  
 20  	close c1;
 21* end;

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
15/3     PL/SQL: Statement ignored                                                                                                                                                                      
15/31    PLS-00208: identifier 'ROWCOUND' is not a legal cursor attribute                                                                                                                               
SQL> l 15
 15* 		exit when c1%notfound or c1%rowcound > 3;
SQL> c/cound/count
 15* 		exit when c1%notfound or c1%rowcount > 3;
SQL> r
  1  create or replace procedure p1(a number)
  2  is
  3  	cursor c1 is
  4  		select *
  5  		from emp
  6  		where deptno = a
  7  		order by sal desc;
  8  	r c1%rowtype;
  9  begin
 10  	open c1;
 11  
 12  	loop
 13  		fetch c1 into r;
 14  
 15  		exit when c1%notfound or c1%rowcount > 3;
 16  
 17  		dbms_output.put_line(r.empno || ' ' || r.ename || ' ' || r.sal);
 18  	end loop;
 19  
 20  	close c1;
 21* end;

Procedure created.

SQL> exec p1(10);
7839 KING 5000                                                                                                                                                                                          
7782 CLARK 2450                                                                                                                                                                                         
7934 MILLER 1300                                                                                                                                                                                        

PL/SQL procedure successfully completed.

SQL> create or replace procedure p1(a number)
  2  is
  3  	cursor c1 is
  4  		select *
  5  		from emp
  6  		where deptno = a
  7  		order by sal desc;
  8  begin
  9  	for r in c1 loop
 10  		exit when c1%notfound or c1%rowcount > 3;
 11  		dbms_output.put_line(r.empno || ' ' || r.ename || ' ' || r.sal);
 12  	end loop;
 13  end;
 14  /

Procedure created.

SQL> exec p1(10)
7839 KING 5000                                                                                                                                                                                          
7782 CLARK 2450                                                                                                                                                                                         
7934 MILLER 1300                                                                                                                                                                                        

PL/SQL procedure successfully completed.

SQL> create or replace procedure p1
  2  is
  3  	cursor c1(dno number) is
  4  		select *
  5  		from emp
  6  		where deptno = dno
  7  		order by sal desc;
  8  begin
  9  	for d in (select deptno from dept order by deptno) loop
 10  		dbms_output.put_line(d.deptno || '번 부서');
 11  
 12  		for r in c1(d.deptno) loop
 13  			dbms_output.put_line(r.empno || ' ' || r.ename || ' ' || r.sal);
 14  
 15  		end loop;
 16  		dbms_output.put_line('---------------------');
 17  end;
 18  /

Warning: Procedure created with compilation errors.

SQL> show errors;
Errors for PROCEDURE P1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
17/4     PLS-00103: Encountered the symbol ";" when expecting one of the                                                                                                                                
         following:                                                                                                                                                                                     
         loop                                                                                                                                                                                           
                                                                                                                                                                                                        
SQL> l 16
 16* 		dbms_output.put_line('---------------------');
SQL> i end loop;
SQL> r
  1  create or replace procedure p1
  2  is
  3  	cursor c1(dno number) is
  4  		select *
  5  		from emp
  6  		where deptno = dno
  7  		order by sal desc;
  8  begin
  9  	for d in (select deptno from dept order by deptno) loop
 10  		dbms_output.put_line(d.deptno || '번 부서');
 11  
 12  		for r in c1(d.deptno) loop
 13  			dbms_output.put_line(r.empno || ' ' || r.ename || ' ' || r.sal);
 14  
 15  		end loop;
 16  		dbms_output.put_line('---------------------');
 17  end loop
 18* end;

Warning: Procedure created with compilation errors.

SQL> create or replace procedure p1
  2  is
  3     cursor c1(dno number) is
  4             select *
  5             from emp
  6             where deptno = dno
  7             order by sal desc;
  8  begin
  9     for d in (select deptno from dept order by deptno) loop
 10             dbms_output.put_line(d.deptno || '번 부서');
 11  
 12             for r in c1(d.deptno) loop
 13                     dbms_output.put_line(r.empno || ' ' || r.ename || ' ' || r.sal);
 14  
 15             end loop;
 16             dbms_output.put_line('---------------------');
 17  	end loop;
 18  end;
 19  /

Procedure created.

SQL> exec p1
10번 부서                                                                                                                                                                                               
7839 KING 5000                                                                                                                                                                                          
7782 CLARK 2450                                                                                                                                                                                         
7934 MILLER 1300                                                                                                                                                                                        
---------------------                                                                                                                                                                                   
20번 부서                                                                                                                                                                                               
7788 SCOTT 3000                                                                                                                                                                                         
7902 FORD 3000                                                                                                                                                                                          
7566 JONES 2975                                                                                                                                                                                         
7876 ADAMS 1100                                                                                                                                                                                         
7369 SMITH 800                                                                                                                                                                                          
---------------------                                                                                                                                                                                   
30번 부서                                                                                                                                                                                               
7698 BLAKE 2850                                                                                                                                                                                         
7499 ALLEN 1600                                                                                                                                                                                         
7844 TURNER 1500                                                                                                                                                                                        
7521 WARD 1250                                                                                                                                                                                          
7654 MARTIN 1250                                                                                                                                                                                        
7900 JAMES 950                                                                                                                                                                                          
---------------------                                                                                                                                                                                   
40번 부서                                                                                                                                                                                               
---------------------                                                                                                                                                                                   

PL/SQL procedure successfully completed.

SQL> 
SQL> 
SQL> -- use subquery instead of cursor
SQL> 
SQL> begin
  2  	for emp_record in (select employee_id, last_name from employees where department_id = 30)
  3  	loop
  4  		dbms_output.put_line(emp_record.employee_id || ' ' || emp_record.last_name);
  5  	end loop;
  6  end;
  7  /

PL/SQL procedure successfully completed.

SQL> set serveroutput on
SQL> r
  1  begin
  2  	for emp_record in (select employee_id, last_name from employees where department_id = 30)
  3  	loop
  4  		dbms_output.put_line(emp_record.employee_id || ' ' || emp_record.last_name);
  5  	end loop;
  6* end;

PL/SQL procedure successfully completed.

SQL> select employee_id, last_name from employees where department_id = 30;

no rows selected

SQL> select employee_id, last_name from employees where department_id = 40;

no rows selected

SQL> select *
  2  from employees;

EMPLOYEE_ID FIRST_NAME                               LAST_NAME                                          EMAIL                                              PHONE_NUMBER                                 
----------- ---------------------------------------- -------------------------------------------------- -------------------------------------------------- ----------------------------------------     
HIRE_DATE    JOB_ID                   SALARY COMMISSION_PCT MANAGER_ID DEPARTMENT_ID                                                                                                                    
------------ -------------------- ---------- -------------- ---------- -------------                                                                                                                    
        100 Steven                                   King                                               SKING                                              515.123.4567                                 
17-JUN-87    AD_PRES                   24000                                      90                                                                                                                    
                                                                                                                                                                                                        
        101 Neena                                    Kochhar                                            NKOCHHAR                                           515.123.4568                                 
21-SEP-89    AD_VP                     17000                       100            90                                                                                                                    
                                                                                                                                                                                                        
        102 Lex                                      De Haan                                            LDEHAAN                                            515.123.4569                                 
13-JAN-93    AD_VP                     17000                       100            90                                                                                                                    
                                                                                                                                                                                                        
        103 Alexander                                Hunold                                             AHUNOLD                                            590.423.4567                                 
03-JAN-90    IT_PROG                    9000                       102            60                                                                                                                    
                                                                                                                                                                                                        
        104 Bruce                                    Ernst                                              BERNST                                             590.423.4568                                 
21-MAY-91    IT_PROG                    6000                       103            60                                                                                                                    
                                                                                                                                                                                                        
        107 Diana                                    Lorentz                                            DLORENTZ                                           590.423.5567                                 
07-FEB-99    IT_PROG                    4200                       103            60                                                                                                                    
                                                                                                                                                                                                        
        124 Kevin                                    Mourgos                                            KMOURGOS                                           650.123.5234                                 
16-NOV-99    ST_MAN                     5800                       100            50                                                                                                                    
                                                                                                                                                                                                        
        141 Trenna                                   Rajs                                               TRAJS                                              650.121.8009                                 
17-OCT-95    ST_CLERK                   3500                       124            50                                                                                                                    
                                                                                                                                                                                                        
        142 Curtis                                   Davies                                             CDAVIES                                            650.121.2994                                 
29-JAN-97    ST_CLERK                   3100                       124            50                                                                                                                    
                                                                                                                                                                                                        
        143 Randall                                  Matos                                              RMATOS                                             650.121.2874                                 
15-MAR-98    ST_CLERK                   2600                       124            50                                                                                                                    
                                                                                                                                                                                                        
        144 Peter                                    Vargas                                             PVARGAS                                            650.121.2004                                 
09-JUL-98    ST_CLERK                   2500                       124            50                                                                                                                    
                                                                                                                                                                                                        
        149 Eleni                                    Zlotkey                                            EZLOTKEY                                           011.44.1344.429018                           
29-JAN-00    SA_MAN                    10500             .2        100            80                                                                                                                    
                                                                                                                                                                                                        
        174 Ellen                                    Abel                                               EABEL                                              011.44.1644.429267                           
11-MAY-96    SA_REP                    11000             .3        149            80                                                                                                                    
                                                                                                                                                                                                        
        176 Jonathon                                 Taylor                                             JTAYLOR                                            011.44.1644.429265                           
24-MAR-98    SA_REP                     8600             .2        149            80                                                                                                                    
                                                                                                                                                                                                        
        178 Kimberely                                Grant                                              KGRANT                                             011.44.1644.429263                           
24-MAY-99    SA_REP                     7000            .15        149                                                                                                                                  
                                                                                                                                                                                                        
        200 Jennifer                                 Whalen                                             JWHALEN                                            515.123.4444                                 
17-SEP-87    AD_ASST                    4400                       101            10                                                                                                                    
                                                                                                                                                                                                        
        201 Michael                                  Hartstein                                          MHARTSTE                                           515.123.5555                                 
17-FEB-96    MK_MAN                    13000                       100            20                                                                                                                    
                                                                                                                                                                                                        
        202 Pat                                      Fay                                                PFAY                                               603.123.6666                                 
17-AUG-97    MK_REP                     6000                       201            20                                                                                                                    
                                                                                                                                                                                                        
        205 Shelley                                  Higgins                                            SHIGGINS                                           515.123.8080                                 
07-JUN-94    AC_MGR                    12000                       101           110                                                                                                                    
                                                                                                                                                                                                        
        206 William                                  Gietz                                              WGIETZ                                             515.123.8181                                 
07-JUN-94    AC_ACCOUNT                 8300                       205           110                                                                                                                    
                                                                                                                                                                                                        

20 rows selected.

SQL> begin
  2     for emp_record in (select employee_id, last_name from employees where department_id = 30)
  3     loop
  4             dbms_output.put_line(emp_record.employee_id || ' ' || emp_record.last_name);
  5     end loop;
  6  end;
  7  /

PL/SQL procedure successfully completed.

SQL> l 2
  2*    for emp_record in (select employee_id, last_name from employees where department_id = 30)
SQL> c/30/90
  2*    for emp_record in (select employee_id, last_name from employees where department_id = 90)
SQL> r
  1  begin
  2     for emp_record in (select employee_id, last_name from employees where department_id = 90)
  3     loop
  4             dbms_output.put_line(emp_record.employee_id || ' ' || emp_record.last_name);
  5     end loop;
  6* end;
100 King                                                                                                                                                                                                
101 Kochhar                                                                                                                                                                                             
102 De Haan                                                                                                                                                                                             

PL/SQL procedure successfully completed.

SQL> create or replace procedure p1(a number, b number)
  2  is
  3         cursor c1 is
  4              select first_name, salary, department_id
  5              from employees
  6              where department_id in (a, b)
  7              for update of salary;
  8      c c1%rowtype;
  9   begin
 10      open c1;
 11  
 12      loop
 13              fetch c1 into c;
 14  
 15         update employees
 16         set salary = salary * 1.2
 17         where current of c1;
 18  
 19      end loop;
 20      close c1;
 21   end;
 22  /

Procedure created.

SQL> exec p1(70, 90);
BEGIN p1(70, 90); END;

*
ERROR at line 1:
ORA-01410: invalid ROWID
ORA-06512: at "ACE24.P1", line 15
ORA-06512: at line 1 


SQL> select rowid, first_name ,salary, department_id
  2  from employees
  3  where department_id in (70, 90);

ROWID              FIRST_NAME                                   SALARY DEPARTMENT_ID                                                                                                                    
------------------ ---------------------------------------- ---------- -------------                                                                                                                    
AAAE7aAAEAAAAQTAAA Steven                                        24000            90                                                                                                                    
AAAE7aAAEAAAAQTAAB Neena                                         17000            90                                                                                                                    
AAAE7aAAEAAAAQTAAC Lex                                           17000            90                                                                                                                    

SQL> create or replace procedure p1(a number, b number)
  2  is
  3         cursor c1 is
  4              select first_name, salary, department_id
  5              from employees
  6              where department_id in (a, b)
  7              for update of salary;
  8      c c1%rowtype;
  9   begin
 10  
 11      open c1;
 12  
 13      fetch c1 into c;
 14      if sql%notfound then
 15  	dbms_output.put_line('No rows have been found');
 16      else
 17  
 18         update employees
 19         set salary = salary * 1.2
 20         where current of c1;
 21      end if;
 22  
 23   end;
 24  /

Procedure created.

SQL> exec p1(70, 90);

PL/SQL procedure successfully completed.

SQL> select salary, first_name, department_id
  2  from employees
  3  where department_id = 90;

    SALARY FIRST_NAME                               DEPARTMENT_ID                                                                                                                                       
---------- ---------------------------------------- -------------                                                                                                                                       
     28800 Steven                                              90                                                                                                                                       
     17000 Neena                                               90                                                                                                                                       
     17000 Lex                                                 90                                                                                                                                       

SQL> rollback;

Rollback complete.

SQL> r
  1* rollback

Rollback complete.

SQL> select salary, first_name, department_id
  2  from employees
  3  where department_id = 90;

    SALARY FIRST_NAME                               DEPARTMENT_ID                                                                                                                                       
---------- ---------------------------------------- -------------                                                                                                                                       
     24000 Steven                                              90                                                                                                                                       
     17000 Neena                                               90                                                                                                                                       
     17000 Lex                                                 90                                                                                                                                       

SQL> spool off
