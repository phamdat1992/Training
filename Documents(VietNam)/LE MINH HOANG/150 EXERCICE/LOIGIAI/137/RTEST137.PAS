var
  a: array[1..200, 1..200] of Boolean;
  mark: array[1..100] of Boolean;
  n, i, m, u, v: Integer;
  f: Text;
begin
  Randomize;
  FillChar(a, SizeOf(a), 0);
  n := 99; m := n + Random(50);
  if m > (n * (n - 1)) div 2 then m := (n * (n - 1)) div 2;
  FillChar(mark, SizeOf(mark), true);
  Assign(f, 'COVER.IN9'); Rewrite(f);
  for i := 1 to m do
    begin
      repeat
        u := Random(n) + 1;
        v := Random(n) + 1;
      until (u <> v) and not a[u, v];
      a[u, v] := True; a[v, u] := True;
      mark[u] := False; mark[v] := False;
    end;
  for u := 1 to n do
    if mark[u] then
      begin
        repeat
          v := Random(n) + 1;
        until v <> u;
        a[u, v] := True; a[v, u] := True;
        Inc(m);
        mark[u] := False; mark[v] := False;
      end;
  Writeln(f, n, ' ', m);
  for u := 1 to n do
    for v := 1 + u to n do
      if a[u, v] then Writeln(f, u, ' ', v);
  Close(f);
end.