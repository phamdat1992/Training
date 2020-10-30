program RandomTest;
var
  f: Text;
  m, n, i, j, d: Integer;
begin
  Randomize;
  Write('m, n = '); Readln(m, n);
  Assign(f, 'CELLS.IN9'); Rewrite(f);
  Writeln(f, m, ' ', n);
  for i := 0 to m - 1 do
    for j := 0 to n - 1 do
      for d := 1 to 2 do
        if Random(8) = 1 then
          case d of
            1: Writeln(f, i, ' ', j, ' ', i + 1, ' ', j);
            2: Writeln(f, i, ' ', j, ' ', i, ' ', j + 1);
          end;
  Close(f);
end.
