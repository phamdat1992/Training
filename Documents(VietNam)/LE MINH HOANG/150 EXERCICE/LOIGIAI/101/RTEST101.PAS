program RandomTest;
var
  f: Text;
  i, n, max, edisk: Integer;
  S, m: LongInt;
  a: array[1..100] of Integer;
begin
  Randomize;
  Write('n, max = '); Readln(n, max);
  S := 0; m := 0;
  for i := 1 to n do
    begin
      a[i] := Random(max) + 1;
      S := S + a[i];
      if a[i] > m then m := a[i];
    end;
  Assign(f, 'DISKS.IN0'); Rewrite(f);
  Writeln(f, 100, ' ', 10000);
  for i := 1 to 100 do
    Write(f, Random(5000) + 5001, ' ');
  Close(f);
end.
