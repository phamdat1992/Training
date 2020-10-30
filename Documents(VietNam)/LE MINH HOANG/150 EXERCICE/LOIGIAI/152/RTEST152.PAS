program RandomTest;
var
  f: Text;

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
  Assign(f, 'ASSIGN.IN1'); Rewrite(f);
  Writeln(f, '10 4 6');
  Writeln(f, '1 3 5 5 5 5 5 5 5 5');
  Writeln(f, '1 1 10');
  Writeln(f, '1 2 10');
  Writeln(f, '1 3 10');
  Writeln(f, '3 1 10');
  Writeln(f, '3 2 10');
  Writeln(f, '3 3 10');
  Writeln(f, '2 2 9');
  Writeln(f, '2 1 8');
  Writeln(f, '4 2 6');
  Writeln(f, '4 3 5');
  Writeln(f, '6 4 0');
  Close(f);
end;

procedure CreateTest2;
begin
  Assign(f, 'ASSIGN.IN2'); Rewrite(f);
  Writeln(f, '6 6 6');
  Writeln(f, '1 2 3 4 5 6');
  Writeln(f, '1 1 10000');
  Writeln(f, '2 1 0');
  Writeln(f, '2 2 10000');
  Writeln(f, '3 2 0');
  Writeln(f, '3 3 10000');
  Writeln(f, '4 3 0');
  Writeln(f, '4 4 10000');
  Writeln(f, '5 4 0');
  Writeln(f, '5 5 10000');
  Writeln(f, '6 5 0');
  Writeln(f, '6 6 10000');
  Close(f);
end;

procedure CreateTest3;
begin
  Assign(f, 'ASSIGN.IN3'); Rewrite(f);
  Writeln(f, '5 6 6');
  Writeln(f, '1 2 3 4 5');
  Writeln(f, '1 1 10000');
  Writeln(f, '2 2 10000');
  Writeln(f, '3 3 10000');
  Writeln(f, '4 4 10000');
  Writeln(f, '5 5 10000');
  Writeln(f, '1 2 1');
  Writeln(f, '2 3 1');
  Writeln(f, '3 4 1');
  Writeln(f, '4 5 1');
  Writeln(f, '6 6 10000');
  Close(f);
end;

procedure CreateTest7;
var
  i, j, k: Integer;
begin
  Assign(f, 'ASSIGN.IN7'); Rewrite(f);
  Writeln(f, 200, ' ', 100, ' ', 300);
  for i := 1 to 200 do Write(f, i, ' ');
  Writeln(f);
  for i := 3 to 300 do
    begin
      Writeln(f, i, ' ', i div 3, ' ', Random(10));
    end;
  Close(f);
end;

procedure CreateTest8;
var
  i, j, k: Integer;
  mark: array[1..400] of Boolean;
begin
  Assign(f, 'ASSIGN.IN8'); Rewrite(f);
  Writeln(f, 300, ' ', 300, ' ', 300);
  for i := 1 to 300 do Write(f, i, ' ');
  Writeln(f);
  for i := 1 to 300 do
    begin
      Writeln(f, i, ' ', 301 - i, ' ', Random(10));
    end;
  Close(f);
end;

{Tao randomtest m nguoi, n viec, r loai, chi co c loai co ich}
procedure CreateRandomTest(Name: string; m, n, r, c, maxV: Integer);
var
  i, j, k, t: Integer;
  mark: array[1..400] of Boolean;
begin
  Assign(f, Name); Rewrite(f);
  Writeln(f, m, ' ', n, ' ', r);
  for i := 1 to m do Write(f, Random(r) + 1, ' ');
  Writeln(f);
  for i := 1 to n do
    begin
      FillChar(mark, SizeOf(mark), True);
      for j := 1 to Random(10) + 5 do
        begin
          k := Random(c) + 1;
          if mark[k] then
            Writeln(f, k, ' ', i, ' ', Random(maxV + 1));
          mark[k] := False;
        end;
    end;
  Close(f);
end;

procedure CreateTest9;
var
  i, j, k, t: Integer;
  mark: array[1..400] of Boolean;
begin
  Assign(f, 'ASSIGN.IN9'); Rewrite(f);
  Writeln(f, 250, ' ', 300, ' ', 300);
  for i := 1 to 250 do Write(f, Random(300) + 1, ' ');
  Writeln(f);
  for i := 1 to 300 do
    begin
      FillChar(mark, SizeOf(mark), True);
      for j := 1 to Random(3) + 1 do
        begin
          k := Random(300) + 1;
          if mark[k] then
            Writeln(f, k, ' ', i, ' ', Random(10000 + 1));
          mark[k] := False;
        end;
    end;
  Close(f);
end;

procedure CreateRandomTest5(Name: string; m, n, r, c, maxV: Integer);
var
  i, j, k, t: Integer;
  mark: array[1..400] of Boolean;
begin
  Assign(f, Name); Rewrite(f);
  Writeln(f, m, ' ', n, ' ', r);
  for i := 1 to m do Write(f, Random(r - 2) + 2, ' ');
  Writeln(f);
  for i := 1 to n - 1 do
    begin
      FillChar(mark, SizeOf(mark), True);
      for j := 1 to Random(10) + 5 do
        begin
          k := Random(c) + 1;
          if mark[k] then
            Writeln(f, k, ' ', i, ' ', Random(maxV + 1));
          mark[k] := False;
        end;
    end;
  Writeln(f, '1 ', n, ' 10000');
  Writeln(f, r, ' ', n, ' 9999');
  Close(f);
end;

begin
  Randomize;
  CreateTest1;
  CreateTest2;
  CreateTest3;
  CreateRandomTest('ASSIGN.IN4', 30, 100, 20, 20, 100);
  CreateRandomTest5('ASSIGN.IN5', 200, 100, 50, 44, 1000);
  CreateRandomTest('ASSIGN.IN6', 177, 300, 300, 300, 9999);
  CreateTest7;
  CreateTest8;
  CreateTest9;
  CreateRandomTest('ASSIGN.IN0', 299, 300, 99, 90, 10000);
end.