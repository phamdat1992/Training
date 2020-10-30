program RandomTest;
type
  TArr = array[1..1000] of Boolean;
var
  f: Text;
  a: array[1..200] of ^TArr;
  i: Integer;

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

procedure CreateTest1;
begin
  Assign(f, 'ASSIGN.IN1'); Rewrite(f);
  Writeln(f, '3 10');
  Writeln(f, '1 2 3 4 0');
  Writeln(f, '1 2 3 5 0');
  Writeln(f, '1 2 3 4 5 6 7 8 9 10 0');
  Close(f);
end;

procedure CreateTest2;
var
  i, j: Integer;
begin
  Assign(f, 'ASSIGN.IN2'); Rewrite(f);
  Writeln(f, '10 100');
  for i := 1 to 10 do
    begin
      for j := 1 to 100 do
        if j <> 99 then Write(f, j, ' ');
      Writeln(f, 0);
    end;
  Close(f);
end;

procedure CreateTest3;
var
  i, j: Integer;
begin
  Assign(f, 'ASSIGN.IN3'); Rewrite(f);
  Writeln(f, '10 50');
  for i := 2 to 10 do
    begin
      for j := 1 to 50 do
        if odd(j) then Write(f, j, ' ');
      Writeln(f, 0);
    end;
  for j := 1 to 50 do Write(f, j, ' ');
  Writeln(f, 0);
  Close(f);
end;

procedure CreateTest(Filename: string; m, n, minWork, maxWork: Integer);
var
  deg: array[1..200] of Integer;
  i, j: Integer;
begin
  for i := 1 to m do deg[i] := minWork + Random(maxWork - minWork + 1);
  Assign(f, Filename); Rewrite(f);
  Writeln(f, m, ' ', n);
  for i := 1 to m do FillChar(a[i]^, SizeOf(a[i]^), False);
  for i := 1 to m do
    begin
      while deg[i] <> 0 do
        begin
          repeat
            j := Random(n) + 1;
          until not a[i]^[j];
          Dec(deg[i]);
          a[i]^[j] := True;
          Write(f, j, ' ');
        end;
      Writeln(f, 0);
    end;
  Close(f);
end;

procedure CreateHardTest(Filename: string; m, n, minWork, maxWork: Integer);
var
  deg: array[1..200] of Integer;
  mark: array[1..1000] of Boolean;
  i, j: Integer;
begin
  for i := 1 to m do deg[i] := minWork + Random(maxWork - minWork + 1);
  Assign(f, Filename); Rewrite(f);
  Writeln(f, m, ' ', n);
  for i := 1 to m do FillChar(a[i]^, SizeOf(a[i]^), False);
  FillChar(mark, sizeOf(mark), True);
  for i := 1 to 4 do
    begin
      for j := 1 to n do
        if Random(4) <> 1 then
          begin
            Write(f, j, ' ');
            mark[j] := False;
          end;
      if i <> 4 then Writeln(f, 0);
    end;
  for j := 1 to n do
    if mark[j] then Write(f, j, ' ');
  Writeln(f, 0);
  for i := 5 to m do
    begin
      while deg[i] <> 0 do
        begin
          repeat
            j := Random(n) + 1;
          until (j mod 2 = 0) and not a[i]^[j];
          Dec(deg[i]);
          a[i]^[j] := True;
          Write(f, j, ' ');
        end;
      Writeln(f, 0);
    end;
  Close(f);
end;

procedure CreateTest9;
var
  i, j: Integer;
begin
  Assign(f, 'ASSIGN.IN9'); Rewrite(f);
  Writeln(f, '200 1000');
  for i := 1 to 200 do
    begin
      for j := 1 to 1000 do
        Write(f, j, ' ');
      Writeln(f, 0);
    end;
  Close(f);
end;

begin
  for i := 1 to 200 do New(a[i]);
  CreateTest1;
  CreateTest2;
  CreateTest3;
  CreateTest('ASSIGN.IN4', 100, 300, 5, 200);
  CreateHardTest('ASSIGN.IN5', 8, 200, 49, 50);
  CreateTest('ASSIGN.IN6', 120, 500, 6, 200);
  CreateHardTest('ASSIGN.IN7', 10, 700, 99, 100);
  CreateTest('ASSIGN.IN8', 200, 100, 10, 20);
  CreateTest9;
  CreateHardTest('ASSIGN.IN0', 200, 1000, 199, 400);
end.