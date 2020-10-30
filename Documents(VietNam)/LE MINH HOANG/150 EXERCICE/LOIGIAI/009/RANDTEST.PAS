program CircleTest;
var
 f: Text;
 m, n, i, j: Integer;
begin
 Randomize;
 Write('m, n = '); Readln(m, n);
 Assign(f, 'CIRCLE.INP'); Rewrite(f);
 Writeln(f, m, ' ', n);
 for i := 1 to m do Writeln(f, Integer(random(20)) - 5);
 for j := 1 to n do Writeln(f, Integer(Random(20)) - 5);
 Close(f);
end.
