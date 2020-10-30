var
 f: Text;
 i, n: Byte;
begin
 Randomize;
 Write('n = '); Readln(n);
 Assign(f, 'DOMINO.IN0'); Rewrite(f);
 Writeln(f, n);
 for i := 1 to n do Write(f, Random(7), ' ');
 Writeln(f);
 for i := 1 to n do Write(f, Random(3), ' ');
 Close(f);
end.
