program sinhtestdandenmau;
const
     dl         =       'Danden.in0p';
     m          =       200;
     n          =       200;
     k          =       15000;
Type
    Arr1        =       array [0..m,0..n] of boolean;
var
   a            :       arr1;
   f            :       text;
   i, u, v      :       integer;
begin
assign(f, dl);
rewrite(f);
randomize;
writeln(f, m, ' ', n, ' ', k);
fillchar(a, sizeof(a), 1);
for i := 1 to k do
    begin
    repeat
          u := random(m + 1);
          v := random(n + 1);
          until a[u,v];
    a[u,v] := false;
    writeln(f, u, ' ', v);
    end;
close(f);
end.

