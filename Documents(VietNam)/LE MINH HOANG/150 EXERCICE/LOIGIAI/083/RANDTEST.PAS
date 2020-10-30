program randtest;
const
 InputFile  = 'b1.INP';
var
 i, j, u, v, m, n, k: Integer;
 a: array[1..100, 1..100] of Boolean;
 f: Text;
begin
 Randomize;
 Write('n , m, k = '); Readln(n, m, k);
 FillChar(a, SizeOf(a), False);
 for i := 1 to m do
  begin
   repeat
    u := Random(n) + 1;
    v := Random(n) + 1;
   until not a[u, v] and (u <> v);
   a[u, v] := True;
   a[v, u] := True;
  end;
 Assign(f, InputFile); Rewrite(f);
 Writeln(f, n, ' ', m, ' ', k);
 for i := 1 to n do
  for j := 1 + i to n do
   if a[i, j] then Writeln(f, i, ' ', j);
 Close(f);
end.
