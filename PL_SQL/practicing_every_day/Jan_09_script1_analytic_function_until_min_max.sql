SQL> 
SQL> --RANKING FUNCTIONS
SQL> 
SQL> select deptno, empno, ename, sal
  2  from emp
  3  order by sal desc;

    DEPTNO      EMPNO ENAME                       SAL                                                                                                                                                   
---------- ---------- -------------------- ----------                                                                                                                                                   
        10       7839 KING                       5000                                                                                                                                                   
        20       7902 FORD                       3000                                                                                                                                                   
        20       7788 SCOTT                      3000                                                                                                                                                   
        20       7566 JONES                      2975                                                                                                                                                   
        30       7698 BLAKE                      2850                                                                                                                                                   
        10       7782 CLARK                      2450                                                                                                                                                   
        30       7499 ALLEN                      1600                                                                                                                                                   
        30       7844 TURNER                     1500                                                                                                                                                   
        10       7934 MILLER                     1300                                                                                                                                                   
        30       7521 WARD                       1250                                                                                                                                                   
        30       7654 MARTIN                     1250                                                                                                                                                   
        20       7876 ADAMS                      1100                                                                                                                                                   
        30       7900 JAMES                       950                                                                                                                                                   
        20       7369 SMITH                       800                                                                                                                                                   

14 rows selected.

SQL> 
SQL> --how to get top 3 salary getters?
SQL> 
SQL> selecct deptno, emapno, ename, sal
SP2-0734: unknown command beginning "selecct de..." - rest of line ignored.
SQL> select deptno,empno,ename, sal,
  2  		rank() 		over (order by sal desc) as rank
  3  from emp;

    DEPTNO      EMPNO ENAME                       SAL       RANK                                                                                                                                        
---------- ---------- -------------------- ---------- ----------                                                                                                                                        
        10       7839 KING                       5000          1                                                                                                                                        
        20       7902 FORD                       3000          2                                                                                                                                        
        20       7788 SCOTT                      3000          2                                                                                                                                        
        20       7566 JONES                      2975          4                                                                                                                                        
        30       7698 BLAKE                      2850          5                                                                                                                                        
        10       7782 CLARK                      2450          6                                                                                                                                        
        30       7499 ALLEN                      1600          7                                                                                                                                        
        30       7844 TURNER                     1500          8                                                                                                                                        
        10       7934 MILLER                     1300          9                                                                                                                                        
        30       7521 WARD                       1250         10                                                                                                                                        
        30       7654 MARTIN                     1250         10                                                                                                                                        
        20       7876 ADAMS                      1100         12                                                                                                                                        
        30       7900 JAMES                       950         13                                                                                                                                        
        20       7369 SMITH                       800         14                                                                                                                                        

14 rows selected.

SQL> select deptno, empno, ename, sal,
  2  		rank()		over (order by sal desc) as rank,
  3  		dense_rank()	over (order by sal desc) as dense_rank
  4  from emp;

    DEPTNO      EMPNO ENAME                       SAL       RANK DENSE_RANK                                                                                                                             
---------- ---------- -------------------- ---------- ---------- ----------                                                                                                                             
        10       7839 KING                       5000          1          1                                                                                                                             
        20       7902 FORD                       3000          2          2                                                                                                                             
        20       7788 SCOTT                      3000          2          2                                                                                                                             
        20       7566 JONES                      2975          4          3                                                                                                                             
        30       7698 BLAKE                      2850          5          4                                                                                                                             
        10       7782 CLARK                      2450          6          5                                                                                                                             
        30       7499 ALLEN                      1600          7          6                                                                                                                             
        30       7844 TURNER                     1500          8          7                                                                                                                             
        10       7934 MILLER                     1300          9          8                                                                                                                             
        30       7521 WARD                       1250         10          9                                                                                                                             
        30       7654 MARTIN                     1250         10          9                                                                                                                             
        20       7876 ADAMS                      1100         12         10                                                                                                                             
        30       7900 JAMES                       950         13         11                                                                                                                             
        20       7369 SMITH                       800         14         12                                                                                                                             

14 rows selected.

SQL> select deptno, empno, ename, sal,
  2  		rank()		over (order by desc) as rank
  3  from emp
  4  where rank <= 3;
		rank()		over (order by desc) as rank
		      		               *
ERROR at line 2:
ORA-00936: missing expression 


SQL> select deptno, empno, ename, sal,
  2  		rank()		over (order by sal desc) as rank
  3  from emp
  4  where rank <= 3;
where rank <= 3
      *
ERROR at line 4:
ORA-00904: "RANK": invalid identifier 


SQL> select deptno, empno, ename, sal,
  2  		rank()		over (order by desc) as rank
  3  from emp
  4  where rownum <= 3;
		rank()		over (order by desc) as rank
		      		               *
ERROR at line 2:
ORA-00936: missing expression 


SQL> select deptno, empno, ename, sal,
  2  		rank()		over (order by sal desc) as rank
  3  from emp
  4  where rownum <= 3;

    DEPTNO      EMPNO ENAME                       SAL       RANK                                                                                                                                        
---------- ---------- -------------------- ---------- ----------                                                                                                                                        
        30       7499 ALLEN                      1600          1                                                                                                                                        
        30       7521 WARD                       1250          2                                                                                                                                        
        20       7369 SMITH                       800          3                                                                                                                                        

SQL> select *
  2  from	(select *
  3  		 , rank()		over (order by sal desc) as rank
  4  		from emp)
  5  where rank <= 3;
		 , rank()		over (order by sal desc) as rank
		 *
ERROR at line 3:
ORA-00923: FROM keyword not found where expected 


