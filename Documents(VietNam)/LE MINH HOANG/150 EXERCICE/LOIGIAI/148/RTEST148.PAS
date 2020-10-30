program RandomTest;
var
  f: Text;

procedure Assign(var f: Text; name: string);
begin
  Writeln('Creating ', name , '...');
  System.Assign(f, name);
end;

procedure CreateTest(FileName: string; n, max: Integer);
var
  i: Integer;
begin
  Assign(f, FileName); Rewrite(f);
  Writeln(f, n);
  for i := 1 to n do  Write(f, ' ', Random(max) + 1);
  Close(f);
end;

begin
  Randomize;
  CreateTest('INCSEQ.IN1', 9, 9);
  CreateTest('INCSEQ.IN2', 20, 9);
  CreateTest('INCSEQ.IN3', 100, 100);
  CreateTest('INCSEQ.IN4', 1000, 1000);
  CreateTest('INCSEQ.IN5', 5000, 2);
  CreateTest('INCSEQ.IN6', 6000, 10000);
  CreateTest('INCSEQ.IN7', 7000, 10000);
  CreateTest('INCSEQ.IN8', 8000, 10000);
  CreateTest('INCSEQ.IN9', 9000, 9999);
  CreateTest('INCSEQ.IN0', 10000, 10000);
end.