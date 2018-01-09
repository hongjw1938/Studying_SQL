SQL> create or replace package pack1
  2  is
  3  	v1 number := 1000;
  4  
  5  	-- public variable
  6  
  7  	procedure p1;		--public subprogram
  8  
  9  	procedure p2;
 10  
 11  	procedure setV7(a varchar2);
 12  	function getV7 return varchar2;	-- To make as an OOP type coding
 13  
 14  end;
 15  /

Package created.

SQL> 
SQL> --make package body
SQL> 
SQL> create or replace package body pack1
  2  is
  3  	v2 number := 2000;	--private variable
  4  
  5  	v7 varchar2(30);	--private variable
  6  
  7  	procedure setV7(a varchar2)	--define body of procedure
  8  
  9  	is
 10  	begin
 11  		v7 := a;
 12  	end;
 13  
 14  	function f1 return varchar2	--private subprogram
 15  	is
 16  	begin
 17  		return '--------------';
 18  	end;
 19  
 20  	procedure p1
 21  	is
 22  		v3 number := 3000;	--local variable
 23  	begin
 24  		dbms_output.put_line(f1);
 25  		dbms_output.put_line(f2):
 26  		dbms_output.put_line(v1);
 27  		dbms_output.put_line(v2);
 28  		dbms_output.put_line(v3);
 29  		dbms_output.put_line(f1);
 30  	end;
 31  
 32  	procedure p2
 33  	is
 34  		v4 number := 3000;	--local variable
 35  
 36  		procedure lp
 37  		is
 38  		begin
 39  			dbms_output.put_line('Show me the money!');
 40  		end;
 41  	begin
 42  		dbms_output.put_line(f1);
 43  		dbms_output.put_line(v1);
 44  		dbms_output.put_line(v2);
 45  		dbms_output.put_line(v4);
 46  		dbms_output.put_line(f1);
 47  
 48  		lp;
 49  	end;
 50  end;
 51  /

Warning: Package Body created with compilation errors.