SQL> select *
  2  from	(select empno, ename, deptno, sal
  3  
SQL> select *
  2  from	(select empno, ename, deptno, sal, rank() over (order by sal desc) as rank
  3  		 from emp)
  4  where rank <= 3;

     EMPNO ENAME                    DEPTNO        SAL       RANK                                                                                                                                        
---------- -------------------- ---------- ---------- ----------                                                                                                                                        
      7839 KING                         10       5000          1                                                                                                                                        
      7788 SCOTT                        20       3000          2                                                                                                                                        
      7902 FORD                         20       3000          2                                                                                                                                        

SQL> select empno, ename, deptno, sal
  2  from 	(select *, rank() over (order by sal desc) as rank
  3  		 from emp)
  4  where rank <= 3;
from 	(select *, rank() over (order by sal desc) as rank
     	         *
ERROR at line 2:
ORA-00923: FROM keyword not found where expected 


SQL> select empno, ename, deptno, sal
  2  from 	(select empno, ename, deptno, sal, rank() over (order by sal desc) as rank
  3  		 from emp)
  4  where rank <= 3;

     EMPNO ENAME                    DEPTNO        SAL                                                                                                                                                   
---------- -------------------- ---------- ----------                                                                                                                                                   
      7839 KING                         10       5000                                                                                                                                                   
      7788 SCOTT                        20       3000                                                                                                                                                   
      7902 FORD                         20       3000                                                                                                                                                   

SQL> 
SQL> 
SQL> 
SQL> 
SQL> select deptno, empno, ename, sal,
  2  		rank()		over (order by sal desc) as rank,
  3  		dense_rank()	over (order by sal desc) as dense_rank,
  4  		row_number()	over (order by sal desc) as row_number
  5  from emp;

    DEPTNO      EMPNO ENAME                       SAL       RANK DENSE_RANK ROW_NUMBER                                                                                                                  
---------- ---------- -------------------- ---------- ---------- ---------- ----------                                                                                                                  
        10       7839 KING                       5000          1          1          1                                                                                                                  
        20       7902 FORD                       3000          2          2          2                                                                                                                  
        20       7788 SCOTT                      3000          2          2          3                                                                                                                  
        20       7566 JONES                      2975          4          3          4                                                                                                                  
        30       7698 BLAKE                      2850          5          4          5                                                                                                                  
        10       7782 CLARK                      2450          6          5          6                                                                                                                  
        30       7499 ALLEN                      1600          7          6          7                                                                                                                  
        30       7844 TURNER                     1500          8          7          8                                                                                                                  
        10       7934 MILLER                     1300          9          8          9                                                                                                                  
        30       7521 WARD                       1250         10          9         10                                                                                                                  
        30       7654 MARTIN                     1250         10          9         11                                                                                                                  
        20       7876 ADAMS                      1100         12         10         12                                                                                                                  
        30       7900 JAMES                       950         13         11         13                                                                                                                  
        20       7369 SMITH                       800         14         12         14                                                                                                                  

14 rows selected.

SQL> break on deptno skip 1
SQL> 
SQL> select deptno, empno, ename, sal,
  2  		rank()		over (partition by deptno
  3  				      order by sal desc)	as rank,
  4  		dense_rank(0	over (partition by deptno
  5  				      order by sal desc)	as dense_rank,
  6  		row_number()	over (partition by deptno
  7  				      order by sal desc)	as row_num
  8  from emp;
		dense_rank(0	over (partition by deptno
		            	*
ERROR at line 4:
ORA-00907: missing right parenthesis 


SQL> l 4
  4* 		dense_rank(0	over (partition by deptno
SQL> c/0/)
  4* 		dense_rank()	over (partition by deptno
SQL> r
  1  select deptno, empno, ename, sal,
  2  		rank()		over (partition by deptno
  3  				      order by sal desc)	as rank,
  4  		dense_rank()	over (partition by deptno
  5  				      order by sal desc)	as dense_rank,
  6  		row_number()	over (partition by deptno
  7  				      order by sal desc)	as row_num
  8* from emp

    DEPTNO      EMPNO ENAME                       SAL       RANK DENSE_RANK    ROW_NUM                                                                                                                  
---------- ---------- -------------------- ---------- ---------- ---------- ----------                                                                                                                  
        10       7839 KING                       5000          1          1          1                                                                                                                  
                 7782 CLARK                      2450          2          2          2                                                                                                                  
                 7934 MILLER                     1300          3          3          3                                                                                                                  
                                                                                                                                                                                                        
        20       7788 SCOTT                      3000          1          1          1                                                                                                                  
                 7902 FORD                       3000          1          1          2                                                                                                                  
                 7566 JONES                      2975          3          2          3                                                                                                                  
                 7876 ADAMS                      1100          4          3          4                                                                                                                  
                 7369 SMITH                       800          5          4          5                                                                                                                  
                                                                                                                                                                                                        
        30       7698 BLAKE                      2850          1          1          1                                                                                                                  
                 7499 ALLEN                      1600          2          2          2                                                                                                                  
                 7844 TURNER                     1500          3          3          3                                                                                                                  
                 7654 MARTIN                     1250          4          4          4                                                                                                                  
                 7521 WARD                       1250          4          4          5                                                                                                                  
                 7900 JAMES                       950          6          5          6                                                                                                                  
                                                                                                                                                                                                        

14 rows selected.

SQL> clear break;
breaks cleared
SQL> 
SQL> 
SQL> create or replace view v1
  2  as
  3  select deptno, empno, ename, sal,
  4  		rank()		over (partition by deptno
  5  					order by sal desc)	as rank,
  6  		dense_rank()	over (partition by deptno
  7  					order by sal desc)	as dense_rank,
  8  		row_number()	over (partition by deptno
  9  					order by sal desc)	as row_num
 10  from emp;

View created.

SQL> select *
  2  from v1;

    DEPTNO      EMPNO ENAME                       SAL       RANK DENSE_RANK    ROW_NUM                                                                                                                  
---------- ---------- -------------------- ---------- ---------- ---------- ----------                                                                                                                  
        10       7839 KING                       5000          1          1          1                                                                                                                  
        10       7782 CLARK                      2450          2          2          2                                                                                                                  
        10       7934 MILLER                     1300          3          3          3                                                                                                                  
        20       7788 SCOTT                      3000          1          1          1                                                                                                                  
        20       7902 FORD                       3000          1          1          2                                                                                                                  
        20       7566 JONES                      2975          3          2          3                                                                                                                  
        20       7876 ADAMS                      1100          4          3          4                                                                                                                  
        20       7369 SMITH                       800          5          4          5                                                                                                                  
        30       7698 BLAKE                      2850          1          1          1                                                                                                                  
        30       7499 ALLEN                      1600          2          2          2                                                                                                                  
        30       7844 TURNER                     1500          3          3          3                                                                                                                  
        30       7654 MARTIN                     1250          4          4          4                                                                                                                  
        30       7521 WARD                       1250          4          4          5                                                                                                                  
        30       7900 JAMES                       950          6          5          6                                                                                                                  

14 rows selected.

SQL> select *
  2  from v1
  3  where rank <=3;

    DEPTNO      EMPNO ENAME                       SAL       RANK DENSE_RANK    ROW_NUM                                                                                                                  
---------- ---------- -------------------- ---------- ---------- ---------- ----------                                                                                                                  
        10       7839 KING                       5000          1          1          1                                                                                                                  
        10       7782 CLARK                      2450          2          2          2                                                                                                                  
        10       7934 MILLER                     1300          3          3          3                                                                                                                  
        20       7788 SCOTT                      3000          1          1          1                                                                                                                  
        20       7902 FORD                       3000          1          1          2                                                                                                                  
        20       7566 JONES                      2975          3          2          3                                                                                                                  
        30       7698 BLAKE                      2850          1          1          1                                                                                                                  
        30       7499 ALLEN                      1600          2          2          2                                                                                                                  
        30       7844 TURNER                     1500          3          3          3                                                                                                                  

9 rows selected.

SQL> select *
  2  from v1
  3  where dense_rank <= 3;

    DEPTNO      EMPNO ENAME                       SAL       RANK DENSE_RANK    ROW_NUM                                                                                                                  
---------- ---------- -------------------- ---------- ---------- ---------- ----------                                                                                                                  
        10       7839 KING                       5000          1          1          1                                                                                                                  
        10       7782 CLARK                      2450          2          2          2                                                                                                                  
        10       7934 MILLER                     1300          3          3          3                                                                                                                  
        20       7788 SCOTT                      3000          1          1          1                                                                                                                  
        20       7902 FORD                       3000          1          1          2                                                                                                                  
        20       7566 JONES                      2975          3          2          3                                                                                                                  
        20       7876 ADAMS                      1100          4          3          4                                                                                                                  
        30       7698 BLAKE                      2850          1          1          1                                                                                                                  
        30       7499 ALLEN                      1600          2          2          2                                                                                                                  
        30       7844 TURNER                     1500          3          3          3                                                                                                                  

10 rows selected.

SQL> 
SQL> --Nulls are treate like normal values
SQL> --Alse, for rank computation, a NULL value is assumed to be equal to another NULL value
SQL> 
SQL> select deptno, empno, ename, sal, comm
  2  from emp
  3  order by comm desc;

    DEPTNO      EMPNO ENAME                       SAL       COMM                                                                                                                                        
---------- ---------- -------------------- ---------- ----------                                                                                                                                        
        20       7369 SMITH                       800                                                                                                                                                   
        10       7782 CLARK                      2450                                                                                                                                                   
        20       7902 FORD                       3000                                                                                                                                                   
        30       7900 JAMES                       950                                                                                                                                                   
        20       7876 ADAMS                      1100                                                                                                                                                   
        20       7566 JONES                      2975                                                                                                                                                   
        30       7698 BLAKE                      2850                                                                                                                                                   
        10       7934 MILLER                     1300                                                                                                                                                   
        20       7788 SCOTT                      3000                                                                                                                                                   
        10       7839 KING                       5000                                                                                                                                                   
        30       7654 MARTIN                     1250       1400                                                                                                                                        
        30       7521 WARD                       1250        500                                                                                                                                        
        30       7499 ALLEN                      1600        300                                                                                                                                        
        30       7844 TURNER                     1500          0                                                                                                                                        

14 rows selected.

SQL> select deptno, empno, ename, sal, comm
  2  from emp
  3  order by nvl(comm, -1) desc;

    DEPTNO      EMPNO ENAME                       SAL       COMM                                                                                                                                        
---------- ---------- -------------------- ---------- ----------                                                                                                                                        
        30       7654 MARTIN                     1250       1400                                                                                                                                        
        30       7521 WARD                       1250        500                                                                                                                                        
        30       7499 ALLEN                      1600        300                                                                                                                                        
        30       7844 TURNER                     1500          0                                                                                                                                        
        20       7788 SCOTT                      3000                                                                                                                                                   
        10       7839 KING                       5000                                                                                                                                                   
        20       7876 ADAMS                      1100                                                                                                                                                   
        30       7900 JAMES                       950                                                                                                                                                   
        20       7902 FORD                       3000                                                                                                                                                   
        10       7934 MILLER                     1300                                                                                                                                                   
        30       7698 BLAKE                      2850                                                                                                                                                   
        20       7566 JONES                      2975                                                                                                                                                   
        20       7369 SMITH                       800                                                                                                                                                   
        10       7782 CLARK                      2450                                                                                                                                                   

14 rows selected.

SQL> select deptno, empno, ename, sal, comm, rank()	over (order by comm desc) as rank
  2  from emp;

    DEPTNO      EMPNO ENAME                       SAL       COMM       RANK                                                                                                                             
---------- ---------- -------------------- ---------- ---------- ----------                                                                                                                             
        20       7369 SMITH                       800                     1                                                                                                                             
        10       7782 CLARK                      2450                     1                                                                                                                             
        20       7902 FORD                       3000                     1                                                                                                                             
        30       7900 JAMES                       950                     1                                                                                                                             
        20       7876 ADAMS                      1100                     1                                                                                                                             
        20       7566 JONES                      2975                     1                                                                                                                             
        30       7698 BLAKE                      2850                     1                                                                                                                             
        10       7934 MILLER                     1300                     1                                                                                                                             
        20       7788 SCOTT                      3000                     1                                                                                                                             
        10       7839 KING                       5000                     1                                                                                                                             
        30       7654 MARTIN                     1250       1400         11                                                                                                                             
        30       7521 WARD                       1250        500         12                                                                                                                             
        30       7499 ALLEN                      1600        300         13                                                                                                                             
        30       7844 TURNER                     1500          0         14                                                                                                                             

14 rows selected.

SQL> select deptno, empno, ename, sal, comm, rank()	over (order by comm desc nulls first) as rank
  2  from emp;

    DEPTNO      EMPNO ENAME                       SAL       COMM       RANK                                                                                                                             
---------- ---------- -------------------- ---------- ---------- ----------                                                                                                                             
        20       7369 SMITH                       800                     1                                                                                                                             
        10       7782 CLARK                      2450                     1                                                                                                                             
        20       7902 FORD                       3000                     1                                                                                                                             
        30       7900 JAMES                       950                     1                                                                                                                             
        20       7876 ADAMS                      1100                     1                                                                                                                             
        20       7566 JONES                      2975                     1                                                                                                                             
        30       7698 BLAKE                      2850                     1                                                                                                                             
        10       7934 MILLER                     1300                     1                                                                                                                             
        20       7788 SCOTT                      3000                     1                                                                                                                             
        10       7839 KING                       5000                     1                                                                                                                             
        30       7654 MARTIN                     1250       1400         11                                                                                                                             
        30       7521 WARD                       1250        500         12                                                                                                                             
        30       7499 ALLEN                      1600        300         13                                                                                                                             
        30       7844 TURNER                     1500          0         14                                                                                                                             

14 rows selected.

SQL> select deptno, empno, ename, sal, comm, rank()	over (order by comm desc nulls last) as rank
  2  from emp;

    DEPTNO      EMPNO ENAME                       SAL       COMM       RANK                                                                                                                             
---------- ---------- -------------------- ---------- ---------- ----------                                                                                                                             
        30       7654 MARTIN                     1250       1400          1                                                                                                                             
        30       7521 WARD                       1250        500          2                                                                                                                             
        30       7499 ALLEN                      1600        300          3                                                                                                                             
        30       7844 TURNER                     1500          0          4                                                                                                                             
        20       7788 SCOTT                      3000                     5                                                                                                                             
        10       7839 KING                       5000                     5                                                                                                                             
        20       7876 ADAMS                      1100                     5                                                                                                                             
        30       7900 JAMES                       950                     5                                                                                                                             
        20       7902 FORD                       3000                     5                                                                                                                             
        10       7934 MILLER                     1300                     5                                                                                                                             
        30       7698 BLAKE                      2850                     5                                                                                                                             
        20       7566 JONES                      2975                     5                                                                                                                             
        20       7369 SMITH                       800                     5                                                                                                                             
        10       7782 CLARK                      2450                     5                                                                                                                             

14 rows selected.

SQL> select *
  2  from emp
  3  ;

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

SQL> select e.empno, e.ename, e.job, e.mgr, e.sal, e.comm, d.deptno, d.dname, d.loc, l.location_id
  2  from emp e, dept d, location l
  3  where e.deptno = d.deptno
  4  and d.location_id = l.location_id;
from emp e, dept d, location l
                    *
ERROR at line 2:
ORA-00942: table or view does not exist 


SQL> select e.empno, e.ename, e.job, e.mgr, e.sal, e.comm, d.deptno, d.dname, d.loc, l.location_id
  2  from emp e, dept d, locations l
  3  where e.deptno = d.deptno
  4  and d.location_id = l.location_id;
and d.location_id = l.location_id
    *
ERROR at line 4:
ORA-00904: "D"."LOCATION_ID": invalid identifier 


SQL> select * from location;
select * from location
              *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> select * from tab;

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

37 rows selected.

SQL> select * from locations;

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
                                                                                                                                                                                                        

SQL> select * from dept;

    DEPTNO DNAME                        LOC                                                                                                                                                             
---------- ---------------------------- --------------------------                                                                                                                                      
        10 ACCOUNTING                   NEW YORK                                                                                                                                                        
        20 RESEARCH                     DALLAS                                                                                                                                                          
        30 SALES                        CHICAGO                                                                                                                                                         
        40 OPERATIONS                   BOSTON                                                                                                                                                          

SQL> select * from regions;

 REGION_ID REGION_NAME                                                                                                                                                                                  
---------- --------------------------------------------------                                                                                                                                           
         1 Europe                                                                                                                                                                                       
         2 Americas                                                                                                                                                                                     
         3 Asia                                                                                                                                                                                         
         4 Middle East and Africa                                                                                                                                                                       

SQL> select * employees;
select * employees
         *
ERROR at line 1:
ORA-00923: FROM keyword not found where expected 


SQL> select * from employees;

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

SQL> select e.employee_id, e.salary, e.first_name, e.email, d.department_id, d.department_name, l.location_id, l.city
  2  from employees e, departments d, locations l
  3  where e.department_id = d.department_id
  4  and d.location_id = l.location_id;

EMPLOYEE_ID     SALARY FIRST_NAME                               EMAIL                                              DEPARTMENT_ID DEPARTMENT_NAME                                                        
----------- ---------- ---------------------------------------- -------------------------------------------------- ------------- ------------------------------------------------------------           
LOCATION_ID CITY                                                                                                                                                                                        
----------- ------------------------------------------------------------                                                                                                                                
        100      24000 Steven                                   SKING                                                         90 Executive                                                              
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        
        101      17000 Neena                                    NKOCHHAR                                                      90 Executive                                                              
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        
        102      17000 Lex                                      LDEHAAN                                                       90 Executive                                                              
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        
        103       9000 Alexander                                AHUNOLD                                                       60 IT                                                                     
       1400 Southlake                                                                                                                                                                                   
                                                                                                                                                                                                        
        104       6000 Bruce                                    BERNST                                                        60 IT                                                                     
       1400 Southlake                                                                                                                                                                                   
                                                                                                                                                                                                        
        107       4200 Diana                                    DLORENTZ                                                      60 IT                                                                     
       1400 Southlake                                                                                                                                                                                   
                                                                                                                                                                                                        
        124       5800 Kevin                                    KMOURGOS                                                      50 Shipping                                                               
       1500 South San Francisco                                                                                                                                                                         
                                                                                                                                                                                                        
        141       3500 Trenna                                   TRAJS                                                         50 Shipping                                                               
       1500 South San Francisco                                                                                                                                                                         
                                                                                                                                                                                                        
        142       3100 Curtis                                   CDAVIES                                                       50 Shipping                                                               
       1500 South San Francisco                                                                                                                                                                         
                                                                                                                                                                                                        
        143       2600 Randall                                  RMATOS                                                        50 Shipping                                                               
       1500 South San Francisco                                                                                                                                                                         
                                                                                                                                                                                                        
        144       2500 Peter                                    PVARGAS                                                       50 Shipping                                                               
       1500 South San Francisco                                                                                                                                                                         
                                                                                                                                                                                                        
        149      10500 Eleni                                    EZLOTKEY                                                      80 Sales                                                                  
       2500 Oxford                                                                                                                                                                                      
                                                                                                                                                                                                        
        174      11000 Ellen                                    EABEL                                                         80 Sales                                                                  
       2500 Oxford                                                                                                                                                                                      
                                                                                                                                                                                                        
        176       8600 Jonathon                                 JTAYLOR                                                       80 Sales                                                                  
       2500 Oxford                                                                                                                                                                                      
                                                                                                                                                                                                        
        200       4400 Jennifer                                 JWHALEN                                                       10 Administration                                                         
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        
        201      13000 Michael                                  MHARTSTE                                                      20 Marketing                                                              
       1800 Toronto                                                                                                                                                                                     
                                                                                                                                                                                                        
        202       6000 Pat                                      PFAY                                                          20 Marketing                                                              
       1800 Toronto                                                                                                                                                                                     
                                                                                                                                                                                                        
        205      12000 Shelley                                  SHIGGINS                                                     110 Accounting                                                             
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        
        206       8300 William                                  WGIETZ                                                       110 Accounting                                                             
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        

19 rows selected.

SQL> create or replace view v1
  2  as
  3   select e.employee_id, e.salary, e.first_name, e.email, d.department_id, d.department_name, l.location_id, l.city
  4   from employees e, departments d, locations l
  5   where e.department_id = d.department_id
  6   and d.location_id = l.location_id;

View created.

SQL> select employee_id, department_id, first_name, rank() over (partition by group_id(department_name, city)
  2  								order by sal desc) as rank_per_group
  3  from v1
  4  group by cube(department_name, city);
select employee_id, department_id, first_name, rank() over (partition by group_id(department_name, city)
                                                                                  *
ERROR at line 1:
ORA-00907: missing right parenthesis 


SQL> select employee_id, department_id, first_name, rank() over (partition by grouping_id(department_name, city)
  2  								order by sal desc) as rank_per_group
  3  from v1
  4  group by cube(department_name, city);
								order by sal desc) as rank_per_group
								         *
ERROR at line 2:
ORA-00904: "SAL": invalid identifier 


SQL> select employee_id, department_id, first_name, rank() over (partition by group_id(department_name, city)
  2  								order by sal desc) as rank_per_group
  3  from v1
  4  group by cube(department_name, city);
select employee_id, department_id, first_name, rank() over (partition by group_id(department_name, city)
                                                                                  *
ERROR at line 1:
ORA-00907: missing right parenthesis 


SQL> l 2
  2* 								order by sal desc) as rank_per_group
SQL> c/sal/salary
  2* 								order by salary desc) as rank_per_group
SQL> r
  1  select employee_id, department_id, first_name, rank() over (partition by group_id(department_name, city)
  2  								order by salary desc) as rank_per_group
  3  from v1
  4* group by cube(department_name, city)
select employee_id, department_id, first_name, rank() over (partition by group_id(department_name, city)
                                                                                  *
ERROR at line 1:
ORA-00907: missing right parenthesis 


SQL> select employee_id, department_id, first_name, rank() over (partition by grouping_id(department_name, city)
  2  from v1
  3  group by cube(department_name, city);
from v1
*
ERROR at line 2:
ORA-00907: missing right parenthesis 


SQL> 
SQL> select employee_id, department_id, first_name, rank() over (partition by grouping_id(department_name, city)
  2  								order by salary desc) as rank_per_group
  3  from v1
  4  group by cube(department_name, city);
select employee_id, department_id, first_name, rank() over (partition by grouping_id(department_name, city)
       *
ERROR at line 1:
ORA-00979: not a GROUP BY expression 


SQL> select employee_id, department_id, first_name, to_char(sum(salary),$999,999.99), rank() over (partition by grouping_id(department_name, city)
  2  
SQL> 
SQL> select employee_id, department_id, first_name, to_char(sum(salary),$999,999.99) as sal, rank() over (partition by grouping_id(department_name, city)
  2  									order by sal desc
  3  from v1
  4  group by cube(department_id, city);
select employee_id, department_id, first_name, to_char(sum(salary),$999,999.99) as sal, rank() over (partition by grouping_id(department_name, city)
                                                                   *
ERROR at line 1:
ORA-00911: invalid character 


SQL> select employee_id, department_id, first_name, to_char(sum(salary), '$999,999.99') as sal, rank() over (partition by grouping_id(department_name, city)
  2  									order by sal desc
  3  from v1
  4  group by cube(department_id, city);
from v1
*
ERROR at line 3:
ORA-00907: missing right parenthesis 


SQL> select employee_id, department_id, first_name, to_char(sum(salary),$999,999.99) as sal, rank() over (partition by grouping_id(department_name, city)
  2  									order by sal desc)
  3  from v1
  4  group by cube(department_id, city);
select employee_id, department_id, first_name, to_char(sum(salary),$999,999.99) as sal, rank() over (partition by grouping_id(department_name, city)
                                                                   *
ERROR at line 1:
ORA-00911: invalid character 


SQL> select employee_id, department_id, first_name, to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_name, city)
  2                                                                     order by sal desc)
  3  from v1
  4  group by cube(department_id, city);
                                                                   order by sal desc)
                                                                            *
ERROR at line 2:
ORA-00904: "SAL": invalid identifier 


SQL> select employee_id, department_id, first_name, to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_name, city)
  2                                                                     order by sum(salary) desc)
  3  from v1
  4  group by cube(department_id, city);
select employee_id, department_id, first_name, to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_name, city)
       *
ERROR at line 1:
ORA-00979: not a GROUP BY expression 


SQL> select employee_id, department_id, first_name, to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_name, city)
  2                                                                     order by sum(salary) desc)
  3  from v1
  4  group by cube(department_id, city);
select employee_id, department_id, first_name, to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_name, city)
       *
ERROR at line 1:
ORA-00979: not a GROUP BY expression 


SQL> select to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_name, city)
  2                                                                     order by sum(salary) desc)
  3  from v1
  4  group by cube(department_id, city);
select to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_name, city)
                                                                                        *
ERROR at line 1:
ORA-00979: not a GROUP BY expression 


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
  2  from v1;

EMPLOYEE_ID     SALARY FIRST_NAME                               EMAIL                                              DEPARTMENT_ID DEPARTMENT_NAME                                                        
----------- ---------- ---------------------------------------- -------------------------------------------------- ------------- ------------------------------------------------------------           
LOCATION_ID CITY                                                                                                                                                                                        
----------- ------------------------------------------------------------                                                                                                                                
        100      24000 Steven                                   SKING                                                         90 Executive                                                              
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        
        101      17000 Neena                                    NKOCHHAR                                                      90 Executive                                                              
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        
        102      17000 Lex                                      LDEHAAN                                                       90 Executive                                                              
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        
        103       9000 Alexander                                AHUNOLD                                                       60 IT                                                                     
       1400 Southlake                                                                                                                                                                                   
                                                                                                                                                                                                        
        104       6000 Bruce                                    BERNST                                                        60 IT                                                                     
       1400 Southlake                                                                                                                                                                                   
                                                                                                                                                                                                        
        107       4200 Diana                                    DLORENTZ                                                      60 IT                                                                     
       1400 Southlake                                                                                                                                                                                   
                                                                                                                                                                                                        
        124       5800 Kevin                                    KMOURGOS                                                      50 Shipping                                                               
       1500 South San Francisco                                                                                                                                                                         
                                                                                                                                                                                                        
        141       3500 Trenna                                   TRAJS                                                         50 Shipping                                                               
       1500 South San Francisco                                                                                                                                                                         
                                                                                                                                                                                                        
        142       3100 Curtis                                   CDAVIES                                                       50 Shipping                                                               
       1500 South San Francisco                                                                                                                                                                         
                                                                                                                                                                                                        
        143       2600 Randall                                  RMATOS                                                        50 Shipping                                                               
       1500 South San Francisco                                                                                                                                                                         
                                                                                                                                                                                                        
        144       2500 Peter                                    PVARGAS                                                       50 Shipping                                                               
       1500 South San Francisco                                                                                                                                                                         
                                                                                                                                                                                                        
        149      10500 Eleni                                    EZLOTKEY                                                      80 Sales                                                                  
       2500 Oxford                                                                                                                                                                                      
                                                                                                                                                                                                        
        174      11000 Ellen                                    EABEL                                                         80 Sales                                                                  
       2500 Oxford                                                                                                                                                                                      
                                                                                                                                                                                                        
        176       8600 Jonathon                                 JTAYLOR                                                       80 Sales                                                                  
       2500 Oxford                                                                                                                                                                                      
                                                                                                                                                                                                        
        200       4400 Jennifer                                 JWHALEN                                                       10 Administration                                                         
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        
        201      13000 Michael                                  MHARTSTE                                                      20 Marketing                                                              
       1800 Toronto                                                                                                                                                                                     
                                                                                                                                                                                                        
        202       6000 Pat                                      PFAY                                                          20 Marketing                                                              
       1800 Toronto                                                                                                                                                                                     
                                                                                                                                                                                                        
        205      12000 Shelley                                  SHIGGINS                                                     110 Accounting                                                             
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        
        206       8300 William                                  WGIETZ                                                       110 Accounting                                                             
       1700 Seattle                                                                                                                                                                                     
                                                                                                                                                                                                        

19 rows selected.

SQL> select to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_id, city)
  2                                                                     order by sum(salary) desc)
  3  from v1
  4  group by cube(department_id, city);

