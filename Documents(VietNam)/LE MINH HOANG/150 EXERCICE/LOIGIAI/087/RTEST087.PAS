program T087;
var
 f: Text;
 i, j, n, k: Integer;
 a: array[1..100, 1..100] of Byte;
begin
 Randomize;
 Write('n, k% = '); Readln(n, k);
 Assign(f, 'HOUSE.INP'); Rewrite(f);
 Writeln(f, n);
 FillChar(a, sizeOf(a), 0);
 for i := 1 to n do
  if Odd(i) then
   for j := i to i + 10 do
    if j < 100 then
     begin
      a[i, j] := 1; a[j, i] := 1;
     end;
 for i := 1 to n do
  begin
   for j := 1 to n do Write(f, a[i, j], ' ');

   Writeln(f);
  end;
 Close(f);
end.
