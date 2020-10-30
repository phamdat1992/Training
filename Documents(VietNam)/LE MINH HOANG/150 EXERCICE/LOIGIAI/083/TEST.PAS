program testCreator;
var
 f: Text;

 procedure CreateTest1;
 begin
   assign(f, 'Schedule.IN1'); Rewrite(f);
   Writeln(f, '9 12 4');
   Writeln(f, '1 2');
   Writeln(f, '2 3');
   Writeln(f, '3 1');
   Writeln(f, '4 5');
   Writeln(f, '5 6');
   Writeln(f, '6 4');
   Writeln(f, '7 8');
   Writeln(f, '8 9');
   Writeln(f, '9 7');
   Writeln(f, '1 4');
   Writeln(f, '4 7');
   Writeln(f, '7 1');
   Close(f);
 end;

 procedure CreateTest2;  {Hai cay khung + 2 canh khac}
 var
  k, i, j, step: Integer;
 begin
   Assign(f, 'Schedule.In2'); Rewrite(f);
   Writeln(f, '100 199 100');
   i := 0; step := 1;
   for k := 1 to 99 do
     begin
       j := i + step;
       i := i mod 100; j := j mod 100;
       Writeln(f, i + 1, ' ', j + 1);
       i := j;
     end;
   i := 0; step := 7;
   for k := 1 to 99 do
     begin
       j := i + step;
       i := i mod 100; j := j mod 100;
       Writeln(f, i + 1, ' ', j + 1);
       i := j;
     end;
   Writeln(f, '1 3');
   Close(f);
 end;

 procedure CreateTest3;
 var
  f: Text;
  i, j: Integer;
 begin
  Assign(f, 'Schedule.IN3'); Rewrite(f);
  Writeln(f, '24 42 7');
  for i := 1 to 24 do
   for j := i + 1 to 24 do
    if i mod 6 = j mod 6 then Writeln(f, i, ' ', j);
  for i := 1 to 5 do
    Writeln(f, i, ' ', i + 1);
  Writeln(f, '6 1');
  Close(f);
 end;

 procedure CreateTest4;
 var
  m, i, j: Integer;

  procedure WriteK6(a, b: Integer);
  var
   i, j: Integer;
  begin
   for i := a to b do
    for j := i + 1 to b do Writeln(f, i, ' ', j);
  end;

 begin
  assign(f, 'Schedule.IN4'); rewrite(f);
  Writeln(f, '90 240 15');
  i := 1;
  for i := 1 to 15 do WriteK6(i * 6 - 5, i * 6);
  for i := 1 to 14 do Writeln(f, i * 6 - 5, ' ', i * 6 + 1);
  Writeln(f, '85 1');
  Close(f);
 end;

procedure CreateTest5;
 var
  m, i, j: Integer;

  procedure WriteK(a, b: Integer);
  var
   i, j: Integer;
  begin
   for i := a to b do
    for j := i + 1 to b do Writeln(f, i, ' ', j);
  end;

 begin
  assign(f, 'Schedule.IN5'); rewrite(f);
  Writeln(f, '450 2070 46');
  i := 1;
  for i := 1 to 45 do WriteK(i * 10 - 9, i * 10);
  for i := 1 to 44 do Writeln(f, i * 10 - 9, ' ', i * 10 + 1);
  Writeln(f, '450 1');
  Close(f);
 end;

begin
 CreateTest1;
 CreateTest2;
 CreateTest3;
 CreateTest4;
 CreateTest5;
end.
