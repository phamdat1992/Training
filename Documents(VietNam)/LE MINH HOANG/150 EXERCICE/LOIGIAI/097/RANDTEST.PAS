program RandomTest;
var
  f: Text;
  i, n, m, max: Integer;
  a: array[1..1000] of Integer;
begin
  Randomize;
  Write('n, m, max = '); Readln(n, m, max);
  Assign(f, 'SUBSEQ.IN7'); Rewrite(f);
  Writeln(f, n, ' ', m);
  for i := 1 to n do a[i] := Random(max + 1);
  for i := 1 to n do Write(f, i, ' ');
  Close(f);
end.