SQL> show errors;
Errors for PACKAGE BODY PACK1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
25/27    PLS-00103: Encountered the symbol ":" when expecting one of the                                                                                                                                
         following:                                                                                                                                                                                     
         := . ( % ;                                                                                                                                                                                     
         The symbol ":= was inserted before ":" to continue.                                                                                                                                            
                                                                                                                                                                                                        
SQL> del 25
SQL> r
  1  create or replace package body pack1
  2  is
  3  	v2 number := 2000;	--private variable
  4  
  5  	v7 varchar2(30);	--private variable
  6  
  7  	procedure setV7(a varchar2)	--define body of procedure
  8  
  9  	is
 10  	begin
 11  		v7 := a;
 12  	end;
 13  
 14  	function f1 return varchar2	--private subprogram
 15  	is
 16  	begin
 17  		return '--------------';
 18  	end;
 19  
 20  	procedure p1
 21  	is
 22  		v3 number := 3000;	--local variable
 23  	begin
 24  		dbms_output.put_line(f1);
 25  		dbms_output.put_line(v1);
 26  		dbms_output.put_line(v2);
 27  		dbms_output.put_line(v3);
 28  		dbms_output.put_line(f1);
 29  	end;
 30  
 31  	procedure p2
 32  	is
 33  		v4 number := 3000;	--local variable
 34  
 35  		procedure lp
 36  		is
 37  		begin
 38  			dbms_output.put_line('Show me the money!');
 39  		end;
 40  	begin
 41  		dbms_output.put_line(f1);
 42  		dbms_output.put_line(v1);
 43  		dbms_output.put_line(v2);
 44  		dbms_output.put_line(v4);
 45  		dbms_output.put_line(f1);
 46  
 47  		lp;
 48  	end;
 49* end;

Warning: Package Body created with compilation errors.

SQL> show errors;
Errors for PACKAGE BODY PACK1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
12/11    PLS-00323: subprogram or cursor 'GETV7' is declared in a package                                                                                                                               
         specification and must be defined in the package body                                                                                                                                          
                                                                                                                                                                                                        
SQL> l 13
 13* 
SQL> i function getV7 return varchar2 is begin return v7; end;
SQL> r
  1  create or replace package body pack1
  2  is
  3  	v2 number := 2000;	--private variable
  4  
  5  	v7 varchar2(30);	--private variable
  6  
  7  	procedure setV7(a varchar2)	--define body of procedure
  8  
  9  	is
 10  	begin
 11  		v7 := a;
 12  	end;
 13  
 14  function getV7 return varchar2 is begin return v7; end
 15  	function f1 return varchar2	--private subprogram
 16  	is
 17  	begin
 18  		return '--------------';
 19  	end;
 20  
 21  	procedure p1
 22  	is
 23  		v3 number := 3000;	--local variable
 24  	begin
 25  		dbms_output.put_line(f1);
 26  		dbms_output.put_line(v1);
 27  		dbms_output.put_line(v2);
 28  		dbms_output.put_line(v3);
 29  		dbms_output.put_line(f1);
 30  	end;
 31  
 32  	procedure p2
 33  	is
 34  		v4 number := 3000;	--local variable
 35  
 36  		procedure lp
 37  		is
 38  		begin
 39  			dbms_output.put_line('Show me the money!');
 40  		end;
 41  	begin
 42  		dbms_output.put_line(f1);
 43  		dbms_output.put_line(v1);
 44  		dbms_output.put_line(v2);
 45  		dbms_output.put_line(v4);
 46  		dbms_output.put_line(f1);
 47  
 48  		lp;
 49  	end;
 50* end;

Warning: Package Body created with compilation errors.

SQL> show error;s
Usage: SHOW ERRORS [{ FUNCTION | PROCEDURE | PACKAGE |
   PACKAGE BODY | TRIGGER | VIEW 
   | TYPE | TYPE BODY | DIMENSION 
   | JAVA SOURCE | JAVA CLASS } [schema.]name]
SQL> show errors;
Errors for PACKAGE BODY PACK1:

LINE/COL ERROR                                                                                                                                                                                          
-------- -----------------------------------------------------------------                                                                                                                              
15/11    PLS-00103: Encountered the symbol "F1" when expecting one of the                                                                                                                               
         following:                                                                                                                                                                                     
         ;                                                                                                                                                                                              
                                                                                                                                                                                                        
SQL> create or replace package body pack1
  2  is
  3     v2 number := 2000;      --private variable
  4  
  5     v7 varchar2(30);        --private variable
  6  
  7     procedure setV7(a varchar2)     --define body of procedure
  8  
  9     is
 10     begin
 11             v7 := a;
 12     end;
 13  
 14     function getV7 return varchar2
 15     is
 16     begin
 17  	   return v7;
 18     end;
 19  
 20     function f1 return varchar2     --private subprogram
 21     is
 22     begin
 23             return '--------------';
 24     end;
 25  
 26     procedure p1
 27     is
 28             v3 number := 3000;      --local variable
 29     begin
 30             dbms_output.put_line(f1);
 31             dbms_output.put_line(v1);
 32             dbms_output.put_line(v2);
 33             dbms_output.put_line(v3);
 34             dbms_output.put_line(f1);
 35     end;
 36  
 37     procedure p2
 38     is
 39             v4 number := 3000;      --local variable
 40  
 41             procedure lp
 42             is
 43             begin
 44                     dbms_output.put_line('Show me the money!');
 45             end;
 46     begin
 47             dbms_output.put_line(f1);
 48             dbms_output.put_line(v1);
 49             dbms_output.put_line(v2);
 50             dbms_output.put_line(v4);
 51             dbms_output.put_line(f1);
 52  
 53             lp;
 54     end;
 55  end;
 56  /

Package body created.

SQL> exec pack1.v1 := 3000 --success
BEGIN pack1.v1 := 3000 --success; END;

*
ERROR at line 1:
ORA-06550: line 2, column 0:
PLS-00103: Encountered the symbol "end-of-file" when expecting one of the following: 
* & = - + ; < / > at in is mod remainder not rem 
<an exponent (**)> <> or != or ~= >= <= <> and or like like2 
like4 likec between || multiset member submultiset 


SQL> exec pack1.v1 := 3000

PL/SQL procedure successfully completed.

SQL> --success with pack1.v1
SQL> 
SQL> exec pack1.v2 := 3000
BEGIN pack1.v2 := 3000; END;

            *
ERROR at line 1:
ORA-06550: line 1, column 13:
PLS-00302: component 'V2' must be declared
ORA-06550: line 1, column 7:
PL/SQL: Statement ignored 


SQL> --Fail to initialize v2 at the outside of the package. Variable v2 is private type.
SQL> 
SQL> exec pack1.p1

PL/SQL procedure successfully completed.

SQL> set serveroutput on
SQL> exec pack1.p1
--------------                                                                                                                                                                                          
3000                                                                                                                                                                                                    
2000                                                                                                                                                                                                    
3000                                                                                                                                                                                                    
--------------                                                                                                                                                                                          

PL/SQL procedure successfully completed.

SQL> --success
SQL> 
SQL> exec pack1.p2
--------------                                                                                                                                                                                          
3000                                                                                                                                                                                                    
2000                                                                                                                                                                                                    
3000                                                                                                                                                                                                    
--------------                                                                                                                                                                                          
Show me the money!                                                                                                                                                                                      

PL/SQL procedure successfully completed.

SQL> --success
SQL> 
SQL> 
SQL> 
SQL> 
SQL> exec pack1.f1
BEGIN pack1.f1; END;

            *
ERROR at line 1:
ORA-06550: line 1, column 13:
PLS-00302: component 'F1' must be declared
ORA-06550: line 1, column 7:
PL/SQL: Statement ignored 


SQL> --fail because f1 is local subprogram which is defined inside of the package body.
SQL> 
SQL> 
SQL> 
SQL> exec dbms_output.put_line(pack1.v1)
3000                                                                                                                                                                                                    

PL/SQL procedure successfully completed.

SQL> --success
SQL> 
SQL> 
SQL> 
SQL> exec pack1.v7 := 'Dog'
BEGIN pack1.v7 := 'Dog'; END;

            *
ERROR at line 1:
ORA-06550: line 1, column 13:
PLS-00302: component 'V7' must be declared
ORA-06550: line 1, column 7:
PL/SQL: Statement ignored 


SQL> --Fail to initialize pack1.v7 because v7 is local variable of procedure setV7
SQL> 
SQL> 
SQL> exec dbms_output.put_line(pack1.getV7)

PL/SQL procedure successfully completed.

SQL> exec pack1.setV7('Dog')

PL/SQL procedure successfully completed.

SQL> exec dbms_output.put_line(pack1.getV7)
Dog                                                                                                                                                                                                     

PL/SQL procedure successfully completed.

SQL> --setter getter using
SQL> 
SQL> 
SQL> exec pack1.v1 := 200;

PL/SQL procedure successfully completed.

SQL> exec dbms_output.put_line(pack1.v1)
200                                                                                                                                                                                                     

PL/SQL procedure successfully completed.

SQL> spool off
