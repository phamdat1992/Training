const fi='noidien.in4';
var i,j,n:integer;
	f:text;
BEGIN
   assign(f,fi); rewrite(f);
   n:=100;
   writeln(f,n);
   randomize;
   for i:=1 to n do
   writeln(f,random(30000),' ',random(30000));
   close(f);
END.