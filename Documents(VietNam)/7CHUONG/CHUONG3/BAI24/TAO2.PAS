program tao2;
var i, j, k, n : integer;
    f          : text;
begin
     randomize;
     for k := 4 to 9 do
     begin
          assign(f, 'c:\hung\dihoc3\quang\b21.in'+chr(k+48)); rewrite(f);
          n := 10;
          writeln(f, n,' ',n-1);
          for i := 1 to n do
          begin
               for j := 1 to n-1 do
                   if random (10) > 7 then write(f, '1 ')
                   else write(f, '0 ');
               writeln(f);
          end;
          close(f);
     end;
end.