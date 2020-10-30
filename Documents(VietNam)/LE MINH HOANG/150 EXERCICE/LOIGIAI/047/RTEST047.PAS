program RandomTest;
var
  Index: array[1..200] of Integer;
  a: array[1..200, 1..200] of Boolean;
  n, i, j: Integer;
  f: Text;
begin
  Randomize;
  Write('n = '); Readln(n);
  FillChar(a, SizeOf(a), False);
  for i := 2 to n do
    begin
      j := Random(i - 1) + 1;
      a[i, j] := True;
      a[j, i] := True;
    end;
  for i := 1 to n do
    if Random(10) = 1 then
      begin
        j := Random(n) + 1;
        a[i, j] := True;
        a[j, i] := True;
      end;
  FillChar(Index, SizeOf(Index), 0);
  for i := 1 to n do
    begin
      repeat
        j := Random(n) + 1;
      until Index[j] = 0;
      Index[j] := i;
    end;
  Assign(f, 'MOVE.IN8'); Rewrite(f);
  Writeln(f, n, ' ', Index[1], ' ', Index[n]);
  for i := 1 to n do
    if i = Index[n] then Write(f, 20000, ' ')
    else Write(f, Random(3), ' ');
  Writeln(f);
  for i := 1 to n do
    for j := 1 + i to n do
      if a[i, j] then Writeln(f, Index[i], ' ', Index[j]);
  Close(f);
end.
