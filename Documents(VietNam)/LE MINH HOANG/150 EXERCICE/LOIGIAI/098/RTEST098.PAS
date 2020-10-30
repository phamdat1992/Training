program RandomTest;
var
  f: Text;
  i, n, max, min: Integer;
begin
  Randomize;
  Write('n, max, min = '); Readln(n, max, min);
  Assign(f, 'SEQ.IN7'); Rewrite(f);
  Writeln(f, n);
  for i := 1 to n div 2 do
    Write(f, i * 2 + 30, ' ', i * 2 - 1 + 30, ' ');
  Close(f);
end.
