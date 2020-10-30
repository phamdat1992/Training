const fin='Tranh.I0';
      N = 5;
       M = 5;
      Max = 50;
var   f:text;
      i,j:integer;
begin
     randomize;
     assign(f,fin);rewrite(f);
     writeln(f,N, ' ',M);
     for i:=1 to N do write(f,random(Max)+1:3);
     writeln(f);
     for i:=1 to N do
        begin
           for j:=1 to M do write(f,random(Max)+1:3);
           writeln(f);
        end;
     close(f);
end.