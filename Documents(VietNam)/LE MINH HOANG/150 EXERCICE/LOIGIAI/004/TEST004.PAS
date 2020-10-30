program Test004;
var
  f: Text;

procedure Test1;
begin
  Assign(f, 'SEQ.IN1'); Rewrite(f);
  Writeln(f, '10 9');
  Writeln(f, '11 3 2 4 7');
  Writeln(f, '9 16 12 10 6');
  Close(f);
end;

procedure Test2;
begin
  Assign(f, 'SEQ.IN2'); Rewrite(f);
  Writeln(f, '13 40');
  Writeln(f, '140 320 230 456 440 750 123 660 770 880 789 990 1010');
  Close(f);
end;

procedure Test3;
var
  i: Integer;
begin
  Assign(f, 'SEQ.IN3'); Rewrite(f);
  Writeln(f, '20 31');
  for i := 1 to 20 do Writeln(f, Random(100) * 5 + 5);
  Close(f);
end;

procedure Test4;
var
  i: Integer;
begin
  Assign(f, 'SEQ.IN4'); Rewrite(f);
  Writeln(f, '49 50');
  for i := 1 to 49 do Writeln(f, Random(100) * 50 + 1);
  Close(f);
end;

procedure Test5;
var
  i: Integer;
begin
  Assign(f, 'SEQ.IN5'); Rewrite(f);
  Writeln(f, '100 10');
  for i := 1 to 100 do Writeln(f, i);
  Close(f);
end;

procedure Test6;
var
  i: Integer;
begin
  Assign(f, 'SEQ.IN6'); Rewrite(f);
  Writeln(f, '200 50');
  for i := 1 to 200 do Writeln(f, 2 * (i mod 24) + 1);
  Close(f);
end;

procedure Test7;
var
  i: Integer;
begin
  Assign(f, 'SEQ.IN7'); Rewrite(f);
  Writeln(f, '700 47');
  for i := 1 to 700 do Writeln(f, Random(100) * 47 + 2);
  Close(f);
end;

procedure Test8;
var
  i: Integer;
begin
  Assign(f, 'SEQ.IN8'); Rewrite(f);
  Writeln(f, '800 31');
  for i := 1 to 700 do Writeln(f, Random(300) * 31);
  Close(f);
end;

procedure Test9;
var
  i, c: Integer;
begin
  Assign(f, 'SEQ.IN9'); Rewrite(f);
  Writeln(f, '969 24');
  for i := 1 to 969 do
    if i mod 100 <> 0 then Writeln(f, Random(400) * 24 + 1)
    else Writeln(f, Random(400) * 24 + 13);
  Close(f);
end;

procedure Test0;
var
  i, c: Integer;
begin
  Assign(f, 'SEQ.IN0'); Rewrite(f);
  Writeln(f, '960 24');
  for i := 1 to 969 do
    if i mod 100 <> 0 then Writeln(f, Random(100) * 24 + 1)
    else Writeln(f, Random(100) * 24 + 13);
  Close(f);
end;

begin
  Test1;
  Test2;
  Test3;
  Test4;
  Test5;
  Test6;
  Test7;
  Test8;
  Test9;
  Test0;
end.
