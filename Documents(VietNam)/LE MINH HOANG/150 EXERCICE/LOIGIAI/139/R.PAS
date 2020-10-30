var
  i, j, x, y: Integer;
  a: array[1..100, 1..100] of Char;
  f: Text;
begin
  FillChar(a, SizeOf(a), '.');
  for i := 1 to 100 do
    begin
      repeat
        x := Random(100) + 1;
        y := Random(100) + 1;
      until a[x, y] = '.';
      a[x, y] := '&';
      repeat
        x := Random(100) + 1;
        y := Random(100) + 1;
      until a[x, y] = '.';
      a[x, y] := '*';
    end;
  for i := 1 to 100 do
    begin
      repeat
        x := Random(100) + 1;
        y := Random(100) + 1;
      until a[x, y] = '.';
      a[x, y] := '@';
    end;
  Assign(f, 'HORSEMAN.IN0'); Rewrite(f);
  Writeln(f, '100 100');
  for i := 1 to 100 do
    begin
      for j := 1 to 100 do Write(f, a[i, j]);
      Writeln(f);
    end;
  Close(f);
end.