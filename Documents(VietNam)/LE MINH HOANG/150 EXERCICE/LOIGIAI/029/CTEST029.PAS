program RandomTest;
var
  f: Text;
  i, j, m, n, max: Integer;
begin
  Randomize;
  Write('m, n, max = '); Readln(m, n, max);
  Assign(f, 'PAINT.IN0'); Rewrite(f);
  Writeln(f, m, ' ', n);
  for i := 1 to m do
    begin
      for j := 1 to n do Write(f, Random(max + 1), ' ');
      Writeln(f);
    end;
  Close(f);
end.
