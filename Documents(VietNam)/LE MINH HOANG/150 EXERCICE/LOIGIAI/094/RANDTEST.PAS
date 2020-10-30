program RandomTest;
var
  x, t: array[1..10000] of Integer;
  V, i, j, n: Integer;
  f: Text;
begin
  Randomize;
  Write('n = '); Readln(n);
  Assign(f, 'RECOVER.INP'); Rewrite(f);
  Writeln(f, n);
  FillChar(x, SizeOf(x), 0);
  for i := 1 to n do
    begin
      repeat
        j := Random(n) + 1;
      until x[j] = 0;
      x[j] := i;
    end;
  for i := 1 to n do
    begin
      v := x[i];
      t[v] := 0;
      for j := 1 to i - 1 do
        if x[j] > v then Inc(t[v]);
    end;
  for i := 1 to n do Write(f, t[i], ' ');
  Close(f);
end.
