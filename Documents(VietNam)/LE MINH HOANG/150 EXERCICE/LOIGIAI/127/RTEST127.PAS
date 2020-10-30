program RandomTest;
var
  f: Text;
  i, n, min, max: LongInt;

procedure Assign(var f: Text; s: string);
begin
  Write('Creating ', s, '...');
  System.Assign(f, s);
end;

procedure Close(var f: Text);
begin
  System.Close(f);
  Writeln('Done');
end;

function RandomInt(min, max: LongInt): LongInt;
var
  t: LongInt;
begin
  t := Round(Random * (max - min));
  RandomInt := t + min;
end;

procedure RandomSeg(min, max: LongInt);
var
  t, l, r: LongInt;
begin
  l := RandomInt(min, max - 2);
  r := RandomInt(l + 1, max);
  Writeln(f, l, ' ', r);
end;

procedure CreateTest5;
var
  i: Integer;
begin
  Assign(f, 'PTS.IN5'); Rewrite(f);
  Writeln(f, 10000);
  for i := 1 to 20000 do
    if odd(i) then
    begin
      Writeln(f, i, ' ', i + 1);
    end;
  Close(f);
end;

procedure CreateRTest(FileName: string; n, min, max: LongInt);
var
  i: LongInt;
begin
  Assign(f, FileName); Rewrite(f);
  Writeln(f, n);
  for i := 1 to n do RandomSeg(min, max);
  Close(f);
end;

begin
  Randomize;
  CreateRTest('PTS.IN1', 10, -10, 20);
  CreateRTest('PTS.IN2', 100, -20, 0);
  CreateRTest('PTS.IN3', 1000, -20, 40);
  CreateRTest('PTS.IN4', 10000, -1000, 1000);
  CreateTest5;
  CreateRTest('PTS.IN6', 20000, -10000, 10000);
  CreateRTest('PTS.IN7', 30000, -10000, 10000);
  CreateRTest('PTS.IN8', 50000, -30000, 30000);
  CreateRTest('PTS.IN9', 99999, -30000, 30000);
  CreateRTest('PTS.IN0', 100000, -30000, 30000);
end.