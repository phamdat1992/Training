program RandomTest;
var
  f: Text;

procedure CreateTest1;
begin
  Assign(f, 'MATCH.IN1'); Rewrite(f);
  Writeln(f, '4 5');
  Writeln(f, '1 1');
  Writeln(f, '1 4');
  Writeln(f, '2 1');
  Writeln(f, '2 2');
  Writeln(f, '2 4');
  Writeln(f, '3 2');
  Writeln(f, '3 3');
  Writeln(f, '4 2');
  Writeln(f, '4 3');
  Close(f);
end;

procedure CreateTest(FName: string;m, n, k: Integer);
var
  i, j: Integer;
begin
  Assign(f, FName); Rewrite(f);
  Writeln(f, m, ' ', n);
  for i := 1 to m do
    for j := 1 to n do
      if Random(k) = 0 then Writeln(f, i, ' ', j);
  Close(f);
end;

begin
  Randomize;
  CreateTest1;
  CreateTest('MATCH.IN2', 10, 10, 4);
  CreateTest('MATCH.IN3', 20, 10, 5);
  CreateTest('MATCH.IN4', 20, 30, 7);
  CreateTest('MATCH.IN5', 40, 50, 12);
  CreateTest('MATCH.IN6', 60, 50, 30);
  CreateTest('MATCH.IN7', 100, 100, 30);
  CreateTest('MATCH.IN8', 100, 100, 10);
  CreateTest('MATCH.IN9', 100, 100, 40);
  CreateTest('MATCH.IN0', 100, 100, 100);
end.