SAL                    RANK()OVER(PARTITIONBYGROUPING_ID(DEPARTMENT_ID,CITY)ORDERBYSUM(SALARY)DESC)                                                                                                     
---------------------- ----------------------------------------------------------------------------                                                                                                     
  58,000.00                                                                                       1                                                                                                     
  30,100.00                                                                                       2                                                                                                     
  20,300.00                                                                                       3                                                                                                     
  19,200.00                                                                                       4                                                                                                     
  19,000.00                                                                                       5                                                                                                     
  17,500.00                                                                                       6                                                                                                     
   4,400.00                                                                                       7                                                                                                     
  58,000.00                                                                                       1                                                                                                     
  30,100.00                                                                                       2                                                                                                     
  20,300.00                                                                                       3                                                                                                     
  19,200.00                                                                                       4                                                                                                     
  19,000.00                                                                                       5                                                                                                     
  17,500.00                                                                                       6                                                                                                     
   4,400.00                                                                                       7                                                                                                     
  82,700.00                                                                                       1                                                                                                     
  30,100.00                                                                                       2                                                                                                     
  19,200.00                                                                                       3                                                                                                     
  19,000.00                                                                                       4                                                                                                     
  17,500.00                                                                                       5                                                                                                     
 168,500.00                                                                                       1                                                                                                     

