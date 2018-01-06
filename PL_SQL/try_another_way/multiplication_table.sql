begin
   dbms_output.put_line('구구단을 외자');
   <<outer>>
	for i in 1 .. 9 loop
		for j in 1 .. 8 loop
			exit when i >= 2;
	        	dbms_output.put(i+j || rpad('단',20, ' ') );
		end loop;
		
	dbms_output.new_line;
		
		for k in 2..9 loop
			dbms_output.put(k || ' * ' || i || ' = ' || rpad(k*i,13,' '));
		end loop;
	dbms_output.new_line;
   end loop;
end;


