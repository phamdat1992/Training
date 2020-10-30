program RandomTest;
var
  f: Text;

procedure Assign(var f: Text; name: string);
begin
  Writeln('Creating ', name , '...');
  System.Assign(f, name);
end;

procedure CreateTest(FileName: string; m, n: Integer);
var
  i, x1, y1, x2, y2: Integer;
begin
  Assign(f, FileName); Rewrite(f);
  Writeln(f, m, ' ', n);
  for x1 := 0 to m do
    for y1 := 0 to n do
      case Random(4) of
        1: if x1 < m then Writeln(f, x1, ' ', y1, ' ', x1 + 1, ' ', y1);
        2: if y1 < n then Writeln(f, x1, ' ', y1, ' ', x1, ' ', y1 + 1);
      end;
  Close(f);
end;

begin
  Randomize;
  CreateTest('NET.IN1', 2, 3);
  CreateTest('NET.IN2', 5, 4);
  CreateTest('NET.IN3', 10, 10);
  CreateTest('NET.IN4', 20, 10);
  CreateTest('NET.IN5', 20, 30);
  CreateTest('NET.IN6', 40, 40);
  CreateTest('NET.IN7', 50, 51);
  CreateTest('NET.IN8', 60, 59);
  CreateTest('NET.IN9', 99, 99);
  CreateTest('NET.IN0', 100, 100);
end.