program RandomTest;
var
  f: Text;
  id: array[1..1000] of Integer;

procedure Assign(var f: Text; Name: string);
begin
  Write('Creating ', Name, '...');
  System.Assign(f, Name);
end;

procedure Close(var f: Text);
begin
  System.Close(f);
  Writeln('Done');
end;

procedure CreateTest1;
begin
  Assign(f, 'SCHEDULE.IN1'); Rewrite(f);
  Writeln(f, '9');
  Writeln(f, '9 0');
  Writeln(f, '0');
  Writeln(f, '1 2 0');
  Writeln(f, '8 0');
  Writeln(f, '2 3 4 0');
  Writeln(f, '5 0');
  Writeln(f, '4 5 0');
  Writeln(f, '0');
  Writeln(f, '0');
  Close(f);
end;

procedure CreateTest9;
var
  i: Integer;
begin
  Assign(f, 'SCHEDULE.IN9'); Rewrite(f);
  Writeln(f, 200);
  for i := 1 to 200 do Writeln(f, 0);
  Close(f);
end;

procedure CreateId(n: Integer);
var
  t, i, j: Integer;
begin
  for i := 1 to n do id[i] := i;
  for i := 1 to n do
    begin
      j := Random(n) + 1;
      t := id[i]; id[i] := id[j]; id[j] := t;
    end;
end;

procedure CreateRandomTest(Name: string; n, r: Integer);
var
  c, i, j: Integer;
begin
  CreateId(n);
  Assign(f, Name); Rewrite(f);
  Writeln(f, n);
  for c := 1 to n do
    for i := 1 to n do
      if id[i] = c then
        begin
          for j := 1 to i - 1 do
            if Random(r) = 0 then Write(f, id[j], ' ');
          Writeln(f, 0);
        end;
  Close(f);
end;

begin
  Randomize;
  CreateTest1;
  CreateRandomTest('SCHEDULE.IN2', 10, 5);
  CreateRandomTest('SCHEDULE.IN3', 30, 7);
  CreateRandomTest('SCHEDULE.IN4', 60, 8);
  CreateRandomTest('SCHEDULE.IN5', 100, 10);
  CreateRandomTest('SCHEDULE.IN6', 120, 10);
  CreateRandomTest('SCHEDULE.IN7', 140, 20);
  CreateRandomTest('SCHEDULE.IN8', 160, 1);
  CreateTest9;
  CreateRandomTest('SCHEDULE.IN0', 200, 15);
end.