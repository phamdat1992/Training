var
 f: Text;
 n, i: Byte;
begin
 Write('n = '); Readln(n);
 Assign(f, 'CANDY.INP'); Rewrite(f);
 Writeln(f, n);
 for i := 1 to n do Writeln(f, 1 + Random(200));
 Close(f);
end.
