var
  f: Text;
  m, n, max, i, j: Integer;
begin
  randomize;
  Assign(f, 'MAX.IN0'); Rewrite(f);
  Write('m, n, max = '); Readln(m, n, max);
  Inc(max);
  Writeln(f, m, ' ', n);
  for i := 1 to m do
    begin
      for j := 1 to n do
        if Random(2) = 1 then Write(f, Integer(Random(max)): 4, ' ')
        else Write(f, -Integer(Random(max)): 4, ' ');
      Writeln(f);
    end;
  Close(f);
end.
