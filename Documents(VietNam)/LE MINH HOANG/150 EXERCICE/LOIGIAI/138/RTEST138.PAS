program RandomTest;
var
  a: array[1..250, 1..250] of Boolean;
  f: Text;
  m, n, i, j, k, x, y, u, v, SA, SB: LongInt;
  Lab: array[1..250] of Integer;

procedure Gen(var x, y: LongInt);
begin
  repeat
    x := Random(n) + 1;
    y := Random(n) + 1;
  until x <> y;
end;

function Check(x, y, u, v: Integer): Boolean;
begin
  if (x = u) or (y = v) then
    begin
      Check := False; Exit;
    end;
  if (Lab[u] = Lab[x]) and (Lab[v] = Lab[y]) then
    begin
      Check := True; Exit;
    end;
  Check := False;
end;

begin
  FillChar(a, SizeOf(a), False);
  Write('n, m = '); Readln(n, m);
  for i := 1 to n do
    Lab[i] := Random(2) + 1;
  Gen(x, y); SA := x; SB := y;
  Lab[x] := 1; Lab[y] := 2;
  for i := 1 to m do
    begin
      repeat
        Gen(u, v);
      until Check(x, y, u, v);
      a[x, u] := True; a[y, v] := True;
      x := u; y := v;
    end;
  for i := 1 to 10 do
    begin
      repeat
        Gen(u, v);
      until (x <> u) and (y <> v);
      a[x, u] := True; a[y, v] := True;
      x := u; y := v;
    end;
  repeat
    u := Random(n) + 1;
  until (u <> x) and (u <> y);
  a[x, u] := True; a[y, u] := True;
  m := 0;
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] then Inc(m);
  Assign(f, 'RMOVE.INP'); Rewrite(f);
  Writeln(f, n, ' ', m, ' ', SA, ' ', SB);
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] then Writeln(f, i, ' ', j);
  Close(f);
end.