20 rows selected.

SQL> select employee_id, department_id,to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_id, city)
  2                                                                     order by sum(salary) desc)
  3  from v1
  4  group by cube(department_id, city);
select employee_id, department_id,to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_id, city)
       *
ERROR at line 1:
ORA-00979: not a GROUP BY expression 


SQL> select department_name, to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_id, city)
  2                                                                     order by sum(salary) desc)
  3  from v1
  4  group by cube(department_id, city);
select department_name, to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_id, city)
       *
ERROR at line 1:
ORA-00979: not a GROUP BY expression 


SQL> select department_id, city, to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_id, city)
  2                                                                     order by sum(salary) desc)
  3  from v1
  4  group by cube(department_id, city);

DEPARTMENT_ID CITY                                                         SAL                    RANK()OVER(PARTITIONBYGROUPING_ID(DEPARTMENT_ID,CITY)ORDERBYSUM(SALARY)DESC)                          
------------- ------------------------------------------------------------ ---------------------- ----------------------------------------------------------------------------                          
           90 Seattle                                                        58,000.00                                                                                       1                          
           80 Oxford                                                         30,100.00                                                                                       2                          
          110 Seattle                                                        20,300.00                                                                                       3                          
           60 Southlake                                                      19,200.00                                                                                       4                          
           20 Toronto                                                        19,000.00                                                                                       5                          
           50 South San Francisco                                            17,500.00                                                                                       6                          
           10 Seattle                                                         4,400.00                                                                                       7                          
           90                                                                58,000.00                                                                                       1                          
           80                                                                30,100.00                                                                                       2                          
          110                                                                20,300.00                                                                                       3                          
           60                                                                19,200.00                                                                                       4                          
           20                                                                19,000.00                                                                                       5                          
           50                                                                17,500.00                                                                                       6                          
           10                                                                 4,400.00                                                                                       7                          
              Seattle                                                        82,700.00                                                                                       1                          
              Oxford                                                         30,100.00                                                                                       2                          
              Southlake                                                      19,200.00                                                                                       3                          
              Toronto                                                        19,000.00                                                                                       4                          
              South San Francisco                                            17,500.00                                                                                       5                          
                                                                            168,500.00                                                                                       1                          

20 rows selected.

SQL> select department_id, city, to_char(sum(salary), '999,999.99') as sal, rank() over (partition by grouping_id(department_id, city)
  2                                                                     order by sum(salary) desc)
  3  from v1
  4  group by cube(department_id, city);

DEPARTMENT_ID CITY                                                         SAL                    RANK()OVER(PARTITIONBYGROUPING_ID(DEPARTMENT_ID,CITY)ORDERBYSUM(SALARY)DESC)                          
------------- ------------------------------------------------------------ ---------------------- ----------------------------------------------------------------------------                          
           90 Seattle                                                        58,000.00                                                                                       1                          
           80 Oxford                                                         30,100.00                                                                                       2                          
          110 Seattle                                                        20,300.00                                                                                       3                          
           60 Southlake                                                      19,200.00                                                                                       4                          
           20 Toronto                                                        19,000.00                                                                                       5                          
           50 South San Francisco                                            17,500.00                                                                                       6                          
           10 Seattle                                                         4,400.00                                                                                       7                          
           90                                                                58,000.00                                                                                       1                          
           80                                                                30,100.00                                                                                       2                          
          110                                                                20,300.00                                                                                       3                          
           60                                                                19,200.00                                                                                       4                          
           20                                                                19,000.00                                                                                       5                          
           50                                                                17,500.00                                                                                       6                          
           10                                                                 4,400.00                                                                                       7                          
              Seattle                                                        82,700.00                                                                                       1                          
              Oxford                                                         30,100.00                                                                                       2                          
              Southlake                                                      19,200.00                                                                                       3                          
              Toronto                                                        19,000.00                                                                                       4                          
              South San Francisco                                            17,500.00                                                                                       5                          
                                                                            168,500.00                                                                                       1                          

20 rows selected.

SQL> 
SQL> 
SQL> 
SQL> -- NTILE
SQL> 
SQL> drop table t1 cascade constraints purge;

Table dropped.

SQL> 
SQL> create table t1
  2  as
  3  select level as no
  4  from dual
  5  connect by level <= 10;

Table created.

SQL> select *
  2  from t1;

        NO                                                                                                                                                                                              
----------                                                                                                                                                                                              
         1                                                                                                                                                                                              
         2                                                                                                                                                                                              
         3                                                                                                                                                                                              
         4                                                                                                                                                                                              
         5                                                                                                                                                                                              
         6                                                                                                                                                                                              
         7                                                                                                                                                                                              
         8                                                                                                                                                                                              
         9                                                                                                                                                                                              
        10                                                                                                                                                                                              

10 rows selected.

SQL> select no,
  2  		ntile(2) over (order by no) as ntile1,
  3  		ntile(3) over (order by no) as ntile3,
  4  		ntile(4) over (order by no) as ntile4,
  5  		ntile(5) over (order by no) as ntile5
  6  from t1;

        NO     NTILE1     NTILE3     NTILE4     NTILE5                                                                                                                                                  
---------- ---------- ---------- ---------- ----------                                                                                                                                                  
         1          1          1          1          1                                                                                                                                                  
         2          1          1          1          1                                                                                                                                                  
         3          1          1          1          2                                                                                                                                                  
         4          1          1          2          2                                                                                                                                                  
         5          1          2          2          3                                                                                                                                                  
         6          2          2          2          3                                                                                                                                                  
         7          2          2          3          4                                                                                                                                                  
         8          2          3          3          4                                                                                                                                                  
         9          2          3          4          5                                                                                                                                                  
        10          2          3          4          5                                                                                                                                                  

10 rows selected.

