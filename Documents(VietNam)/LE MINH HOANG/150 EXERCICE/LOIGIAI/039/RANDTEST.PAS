var
  f: Text;
  i, j, n, m, k, t, x, y, maxX, maxY: Integer;
  Lab: array[1..1000] of Integer;
  a: array[-100..100, -100..100] of Boolean;
begin
 Randomize;
 Assign(f, 'NET.IN9'); Rewrite(f);
 Write('n, m, sotp, maxX, maxY = '); Readln(n, m, k, maxx, maxy);
 Writeln(f, n, ' ', m);
 for i := 1 to n do Lab[i] := Random(k);
 FillChar(a, SizeOf(a), True);
 for i := 1 to n do
   begin
     repeat
       x := Random(maxx + 1);
       if Random(2) = 1 then x := -x;
       y := Random(maxy + 1);
       if Random(2) = 1 then y := -y;
     until a[x, y];
     a[x, y] := False;
     Writeln(f, x * 10, ' ', y * 10);
   end;
 t := 0;
 for i := 1 to n do
   for j := 1 + i to n do
     if (Random(2) = 1) and (Lab[i] = Lab[j]) then
       begin
         Writeln(f, i, ' ', j);
         Inc(t);
       end;
 Writeln(t);
 Close(f);
end.
