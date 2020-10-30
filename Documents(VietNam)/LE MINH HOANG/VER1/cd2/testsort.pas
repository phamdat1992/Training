program TestSort;
var
  Index: array[1..30000] of Integer;
  j, n, i: Integer;
  f: Text;
begin
  Randomize;
  Write('n = '); Readln(n);
  Assign(f, 'SORT.INP'); Rewrite(f);
  for i := 1 to n do Writeln(f, Random(15001));
  Close(f);
end.
