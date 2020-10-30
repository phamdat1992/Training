type
  TArr = array[1..700] of Boolean;
var
  i, n, m: Integer;
  MarkX, MarkY: array[1..700] of Boolean;
  f: Text;

procedure Assign(var f: Text; FileName: string);
begin
  Write('Creating ', FileName, '...');
  System.Assign(f, FileName);
end;

procedure Close(var f: Text);
begin
  Writeln('Done');
  System.Close(f);
end;

procedure CreateTest(FileName: string; m, n: Integer);
var
  x, i, j: Integer;
begin
  Assign(f, FileName); Rewrite(f);
  for i := 1 to m do
    MarkX[i] := Random(4) = 1;
  for j := 1 to n do
    MarkY[j] := Random(4) = 1;
  Writeln(f, m, ' ', n);
  for i := 1 to m do
    for j := 1 to n do
      if (Random(3) = 1) and (MarkX[i] or MarkY[j]) then
        Writeln(f, i, ' ', j);
  Close(f);
end;

procedure CreateTest1;
begin
  Assign(f, 'TAX.IN1'); Rewrite(f);
  Writeln(f, '5 6');
  Writeln(f, '5 1');
  Writeln(f, '5 2');
  Writeln(f, '5 3');
  Writeln(f, '1 4');
  Writeln(f, '2 4');
  Writeln(f, '3 4');
  Close(f);
end;

procedure CreateTest7(m, n: Integer);
var
  x, i, j: Integer;
begin
  Assign(f, 'TAX.IN7'); Rewrite(f);
  Writeln(f, m, ' ', n);
  for i := 1 to m do
    for j := 1 to n do
      if (Random(3) = 1) then
        Writeln(f, i, ' ', j);
  Close(f);
end;

begin
  Randomize;
  CreateTest1;
  CreateTest('TAX.IN2', 10, 20);
  CreateTest('TAX.IN3', 100, 50);
  CreateTest('TAX.IN4', 100, 100);
  CreateTest('TAX.IN5', 200, 100);
  CreateTest('TAX.IN6', 200, 300);
  CreateTest7(400, 400);
  CreateTest('TAX.IN8', 333, 444);
  CreateTest('TAX.IN9', 555, 444);
  CreateTest('TAX.IN0', 600, 600);
end.