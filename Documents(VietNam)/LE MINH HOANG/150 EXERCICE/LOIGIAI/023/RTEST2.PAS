var
  a, b: array[1..1000] of Integer;
  m, n, i, j: INteger;
  f: Text;
begin
  Randomize;
  Write('m = '); Readln(m);
  Write('n = '); Readln(n);
  Assign(f, 'OPT.IN0'); Rewrite(f);
  Write(f, 9);
  for i := 2 to m do Write(f, 9);
  Writeln(f);
  Write(f, 9);
  for i := 2 to n do Write(f, 9);
  Close(f);
end.
