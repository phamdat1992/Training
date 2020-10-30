program RandomTest;
var
  f: Text;

procedure CreateTest(FileName: string; n, k, min, max: Integer; ratio: Real);
var
  i, x, y: Integer;
begin
  Writeln(FileName);
  Assign(f, Filename); Rewrite(f);
  Writeln(f, n, ' ', k);
  for i := 1 to n * n + n do
    Write(f, Random(k) + 1, ' ');
  Writeln(f);
  for x := 1 to n + 1 do
    for y := 1 to k do
      if Random <= ratio then Writeln(f, x, ' ', y, ' ',
         Random(max - min) + 1 + min);
  Close(f);
end;

begin
  Randomize;
  CreateTest('IOI.IN1', 3, 4, 1, 9, 0.5);
  CreateTest('IOI.IN2', 5, 10, 1, 9, 0.5);
  CreateTest('IOI.IN3', 10, 20, 1, 20, 0.3);
  CreateTest('IOI.IN4', 30, 100, 10, 100, 0.2);
  CreateTest('IOI.IN5', 50, 100, 1, 100, 0.1);
  CreateTest('IOI.IN6', 60, 200, 1, 100, 0.1);
  CreateTest('IOI.IN7', 70, 1000, 1, 100, 0.1);
  CreateTest('IOI.IN8', 80, 80, 100, 100, 1);
  CreateTest('IOI.IN9', 99, 9, 1, 100, 0.6);
  CreateTest('IOI.IN0', 100, 1000, 1, 100, 0.3);
end.
