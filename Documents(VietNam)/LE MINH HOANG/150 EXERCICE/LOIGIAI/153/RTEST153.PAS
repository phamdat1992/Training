program RandomTest;
var
  f: Text;
  a: array[1..200, 1..200] of Char;

procedure CreateTest1;
begin
  Assign(f, 'GRID.IN1'); Rewrite(f);
  Writeln(f, '4 5');
  Writeln(f, '+..*.');
  Writeln(f, '++.+.');
  Writeln(f, '+....');
  Writeln(f, '.++..');
  Close(f);
end;

procedure CreateTest(FName: string; m, n, k: Integer);
var
  i, j: Integer;
  Free: array[1..200] of Boolean;
begin
  Assign(f, FName); Rewrite(f);
  Writeln(f, m, ' ', n);
  FillChar(a, SizeOf(a), '.');
  for i := 1 to m do
    for j := 1 to n do
      if Random(k) = 0 then a[i, j] := '+';
  FillChar(Free, SizeOf(Free), True);
  for i := 1 to m do
    if Random(3) = 1 then
      begin
        j := Random(n) + 1;
        if Free[j] and (a[i, j] = '+') then
          begin
            a[i, j] := '*';
            Free[j] := False;
          end;
      end;
  for i := 1 to m do
    begin
      for j := 1 to n do Write(f, a[i, j]);
      Writeln(f);
    end;
  Close(f);
end;

begin
  Randomize;
  CreateTest1;
  CreateTest('GRID.IN2', 10, 10, 4);
  CreateTest('GRID.IN3', 20, 10, 5);
  CreateTest('GRID.IN4', 20, 30, 7);
  CreateTest('GRID.IN5', 40, 50, 12);
  CreateTest('GRID.IN6', 60, 50, 30);
  CreateTest('GRID.IN7', 100, 100, 30);
  CreateTest('GRID.IN8', 100, 150, 10);
  CreateTest('GRID.IN9', 200, 190, 40);
  CreateTest('GRID.IN0', 200, 200, 100);
end.