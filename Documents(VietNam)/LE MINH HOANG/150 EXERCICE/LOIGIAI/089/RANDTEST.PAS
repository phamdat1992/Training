var
 a: array[1..200, 1..200] of Boolean;
 n, k, i, j: Integer;
 f: Text;
begin
 Write('n, k% = '); Readln(n, k);
 Assign(f, 'FLOWERS.INP'); Rewrite(f);
 Writeln(f, n);
 for i := 1 to n do
  for j := 1 to n do
   if (i <> j) and (Random(100) < k) then Writeln(f, i, ' ', j);
 Close(f);
end.