SQL> select no, cume_dist() over (order by no) cume_dist,
  2  		percent_rank(0 over (order by no) as percent_rank
  3  from t1;
		percent_rank(0 over (order by no) as percent_rank
		               *
ERROR at line 2:
ORA-00907: missing right parenthesis 


SQL> select no, cume_dist() over (order by no) cume_dist,
  2  		percent_rank() over (order by no) as percent_rank
  3  from t1;

        NO  CUME_DIST PERCENT_RANK                                                                                                                                                                      
---------- ---------- ------------                                                                                                                                                                      
         1         .1            0                                                                                                                                                                      
         2         .2   .111111111                                                                                                                                                                      
         3         .3   .222222222                                                                                                                                                                      
         4         .4   .333333333                                                                                                                                                                      
         5         .5   .444444444                                                                                                                                                                      
         6         .6   .555555556                                                                                                                                                                      
         7         .7   .666666667                                                                                                                                                                      
         8         .8   .777777778                                                                                                                                                                      
         9         .9   .888888889                                                                                                                                                                      
        10          1            1                                                                                                                                                                      

10 rows selected.

SQL> select no, cume_dist(4) over (order by no) cume_dist,
  2  		percent_rank() over (partition by cume_dist(4) over (order by no) order by no) aa
  3  from t1;
select no, cume_dist(4) over (order by no) cume_dist,
                        *
ERROR at line 1:
ORA-02000: missing WITHIN keyword 


SQL> select level as no
  2  from (select level as no from dual connect by level <= 10)
  3  connect by level <= 20;
  SQL> select level as no
  2  from (select level as no1
  3  		from dual
  4  		connect by level <= 2)
  5  connect by level <= 3
  6  order by no
  7  ;

        NO                                                                                                                                                                                              
----------                                                                                                                                                                                              
         1                                                                                                                                                                                              
         1                                                                                                                                                                                              
         2                                                                                                                                                                                              
         2                                                                                                                                                                                              
         2                                                                                                                                                                                              
         2                                                                                                                                                                                              
         3                                                                                                                                                                                              
         3                                                                                                                                                                                              
         3                                                                                                                                                                                              
         3                                                                                                                                                                                              
         3                                                                                                                                                                                              
         3                                                                                                                                                                                              
         3                                                                                                                                                                                              
         3                                                                                                                                                                                              

14 rows selected.

SQL> create or replace view v1
  2  as
  3  select level as no
  4  from (select level as no1
  5             from dual
  6             connect by level <= 2)
  7  connect by level <= 3
  8  order by no
  9  ;

View created.

SQL> select no, cume_dist(4) over (order by no asc)
  2  from v1;
select no, cume_dist(4) over (order by no asc)
                        *
ERROR at line 1:
ORA-02000: missing WITHIN keyword 


SQL> select no, cume_dist() over (order by no asc)
  2  from v1;

        NO CUME_DIST()OVER(ORDERBYNOASC)                                                                                                                                                                
---------- -----------------------------                                                                                                                                                                
         1                    .142857143                                                                                                                                                                
         1                    .142857143                                                                                                                                                                
         2                    .428571429                                                                                                                                                                
         2                    .428571429                                                                                                                                                                
         2                    .428571429                                                                                                                                                                
         2                    .428571429                                                                                                                                                                
         3                             1                                                                                                                                                                
         3                             1                                                                                                                                                                
         3                             1                                                                                                                                                                
         3                             1                                                                                                                                                                
         3                             1                                                                                                                                                                
         3                             1                                                                                                                                                                
         3                             1                                                                                                                                                                
         3                             1                                                                                                                                                                

14 rows selected.

SQL> select no, cume_dist() over (order by no asc), percent_rank() over (order by no asc)
  2  from v1;

        NO CUME_DIST()OVER(ORDERBYNOASC) PERCENT_RANK()OVER(ORDERBYNOASC)                                                                                                                               
---------- ----------------------------- --------------------------------                                                                                                                               
         1                    .142857143                                0                                                                                                                               
         1                    .142857143                                0                                                                                                                               
         2                    .428571429                       .153846154                                                                                                                               
         2                    .428571429                       .153846154                                                                                                                               
         2                    .428571429                       .153846154                                                                                                                               
         2                    .428571429                       .153846154                                                                                                                               
         3                             1                       .461538462                                                                                                                               
         3                             1                       .461538462                                                                                                                               
         3                             1                       .461538462                                                                                                                               
         3                             1                       .461538462                                                                                                                               
         3                             1                       .461538462                                                                                                                               
         3                             1                       .461538462                                                                                                                               
         3                             1                       .461538462                                                                                                                               
         3                             1                       .461538462                                                                                                                               

14 rows selected.

SQL> select no, c, p, no*c, (no-1)*p
  2  from (select 1/10 c, 1/9 p from dual) a,
  3  	  (select level as no from dual connect by level <= 10) b;

        NO          C          P       NO*C   (NO-1)*P                                                                                                                                                  
---------- ---------- ---------- ---------- ----------                                                                                                                                                  
         1         .1 .111111111         .1          0                                                                                                                                                  
         2         .1 .111111111         .2 .111111111                                                                                                                                                  
         3         .1 .111111111         .3 .222222222                                                                                                                                                  
         4         .1 .111111111         .4 .333333333                                                                                                                                                  
         5         .1 .111111111         .5 .444444444                                                                                                                                                  
         6         .1 .111111111         .6 .555555556                                                                                                                                                  
         7         .1 .111111111         .7 .666666667                                                                                                                                                  
         8         .1 .111111111         .8 .777777778                                                                                                                                                  
         9         .1 .111111111         .9 .888888889                                                                                                                                                  
        10         .1 .111111111          1          1                                                                                                                                                  

10 rows selected.

SQL> select deptno, empno, ename, sal
  2  from emp
  3  order by sal desc;

    DEPTNO      EMPNO ENAME                       SAL                                                                                                                                                   
---------- ---------- -------------------- ----------                                                                                                                                                   
        10       7839 KING                       5000                                                                                                                                                   
        20       7902 FORD                       3000                                                                                                                                                   
        20       7788 SCOTT                      3000                                                                                                                                                   
        20       7566 JONES                      2975                                                                                                                                                   
        30       7698 BLAKE                      2850                                                                                                                                                   
        10       7782 CLARK                      2450                                                                                                                                                   
        30       7499 ALLEN                      1600                                                                                                                                                   
        30       7844 TURNER                     1500                                                                                                                                                   
        10       7934 MILLER                     1300                                                                                                                                                   
        30       7521 WARD                       1250                                                                                                                                                   
        30       7654 MARTIN                     1250                                                                                                                                                   
        20       7876 ADAMS                      1100                                                                                                                                                   
        30       7900 JAMES                       950                                                                                                                                                   
        20       7369 SMITH                       800                                                                                                                                                   

14 rows selected.

SQL> select deptno, empno, ename, sal, cume_dist() over (order by sal desc) as cume_dist,
  2  					percent_rank() over (order by sal desc) as percent_rank
  3  from emp;

    DEPTNO      EMPNO ENAME                       SAL  CUME_DIST PERCENT_RANK                                                                                                                           
---------- ---------- -------------------- ---------- ---------- ------------                                                                                                                           
        10       7839 KING                       5000 .071428571            0                                                                                                                           
        20       7902 FORD                       3000 .214285714   .076923077                                                                                                                           
        20       7788 SCOTT                      3000 .214285714   .076923077                                                                                                                           
        20       7566 JONES                      2975 .285714286   .230769231                                                                                                                           
        30       7698 BLAKE                      2850 .357142857   .307692308                                                                                                                           
        10       7782 CLARK                      2450 .428571429   .384615385                                                                                                                           
        30       7499 ALLEN                      1600         .5   .461538462                                                                                                                           
        30       7844 TURNER                     1500 .571428571   .538461538                                                                                                                           
        10       7934 MILLER                     1300 .642857143   .615384615                                                                                                                           
        30       7521 WARD                       1250 .785714286   .692307692                                                                                                                           
        30       7654 MARTIN                     1250 .785714286   .692307692                                                                                                                           
        20       7876 ADAMS                      1100 .857142857   .846153846                                                                                                                           
        30       7900 JAMES                       950 .928571429   .923076923                                                                                                                           
        20       7369 SMITH                       800          1            1                                                                                                                           

14 rows selected.

SQL> 
SQL> 
SQL> 
SQL> 
SQL> --Reporting
SQL> 
SQL> select deptno, ename, sal
  2  from emp;

    DEPTNO ENAME                       SAL                                                                                                                                                              
---------- -------------------- ----------                                                                                                                                                              
        20 SMITH                       800                                                                                                                                                              
        30 ALLEN                      1600                                                                                                                                                              
        30 WARD                       1250                                                                                                                                                              
        20 JONES                      2975                                                                                                                                                              
        30 MARTIN                     1250                                                                                                                                                              
        30 BLAKE                      2850                                                                                                                                                              
        10 CLARK                      2450                                                                                                                                                              
        20 SCOTT                      3000                                                                                                                                                              
        10 KING                       5000                                                                                                                                                              
        30 TURNER                     1500                                                                                                                                                              
        20 ADAMS                      1100                                                                                                                                                              
        30 JAMES                       950                                                                                                                                                              
        20 FORD                       3000                                                                                                                                                              
        10 MILLER                     1300                                                                                                                                                              

14 rows selected.

SQL> select deptno, ename, sal,
  2  	sum(sal) over () as Aggregation
  3  	sum(sal) over (partition by deptno) Agg.department
  4  from emp;
	sum(sal) over (partition by deptno) Agg.department
	*
ERROR at line 3:
ORA-00923: FROM keyword not found where expected 


SQL> select deptno, ename, sal,
  2  	sum(sal) over () as Aggregation
  3  	sum(sal) over (partition by deptno) Agg_department
  4  from emp;
	sum(sal) over (partition by deptno) Agg_department
	*
ERROR at line 3:
ORA-00923: FROM keyword not found where expected 


SQL> select deptno, ename, sal,
  2  	sum(sal) over () as Aggregation,
  3  	sum(sal) over (partition by deptno) Agg_department
  4  from emp;

    DEPTNO ENAME                       SAL AGGREGATION AGG_DEPARTMENT                                                                                                                                   
---------- -------------------- ---------- ----------- --------------                                                                                                                                   
        10 CLARK                      2450       29025           8750                                                                                                                                   
        10 KING                       5000       29025           8750                                                                                                                                   
        10 MILLER                     1300       29025           8750                                                                                                                                   
        20 JONES                      2975       29025          10875                                                                                                                                   
        20 FORD                       3000       29025          10875                                                                                                                                   
        20 ADAMS                      1100       29025          10875                                                                                                                                   
        20 SMITH                       800       29025          10875                                                                                                                                   
        20 SCOTT                      3000       29025          10875                                                                                                                                   
        30 WARD                       1250       29025           9400                                                                                                                                   
        30 TURNER                     1500       29025           9400                                                                                                                                   
        30 ALLEN                      1600       29025           9400                                                                                                                                   
        30 JAMES                       950       29025           9400                                                                                                                                   
        30 BLAKE                      2850       29025           9400                                                                                                                                   
        30 MARTIN                     1250       29025           9400                                                                                                                                   

14 rows selected.

SQL> select deptno, ename, sal, '총계', '부서총계', to_char(sal/총계,       .9999999), to_char(sal/부서총계,     .9999999)
  2  from (select deptno, ename, sal, sum(sal) over () as 총계, sum(sal) over (partition by deptno) as 부서총계
  3  		from emp);

    DEPTNO ENAME                       SAL '총계'       '부서총계'               TO_CHAR(SAL/총계,. TO_CHAR(SAL/부서총                                                                                  
---------- -------------------- ---------- ------------ ------------------------ ------------------ ------------------                                                                                  
        10 CLARK                      2450 총계         부서총계                  .0844100           .2800000                                                                                           
        10 KING                       5000 총계         부서총계                  .1722653           .5714286                                                                                           
        10 MILLER                     1300 총계         부서총계                  .0447890           .1485714                                                                                           
        20 JONES                      2975 총계         부서총계                  .1024978           .2735632                                                                                           
        20 FORD                       3000 총계         부서총계                  .1033592           .2758621                                                                                           
        20 ADAMS                      1100 총계         부서총계                  .0378984           .1011494                                                                                           
        20 SMITH                       800 총계         부서총계                  .0275624           .0735632                                                                                           
        20 SCOTT                      3000 총계         부서총계                  .1033592           .2758621                                                                                           
        30 WARD                       1250 총계         부서총계                  .0430663           .1329787                                                                                           
        30 TURNER                     1500 총계         부서총계                  .0516796           .1595745                                                                                           
        30 ALLEN                      1600 총계         부서총계                  .0551249           .1702128                                                                                           
        30 JAMES                       950 총계         부서총계                  .0327304           .1010638                                                                                           
        30 BLAKE                      2850 총계         부서총계                  .0981912           .3031915                                                                                           
        30 MARTIN                     1250 총계         부서총계                  .0430663           .1329787                                                                                           

14 rows selected.

SQL> 
SQL> --windowing
SQL> 
SQL> select deptno, ename, sal, sum(sal) over (order by sal desc, ename) as sum1
  2  from emp;

    DEPTNO ENAME                       SAL       SUM1                                                                                                                                                   
---------- -------------------- ---------- ----------                                                                                                                                                   
        10 KING                       5000       5000                                                                                                                                                   
        20 FORD                       3000       8000                                                                                                                                                   
        20 SCOTT                      3000      11000                                                                                                                                                   
        20 JONES                      2975      13975                                                                                                                                                   
        30 BLAKE                      2850      16825                                                                                                                                                   
        10 CLARK                      2450      19275                                                                                                                                                   
        30 ALLEN                      1600      20875                                                                                                                                                   
        30 TURNER                     1500      22375                                                                                                                                                   
        10 MILLER                     1300      23675                                                                                                                                                   
        30 MARTIN                     1250      24925                                                                                                                                                   
        30 WARD                       1250      26175                                                                                                                                                   
        20 ADAMS                      1100      27275                                                                                                                                                   
        30 JAMES                       950      28225                                                                                                                                                   
        20 SMITH                       800      29025                                                                                                                                                   

14 rows selected.

SQL> select deptno, ename, sal, sum(sal) over (order by sal desc, ename rows 2 preceding) as sum1
  2  from emp;

    DEPTNO ENAME                       SAL       SUM1                                                                                                                                                   
---------- -------------------- ---------- ----------                                                                                                                                                   
        10 KING                       5000       5000                                                                                                                                                   
        20 FORD                       3000       8000                                                                                                                                                   
        20 SCOTT                      3000      11000                                                                                                                                                   
        20 JONES                      2975       8975                                                                                                                                                   
        30 BLAKE                      2850       8825                                                                                                                                                   
        10 CLARK                      2450       8275                                                                                                                                                   
        30 ALLEN                      1600       6900                                                                                                                                                   
        30 TURNER                     1500       5550                                                                                                                                                   
        10 MILLER                     1300       4400                                                                                                                                                   
        30 MARTIN                     1250       4050                                                                                                                                                   
        30 WARD                       1250       3800                                                                                                                                                   
        20 ADAMS                      1100       3600                                                                                                                                                   
        30 JAMES                       950       3300                                                                                                                                                   
        20 SMITH                       800       2850                                                                                                                                                   

14 rows selected.

SQL> 
SQL> 
SQL> --avg function
SQL> 
SQL> select deptno, ename, sal, avg(sal) over () as 전체평균 , avg(sal) over (partition by deptno) as 부서별평균
  2  from emp;

    DEPTNO ENAME                       SAL   전체평균 부서별평균                                                                                                                                        
---------- -------------------- ---------- ---------- ----------                                                                                                                                        
        10 CLARK                      2450 2073.21429 2916.66667                                                                                                                                        
        10 KING                       5000 2073.21429 2916.66667                                                                                                                                        
        10 MILLER                     1300 2073.21429 2916.66667                                                                                                                                        
        20 JONES                      2975 2073.21429       2175                                                                                                                                        
        20 FORD                       3000 2073.21429       2175                                                                                                                                        
        20 ADAMS                      1100 2073.21429       2175                                                                                                                                        
        20 SMITH                       800 2073.21429       2175                                                                                                                                        
        20 SCOTT                      3000 2073.21429       2175                                                                                                                                        
        30 WARD                       1250 2073.21429 1566.66667                                                                                                                                        
        30 TURNER                     1500 2073.21429 1566.66667                                                                                                                                        
        30 ALLEN                      1600 2073.21429 1566.66667                                                                                                                                        
        30 JAMES                       950 2073.21429 1566.66667                                                                                                                                        
        30 BLAKE                      2850 2073.21429 1566.66667                                                                                                                                        
        30 MARTIN                     1250 2073.21429 1566.66667                                                                                                                                        

14 rows selected.

SQL> select deptno, ename, sal, (select avg(sal) from emp) as 전체평균, (select avg(sal) from emp where deptno = e1.deptno) as 부서별평균
  2  from emp e1
  3  order by deptno;

    DEPTNO ENAME                       SAL   전체평균 부서별평균                                                                                                                                        
---------- -------------------- ---------- ---------- ----------                                                                                                                                        
        10 CLARK                      2450 2073.21429 2916.66667                                                                                                                                        
        10 KING                       5000 2073.21429 2916.66667                                                                                                                                        
        10 MILLER                     1300 2073.21429 2916.66667                                                                                                                                        
        20 JONES                      2975 2073.21429       2175                                                                                                                                        
        20 FORD                       3000 2073.21429       2175                                                                                                                                        
        20 ADAMS                      1100 2073.21429       2175                                                                                                                                        
        20 SMITH                       800 2073.21429       2175                                                                                                                                        
        20 SCOTT                      3000 2073.21429       2175                                                                                                                                        
        30 WARD                       1250 2073.21429 1566.66667                                                                                                                                        
        30 TURNER                     1500 2073.21429 1566.66667                                                                                                                                        
        30 ALLEN                      1600 2073.21429 1566.66667                                                                                                                                        
        30 JAMES                       950 2073.21429 1566.66667                                                                                                                                        
        30 BLAKE                      2850 2073.21429 1566.66667                                                                                                                                        
        30 MARTIN                     1250 2073.21429 1566.66667                                                                                                                                        

14 rows selected.

SQL> select deptno, ename, sal, avg(sal) over (order by sal desc, ename) as vag1
  2  from emp;

    DEPTNO ENAME                       SAL       VAG1                                                                                                                                                   
---------- -------------------- ---------- ----------                                                                                                                                                   
        10 KING                       5000       5000                                                                                                                                                   
        20 FORD                       3000       4000                                                                                                                                                   
        20 SCOTT                      3000 3666.66667                                                                                                                                                   
        20 JONES                      2975    3493.75                                                                                                                                                   
        30 BLAKE                      2850       3365                                                                                                                                                   
        10 CLARK                      2450     3212.5                                                                                                                                                   
        30 ALLEN                      1600 2982.14286                                                                                                                                                   
        30 TURNER                     1500   2796.875                                                                                                                                                   
        10 MILLER                     1300 2630.55556                                                                                                                                                   
        30 MARTIN                     1250     2492.5                                                                                                                                                   
        30 WARD                       1250 2379.54545                                                                                                                                                   
        20 ADAMS                      1100 2272.91667                                                                                                                                                   
        30 JAMES                       950 2171.15385                                                                                                                                                   
        20 SMITH                       800 2073.21429                                                                                                                                                   

14 rows selected.

SQL> select deptno, ename, sal, avg(sal) over (partition by deptno order by sal desc) as avg1
  2  from emp;

    DEPTNO ENAME                       SAL       AVG1                                                                                                                                                   
---------- -------------------- ---------- ----------                                                                                                                                                   
        10 KING                       5000       5000                                                                                                                                                   
        10 CLARK                      2450       3725                                                                                                                                                   
        10 MILLER                     1300 2916.66667                                                                                                                                                   
        20 SCOTT                      3000       3000                                                                                                                                                   
        20 FORD                       3000       3000                                                                                                                                                   
        20 JONES                      2975 2991.66667                                                                                                                                                   
        20 ADAMS                      1100    2518.75                                                                                                                                                   
        20 SMITH                       800       2175                                                                                                                                                   
        30 BLAKE                      2850       2850                                                                                                                                                   
        30 ALLEN                      1600       2225                                                                                                                                                   
        30 TURNER                     1500 1983.33333                                                                                                                                                   
        30 MARTIN                     1250       1690                                                                                                                                                   
        30 WARD                       1250       1690                                                                                                                                                   
        30 JAMES                       950 1566.66667                                                                                                                                                   

14 rows selected.

SQL> select deptno, ename, sal, avg(sal) over (partition by deptno order by sal desc, ename rows 2 preceding) as avg1
  2  from emp;

    DEPTNO ENAME                       SAL       AVG1                                                                                                                                                   
---------- -------------------- ---------- ----------                                                                                                                                                   
        10 KING                       5000       5000                                                                                                                                                   
        10 CLARK                      2450       3725                                                                                                                                                   
        10 MILLER                     1300 2916.66667                                                                                                                                                   
        20 FORD                       3000       3000                                                                                                                                                   
        20 SCOTT                      3000       3000                                                                                                                                                   
        20 JONES                      2975 2991.66667                                                                                                                                                   
        20 ADAMS                      1100 2358.33333                                                                                                                                                   
        20 SMITH                       800       1625                                                                                                                                                   
        30 BLAKE                      2850       2850                                                                                                                                                   
        30 ALLEN                      1600       2225                                                                                                                                                   
        30 TURNER                     1500 1983.33333                                                                                                                                                   
        30 MARTIN                     1250       1450                                                                                                                                                   
        30 WARD                       1250 1333.33333                                                                                                                                                   
        30 JAMES                       950       1150                                                                                                                                                   

14 rows selected.

SQL> drop table t1 purge;

Table dropped.

SQL> create table t1
  2  as
  3  select decode(mod(level, 15), 0, 15, mod(level, 15)) as no,
  4  	case when level <= 15 then 'A',
  5  	     when level <= 30 then 'B',
  6          when level <= 45 then 'C'
  7  	end as stock,
  8  	to_date('20111201', 'YYYYMMDD') + mod(level - 1, 15) as day,
  9  	round(dbms_random.value(100,150)) as price
 10  from dual
 11  connect by level <= 45;
	case when level <= 15 then 'A',
	                              *
ERROR at line 4:
ORA-00905: missing keyword 


SQL> create table t1
  2               as
  3               select decode(mod(level, 15), 0, 15, mod(level, 15)) as no,
  4                      case when level <= 15 then 'A'
  5                           when level <= 30 then 'B'
  6                           when level <= 45 then 'C'
  7                      end as stock,
  8                      to_date('20111201', 'YYYYMMDD') + mod(level - 1, 15) as day,
  9                      round(dbms_random.value(100, 150)) as price
 10               from dual
 11               connect by level <= 45;

Table created.

SQL> select stock, no, day, price from t1;

ST         NO DAY               PRICE                                                                                                                                                                   
-- ---------- ------------ ----------                                                                                                                                                                   
A           1 01-DEC-11           142                                                                                                                                                                   
A           2 02-DEC-11           144                                                                                                                                                                   
A           3 03-DEC-11           132                                                                                                                                                                   
A           4 04-DEC-11           105                                                                                                                                                                   
A           5 05-DEC-11           121                                                                                                                                                                   
A           6 06-DEC-11           148                                                                                                                                                                   
A           7 07-DEC-11           142                                                                                                                                                                   
A           8 08-DEC-11           134                                                                                                                                                                   
A           9 09-DEC-11           136                                                                                                                                                                   
A          10 10-DEC-11           142                                                                                                                                                                   
A          11 11-DEC-11           123                                                                                                                                                                   
A          12 12-DEC-11           146                                                                                                                                                                   
A          13 13-DEC-11           145                                                                                                                                                                   
A          14 14-DEC-11           111                                                                                                                                                                   
A          15 15-DEC-11           142                                                                                                                                                                   
B           1 01-DEC-11           108                                                                                                                                                                   
B           2 02-DEC-11           139                                                                                                                                                                   
B           3 03-DEC-11           111                                                                                                                                                                   
B           4 04-DEC-11           112                                                                                                                                                                   
B           5 05-DEC-11           128                                                                                                                                                                   
B           6 06-DEC-11           109                                                                                                                                                                   
B           7 07-DEC-11           103                                                                                                                                                                   
B           8 08-DEC-11           129                                                                                                                                                                   
B           9 09-DEC-11           118                                                                                                                                                                   
B          10 10-DEC-11           102                                                                                                                                                                   
B          11 11-DEC-11           110                                                                                                                                                                   
B          12 12-DEC-11           102                                                                                                                                                                   
B          13 13-DEC-11           141                                                                                                                                                                   
B          14 14-DEC-11           108                                                                                                                                                                   
B          15 15-DEC-11           141                                                                                                                                                                   
C           1 01-DEC-11           118                                                                                                                                                                   
C           2 02-DEC-11           107                                                                                                                                                                   
C           3 03-DEC-11           119                                                                                                                                                                   
C           4 04-DEC-11           136                                                                                                                                                                   
C           5 05-DEC-11           132                                                                                                                                                                   
C           6 06-DEC-11           149                                                                                                                                                                   
C           7 07-DEC-11           146                                                                                                                                                                   
C           8 08-DEC-11           127                                                                                                                                                                   
C           9 09-DEC-11           127                                                                                                                                                                   
C          10 10-DEC-11           102                                                                                                                                                                   
C          11 11-DEC-11           135                                                                                                                                                                   
C          12 12-DEC-11           147                                                                                                                                                                   
C          13 13-DEC-11           105                                                                                                                                                                   
C          14 14-DEC-11           135                                                                                                                                                                   
C          15 15-DEC-11           122                                                                                                                                                                   

45 rows selected.

SQL> select stock, no, day, price, avg(price) over (partition by stock order by day range 2 preceding) as "3일 이동 평균"
  2  from t1;

ST         NO DAY               PRICE 3일 이동 평균                                                                                                                                                     
-- ---------- ------------ ---------- -------------                                                                                                                                                     
A           1 01-DEC-11           142           142                                                                                                                                                     
A           2 02-DEC-11           144           143                                                                                                                                                     
A           3 03-DEC-11           132    139.333333                                                                                                                                                     
A           4 04-DEC-11           105           127                                                                                                                                                     
A           5 05-DEC-11           121    119.333333                                                                                                                                                     
A           6 06-DEC-11           148    124.666667                                                                                                                                                     
A           7 07-DEC-11           142           137                                                                                                                                                     
A           8 08-DEC-11           134    141.333333                                                                                                                                                     
A           9 09-DEC-11           136    137.333333                                                                                                                                                     
A          10 10-DEC-11           142    137.333333                                                                                                                                                     
A          11 11-DEC-11           123    133.666667                                                                                                                                                     
A          12 12-DEC-11           146           137                                                                                                                                                     
A          13 13-DEC-11           145           138                                                                                                                                                     
A          14 14-DEC-11           111           134                                                                                                                                                     
A          15 15-DEC-11           142    132.666667                                                                                                                                                     
B           1 01-DEC-11           108           108                                                                                                                                                     
B           2 02-DEC-11           139         123.5                                                                                                                                                     
B           3 03-DEC-11           111    119.333333                                                                                                                                                     
B           4 04-DEC-11           112    120.666667                                                                                                                                                     
B           5 05-DEC-11           128           117                                                                                                                                                     
B           6 06-DEC-11           109    116.333333                                                                                                                                                     
B           7 07-DEC-11           103    113.333333                                                                                                                                                     
B           8 08-DEC-11           129    113.666667                                                                                                                                                     
B           9 09-DEC-11           118    116.666667                                                                                                                                                     
B          10 10-DEC-11           102    116.333333                                                                                                                                                     
B          11 11-DEC-11           110           110                                                                                                                                                     
B          12 12-DEC-11           102    104.666667                                                                                                                                                     
B          13 13-DEC-11           141    117.666667                                                                                                                                                     
B          14 14-DEC-11           108           117                                                                                                                                                     
B          15 15-DEC-11           141           130                                                                                                                                                     
C           1 01-DEC-11           118           118                                                                                                                                                     
C           2 02-DEC-11           107         112.5                                                                                                                                                     
C           3 03-DEC-11           119    114.666667                                                                                                                                                     
C           4 04-DEC-11           136    120.666667                                                                                                                                                     
C           5 05-DEC-11           132           129                                                                                                                                                     
C           6 06-DEC-11           149           139                                                                                                                                                     
C           7 07-DEC-11           146    142.333333                                                                                                                                                     
C           8 08-DEC-11           127    140.666667                                                                                                                                                     
C           9 09-DEC-11           127    133.333333                                                                                                                                                     
C          10 10-DEC-11           102    118.666667                                                                                                                                                     
C          11 11-DEC-11           135    121.333333                                                                                                                                                     
C          12 12-DEC-11           147           128                                                                                                                                                     
C          13 13-DEC-11           105           129                                                                                                                                                     
C          14 14-DEC-11           135           129                                                                                                                                                     
C          15 15-DEC-11           122    120.666667                                                                                                                                                     

45 rows selected.

SQL> with t as (
  2  		select stock, no, day, price, avg(price) over (partition by stock order by day range 2 preceding) as day 3
  3  		from t1)
  4  select stock, no, day, price, day3, rpad('*', round(day3/5), '*') as stars
  5  from t;
		select stock, no, day, price, avg(price) over (partition by stock order by day range 2 preceding) as day 3
		                                                                                                         *
ERROR at line 2:
ORA-00923: FROM keyword not found where expected 


SQL>          with t as (
  2                          select stock, no, day, price, avg(price) over (partition by stock
  3                                                                         order by day range 2 preceding) as day3
  4                          from t1)
  5               select stock, no, day, price, day3, rpad('*', round(day3/5), '*') as stars
  6               from t;

ST         NO DAY               PRICE       DAY3                                                                                                                                                        
-- ---------- ------------ ---------- ----------                                                                                                                                                        
STARS                                                                                                                                                                                                   
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
A           1 01-DEC-11           142        142                                                                                                                                                        
****************************                                                                                                                                                                            
                                                                                                                                                                                                        
A           2 02-DEC-11           144        143                                                                                                                                                        
*****************************                                                                                                                                                                           
                                                                                                                                                                                                        
A           3 03-DEC-11           132 139.333333                                                                                                                                                        
****************************                                                                                                                                                                            
                                                                                                                                                                                                        
A           4 04-DEC-11           105        127                                                                                                                                                        
*************************                                                                                                                                                                               
                                                                                                                                                                                                        
A           5 05-DEC-11           121 119.333333                                                                                                                                                        
************************                                                                                                                                                                                
                                                                                                                                                                                                        
A           6 06-DEC-11           148 124.666667                                                                                                                                                        
*************************                                                                                                                                                                               
                                                                                                                                                                                                        
A           7 07-DEC-11           142        137                                                                                                                                                        
***************************                                                                                                                                                                             
                                                                                                                                                                                                        
A           8 08-DEC-11           134 141.333333                                                                                                                                                        
****************************                                                                                                                                                                            
                                                                                                                                                                                                        
A           9 09-DEC-11           136 137.333333                                                                                                                                                        
***************************                                                                                                                                                                             
                                                                                                                                                                                                        
A          10 10-DEC-11           142 137.333333                                                                                                                                                        
***************************                                                                                                                                                                             
                                                                                                                                                                                                        
A          11 11-DEC-11           123 133.666667                                                                                                                                                        
***************************                                                                                                                                                                             
                                                                                                                                                                                                        
A          12 12-DEC-11           146        137                                                                                                                                                        
***************************                                                                                                                                                                             
                                                                                                                                                                                                        
A          13 13-DEC-11           145        138                                                                                                                                                        
****************************                                                                                                                                                                            
                                                                                                                                                                                                        
A          14 14-DEC-11           111        134                                                                                                                                                        
***************************                                                                                                                                                                             
                                                                                                                                                                                                        
A          15 15-DEC-11           142 132.666667                                                                                                                                                        
***************************                                                                                                                                                                             
                                                                                                                                                                                                        
B           1 01-DEC-11           108        108                                                                                                                                                        
**********************                                                                                                                                                                                  
                                                                                                                                                                                                        
B           2 02-DEC-11           139      123.5                                                                                                                                                        
*************************                                                                                                                                                                               
                                                                                                                                                                                                        
B           3 03-DEC-11           111 119.333333                                                                                                                                                        
************************                                                                                                                                                                                
                                                                                                                                                                                                        
B           4 04-DEC-11           112 120.666667                                                                                                                                                        
************************                                                                                                                                                                                
                                                                                                                                                                                                        
B           5 05-DEC-11           128        117                                                                                                                                                        
***********************                                                                                                                                                                                 
                                                                                                                                                                                                        
B           6 06-DEC-11           109 116.333333                                                                                                                                                        
***********************                                                                                                                                                                                 
                                                                                                                                                                                                        
B           7 07-DEC-11           103 113.333333                                                                                                                                                        
***********************                                                                                                                                                                                 
                                                                                                                                                                                                        
B           8 08-DEC-11           129 113.666667                                                                                                                                                        
***********************                                                                                                                                                                                 
                                                                                                                                                                                                        
B           9 09-DEC-11           118 116.666667                                                                                                                                                        
***********************                                                                                                                                                                                 
                                                                                                                                                                                                        
B          10 10-DEC-11           102 116.333333                                                                                                                                                        
***********************                                                                                                                                                                                 
                                                                                                                                                                                                        
B          11 11-DEC-11           110        110                                                                                                                                                        
**********************                                                                                                                                                                                  
                                                                                                                                                                                                        
B          12 12-DEC-11           102 104.666667                                                                                                                                                        
*********************                                                                                                                                                                                   
                                                                                                                                                                                                        
B          13 13-DEC-11           141 117.666667                                                                                                                                                        
************************                                                                                                                                                                                
                                                                                                                                                                                                        
B          14 14-DEC-11           108        117                                                                                                                                                        
***********************                                                                                                                                                                                 
                                                                                                                                                                                                        
B          15 15-DEC-11           141        130                                                                                                                                                        
**************************                                                                                                                                                                              
                                                                                                                                                                                                        
C           1 01-DEC-11           118        118                                                                                                                                                        
************************                                                                                                                                                                                
                                                                                                                                                                                                        
C           2 02-DEC-11           107      112.5                                                                                                                                                        
***********************                                                                                                                                                                                 

ST         NO DAY               PRICE       DAY3                                                                                                                                                        
-- ---------- ------------ ---------- ----------                                                                                                                                                        
STARS                                                                                                                                                                                                   
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                                                                                                                        
C           3 03-DEC-11           119 114.666667                                                                                                                                                        
***********************                                                                                                                                                                                 
                                                                                                                                                                                                        
C           4 04-DEC-11           136 120.666667                                                                                                                                                        
************************                                                                                                                                                                                
                                                                                                                                                                                                        
C           5 05-DEC-11           132        129                                                                                                                                                        
**************************                                                                                                                                                                              
                                                                                                                                                                                                        
C           6 06-DEC-11           149        139                                                                                                                                                        
****************************                                                                                                                                                                            
                                                                                                                                                                                                        
C           7 07-DEC-11           146 142.333333                                                                                                                                                        
****************************                                                                                                                                                                            
                                                                                                                                                                                                        
C           8 08-DEC-11           127 140.666667                                                                                                                                                        
****************************                                                                                                                                                                            
                                                                                                                                                                                                        
C           9 09-DEC-11           127 133.333333                                                                                                                                                        
***************************                                                                                                                                                                             
                                                                                                                                                                                                        
C          10 10-DEC-11           102 118.666667                                                                                                                                                        
************************                                                                                                                                                                                
                                                                                                                                                                                                        
C          11 11-DEC-11           135 121.333333                                                                                                                                                        
************************                                                                                                                                                                                
                                                                                                                                                                                                        
C          12 12-DEC-11           147        128                                                                                                                                                        
**************************                                                                                                                                                                              
                                                                                                                                                                                                        
C          13 13-DEC-11           105        129                                                                                                                                                        
**************************                                                                                                                                                                              
                                                                                                                                                                                                        
C          14 14-DEC-11           135        129                                                                                                                                                        
**************************                                                                                                                                                                              
                                                                                                                                                                                                        
C          15 15-DEC-11           122 120.666667                                                                                                                                                        
************************                                                                                                                                                                                
                                                                                                                                                                                                        

45 rows selected.

SQL> 
SQL> 
SQL> 
SQL> 
SQL> 
SQL> 
SQL> -MAX/ MIN
SP2-0042: unknown command "-MAX/ MIN" - rest of line ignored.
SQL> 
SQL> 
SQL> 
SQL> select deptno, ename, sal, max(sal) over () as 전체최대, max(sal) over (partition by deptno) as 부서별최대,
  2  	min(sal) over () as 전체최소, min(sal) over (partition by deptno) as 부서별최소
  3  from emp;

    DEPTNO ENAME                       SAL   전체최대 부서별최대   전체최소 부서별최소                                                                                                                  
---------- -------------------- ---------- ---------- ---------- ---------- ----------                                                                                                                  
        10 CLARK                      2450       5000       5000        800       1300                                                                                                                  
        10 KING                       5000       5000       5000        800       1300                                                                                                                  
        10 MILLER                     1300       5000       5000        800       1300                                                                                                                  
        20 JONES                      2975       5000       3000        800        800                                                                                                                  
        20 FORD                       3000       5000       3000        800        800                                                                                                                  
        20 ADAMS                      1100       5000       3000        800        800                                                                                                                  
        20 SMITH                       800       5000       3000        800        800                                                                                                                  
        20 SCOTT                      3000       5000       3000        800        800                                                                                                                  
        30 WARD                       1250       5000       2850        800        950                                                                                                                  
        30 TURNER                     1500       5000       2850        800        950                                                                                                                  
        30 ALLEN                      1600       5000       2850        800        950                                                                                                                  
        30 JAMES                       950       5000       2850        800        950                                                                                                                  
        30 BLAKE                      2850       5000       2850        800        950                                                                                                                  
        30 MARTIN                     1250       5000       2850        800        950                                                                                                                  

14 rows selected.

SQL> select deptno, ename, sal,
  2           max(sal) over (order by sal desc) as 전체최대,
  3           min(sal) over (order by sal desc) as 전체최소
  4  from emp;

    DEPTNO ENAME                       SAL   전체최대   전체최소                                                                                                                                        
---------- -------------------- ---------- ---------- ----------                                                                                                                                        
        10 KING                       5000       5000       5000                                                                                                                                        
        20 FORD                       3000       5000       3000                                                                                                                                        
        20 SCOTT                      3000       5000       3000                                                                                                                                        
        20 JONES                      2975       5000       2975                                                                                                                                        
        30 BLAKE                      2850       5000       2850                                                                                                                                        
        10 CLARK                      2450       5000       2450                                                                                                                                        
        30 ALLEN                      1600       5000       1600                                                                                                                                        
        30 TURNER                     1500       5000       1500                                                                                                                                        
        10 MILLER                     1300       5000       1300                                                                                                                                        
        30 WARD                       1250       5000       1250                                                                                                                                        
        30 MARTIN                     1250       5000       1250                                                                                                                                        
        20 ADAMS                      1100       5000       1100                                                                                                                                        
        30 JAMES                       950       5000        950                                                                                                                                        
        20 SMITH                       800       5000        800                                                                                                                                        

14 rows selected.

SQL> 
SQL>   select deptno, ename, sal,
  2           max(sal) over (partition by deptno
  3                          order by sal desc)   as max1,
  4           min(sal) over (partition by deptno
  5                          order by sal)        as min1,
  6           min(sal) over (partition by deptno) as min2
  7    from emp;

    DEPTNO ENAME                       SAL       MAX1       MIN1       MIN2                                                                                                                             
---------- -------------------- ---------- ---------- ---------- ----------                                                                                                                             
        10 KING                       5000       5000       1300       1300                                                                                                                             
        10 CLARK                      2450       5000       1300       1300                                                                                                                             
        10 MILLER                     1300       5000       1300       1300                                                                                                                             
        20 SCOTT                      3000       3000        800        800                                                                                                                             
        20 FORD                       3000       3000        800        800                                                                                                                             
        20 JONES                      2975       3000        800        800                                                                                                                             
        20 ADAMS                      1100       3000        800        800                                                                                                                             
        20 SMITH                       800       3000        800        800                                                                                                                             
        30 BLAKE                      2850       2850        950        950                                                                                                                             
        30 ALLEN                      1600       2850        950        950                                                                                                                             
        30 TURNER                     1500       2850        950        950                                                                                                                             
        30 WARD                       1250       2850        950        950                                                                                                                             
        30 MARTIN                     1250       2850        950        950                                                                                                                             
        30 JAMES                       950       2850        950        950                                                                                                                             

14 rows selected.

SQL> 
SQL>   select deptno, ename, hiredate, sal,
  2           max(sal) over (partition by deptno
  3                          order by hiredate
  4                          rows 2 preceding) as max1,
  5           min(sal) over (partition by deptno
  6                          order by hiredate
  7                          rows 2 preceding) as min1
  8    from emp;

    DEPTNO ENAME                HIREDATE            SAL       MAX1       MIN1                                                                                                                           
---------- -------------------- ------------ ---------- ---------- ----------                                                                                                                           
        10 CLARK                09-JUN-81          2450       2450       2450                                                                                                                           
        10 KING                 17-NOV-81          5000       5000       2450                                                                                                                           
        10 MILLER               23-JAN-82          1300       5000       1300                                                                                                                           
        20 SMITH                17-DEC-80           800        800        800                                                                                                                           
        20 JONES                02-APR-81          2975       2975        800                                                                                                                           
        20 FORD                 03-DEC-81          3000       3000        800                                                                                                                           
        20 SCOTT                09-DEC-82          3000       3000       2975                                                                                                                           
        20 ADAMS                12-JAN-83          1100       3000       1100                                                                                                                           
        30 ALLEN                20-FEB-81          1600       1600       1600                                                                                                                           
        30 WARD                 22-FEB-81          1250       1600       1250                                                                                                                           
        30 BLAKE                01-MAY-81          2850       2850       1250                                                                                                                           
        30 TURNER               08-SEP-81          1500       2850       1250                                                                                                                           
        30 MARTIN               28-SEP-81          1250       2850       1250                                                                                                                           
        30 JAMES                03-DEC-81           950       1500        950                                                                                                                           

14 rows selected.

SQL> spool off
