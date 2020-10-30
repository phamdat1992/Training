program RandomTest;
const
  max = 200;
var
  a: array[1..max, 1..max] of Boolean;
  m, n, i, u, v, s, f: Integer;
  fi: Text;
begin
  Randomize;
  Assign(fi, 'TOURS.IN0'); Rewrite(fi);
  Write('n, m = '); Readln(n, m);
  if m > LongInt(n) * (n - 1) div 2 then
    m := LongInt(n) * (n - 1) div 2;
  repeat
    s := Random(n) + 1; f := Random(n) + 1;
  until s <> f;
  Writeln(fi, n, ' ', m, ' ', s, ' ', f);
  FillChar(a, SizeOf(a), False);
  for i := 1 to m do
    begin
      repeat
        u := Random(n) + 1;
        v := Random(n) + 1;
      until (u <> v) and not a[u, v];
      a[u, v] := True;
      a[v, u] := True;
    end;
  for u := 1 to n do
    for v := u + 1 to n do
      if a[u, v] then Writeln(fi, u, ' ', v);
  Close(fi);
end.
