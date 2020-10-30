program sinhtestpicture;
const
     dl         =       'picture.in976521p';
     giatri     =       50;
     n          =       50;
     m          =       1500;
var
   i, j         :       integer;
   f            :       text;
begin
randomize;
assign(f, dl);
rewrite(f);
writeln(f, n, ' ', m);
for i := 1 to n do
    write(f, random(giatri) + 1, ' ');
writeln(f);
for i := 1 to n do
    begin
    for j := 1 to m do
        write(f, random(giatri) + 1, ' ');
    writeln(f);
    end;
close(f);
end.