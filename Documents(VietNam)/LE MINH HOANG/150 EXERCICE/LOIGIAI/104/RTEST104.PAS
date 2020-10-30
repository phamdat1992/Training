var
  a: array[1..200, 1..200] of Boolean;
  Index: array[1..200] of Integer;
  i, j, u, v, n, m, t: Integer;
  f: Text;
begin
  Randomize;
  Write('n = '); Readln(n);
  FillChar(a, SizeOf(a), False);
  for v := 2 to n do
    begin
      u := Random(v - 1) + 1;
      a[u, v] := True; a[v, u] := True;
    end;
  for v := 2 to n do
    begin
      u := Random(v - 1) + 1;
      a[u, v] := True; a[v, u] := True;
    end;
  for i := 1 to n do
    begin
      u := Random(n) + 1;
      v := Random(n) + 1;
      if u <> v then
        begin
          a[u, v] := True; a[v, u] := True;
        end;
    end;
  m := 0;
  for u := 1 to n do
    for v := u + 1 to n do
      if a[u, v] then Inc(m);
  for i := 1 to n do Index[i] := i;
  for i := 1 to n do
    begin
      j := Random(n) + 1;
      t := Index[i]; Index[i] := Index[j]; Index[j] := t;
    end;
  Assign(f, 'MSTONE.IN0'); Rewrite(f);
  Writeln(f, n, ' ', m);
  for u := 1 to n do
    for v := u + 1 to n do
      if a[u, v] then Writeln(f, Index[u], ' ', Index[v]);
  Close(f);
end.
