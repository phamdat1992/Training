program RandomTest;
var
  f: Text;
  i, n: Integer;
begin
  Randomize;
  Write('n = '); Readln(n);
  Assign(f, 'BRACKETS.IN0'); Rewrite(f);
  for i := 1 to n do
    if i = 1 then Write(f, '(')
    else Write(f, ')');
  Close(f);
end.