program RandomTest;
var
  c: array[1..100, 1..100] of LongInt;
  f: Text;
  i, u, v, k, j: Integer;
begin
  Assign(f, 'TOUR.IN8'); Rewrite(f);
  Writeln(f, '100 99');
  for i := 2 to 100 do Writeln(f, i, ' ', Random(i - 1) + 1, ' 1');
  Close(f);
  Assign(f, 'TOUR.IN9'); Rewrite(f);
  Writeln(f, '100 100');
  for i := 1 to 99 do Writeln(f, i, ' ', i + 1, ' 10000');
  Writeln(f, '1 100 10000');
  Close(f);
  FillChar(c, SizeOf(c), 0);
  for i := 1 to 100 do
    for j := i + 1 to 100 do
      begin
        c[i, j] := Random(100) + 1;
        c[j, i] := c[i, j];
      end;
  for k := 1 to 100 do
    for u := 1 to 100 do
      for v := 1 to 100 do
        if c[u, v] > c[u, k] + c[k, v] then
          c[u, v] := c[u, k] + c[k, v];
  Assign(f, 'TOUR.IN0'); Rewrite(f);
  Writeln(f, '100 4950');
  for u := 1 to 100 do
    for v := u + 1 to 100 do Writeln(f, u, ' ', v, ' ', c[u, v]);
  Close(f);
end.