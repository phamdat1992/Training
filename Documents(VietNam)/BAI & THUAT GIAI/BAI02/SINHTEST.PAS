Program sinhtest_bai_chess;
Uses crt;
Const
     n          =       10000;
     maxso      =       100;
     dl         =       'doico.in7';
{Type
    Arr1        =       Array [1..maxn] of integer;}
Var
{   a            :       arr1;}
   f            :       text;
   i, j         :       integer;
Begin
randomize;
assign(f, dl);
rewrite(f);
writeln(f, n); 
for i := 1 to n do
    begin
{   j := random(maxso) + 1;   writeln(f, j, ' ', j - 1); - test 8}
    writeln(f, random(maxso) + 1, ' ', random(maxso) + 1);
    end;
close(f);
End.