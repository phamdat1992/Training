var
  a: array[1..200, 1..200] of Boolean;
  i, j, n, m, k, u, v, t: Integer;
  f: Text;
  Lab, Index: array[1..200] of Integer;

begin
  Randomize;
  Write('n, m, so tp lien thong: '); Readln(n, m, k);
  FillChar(a, SizeOf(a), False);
  for i := 1 to n do Lab[i] := Random(k);
  i := 1;
  while i <= m do
    begin
      u := Random(n) + 1;
      v := random(n) + 1;
      if (u <> v) and (Lab[u] = Lab[v]) and not a[u, v] then
        begin
          a[u, v] := True;
          a[v, u] := True;
          Inc(i);
        end;
    end;
  for i := 1 to n do Index[i] := i;
  for u := 1 to n do
    begin
      v := Random(n) + 1;
      t := Index[u]; Index[u] := Index[v]; Index[v] := t;
    end;
  Assign(f, 'TOURS.IN0'); Rewrite(f);
  Writeln(f, n, ' ', m);
  for u := 1 to n do
    for v := 1 + u to n do
      if a[u, v] then Writeln(f, Index[u], ' ', Index[v]);
  Close(f);
end.
