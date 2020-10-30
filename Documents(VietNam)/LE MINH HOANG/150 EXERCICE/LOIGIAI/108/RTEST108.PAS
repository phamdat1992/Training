program RandomTest;
const
  Pattern: array[1..10, 1..12] of Char =
  (
  'aaaaaaaaaaaa',
  'a..........a',
  'a.aaaaaaaa.a',
  'a.a....aaa.a',
  'a.a.aa.aaa.a',
  'a.a.aa.....a',
  'a.a.aaaaaaaa',
  'a.a.aaaaaaaa',
  '..a.........',
  'aaaaaaaaaaaa'
  );
var
  a: array[1..110, 1..112] of integer;
  i, j, m, n: Integer;
  f: Text;

procedure FillPattern(x, y: Integer);
var
  i, j: Integer;
begin
  for i := 1 to 10 do
    for j := 1 to 12 do
      if Pattern[i, j] = '.' then
        a[x + i - 1, y + j - 1] := Random(3)
      else
        a[x + i - 1, y + j - 1] := Random(10) + 91
end;

begin
  Randomize;
  Write('m, n = '); Readln(m, n);
  Assign(f, 'FAIR.IN2'); Rewrite(f);
  Writeln(f, m, ' ', n);
  for i := 1 to m do
    for j := 1 to n do a[i, j] := Random(10);
  {for i := 1 to 300 do
    FillPattern(Random(m) + 1, Random(n) + 1);
  for i := 1 to n div 12 do
    FilLPattern(10, i * 12 - 11);}
  for i := 1 to m do
    begin
      for  j := 1 to  n do Write(f, a[i, j]:3, ' ');
      Writeln(f);
    end;
  Close(f);
end.