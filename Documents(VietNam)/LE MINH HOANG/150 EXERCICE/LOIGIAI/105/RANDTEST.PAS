program RandomTest;
var
  n, maxCost, maxDay, i: Integer;
  f: Text;
begin
  Randomize;
  Write('n, maxCost, maxDay = '); Readln(n, maxCost, maxDay);
  Assign(f, 'SCHEDULE.IN0'); Rewrite(f);
  Writeln(f, n);
  for i := 1 to n do Write(f, Random(maxCost) + 1, ' ');
  Writeln(f);
  for i := 1 to n do Write(f, Random(maxDay) + 1, ' ');
 {
  for i := 1 to 5000 do Write(f, 10000, ' ');
  for i := 5000 downto 1 do Write(f, 10000, ' ');
  Writeln(f);
  for i := 1 to n do Write(f, 100, ' ');}
  Close(f);
end.
