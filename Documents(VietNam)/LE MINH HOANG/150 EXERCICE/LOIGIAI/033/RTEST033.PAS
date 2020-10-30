var
 f: Text;
 i, j, m, n: Byte;
begin
 Randomize;
 Write('m, n = '); Readln(m, n);
 Assign(f, 'WATER.IN5'); Rewrite(f);
 Writeln(f, m, ' ', n);
 for i := 1 to m do
  begin
   for j := 1 to n do Write(f, Random(200) + 1 :6);
   Writeln(f);
  end;
 Close(f);
end.
