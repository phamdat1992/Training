program RandomTest;
var
  f: Text;
  a: array[1..200, 1..200] of Boolean;

procedure Assign(var f: Text; FName: string);
begin
  Writeln(FName);
  System.Assign(f, FName);
end;

procedure CreateTest1;
begin
  Assign(f, 'MATCH.IN1'); Rewrite(f);
  Writeln(f, '4');
  Writeln(f, '1 1 0');
  Writeln(f, '1 2 0');
  Writeln(f, '2 1 0');
  Writeln(f, '2 4 2');
  Writeln(f, '3 2 1');
  Writeln(f, '3 3 0');
  Writeln(f, '4 3 0');
  Writeln(f, '4 4 9');
  Close(f);
end;

procedure CreateTest2;
var
  i: Integer;
begin
  Assign(f, 'MATCH.IN2'); Rewrite(f);
  Writeln(f, '10');
  for i := 1 to 10 do Writeln(f, i, ' ', i, ' ', 200);
  for i := 1 to 9 do Writeln(f, i, ' ', i + 1, ' ', 0);
  Close(f);
end;

procedure CreateTest3;
var
  i: Integer;
begin
  Assign(f, 'MATCH.IN3'); Rewrite(f);
  Writeln(f, '100');
  for i := 1 to 100 do Writeln(f, i, ' ', i, ' ', 200);
  for i := 1 to 99 do Writeln(f, i, ' ', i + 1, ' ', 0);
  Close(f);
end;

procedure CreateRandomTest(FileName: string; n: Integer; max: Integer; r: real);
var
  id: array[1..200] of Integer;
  t, i, j: Integer;
begin
  FillChar(a, SizeOF(a), False);
  for i := 1 to n do id[i] := i;
  for i := 1 to n do
    begin
      j := Random(n) + 1;
      t := id[i]; id[i] := id[j]; id[j] := t;
    end;
  for i := 1 to n do a[i, id[i]] := True;
  for i := 1 to n do
    for j := 1 to n do a[i, j] := Random <= r;
  Assign(f, FileName); Rewrite(f);
  Writeln(f, n);
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] then Writeln(f, i, ' ', j, ' ', Random(max + 1));
  Close(f);
end;

procedure CreateTest8;
var
  i: Integer;
begin
  Assign(f, 'MATCH.IN8'); Rewrite(f);
  Writeln(f, 100);
  for i := 1 to 100 do Writeln(f, i, ' ', i, ' ', 200);
  for i := 2 to 100 do Writeln(f, i, ' ', i - 1, ' ', 0);
  Close(f);
end;

procedure CreateTest9;
var
  i: Integer;
begin
  Assign(f, 'MATCH.IN9'); Rewrite(f);
  Writeln(f, 200);
  for i := 1 to 200 do Writeln(f, i, ' ', i, ' ', 200);
  for i := 2 to 200 do Writeln(f, i, ' ', i - 1, ' ', 0);
  Close(f);
end;

begin
  Randomize;
  CreateTest1;
  CreateTest2;
  CreateRandomTest('MATCH.IN3', 20, 9, 0.3);
  CreateRandomTest('MATCH.IN4', 50, 200, 0.2);
  CreateRandomTest('MATCH.IN5', 100, 200, 1.1);
  CreateRandomTest('MATCH.IN6', 120, 200, 0.6);
  CreateRandomTest('MATCH.IN7', 140, 200, 0.4);
  CreateTest8;
  CreateTest9;
  CreateRandomTest('MATCH.IN0', 200, 200, 0.3);
end.