uses crt;
const
     fi1='ngang.inp';
     fi2='doc.inp';
var
   f1,f2:text;
   i,x ,j,n:integer;
begin
     assign(f1,fi1);
     rewrite(f1);
     assign(f2,fi2);
     rewrite(f2);
     n:=100;
     x:=1;
     for i:=1 to n do
     begin
          for j:=1 to n-1 do
          begin
               if j<>n-1 then
          write(f1,x,' ') else writeln(f1,x);
          end;
     end;
     close(f1);
     for i:=1to n-1 do
     begin
          for j:=1 to n do
          write(f2,x,' ');
          if i<>n-1 then
          writeln(f2);
     end;
     close(f2);

end.