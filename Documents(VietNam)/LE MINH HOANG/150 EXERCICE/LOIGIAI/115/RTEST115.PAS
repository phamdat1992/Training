const
  S: array[1..4] of Char = '[]()';
var
  f: Text;
  i, n: Integer;
begin
  Randomize;
  Write('n = '); Readln(n);
  Assign(f, 'BRACKET.IN0'); Rewrite(f);
  for i := 1 to n do Write(f, S[Random(4) + 1]);
  Close(f);
end.