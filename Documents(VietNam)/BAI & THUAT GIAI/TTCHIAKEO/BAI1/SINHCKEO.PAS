program sinh;
uses crt;
const
     n                  =       40;
     dl                 =       'chiakeo.in4p';
     gh                 =       100;
var
   f                    :       text;
   i, j                 :       integer;
begin
assign(f, dl); rewrite(f);
randomize;
writeln(f, n);
{for i := 1 to n do write(f, 1 + 2 * i, ' ');}
for i := 1 to n do
    write(f, random(gh) + 1, ' ');
close(f);
end.