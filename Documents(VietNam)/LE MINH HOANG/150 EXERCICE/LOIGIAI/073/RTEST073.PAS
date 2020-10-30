const
 InputFile  = 'NUMBER.IN0';
var
 f: Text;
 m, n, i, j: Integer;
begin
 Randomize;
 Write('m, n = '); Readln(m, n);
 Assign(f, InputFile); Rewrite(f);
 Write(f, Random(9) + 1);
 for i := 2 to m do Write(f, Random(10));
 Writeln(f);
 Write(f, Random(9) + 1);
 for j := 2 to n do Write(f, Random(10));
 Close(f);
end.
