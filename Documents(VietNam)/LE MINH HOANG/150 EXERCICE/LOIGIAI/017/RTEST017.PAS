var
  m, n, i, j, k, tg: Integer;
  f: Text;
  a: array[0..30000] of Integer;
begin
  randomize;
  Assign(f, 'BOARD.IN6'); Rewrite(f);
  Write('M, N '); Readln(m, n);
  Writeln(f, m, ' ', n);
  for i := 0 to m * n - 1 do A[i] := i;
  for k := 1 to 10000 do
    begin
      i := Random(m * n); j := Random(m * n);
      tg := A[i]; A[i] := A[j]; A[j] := tg;
    end;
  for i := 0 to m - 1 do
    begin
      for j := 0 to n - 1 do Write(f, a[i * n + j]:4,' ');
      Writeln(f);
    end;
  Close(f);
end.
