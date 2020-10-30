program sinhdayloi;
const
     dl                 =       'dayloi.in7p';
     n                  =       4000;
     gh                 =       32000;
var
   i, j, k              :       integer;
   f                    :       text;
begin
randomize;
assign(f, dl); rewrite(f);
writeln(f, n);
for i := 1 to n do
    begin
    j := random(2);
    if j = 0 then write(f, random(gh), ' ')
    else          write(f, -random(gh), ' ');
    end;
{j := random(gh);
k := n div 4;
for i := 1 to k do
    write(f, j - i, ' ');
for i := k + 1 to n do
    write(f, j + i - k, ' ');}

close(f);
end.
