const
 InputFile  = 'CITY.IN8';
 max = 200;
 maxV = 1000;
type
 TLine  = array[1..max] of LongInt;
var
 c: array[1..max] of ^TLine;
 a: array[1..max, 1..max] of Boolean;
 f: Text;
 n, i, m, u, v, k: Integer;
begin
 Write('n, m = '); Readln(n, m);
 for u := 1 to n do New(c[u]);
 for u := 1 to n do
  begin
   c[u]^[u] := 0;
   for v := u + 1 to n do
    begin
     c[u]^[v] := Random(maxV) + 1;
     c[v]^[u] := c[u]^[v];
    end;
  end;
 FillChar(a, SizeOf(a), False);
 for k := 1 to n do
  for u := 1 to n do
   for v := 1 + u to n do
    if c[u]^[v] > c[u]^[k] + c[k]^[v] then
     begin
      c[u]^[v] := c[u]^[k] + c[k]^[v];
      c[v]^[u] := c[u]^[v];
     end;
 for i := 2 to n do
  begin
   a[Random(i - 1) + 1, i] := True;
   a[i, Random(i - 1) + 1] := True;
  end;
 m := m - (n - 1);
 for i := 1 to m do
  begin
   repeat
    u := Random(n) + 1; v := Random(n) + 1;
   until (u < v) and not a[u, v];
   a[u, v] := True; a[v, u] := True;
  end;
 Assign(f, InputFile); Rewrite(f);
 Writeln(f, n, ' ', m + (n - 1));
 for u := 1 to n do
  for v := u + 1 to n do
   if a[u, v] then
    if Random(3) = 1 then Writeln(f, u, ' ', v, ' ', c[u]^[v] + Random(10) + 1)
    else Writeln(f, u, ' ', v, ' ', c[u]^[v]);
 Close(f);
end.
