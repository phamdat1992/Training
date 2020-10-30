program RandomTest;
var
 f: Text;
 i, j, m, n: Integer;
procedure WriteS(W: Word);
var
 i: Integer;
begin
 for i := 0 to m - 1 do
  if W and (1 shl i) <> 0 then Write(f, '1 ')
  else Write(f, '0 ');
 Writeln(f);
end;

begin
 Randomize;
 Write('n, m = '); Readln(n, m);
 Assign(f, 'GROUP.INP'); Rewrite(f);
 Writeln(f, n, ' ', m);
 for i := 1 to n do
  WriteS(Random(1 shl m - 1));
 Close(f);
end.
