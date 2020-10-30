program sinhchanel;
const
     dl         =       'chanel.in04321';
     max        =       30000;
     n          =       5000;
var
   i, j, k, tg  :        longint;
   f            :       text;
begin
assign(f, dl);
rewrite(f);
randomize;

writeln(f, n);
For i := 1 to n do
    begin
    j := random(max) + 1;
    j := random(max) * j + 1;
    repeat
          k := random(max) + 1;
          k := k * random(max) + 1; {- test longint}
          until k <> j;
    if k < j then begin tg := k; k := j; j := tg; end;
    if k > j then
    writeln(f, j, ' ', k);
    end;
close(f);
end.