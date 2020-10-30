program RandomTest;
var
  f: Text;
  a: array[1..100, 1..100] of Boolean;

procedure CreateTest1;
begin
  WritelN('MAXFLOW.IN1');
  Assign(f, 'MAXFLOW.IN1'); Rewrite(f);
  Writeln(f, '6 8');
  Writeln(f, '1 2 5');
  Writeln(f, '1 3 5');
  Writeln(f, '2 4 6');
  Writeln(f, '2 5 3');
  Writeln(f, '3 4 3');
  Writeln(f, '3 5 1');
  Writeln(f, '4 6 6');
  Writeln(f, '5 6 6');
  Close(f);
end;

procedure CreateTest(FileName: string; n: Integer; r: real; max: Integer);
var
  i, j, m: Integer;
begin
  Assign(f, FileName); Rewrite(f);
  Writeln(FileName);
  FillChar(a, SizeOf(a), False);
  for i := 2 to n do
    begin
      j := Random(i - 1) + 1;
      a[i, j] := True;
    end;
  for i := 1 to n do
    for j := 1 to n do
      if (i <> j) and (Random < r) then a[i, j] := True;
  for i := 1 to n do
    begin
      a[i, 1] := false;
      a[n, i] := false;
    end;
  m := 0;
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] then Inc(m);
  Writeln(f, n, ' ', m);
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] then
        Writeln(f, i, ' ', j, ' ', Random(max) + 1);
  Close(f);
end;

begin
  Randomize;
  CreateTest1;
  CreateTest('MAXFLOW.IN2', 10, 0.3, 10);
  CreateTest('MAXFLOW.IN3', 20, 0.4, 30);
  CreateTest('MAXFLOW.IN4', 40, 0.4, 100);
  CreateTest('MAXFLOW.IN5', 60, 0.5, 100);
  CreateTest('MAXFLOW.IN6', 70, 0.3, 100);
  CreateTest('MAXFLOW.IN7', 100, 0.7, 100);
  CreateTest('MAXFLOW.IN8', 100, 0.9, 100);
  CreateTest('MAXFLOW.IN9', 100, 1, 100);
  CreateTest('MAXFLOW.IN0', 100, 0.3, 100);
end.