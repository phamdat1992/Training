program RandomTest;
const
  Size = 201;
var
  f: Text;
  i, j, n, m, t: Integer;
begin
  Randomize;
  Assign(f, 'VITERBI.IN0'); Rewrite(f);
  Write('n, m, T = '); Readln(n, m, T);
  Writeln(f, n, ' ', m, ' ', T);
  for i := 1 to T do Write(f, Random(m) + 1, ' ');
  Writeln(f);
  for i := 1 to n do
    begin
      for j := 1 to n do
        if i = j then Write(f, 0:5)
        else Write(f, Random(Size):5);
      Writeln(f);
    end;
  for i := 1 to n do
    begin
      for j := 1 to m do
        Write(f, Random(Size):5);
      Writeln(f);
    end;
  Close(f);
end.