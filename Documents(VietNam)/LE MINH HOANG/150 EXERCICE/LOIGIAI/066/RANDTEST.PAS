program RandomTest;
var
 f: Text;
 i, j, m, n, k, p: Integer;
 a: array[1..100, 1..100] of Integer;
begin
 Randomize;
 Assign(f, 'TRAFFIC.INP'); Rewrite(f);
 Writeln('Kich thuoc luoi, m, n, k% Xac suat co den trong luoi = '); 
 Readln(m, n, k);
 FillChar(a, SizeOf(a), 0);
 p := 0;
 for i := 1 to m do
  for j := 1 to n do
   if Random(100) < k then
    begin
     a[i, j] := Random(10000) + 1;
     Inc(p);
    end;
 if a[1, 1] <> 0 then
  begin
   Dec(p);
   a[1, 1] := 0;
  end;
  if a[m, n] <> 0 then
  begin
   Dec(p);
   a[m, n] := 0;
  end;
 Writeln(f, m, ' ', n);
 Writeln(f, p);
 for i := 1 to m do
  for j := 1 to n do
   if a[i, j] <> 0 then Writeln(f, i, ' ', j, ' ', a[i, j]);
 Close(f);
 for i := 1 to m do
  begin
   for j := 1 to n do Write(a[i, j]:5);
   Writeln;
  end;
end.
