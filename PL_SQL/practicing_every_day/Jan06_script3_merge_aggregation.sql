SQL> /* Merge Test */
SQL> select *
  2  from copy_emp;
from copy_emp
     *
ERROR at line 2:
ORA-00942: table or view does not exist 


SQL> begin
  2  MERGE INTO copy_emp c
  3  USING employees e
  4  on (e.employee_id = c.empno)
  5  	WHEN MATCHED THEN
  6  		UPDATE SET
  7  			c.first_name = e.first_name,
  8  			c.last_name = e.last_name,
  9  			c.email = e.email;
 10  	WHEN NOT MATCHED THEN
 11  		dbms_output.put_line('No Matching condition');
 12  end;
 13  /
	WHEN NOT MATCHED THEN
	*
ERROR at line 10:
ORA-06550: line 10, column 2:
PLS-00103: Encountered the symbol "WHEN" when expecting one of the following: 
( begin case declare end exception exit for goto if loop mod 
null pragma raise return select update while with 
<an identifier> <a double-quoted delimited-identifier> 
<a bind variable> << continue close current delete fetch lock 
insert open rollback savepoint set sql execute commit forall 
merge pipe purge
The symbol "case" was substituted for "WHEN" to continue.
ORA-06550: line 12, column 4:
PLS-00103: Encountered the symbol ";" when expecting one of the following: 
case 


SQL> create table as select * from employees where rownum <= 3;
create table as select * from employees where rownum <= 3
             *
ERROR at line 1:
ORA-00903: invalid table name 


SQL> create table copy_emp as select * from employees where rownum <= 3;

Table created.

SQL> begin
  2  MERGE INTO copy_emp c
  3  USING employees e
  4  on (e.employee_id = c.empno)
  5     WHEN MATCHED THEN
  6             UPDATE SET
  7                     c.first_name = e.first_name,
  8                     c.last_name = e.last_name,
  9                     c.email = e.email;
 10     WHEN NOT MATCHED THEN
 11             dbms_output.put_line('No Matching condition');
 12  end;
 13  /
   WHEN NOT MATCHED THEN
   *
ERROR at line 10:
ORA-06550: line 10, column 4:
PLS-00103: Encountered the symbol "WHEN" when expecting one of the following: 
( begin case declare end exception exit for goto if loop mod 
null pragma raise return select update while with 
<an identifier> <a double-quoted delimited-identifier> 
<a bind variable> << continue close current delete fetch lock 
insert open rollback savepoint set sql execute commit forall 
merge pipe purge
The symbol "case" was substituted for "WHEN" to continue.
ORA-06550: line 12, column 4:
PLS-00103: Encountered the symbol ";" when expecting one of the following: 
case 


SQL> show errors;
No errors.
SQL> begin
  2  MERGE INTO copy_emp c
  3  USING employees e
  4  on (e.employee_id = c.empno)
  5     WHEN MATCHED THEN
  6             UPDATE SET
  7                     c.first_name = e.first_name,
  8                     c.last_name = e.last_name,
  9                     c.email = e.email
 10  	WHEN NOT MATCHED THEN
 11  		           dbms_output.put_line('No Matching condition');
 12  end;
 13  /
		           dbms_output.put_line('No Matching condition');
		           *
ERROR at line 11:
ORA-06550: line 11, column 14:
PL/SQL: ORA-00905: missing keyword
ORA-06550: line 2, column 1:
PL/SQL: SQL Statement ignored 


SQL> begin
  2  MERGE INTO copy_emp c
  3  	USING employees e
  4  	on (e.employee_id = c.empno)
  5  	WHEN MATCHED THEN
  6  		UPDATE SET
  7  			c.first_name    = e.first_name;
  8  			c.last_name     = e.last_name;
  9  /
			c.last_name     = e.last_name;
			                *
ERROR at line 8:
ORA-06550: line 8, column 20:
PLS-00103: Encountered the symbol "=" when expecting one of the following: 
:= . ( @ % ; 


SQL>  begin
  2   MERGE INTO copy_emp c
  3      USING employees e
  4      on (e.employee_id = c.empno)
  5      WHEN MATCHED THEN
  6              UPDATE SET
  7                      c.first_name    = e.first_name,
  8  			 c.last_name     = e.last_name,
  9  			 c.email         = e.email,
 10  			 c.phone_number  = e.phone_number,
 11  			 c.hire_date     = e.hire_date,
 12  			 c.job_id        = e.job_id,
 13  			 c.salary        = e.salary,
 14  			 c.commission_pct= e.comission_pct,
 15  			 c.manager_id    = e.manager_id,
 16  			 c.department_id = e.department_id
 17  	WHEN NOT MATCHED THEN
 18  		INSERT VALUES (e.employee_id, e.first_name, e.last_name, e.email, e.phone_number, e.hire_date,
 19  				e.job_id, e.salary, e.commission_pct, e.manager_id, e.department_id);
 20  end;
 21  /
    on (e.employee_id = c.empno)
                        *
ERROR at line 4:
ORA-06550: line 4, column 25:
PL/SQL: ORA-00904: "C"."EMPNO": invalid identifier
ORA-06550: line 2, column 2:
PL/SQL: SQL Statement ignored 


SQL> l 4
  4*     on (e.employee_id = c.empno)
SQL> c/c.empno/c.employee_id
  4*     on (e.employee_id = c.employee_id)
SQL> r
  1   begin
  2   MERGE INTO copy_emp c
  3      USING employees e
  4      on (e.employee_id = c.employee_id)
  5      WHEN MATCHED THEN
  6              UPDATE SET
  7                      c.first_name    = e.first_name,
  8  			 c.last_name     = e.last_name,
  9  			 c.email         = e.email,
 10  			 c.phone_number  = e.phone_number,
 11  			 c.hire_date     = e.hire_date,
 12  			 c.job_id        = e.job_id,
 13  			 c.salary        = e.salary,
 14  			 c.commission_pct= e.comission_pct,
 15  			 c.manager_id    = e.manager_id,
 16  			 c.department_id = e.department_id
 17  	WHEN NOT MATCHED THEN
 18  		INSERT VALUES (e.employee_id, e.first_name, e.last_name, e.email, e.phone_number, e.hire_date,
 19  				e.job_id, e.salary, e.commission_pct, e.manager_id, e.department_id);
 20* end;
			 c.commission_pct= e.comission_pct,
			                   *
ERROR at line 14:
ORA-06550: line 14, column 23:
PL/SQL: ORA-00904: "E"."COMISSION_PCT": invalid identifier
ORA-06550: line 2, column 2:
PL/SQL: SQL Statement ignored 


SQL> l 14
 14* 			 c.commission_pct= e.comission_pct,
SQL> c/e.comi/e.commi
 14* 			 c.commission_pct= e.commission_pct,
SQL> r
  1   begin
  2   MERGE INTO copy_emp c
  3      USING employees e
  4      on (e.employee_id = c.employee_id)
  5      WHEN MATCHED THEN
  6              UPDATE SET
  7                      c.first_name    = e.first_name,
  8  			 c.last_name     = e.last_name,
  9  			 c.email         = e.email,
 10  			 c.phone_number  = e.phone_number,
 11  			 c.hire_date     = e.hire_date,
 12  			 c.job_id        = e.job_id,
 13  			 c.salary        = e.salary,
 14  			 c.commission_pct= e.commission_pct,
 15  			 c.manager_id    = e.manager_id,
 16  			 c.department_id = e.department_id
 17  	WHEN NOT MATCHED THEN
 18  		INSERT VALUES (e.employee_id, e.first_name, e.last_name, e.email, e.phone_number, e.hire_date,
 19  				e.job_id, e.salary, e.commission_pct, e.manager_id, e.department_id);
 20* end;

PL/SQL procedure successfully completed.

SQL> select *
  2  from copy_emp;

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
                                                                                                                                                                                                        
        144 Peter                                    Vargas                                             PVARGAS                                            650.121.2004                                 
09-JUL-98    ST_CLERK                   2500                       124            50                                                                                                                    
                                                                                                                                                                                                        
        143 Randall                                  Matos                                              RMATOS                                             650.121.2874                                 
15-MAR-98    ST_CLERK                   2600                       124            50                                                                                                                    
                                                                                                                                                                                                        
        202 Pat                                      Fay                                                PFAY                                               603.123.6666                                 
17-AUG-97    MK_REP                     6000                       201            20                                                                                                                    
                                                                                                                                                                                                        
        141 Trenna                                   Rajs                                               TRAJS                                              650.121.8009                                 
17-OCT-95    ST_CLERK                   3500                       124            50                                                                                                                    
                                                                                                                                                                                                        
        174 Ellen                                    Abel                                               EABEL                                              011.44.1644.429267                           
11-MAY-96    SA_REP                    11000             .3        149            80                                                                                                                    
                                                                                                                                                                                                        
        103 Alexander                                Hunold                                             AHUNOLD                                            590.423.4567                                 
03-JAN-90    IT_PROG                    9000                       102            60                                                                                                                    
                                                                                                                                                                                                        
        201 Michael                                  Hartstein                                          MHARTSTE                                           515.123.5555                                 
17-FEB-96    MK_MAN                    13000                       100            20                                                                                                                    
                                                                                                                                                                                                        
        104 Bruce                                    Ernst                                              BERNST                                             590.423.4568                                 
21-MAY-91    IT_PROG                    6000                       103            60                                                                                                                    
                                                                                                                                                                                                        
        200 Jennifer                                 Whalen                                             JWHALEN                                            515.123.4444                                 
17-SEP-87    AD_ASST                    4400                       101            10                                                                                                                    
                                                                                                                                                                                                        
        107 Diana                                    Lorentz                                            DLORENTZ                                           590.423.5567                                 
07-FEB-99    IT_PROG                    4200                       103            60                                                                                                                    
                                                                                                                                                                                                        
        142 Curtis                                   Davies                                             CDAVIES                                            650.121.2994                                 
29-JAN-97    ST_CLERK                   3100                       124            50                                                                                                                    
                                                                                                                                                                                                        
        149 Eleni                                    Zlotkey                                            EZLOTKEY                                           011.44.1344.429018                           
29-JAN-00    SA_MAN                    10500             .2        100            80                                                                                                                    
                                                                                                                                                                                                        
        206 William                                  Gietz                                              WGIETZ                                             515.123.8181                                 
07-JUN-94    AC_ACCOUNT                 8300                       205           110                                                                                                                    
                                                                                                                                                                                                        
        176 Jonathon                                 Taylor                                             JTAYLOR                                            011.44.1644.429265                           
24-MAR-98    SA_REP                     8600             .2        149            80                                                                                                                    
                                                                                                                                                                                                        
        124 Kevin                                    Mourgos                                            KMOURGOS                                           650.123.5234                                 
16-NOV-99    ST_MAN                     5800                       100            50                                                                                                                    
                                                                                                                                                                                                        
        205 Shelley                                  Higgins                                            SHIGGINS                                           515.123.8080                                 
07-JUN-94    AC_MGR                    12000                       101           110                                                                                                                    
                                                                                                                                                                                                        
        178 Kimberely                                Grant                                              KGRANT                                             011.44.1644.429263                           
24-MAY-99    SA_REP                     7000            .15        149                                                                                                                                  
                                                                                                                                                                                                        

20 rows selected.

SQL> 
SQL> 
SQL> 
SQL> 
SQL> /* SQL for Aggregation in Data Warehouse*/
SQL> 
SQL> /*roll up*/

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
                                                                                                                                                                                                        
        144 Peter                                    Vargas                                             PVARGAS                                            650.121.2004                                 
09-JUL-98    ST_CLERK                   2500                       124            50                                                                                                                    
                                                                                                                                                                                                        
        143 Randall                                  Matos                                              RMATOS                                             650.121.2874                                 
15-MAR-98    ST_CLERK                   2600                       124            50                                                                                                                    
                                                                                                                                                                                                        
        202 Pat                                      Fay                                                PFAY                                               603.123.6666                                 
17-AUG-97    MK_REP                     6000                       201            20                                                                                                                    
                                                                                                                                                                                                        
        141 Trenna                                   Rajs                                               TRAJS                                              650.121.8009                                 
17-OCT-95    ST_CLERK                   3500                       124            50                                                                                                                    
                                                                                                                                                                                                        
        174 Ellen                                    Abel                                               EABEL                                              011.44.1644.429267                           
11-MAY-96    SA_REP                    11000             .3        149            80                                                                                                                    
                                                                                                                                                                                                        
        103 Alexander                                Hunold                                             AHUNOLD                                            590.423.4567                                 
03-JAN-90    IT_PROG                    9000                       102            60                                                                                                                    
                                                                                                                                                                                                        
        201 Michael                                  Hartstein                                          MHARTSTE                                           515.123.5555                                 
17-FEB-96    MK_MAN                    13000                       100            20                                                                                                                    
                                                                                                                                                                                                        
        104 Bruce                                    Ernst                                              BERNST                                             590.423.4568                                 
21-MAY-91    IT_PROG                    6000                       103            60                                                                                                                    
                                                                                                                                                                                                        
        200 Jennifer                                 Whalen                                             JWHALEN                                            515.123.4444                                 
17-SEP-87    AD_ASST                    4400                       101            10                                                                                                                    
                                                                                                                                                                                                        
        107 Diana                                    Lorentz                                            DLORENTZ                                           590.423.5567                                 
07-FEB-99    IT_PROG                    4200                       103            60                                                                                                                    
                                                                                                                                                                                                        
        142 Curtis                                   Davies                                             CDAVIES                                            650.121.2994                                 
29-JAN-97    ST_CLERK                   3100                       124            50                                                                                                                    
                                                                                                                                                                                                        
        149 Eleni                                    Zlotkey                                            EZLOTKEY                                           011.44.1344.429018                           
29-JAN-00    SA_MAN                    10500             .2        100            80                                                                                                                    
                                                                                                                                                                                                        
        206 William                                  Gietz                                              WGIETZ                                             515.123.8181                                 
07-JUN-94    AC_ACCOUNT                 8300                       205           110                                                                                                                    
                                                                                                                                                                                                        
        176 Jonathon                                 Taylor                                             JTAYLOR                                            011.44.1644.429265                           
24-MAR-98    SA_REP                     8600             .2        149            80                                                                                                                    
                                                                                                                                                                                                        
        124 Kevin                                    Mourgos                                            KMOURGOS                                           650.123.5234                                 
16-NOV-99    ST_MAN                     5800                       100            50                                                                                                                    
                                                                                                                                                                                                        
        205 Shelley                                  Higgins                                            SHIGGINS                                           515.123.8080                                 
07-JUN-94    AC_MGR                    12000                       101           110                                                                                                                    
                                                                                                                                                                                                        
        178 Kimberely                                Grant                                              KGRANT                                             011.44.1644.429263                           
24-MAY-99    SA_REP                     7000            .15        149                                                                                                                                  
                                                                                                                                                                                                        

20 rows selected.

SQL> 
SQL> 
SQL> select deptno, job, sum(sal)
  2  from emp
  3  group by deptno, job;

    DEPTNO JOB                  SUM(SAL)                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
        20 CLERK                    1900                                                                                                                                                                
        30 SALESMAN                 5600                                                                                                                                                                
        20 MANAGER                  2975                                                                                                                                                                
        30 CLERK                     950                                                                                                                                                                
        10 PRESIDENT                5000                                                                                                                                                                
        30 MANAGER                  2850                                                                                                                                                                
        10 CLERK                    1300                                                                                                                                                                
        10 MANAGER                  2450                                                                                                                                                                
        20 ANALYST                  6000                                                                                                                                                                

9 rows selected.

SQL> select deptno, job, sum(sal)
  2  from emp
  3  group by rollup(deptno, job);

    DEPTNO JOB                  SUM(SAL)                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
        10 CLERK                    1300                                                                                                                                                                
        10 MANAGER                  2450                                                                                                                                                                
        10 PRESIDENT                5000                                                                                                                                                                
        10                          8750                                                                                                                                                                
        20 CLERK                    1900                                                                                                                                                                
        20 ANALYST                  6000                                                                                                                                                                
        20 MANAGER                  2975                                                                                                                                                                
        20                         10875                                                                                                                                                                
        30 CLERK                     950                                                                                                                                                                
        30 MANAGER                  2850                                                                                                                                                                
        30 SALESMAN                 5600                                                                                                                                                                
        30                          9400                                                                                                                                                                
                                   29025                                                                                                                                                                

13 rows selected.

SQL> select deptno, job, sum(sal)
  2  from emp
  3  group by GROUPING SETS((deptno,job),(deptno),());

    DEPTNO JOB                  SUM(SAL)                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
        10 CLERK                    1300                                                                                                                                                                
        10 MANAGER                  2450                                                                                                                                                                
        10 PRESIDENT                5000                                                                                                                                                                
        10                          8750                                                                                                                                                                
        20 CLERK                    1900                                                                                                                                                                
        20 ANALYST                  6000                                                                                                                                                                
        20 MANAGER                  2975                                                                                                                                                                
        20                         10875                                                                                                                                                                
        30 CLERK                     950                                                                                                                                                                
        30 MANAGER                  2850                                                                                                                                                                
        30 SALESMAN                 5600                                                                                                                                                                
        30                          9400                                                                                                                                                                
                                   29025                                                                                                                                                                

13 rows selected.

SQL> select deptno, decode(deptno, null, 'TOTAL', decode(job, null, 'DEPT_SUM', job)) as job, sum(sal)
  2  from emp
  3  group by rollup(deptno,job);

    DEPTNO JOB                  SUM(SAL)                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
        10 CLERK                    1300                                                                                                                                                                
        10 MANAGER                  2450                                                                                                                                                                
        10 PRESIDENT                5000                                                                                                                                                                
        10 DEPT_SUM                 8750                                                                                                                                                                
        20 CLERK                    1900                                                                                                                                                                
        20 ANALYST                  6000                                                                                                                                                                
        20 MANAGER                  2975                                                                                                                                                                
        20 DEPT_SUM                10875                                                                                                                                                                
        30 CLERK                     950                                                                                                                                                                
        30 MANAGER                  2850                                                                                                                                                                
        30 SALESMAN                 5600                                                                                                                                                                
        30 DEPT_SUM                 9400                                                                                                                                                                
           TOTAL                   29025                                                                                                                                                                

13 rows selected.

SQL> 
SQL> 
SQL> select deptno, job, sum(sal)
  2  from emp
  3  group by CUBE(deptno, job);

    DEPTNO JOB                  SUM(SAL)                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
                                   29025                                                                                                                                                                
           CLERK                    4150                                                                                                                                                                
           ANALYST                  6000                                                                                                                                                                
           MANAGER                  8275                                                                                                                                                                
           SALESMAN                 5600                                                                                                                                                                
           PRESIDENT                5000                                                                                                                                                                
        10                          8750                                                                                                                                                                
        10 CLERK                    1300                                                                                                                                                                
        10 MANAGER                  2450                                                                                                                                                                
        10 PRESIDENT                5000                                                                                                                                                                
        20                         10875                                                                                                                                                                
        20 CLERK                    1900                                                                                                                                                                
        20 ANALYST                  6000                                                                                                                                                                
        20 MANAGER                  2975                                                                                                                                                                
        30                          9400                                                                                                                                                                
        30 CLERK                     950                                                                                                                                                                
        30 MANAGER                  2850                                                                                                                                                                
        30 SALESMAN                 5600                                                                                                                                                                

18 rows selected.

SQL> select deptno, job, sum(sal)
  2  from emp
  3  group by GROUPING SETS((deptno, job), (deptno), (job), ());

    DEPTNO JOB                  SUM(SAL)                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
        10 CLERK                    1300                                                                                                                                                                
        20 CLERK                    1900                                                                                                                                                                
        30 CLERK                     950                                                                                                                                                                
        20 ANALYST                  6000                                                                                                                                                                
        10 MANAGER                  2450                                                                                                                                                                
        20 MANAGER                  2975                                                                                                                                                                
        30 MANAGER                  2850                                                                                                                                                                
        30 SALESMAN                 5600                                                                                                                                                                
        10 PRESIDENT                5000                                                                                                                                                                
           CLERK                    4150                                                                                                                                                                
           ANALYST                  6000                                                                                                                                                                
           MANAGER                  8275                                                                                                                                                                
           SALESMAN                 5600                                                                                                                                                                
           PRESIDENT                5000                                                                                                                                                                
        10                          8750                                                                                                                                                                
        20                         10875                                                                                                                                                                
        30                          9400                                                                                                                                                                
                                   29025                                                                                                                                                                

18 rows selected.

SQL> drop table t2 purge;

Table dropped.

SQL> create table t2
  2  as
  3  select empno, ename, sal, job, deptno, decode(mod(empno, 2), 0 ,'M', 'W') as gender
  4  from emp e
  5  union all
  6  select empno, ename, sal+100, job, deptno, decode(mod(empno, 2), 0 'W', 'M') as gender
  7  from emp e;
select empno, ename, sal+100, job, deptno, decode(mod(empno, 2), 0 'W', 'M') as gender
                                                                   *
ERROR at line 6:
ORA-00907: missing right parenthesis 


SQL> l 6
  6* select empno, ename, sal+100, job, deptno, decode(mod(empno, 2), 0 'W', 'M') as gender
SQL> c/0 'W'/0, 'W'
  6* select empno, ename, sal+100, job, deptno, decode(mod(empno, 2), 0, 'W', 'M') as gender
SQL> r
  1  create table t2
  2  as
  3  select empno, ename, sal, job, deptno, decode(mod(empno, 2), 0 ,'M', 'W') as gender
  4  from emp e
  5  union all
  6  select empno, ename, sal+100, job, deptno, decode(mod(empno, 2), 0, 'W', 'M') as gender
  7* from emp e

Table created.

SQL> select *
  2  from emp2;
from emp2
     *
ERROR at line 2:
ORA-00942: table or view does not exist 


SQL> select *
  2  from t2;

     EMPNO ENAME                       SAL JOB                    DEPTNO GE                                                                                                                             
---------- -------------------- ---------- ------------------ ---------- --                                                                                                                             
      7369 SMITH                       800 CLERK                      20 W                                                                                                                              
      7499 ALLEN                      1600 SALESMAN                   30 W                                                                                                                              
      7521 WARD                       1250 SALESMAN                   30 W                                                                                                                              
      7566 JONES                      2975 MANAGER                    20 M                                                                                                                              
      7654 MARTIN                     1250 SALESMAN                   30 M                                                                                                                              
      7698 BLAKE                      2850 MANAGER                    30 M                                                                                                                              
      7782 CLARK                      2450 MANAGER                    10 M                                                                                                                              
      7788 SCOTT                      3000 ANALYST                    20 M                                                                                                                              
      7839 KING                       5000 PRESIDENT                  10 W                                                                                                                              
      7844 TURNER                     1500 SALESMAN                   30 M                                                                                                                              
      7876 ADAMS                      1100 CLERK                      20 M                                                                                                                              
      7900 JAMES                       950 CLERK                      30 M                                                                                                                              
      7902 FORD                       3000 ANALYST                    20 M                                                                                                                              
      7934 MILLER                     1300 CLERK                      10 M                                                                                                                              
      7369 SMITH                       900 CLERK                      20 M                                                                                                                              
      7499 ALLEN                      1700 SALESMAN                   30 M                                                                                                                              
      7521 WARD                       1350 SALESMAN                   30 M                                                                                                                              
      7566 JONES                      3075 MANAGER                    20 W                                                                                                                              
      7654 MARTIN                     1350 SALESMAN                   30 W                                                                                                                              
      7698 BLAKE                      2950 MANAGER                    30 W                                                                                                                              
      7782 CLARK                      2550 MANAGER                    10 W                                                                                                                              
      7788 SCOTT                      3100 ANALYST                    20 W                                                                                                                              
      7839 KING                       5100 PRESIDENT                  10 M                                                                                                                              
      7844 TURNER                     1600 SALESMAN                   30 W                                                                                                                              
      7876 ADAMS                      1200 CLERK                      20 W                                                                                                                              
      7900 JAMES                      1050 CLERK                      30 W                                                                                                                              
      7902 FORD                       3100 ANALYST                    20 W                                                                                                                              
      7934 MILLER                     1400 CLERK                      10 W                                                                                                                              

28 rows selected.

SQL>  create table t2
  2   as
  3   select empno, ename, sal, job, deptno, decode(mod(empno, 2), 0 ,'M', 'W') as gender
  4   from emp e
  5   union all
  6   select empno, ename, sal+100, job, deptno, decode(mod(empno, 2), 0, 'W', 'M') as gender
  7   from emp e
  8   order by 1;
 create table t2
              *
ERROR at line 1:
ORA-00955: name is already used by an existing object 


SQL> select *
  2  from t2
  3  order by 1;

     EMPNO ENAME                       SAL JOB                    DEPTNO GE                                                                                                                             
---------- -------------------- ---------- ------------------ ---------- --                                                                                                                             
      7369 SMITH                       800 CLERK                      20 W                                                                                                                              
      7369 SMITH                       900 CLERK                      20 M                                                                                                                              
      7499 ALLEN                      1700 SALESMAN                   30 M                                                                                                                              
      7499 ALLEN                      1600 SALESMAN                   30 W                                                                                                                              
      7521 WARD                       1250 SALESMAN                   30 W                                                                                                                              
      7521 WARD                       1350 SALESMAN                   30 M                                                                                                                              
      7566 JONES                      3075 MANAGER                    20 W                                                                                                                              
      7566 JONES                      2975 MANAGER                    20 M                                                                                                                              
      7654 MARTIN                     1250 SALESMAN                   30 M                                                                                                                              
      7654 MARTIN                     1350 SALESMAN                   30 W                                                                                                                              
      7698 BLAKE                      2850 MANAGER                    30 M                                                                                                                              
      7698 BLAKE                      2950 MANAGER                    30 W                                                                                                                              
      7782 CLARK                      2450 MANAGER                    10 M                                                                                                                              
      7782 CLARK                      2550 MANAGER                    10 W                                                                                                                              
      7788 SCOTT                      3000 ANALYST                    20 M                                                                                                                              
      7788 SCOTT                      3100 ANALYST                    20 W                                                                                                                              
      7839 KING                       5000 PRESIDENT                  10 W                                                                                                                              
      7839 KING                       5100 PRESIDENT                  10 M                                                                                                                              
      7844 TURNER                     1500 SALESMAN                   30 M                                                                                                                              
      7844 TURNER                     1600 SALESMAN                   30 W                                                                                                                              
      7876 ADAMS                      1100 CLERK                      20 M                                                                                                                              
      7876 ADAMS                      1200 CLERK                      20 W                                                                                                                              
      7900 JAMES                       950 CLERK                      30 M                                                                                                                              
      7900 JAMES                      1050 CLERK                      30 W                                                                                                                              
      7902 FORD                       3000 ANALYST                    20 M                                                                                                                              
      7902 FORD                       3100 ANALYST                    20 W                                                                                                                              
      7934 MILLER                     1400 CLERK                      10 W                                                                                                                              
      7934 MILLER                     1300 CLERK                      10 M                                                                                                                              

28 rows selected.

SQL> select deptno, job, gender, sum(sal)
  2  from emp2
  3  group by rollup(deptno, job, gender)
  4  order by 1,2,3;
from emp2
     *
ERROR at line 2:
ORA-00942: table or view does not exist 


SQL> select deptno, job, gender, sum(sal)
  2  from t2
  3  group by rollup(deptno, job, gender)
  4  order by 1,2,3;

    DEPTNO JOB                GE   SUM(SAL)                                                                                                                                                             
---------- ------------------ -- ----------                                                                                                                                                             
        10 CLERK              M        1300                                                                                                                                                             
        10 CLERK              W        1400                                                                                                                                                             
        10 CLERK                       2700                                                                                                                                                             
        10 MANAGER            M        2450                                                                                                                                                             
        10 MANAGER            W        2550                                                                                                                                                             
        10 MANAGER                     5000                                                                                                                                                             
        10 PRESIDENT          M        5100                                                                                                                                                             
        10 PRESIDENT          W        5000                                                                                                                                                             
        10 PRESIDENT                  10100                                                                                                                                                             
        10                            17800                                                                                                                                                             
        20 ANALYST            M        6000                                                                                                                                                             
        20 ANALYST            W        6200                                                                                                                                                             
        20 ANALYST                    12200                                                                                                                                                             
        20 CLERK              M        2000                                                                                                                                                             
        20 CLERK              W        2000                                                                                                                                                             
        20 CLERK                       4000                                                                                                                                                             
        20 MANAGER            M        2975                                                                                                                                                             
        20 MANAGER            W        3075                                                                                                                                                             
        20 MANAGER                     6050                                                                                                                                                             
        20                            22250                                                                                                                                                             
        30 CLERK              M         950                                                                                                                                                             
        30 CLERK              W        1050                                                                                                                                                             
        30 CLERK                       2000                                                                                                                                                             
        30 MANAGER            M        2850                                                                                                                                                             
        30 MANAGER            W        2950                                                                                                                                                             
        30 MANAGER                     5800                                                                                                                                                             
        30 SALESMAN           M        5800                                                                                                                                                             
        30 SALESMAN           W        5800                                                                                                                                                             
        30 SALESMAN                   11600                                                                                                                                                             
        30                            19400                                                                                                                                                             
                                      59450                                                                                                                                                             

31 rows selected.

SQL> select deptno, job, gender, sum(sal)
  2  from t2
  3  group by GROUPING SETS((deptno,job,gender),(deptno,job),(deptno),());

    DEPTNO JOB                GE   SUM(SAL)                                                                                                                                                             
---------- ------------------ -- ----------                                                                                                                                                             
        10 CLERK              M        1300                                                                                                                                                             
        10 CLERK              W        1400                                                                                                                                                             
        10 CLERK                       2700                                                                                                                                                             
        10 MANAGER            M        2450                                                                                                                                                             
        10 MANAGER            W        2550                                                                                                                                                             
        10 MANAGER                     5000                                                                                                                                                             
        10 PRESIDENT          M        5100                                                                                                                                                             
        10 PRESIDENT          W        5000                                                                                                                                                             
        10 PRESIDENT                  10100                                                                                                                                                             
        10                            17800                                                                                                                                                             
        20 CLERK              M        2000                                                                                                                                                             
        20 CLERK              W        2000                                                                                                                                                             
        20 CLERK                       4000                                                                                                                                                             
        20 ANALYST            M        6000                                                                                                                                                             
        20 ANALYST            W        6200                                                                                                                                                             
        20 ANALYST                    12200                                                                                                                                                             
        20 MANAGER            M        2975                                                                                                                                                             
        20 MANAGER            W        3075                                                                                                                                                             
        20 MANAGER                     6050                                                                                                                                                             
        20                            22250                                                                                                                                                             
        30 CLERK              M         950                                                                                                                                                             
        30 CLERK              W        1050                                                                                                                                                             
        30 CLERK                       2000                                                                                                                                                             
        30 MANAGER            M        2850                                                                                                                                                             
        30 MANAGER            W        2950                                                                                                                                                             
        30 MANAGER                     5800                                                                                                                                                             
        30 SALESMAN           M        5800                                                                                                                                                             
        30 SALESMAN           W        5800                                                                                                                                                             
        30 SALESMAN                   11600                                                                                                                                                             
        30                            19400                                                                                                                                                             
                                      59450                                                                                                                                                             

31 rows selected.

SQL> 
SQL> /*grouping function*/

    DEPTNO JOB                GE   SUM(SAL)                                                                                                                                                             
---------- ------------------ -- ----------                                                                                                                                                             
        10 CLERK              M        1300                                                                                                                                                             
        10 CLERK              W        1400                                                                                                                                                             
        10 CLERK                       2700                                                                                                                                                             
        10 MANAGER            M        2450                                                                                                                                                             
        10 MANAGER            W        2550                                                                                                                                                             
        10 MANAGER                     5000                                                                                                                                                             
        10 PRESIDENT          M        5100                                                                                                                                                             
        10 PRESIDENT          W        5000                                                                                                                                                             
        10 PRESIDENT                  10100                                                                                                                                                             
        10                            17800                                                                                                                                                             
        20 CLERK              M        2000                                                                                                                                                             
        20 CLERK              W        2000                                                                                                                                                             
        20 CLERK                       4000                                                                                                                                                             
        20 ANALYST            M        6000                                                                                                                                                             
        20 ANALYST            W        6200                                                                                                                                                             
        20 ANALYST                    12200                                                                                                                                                             
        20 MANAGER            M        2975                                                                                                                                                             
        20 MANAGER            W        3075                                                                                                                                                             
        20 MANAGER                     6050                                                                                                                                                             
        20                            22250                                                                                                                                                             
        30 CLERK              M         950                                                                                                                                                             
        30 CLERK              W        1050                                                                                                                                                             
        30 CLERK                       2000                                                                                                                                                             
        30 MANAGER            M        2850                                                                                                                                                             
        30 MANAGER            W        2950                                                                                                                                                             
        30 MANAGER                     5800                                                                                                                                                             
        30 SALESMAN           M        5800                                                                                                                                                             
        30 SALESMAN           W        5800                                                                                                                                                             
        30 SALESMAN                   11600                                                                                                                                                             
        30                            19400                                                                                                                                                             
                                      59450                                                                                                                                                             

31 rows selected.

SQL> drop table emp3 purge;
drop table emp3 purge
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> create table emp3 as select * from emp;

Table created.

SQL> update emp3 set job = null where rownum = 1;

1 row updated.

SQL> select *
  2  from emp3;

     EMPNO ENAME                JOB                       MGR HIREDATE            SAL       COMM     DEPTNO                                                                                             
---------- -------------------- ------------------ ---------- ------------ ---------- ---------- ----------                                                                                             
      7369 SMITH                                         7902 17-DEC-80           800                    20                                                                                             
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

SQL> select deptno, job, sum(sal) as sum_sal
  2  from emp3
  3  group by rollup(deptno, job); /*without grouping function*/
  4  ;
group by rollup(deptno, job); /*without grouping function*/
                            *
ERROR at line 3:
ORA-00911: invalid character 


SQL> select deptno, job, sum(sal) as sum_sal
  2  from emp3
  3  group by rollup(deptno, job);

    DEPTNO JOB                   SUM_SAL                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
        10 CLERK                    1300                                                                                                                                                                
        10 MANAGER                  2450                                                                                                                                                                
        10 PRESIDENT                5000                                                                                                                                                                
        10                          8750                                                                                                                                                                
        20                           800                                                                                                                                                                
        20 CLERK                    1100                                                                                                                                                                
        20 ANALYST                  6000                                                                                                                                                                
        20 MANAGER                  2975                                                                                                                                                                
        20                         10875                                                                                                                                                                
        30 CLERK                     950                                                                                                                                                                
        30 MANAGER                  2850                                                                                                                                                                
        30 SALESMAN                 5600                                                                                                                                                                
        30                          9400                                                                                                                                                                
                                   29025                                                                                                                                                                

14 rows selected.

SQL> select *
  2  from (select deptno, job, sum(sal) as sum_sal
  3  		from emp3
  4  		group by rollup(deptno, job))
  5  where deptno is not null
  6  and job is not null;

    DEPTNO JOB                   SUM_SAL                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
        30 SALESMAN                 5600                                                                                                                                                                
        20 MANAGER                  2975                                                                                                                                                                
        20 CLERK                    1100                                                                                                                                                                
        30 CLERK                     950                                                                                                                                                                
        10 PRESIDENT                5000                                                                                                                                                                
        30 MANAGER                  2850                                                                                                                                                                
        10 CLERK                    1300                                                                                                                                                                
        10 MANAGER                  2450                                                                                                                                                                
        20 ANALYST                  6000                                                                                                                                                                

9 rows selected.

SQL>  select *
  2   from (select deptno, job, sum(sal) as sum_sal
  3              from emp3
  4              group by rollup(deptno, job))
  5   where deptno is not null
  6   and job is not null
  7  order by 1,2;

    DEPTNO JOB                   SUM_SAL                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
        10 CLERK                    1300                                                                                                                                                                
        10 MANAGER                  2450                                                                                                                                                                
        10 PRESIDENT                5000                                                                                                                                                                
        20 ANALYST                  6000                                                                                                                                                                
        20 CLERK                    1100                                                                                                                                                                
        20 MANAGER                  2975                                                                                                                                                                
        30 CLERK                     950                                                                                                                                                                
        30 MANAGER                  2850                                                                                                                                                                
        30 SALESMAN                 5600                                                                                                                                                                

9 rows selected.

SQL> select deptno, job, sum(sal) as sum_sal,
  2  	grouping(deptno) as g_deptno,
  3  	grouping(job)    as g_job
  4  from emp3
  5  group by rollup(deptno, job);

    DEPTNO JOB                   SUM_SAL   G_DEPTNO      G_JOB                                                                                                                                          
---------- ------------------ ---------- ---------- ----------                                                                                                                                          
        10 CLERK                    1300          0          0                                                                                                                                          
        10 MANAGER                  2450          0          0                                                                                                                                          
        10 PRESIDENT                5000          0          0                                                                                                                                          
        10                          8750          0          1                                                                                                                                          
        20                           800          0          0                                                                                                                                          
        20 CLERK                    1100          0          0                                                                                                                                          
        20 ANALYST                  6000          0          0                                                                                                                                          
        20 MANAGER                  2975          0          0                                                                                                                                          
        20                         10875          0          1                                                                                                                                          
        30 CLERK                     950          0          0                                                                                                                                          
        30 MANAGER                  2850          0          0                                                                                                                                          
        30 SALESMAN                 5600          0          0                                                                                                                                          
        30                          9400          0          1                                                                                                                                          
                                   29025          1          1                                                                                                                                          

14 rows selected.

SQL> select deptno, job, sum_sal
  2  from (select deptno, job, sum(sal) as sum_sal,
  3  	   	  grouping(deptno) as g_deptno,
  4  		  grouping(job)    as g_job
  5  	   from emp3
  6  	   group by rollup(deptno, job))
  7  where g_deptno = 0
  8  and g_job = 1;

    DEPTNO JOB                   SUM_SAL                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
        30                          9400                                                                                                                                                                
        20                         10875                                                                                                                                                                
        10                          8750                                                                                                                                                                

SQL> select deptno, job, sum_sal
  2  from (	select deptno, job, sum(sal) as sum_sal,
  3  			grouping(deptno) as g_deptno,
  4  			grouping(job)    as g_job
  5  		from emp3
  6  		group by rollup(deptno,job))
  7  where g_deptno = 0
  8  and   g_job    in (0, 1);

    DEPTNO JOB                   SUM_SAL                                                                                                                                                                
---------- ------------------ ----------                                                                                                                                                                
        10 CLERK                    1300                                                                                                                                                                
        10 MANAGER                  2450                                                                                                                                                                
        10 PRESIDENT                5000                                                                                                                                                                
        10                          8750                                                                                                                                                                
        20                           800                                                                                                                                                                
        20 CLERK                    1100                                                                                                                                                                
        20 ANALYST                  6000                                                                                                                                                                
        20 MANAGER                  2975                                                                                                                                                                
        20                         10875                                                                                                                                                                
        30 CLERK                     950                                                                                                                                                                
        30 MANAGER                  2850                                                                                                                                                                
        30 SALESMAN                 5600                                                                                                                                                                
        30                          9400                                                                                                                                                                

13 rows selected.

SQL> 
SQL> 
SQL> 
SQL> --Composite column
SQL> 
SQL> select deptno, job, gender, sum(sal)
  2  from emp2;
from emp2
     *
ERROR at line 2:
ORA-00942: table or view does not exist 


SQL> select deptno, job, gender, sum(sal)
  2  from t2
  3  group by deptno, job, gender;

    DEPTNO JOB                GE   SUM(SAL)                                                                                                                                                             
---------- ------------------ -- ----------                                                                                                                                                             
        20 ANALYST            M        6000                                                                                                                                                             
        20 CLERK              M        2000                                                                                                                                                             
        20 CLERK              W        2000                                                                                                                                                             
        20 MANAGER            M        2975                                                                                                                                                             
        10 CLERK              M        1300                                                                                                                                                             
        10 PRESIDENT          M        5100                                                                                                                                                             
        10 CLERK              W        1400                                                                                                                                                             
        20 ANALYST            W        6200                                                                                                                                                             
        30 SALESMAN           W        5800                                                                                                                                                             
        30 CLERK              M         950                                                                                                                                                             
        20 MANAGER            W        3075                                                                                                                                                             
        10 MANAGER            W        2550                                                                                                                                                             
        30 CLERK              W        1050                                                                                                                                                             
        30 SALESMAN           M        5800                                                                                                                                                             
        10 MANAGER            M        2450                                                                                                                                                             
        30 MANAGER            M        2850                                                                                                                                                             
        10 PRESIDENT          W        5000                                                                                                                                                             
        30 MANAGER            W        2950                                                                                                                                                             

18 rows selected.

SQL> select deptno, job, gender, sum(sal)
  2  from t2
  3  group by rollup(deptno, job, gender);

    DEPTNO JOB                GE   SUM(SAL)                                                                                                                                                             
---------- ------------------ -- ----------                                                                                                                                                             
        10 CLERK              M        1300                                                                                                                                                             
        10 CLERK              W        1400                                                                                                                                                             
        10 CLERK                       2700                                                                                                                                                             
        10 MANAGER            M        2450                                                                                                                                                             
        10 MANAGER            W        2550                                                                                                                                                             
        10 MANAGER                     5000                                                                                                                                                             
        10 PRESIDENT          M        5100                                                                                                                                                             
        10 PRESIDENT          W        5000                                                                                                                                                             
        10 PRESIDENT                  10100                                                                                                                                                             
        10                            17800                                                                                                                                                             
        20 CLERK              M        2000                                                                                                                                                             
        20 CLERK              W        2000                                                                                                                                                             
        20 CLERK                       4000                                                                                                                                                             
        20 ANALYST            M        6000                                                                                                                                                             
        20 ANALYST            W        6200                                                                                                                                                             
        20 ANALYST                    12200                                                                                                                                                             
        20 MANAGER            M        2975                                                                                                                                                             
        20 MANAGER            W        3075                                                                                                                                                             
        20 MANAGER                     6050                                                                                                                                                             
        20                            22250                                                                                                                                                             
        30 CLERK              M         950                                                                                                                                                             
        30 CLERK              W        1050                                                                                                                                                             
        30 CLERK                       2000                                                                                                                                                             
        30 MANAGER            M        2850                                                                                                                                                             
        30 MANAGER            W        2950                                                                                                                                                             
        30 MANAGER                     5800                                                                                                                                                             
        30 SALESMAN           M        5800                                                                                                                                                             
        30 SALESMAN           W        5800                                                                                                                                                             
        30 SALESMAN                   11600                                                                                                                                                             
        30                            19400                                                                                                                                                             
                                      59450                                                                                                                                                             

31 rows selected.

SQL> select deptno, job, gender,sum(sal)
  2  from t2
  3  group by rollup(deptno, (job,gender));

    DEPTNO JOB                GE   SUM(SAL)                                                                                                                                                             
---------- ------------------ -- ----------                                                                                                                                                             
        10 CLERK              M        1300                                                                                                                                                             
        10 CLERK              W        1400                                                                                                                                                             
        10 MANAGER            M        2450                                                                                                                                                             
        10 MANAGER            W        2550                                                                                                                                                             
        10 PRESIDENT          M        5100                                                                                                                                                             
        10 PRESIDENT          W        5000                                                                                                                                                             
        10                            17800                                                                                                                                                             
        20 CLERK              M        2000                                                                                                                                                             
        20 CLERK              W        2000                                                                                                                                                             
        20 ANALYST            M        6000                                                                                                                                                             
        20 ANALYST            W        6200                                                                                                                                                             
        20 MANAGER            M        2975                                                                                                                                                             
        20 MANAGER            W        3075                                                                                                                                                             
        20                            22250                                                                                                                                                             
        30 CLERK              M         950                                                                                                                                                             
        30 CLERK              W        1050                                                                                                                                                             
        30 MANAGER            M        2850                                                                                                                                                             
        30 MANAGER            W        2950                                                                                                                                                             
        30 SALESMAN           M        5800                                                                                                                                                             
        30 SALESMAN           W        5800                                                                                                                                                             
        30                            19400                                                                                                                                                             
                                      59450                                                                                                                                                             

22 rows selected.

SQL> select deptno, job, gender, sum(sal)
  2  from t2
  3  group by rollup((deptno, job), gender);

    DEPTNO JOB                GE   SUM(SAL)                                                                                                                                                             
---------- ------------------ -- ----------                                                                                                                                                             
        10 CLERK              M        1300                                                                                                                                                             
        10 CLERK              W        1400                                                                                                                                                             
        10 CLERK                       2700                                                                                                                                                             
        10 MANAGER            M        2450                                                                                                                                                             
        10 MANAGER            W        2550                                                                                                                                                             
        10 MANAGER                     5000                                                                                                                                                             
        10 PRESIDENT          M        5100                                                                                                                                                             
        10 PRESIDENT          W        5000                                                                                                                                                             
        10 PRESIDENT                  10100                                                                                                                                                             
        20 CLERK              M        2000                                                                                                                                                             
        20 CLERK              W        2000                                                                                                                                                             
        20 CLERK                       4000                                                                                                                                                             
        20 ANALYST            M        6000                                                                                                                                                             
        20 ANALYST            W        6200                                                                                                                                                             
        20 ANALYST                    12200                                                                                                                                                             
        20 MANAGER            M        2975                                                                                                                                                             
        20 MANAGER            W        3075                                                                                                                                                             
        20 MANAGER                     6050                                                                                                                                                             
        30 CLERK              M         950                                                                                                                                                             
        30 CLERK              W        1050                                                                                                                                                             
        30 CLERK                       2000                                                                                                                                                             
        30 MANAGER            M        2850                                                                                                                                                             
        30 MANAGER            W        2950                                                                                                                                                             
        30 MANAGER                     5800                                                                                                                                                             
        30 SALESMAN           M        5800                                                                                                                                                             
        30 SALESMAN           W        5800                                                                                                                                                             
        30 SALESMAN                   11600                                                                                                                                                             
                                      59450                                                                                                                                                             

28 rows selected.

SQL> select deptno, job, gender, sum(sal)
  2  from t2
  3  group by rollup((deptno, job, gender));

    DEPTNO JOB                GE   SUM(SAL)                                                                                                                                                             
---------- ------------------ -- ----------                                                                                                                                                             
        10 CLERK              M        1300                                                                                                                                                             
        10 CLERK              W        1400                                                                                                                                                             
        10 MANAGER            M        2450                                                                                                                                                             
        10 MANAGER            W        2550                                                                                                                                                             
        10 PRESIDENT          M        5100                                                                                                                                                             
        10 PRESIDENT          W        5000                                                                                                                                                             
        20 CLERK              M        2000                                                                                                                                                             
        20 CLERK              W        2000                                                                                                                                                             
        20 ANALYST            M        6000                                                                                                                                                             
        20 ANALYST            W        6200                                                                                                                                                             
        20 MANAGER            M        2975                                                                                                                                                             
        20 MANAGER            W        3075                                                                                                                                                             
        30 CLERK              M         950                                                                                                                                                             
        30 CLERK              W        1050                                                                                                                                                             
        30 MANAGER            M        2850                                                                                                                                                             
        30 MANAGER            W        2950                                                                                                                                                             
        30 SALESMAN           M        5800                                                                                                                                                             
        30 SALESMAN           W        5800                                                                                                                                                             
                                      59450                                                                                                                                                             

19 rows selected.

SQL> --Concatenated Groupings
SQL> 
SQL> select deptno, job, gender, sum(sal)
  2  from t2
  3  group by deptno, rollup(job), cude(gender);
group by deptno, rollup(job), cude(gender)
                              *
ERROR at line 3:
ORA-00904: "CUDE": invalid identifier 


SQL> l 3
  3* group by deptno, rollup(job), cude(gender)
SQL> c/cude/cube
  3* group by deptno, rollup(job), cube(gender)
SQL> r
  1  select deptno, job, gender, sum(sal)
  2  from t2
  3* group by deptno, rollup(job), cube(gender)

    DEPTNO JOB                GE   SUM(SAL)                                                                                                                                                             
---------- ------------------ -- ----------                                                                                                                                                             
        10 CLERK              M        1300                                                                                                                                                             
        10 MANAGER            M        2450                                                                                                                                                             
        10 PRESIDENT          M        5100                                                                                                                                                             
        10 CLERK              W        1400                                                                                                                                                             
        10 MANAGER            W        2550                                                                                                                                                             
        10 PRESIDENT          W        5000                                                                                                                                                             
        20 CLERK              M        2000                                                                                                                                                             
        20 ANALYST            M        6000                                                                                                                                                             
        20 MANAGER            M        2975                                                                                                                                                             
        20 CLERK              W        2000                                                                                                                                                             
        20 ANALYST            W        6200                                                                                                                                                             
        20 MANAGER            W        3075                                                                                                                                                             
        30 CLERK              M         950                                                                                                                                                             
        30 MANAGER            M        2850                                                                                                                                                             
        30 SALESMAN           M        5800                                                                                                                                                             
        30 CLERK              W        1050                                                                                                                                                             
        30 MANAGER            W        2950                                                                                                                                                             
        30 SALESMAN           W        5800                                                                                                                                                             
        10                    M        8850                                                                                                                                                             
        10                    W        8950                                                                                                                                                             
        20                    M       10975                                                                                                                                                             
        20                    W       11275                                                                                                                                                             
        30                    M        9600                                                                                                                                                             
        30                    W        9800                                                                                                                                                             
        10 CLERK                       2700                                                                                                                                                             
        10 MANAGER                     5000                                                                                                                                                             
        10 PRESIDENT                  10100                                                                                                                                                             
        10                            17800                                                                                                                                                             
        20 CLERK                       4000                                                                                                                                                             
        20 ANALYST                    12200                                                                                                                                                             
        20 MANAGER                     6050                                                                                                                                                             
        20                            22250                                                                                                                                                             
        30 CLERK                       2000                                                                                                                                                             
        30 MANAGER                     5800                                                                                                                                                             
        30 SALESMAN                   11600                                                                                                                                                             
        30                            19400                                                                                                                                                             

36 rows selected.

SQL> --Exercise!
SQL> select *
  2  from city;
from city
     *
ERROR at line 2:
ORA-00942: table or view does not exist 


SQL> select *
  2  from tab;

TNAME                                                        TABTYPE         CLUSTERID                                                                                                                  
------------------------------------------------------------ -------------- ----------                                                                                                                  
BIN$ZDpxW4znRQaFiY1LHn9vJQ==$0                               TABLE                                                                                                                                      
BONUS                                                        TABLE                                                                                                                                      
COPY_EMP                                                     TABLE                                                                                                                                      
COUNTRIES                                                    TABLE                                                                                                                                      
D1                                                           TABLE                                                                                                                                      
DEPARTMENTS                                                  TABLE                                                                                                                                      
DEPT                                                         TABLE                                                                                                                                      
DUMMY                                                        TABLE                                                                                                                                      
E1                                                           TABLE                                                                                                                                      
EMP                                                          TABLE                                                                                                                                      
EMP3                                                         TABLE                                                                                                                                      
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

36 rows selected.

SQL> select *
  2  from departments;

DEPARTMENT_ID DEPARTMENT_NAME                                              MANAGER_ID LOCATION_ID                                                                                                       
------------- ------------------------------------------------------------ ---------- -----------                                                                                                       
           10 Administration                                                      200        1700                                                                                                       
           20 Marketing                                                           201        1800                                                                                                       
           50 Shipping                                                            124        1500                                                                                                       
           60 IT                                                                  103        1400                                                                                                       
           80 Sales                                                               149        2500                                                                                                       
           90 Executive                                                           100        1700                                                                                                       
          110 Accounting                                                          205        1700                                                                                                       
          190 Contracting                                                                    1700                                                                                                       

8 rows selected.

SQL> select *
  2  from regions;

 REGION_ID REGION_NAME                                                                                                                                                                                  
---------- --------------------------------------------------                                                                                                                                           
         1 Europe                                                                                                                                                                                       
         2 Americas                                                                                                                                                                                     
         3 Asia                                                                                                                                                                                         
         4 Middle East and Africa                                                                                                                                                                       

SQL> select *
  2  from employees
  3  where rownum = 1;

EMPLOYEE_ID FIRST_NAME                               LAST_NAME                                          EMAIL                                              PHONE_NUMBER                                 
----------- ---------------------------------------- -------------------------------------------------- -------------------------------------------------- ----------------------------------------     
HIRE_DATE    JOB_ID                   SALARY COMMISSION_PCT MANAGER_ID DEPARTMENT_ID                                                                                                                    
------------ -------------------- ---------- -------------- ---------- -------------                                                                                                                    
        100 Steven                                   King                                               SKING                                              515.123.4567                                 
17-JUN-87    AD_PRES                   24000                                      90                                                                                                                    
                                                                                                                                                                                                        

SQL> select *
  2  from locations;

LOCATION_ID STREET_ADDRESS                                                                   POSTAL_CODE              CITY                                                                              
----------- -------------------------------------------------------------------------------- ------------------------ ------------------------------------------------------------                      
STATE_PROVINCE                                     COUN                                                                                                                                                 
-------------------------------------------------- ----                                                                                                                                                 
       1400 2014 Jabberwocky Rd                                                              26192                    Southlake                                                                         
Texas                                              US                                                                                                                                                   
                                                                                                                                                                                                        
       1500 2011 Interiors Blvd                                                              99236                    South San Francisco                                                               
California                                         US                                                                                                                                                   
                                                                                                                                                                                                        
       1700 2004 Charade Rd                                                                  98199                    Seattle                                                                           
Washington                                         US                                                                                                                                                   
                                                                                                                                                                                                        
       1800 460 Bloor St. W.                                                                 ON M5S 1X8               Toronto                                                                           
Ontario                                            CA                                                                                                                                                   
                                                                                                                                                                                                        
       2500 Magdalen Centre, The Oxford Science Park                                         OX9 9ZB                  Oxford                                                                            
Oxford                                             UK                                                                                                                                                   
                                                                                                                                                                                                        

SQL> select l.city, e.department_id, count(*)
  2  from locations l, employees e, departments d
  3  where l.location_id = d.location_id
  4  and   d.department_id = e.department_id;
select l.city, e.department_id, count(*)
       *
ERROR at line 1:
ORA-00937: not a single-group group function 


SQL> select l.city, e.department_id, count(*)
  2  from locations l, employees e, departments d
  3  where l.location_id = d.location_id
  4  and   d.department_id = e.department_id
  5  group by grouping sets((l.city,e.department_id),(l.city),());

CITY                                                         DEPARTMENT_ID   COUNT(*)                                                                                                                   
------------------------------------------------------------ ------------- ----------                                                                                                                   
Oxford                                                                  80          3                                                                                                                   
Oxford                                                                              3                                                                                                                   
Seattle                                                                 10          1                                                                                                                   
Seattle                                                                 90          3                                                                                                                   
Seattle                                                                110          2                                                                                                                   
Seattle                                                                             6                                                                                                                   
Toronto                                                                 20          2                                                                                                                   
Toronto                                                                             2                                                                                                                   
Southlake                                                               60          3                                                                                                                   
Southlake                                                                           3                                                                                                                   
South San Francisco                                                     50          5                                                                                                                   
South San Francisco                                                                 5                                                                                                                   
                                                                                   19                                                                                                                   

13 rows selected.

SQL> col city for a20
SQL> r
  1  select l.city, e.department_id, count(*)
  2  from locations l, employees e, departments d
  3  where l.location_id = d.location_id
  4  and   d.department_id = e.department_id
  5* group by grouping sets((l.city,e.department_id),(l.city),())

CITY                 DEPARTMENT_ID   COUNT(*)                                                                                                                                                           
-------------------- ------------- ----------                                                                                                                                                           
Oxford                          80          3                                                                                                                                                           
Oxford                                      3                                                                                                                                                           
Seattle                         10          1                                                                                                                                                           
Seattle                         90          3                                                                                                                                                           
Seattle                        110          2                                                                                                                                                           
Seattle                                     6                                                                                                                                                           
Toronto                         20          2                                                                                                                                                           
Toronto                                     2                                                                                                                                                           
Southlake                       60          3                                                                                                                                                           
Southlake                                   3                                                                                                                                                           
South San Francisco             50          5                                                                                                                                                           
South San Francisco                         5                                                                                                                                                           
                                           19                                                                                                                                                           

13 rows selected.

SQL> break city skip 1
SP2-0016: break specification must start with ON/BY or ACROSS keyword
SQL> break on null skip 1
SQL> r
  1  select l.city, e.department_id, count(*)
  2  from locations l, employees e, departments d
  3  where l.location_id = d.location_id
  4  and   d.department_id = e.department_id
  5* group by grouping sets((l.city,e.department_id),(l.city),())

CITY                 DEPARTMENT_ID   COUNT(*)                                                                                                                                                           
-------------------- ------------- ----------                                                                                                                                                           
Oxford                          80          3                                                                                                                                                           
Oxford                                      3                                                                                                                                                           
Seattle                         10          1                                                                                                                                                           
Seattle                         90          3                                                                                                                                                           
Seattle                        110          2                                                                                                                                                           
Seattle                                     6                                                                                                                                                           
Toronto                         20          2                                                                                                                                                           
Toronto                                     2                                                                                                                                                           
Southlake                       60          3                                                                                                                                                           
Southlake                                   3                                                                                                                                                           
South San Francisco             50          5                                                                                                                                                           
South San Francisco                         5                                                                                                                                                           
                                           19                                                                                                                                                           

13 rows selected.

SQL> break on city skip 1;
SQL> r
  1  select l.city, e.department_id, count(*)
  2  from locations l, employees e, departments d
  3  where l.location_id = d.location_id
  4  and   d.department_id = e.department_id
  5* group by grouping sets((l.city,e.department_id),(l.city),())

CITY                 DEPARTMENT_ID   COUNT(*)                                                                                                                                                           
-------------------- ------------- ----------                                                                                                                                                           
Oxford                          80          3                                                                                                                                                           
                                            3                                                                                                                                                           
                                                                                                                                                                                                        
Seattle                         10          1                                                                                                                                                           
                                90          3                                                                                                                                                           
                               110          2                                                                                                                                                           
                                            6                                                                                                                                                           
                                                                                                                                                                                                        
Toronto                         20          2                                                                                                                                                           
                                            2                                                                                                                                                           
                                                                                                                                                                                                        
Southlake                       60          3                                                                                                                                                           
                                            3                                                                                                                                                           
                                                                                                                                                                                                        
South San Francisco             50          5                                                                                                                                                           
                                            5                                                                                                                                                           
                                                                                                                                                                                                        
                                           19                                                                                                                                                           
                                                                                                                                                                                                        

13 rows selected.

SQL> break off
SP2-0016: break specification must start with ON/BY or ACROSS keyword
SQL> clear break
breaks cleared
SQL> skip on city 1
SP2-0734: unknown command beginning "skip on ci..." - rest of line ignored.
SQL> skip on city skip 1
SP2-0734: unknown command beginning "skip on ci..." - rest of line ignored.
SQL> skip 1 on city skip 1
SP2-0734: unknown command beginning "skip 1 on ..." - rest of line ignored.
SQL> select l.city, e.department_id, count(*)
  2  from locations l, employees e, departments d
  3  where l.location_id = d.location_id
  4  and   d.department_id = e.department_id
  5  group by rollup(l.city, e.department_id);

CITY                 DEPARTMENT_ID   COUNT(*)                                                                                                                                                           
-------------------- ------------- ----------                                                                                                                                                           
Oxford                          80          3                                                                                                                                                           
Oxford                                      3                                                                                                                                                           
Seattle                         10          1                                                                                                                                                           
Seattle                         90          3                                                                                                                                                           
Seattle                        110          2                                                                                                                                                           
Seattle                                     6                                                                                                                                                           
Toronto                         20          2                                                                                                                                                           
Toronto                                     2                                                                                                                                                           
Southlake                       60          3                                                                                                                                                           
Southlake                                   3                                                                                                                                                           
South San Francisco             50          5                                                                                                                                                           
South San Francisco                         5                                                                                                                                                           
                                           19                                                                                                                                                           

13 rows selected.

SQL> select l.city, e.department_id, count(e.employee_id)
  2  from locations l full outer join departments d
  3  
SQL> select l.city, e.department_id, count(e.employee_id)
  2  from locations l full outer join departments d
  3  on l.location_id = d.location_id
  4  full outer join employees e
  5  on d.department_id = e.department_id
  6  group by rollup(l.city, e.department_id);

CITY                 DEPARTMENT_ID COUNT(E.EMPLOYEE_ID)                                                                                                                                                 
-------------------- ------------- --------------------                                                                                                                                                 
                                                      1                                                                                                                                                 
                                                      1                                                                                                                                                 
Oxford                          80                    3                                                                                                                                                 
Oxford                                                3                                                                                                                                                 
Seattle                                               0                                                                                                                                                 
Seattle                         10                    1                                                                                                                                                 
Seattle                         90                    3                                                                                                                                                 
Seattle                        110                    2                                                                                                                                                 
Seattle                                               6                                                                                                                                                 
Toronto                         20                    2                                                                                                                                                 
Toronto                                               2                                                                                                                                                 
Southlake                       60                    3                                                                                                                                                 
Southlake                                             3                                                                                                                                                 
South San Francisco             50                    5                                                                                                                                                 
South San Francisco                                   5                                                                                                                                                 
                                                     20                                                                                                                                                 

16 rows selected.

SQL> select l.city, e.department_id, count(e.employee_id)
  2  from locations l full outer join departments d
  3  on l.location_id = d.location_id
  4  full outer join employees e
  5  on d.department_id = e.department_id
  6  group by rollup(l.city, e.department_id)
  7  order by 1,2,3;

CITY                 DEPARTMENT_ID COUNT(E.EMPLOYEE_ID)                                                                                                                                                 
-------------------- ------------- --------------------                                                                                                                                                 
Oxford                          80                    3                                                                                                                                                 
Oxford                                                3                                                                                                                                                 
Seattle                         10                    1                                                                                                                                                 
Seattle                         90                    3                                                                                                                                                 
Seattle                        110                    2                                                                                                                                                 
Seattle                                               0                                                                                                                                                 
Seattle                                               6                                                                                                                                                 
South San Francisco             50                    5                                                                                                                                                 
South San Francisco                                   5                                                                                                                                                 
Southlake                       60                    3                                                                                                                                                 
Southlake                                             3                                                                                                                                                 
Toronto                         20                    2                                                                                                                                                 
Toronto                                               2                                                                                                                                                 
                                                      1                                                                                                                                                 
                                                      1                                                                                                                                                 
                                                     20                                                                                                                                                 

16 rows selected.

SQL> spool off
