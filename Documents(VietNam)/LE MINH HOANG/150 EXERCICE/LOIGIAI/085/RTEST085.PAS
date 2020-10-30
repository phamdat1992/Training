program TigerTestCreator;
procedure CreateTest1; {Test de bai}
var
  f: text;
begin
  Assign(f, 'TIGER.IN1'); Rewrite(f);
  Writeln(f, '9');
  Writeln(f, '1 2');
  Writeln(f, '1 3');
  Writeln(f, '1 4');
  Writeln(f, '1 5');
  Writeln(f, '2 4');
  Writeln(f, '3 5');
  Writeln(f, '4 5');
  Writeln(f, '4 6');
  Writeln(f, '5 7');
  Writeln(f, '6 8');
  Writeln(f, '6 9');
  Writeln(f, '7 8');
  Writeln(f, '7 9');
  Writeln(f, '8 9');
  Close(f);
end;

procedure CreateTest2; {Test de bai}
var
  f: text;
begin
  Assign(f, 'TIGER.IN2'); Rewrite(f);
  Writeln(f, '11');
  Writeln(f, '1 2');
  Writeln(f, '1 3');
  Writeln(f, '1 4');
  Writeln(f, '2 3');
  Writeln(f, '2 7');
  Writeln(f, '3 6');
  Writeln(f, '3 4');
  Writeln(f, '5 6');
  Writeln(f, '5 10');
  Writeln(f, '6 7');
  Writeln(f, '6 9');
  Writeln(f, '8 9');
  Writeln(f, '8 11');
  Writeln(f, '9 10');
  Writeln(f, '9 11');
  Writeln(f, '10 11');
  Close(f);
end;

procedure CreateTest3; {Khong lien thong}
var
  f: Text;
  i: Integer;
begin
  Assign(f, 'TIGER.IN3'); Rewrite(f);
  Writeln(f, 50);
  for i := 2 to 49 do
    if Odd(i) then Writeln(f, 1, ' ', i)
    else Writeln(f, i, ' ', 50);
  Close(f);
end;

procedure CreateTest4; {No solution}
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, 'TIGER.IN4'); Rewrite(f);
  Writeln(f, 10);
  for i := 1 to 10 do
    for j := 1 + i to 10 do
      Writeln(f, i, ' ', j);
  Close(f);
end;

procedure CreateTest5; {Do thi day du bo canh (1, n)}
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, 'TIGER.IN5'); Rewrite(f);
  Writeln(f, 100);
  for i := 1 to 100 do
    for j := 1 + i to 100 do
      if (i <> 1) or (j <> 100) then
        Writeln(f, i, ' ', j);
  Close(f);
end;

procedure CreateTest6; {Chu trinh}
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, 'TIGER.IN6'); Rewrite(f);
  Writeln(f, 100);
  for i := 1 to 98  do
    Writeln(f, i, ' ', i + 2);
  Writeln(f, '1 2');
  Writeln(f, '99 100');
  Close(f);
end;

procedure CreateTest7; {Cay nhi phan goc 1, cac la noi voi n}
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, 'TIGER.IN7'); Rewrite(f);
  Writeln(f, 100);
  for i := 1 to 99 do
    if i * 2 >= 100 then Writeln(f, i, ' ', 100)
    else
      begin
        Writeln(f, i, ' ', i * 2);
        if i * 2 + 1 < 100 then Writeln(f, i, ' ', i * 2 + 1);
      end;
  Close(f);
end;

procedure CreateTest8; {Cay tam phan goc n, cac la noi voi 1}
var
  f: Text;
  i, j: Integer;
  procedure W(i, j: Integer);
  begin
    Writeln(f, 101 - i, ' ', 101 - j);
  end;
begin
  Assign(f, 'TIGER.IN8'); Rewrite(f);
  Writeln(f, 100);
  for i := 1 to 99 do
    if i * 3 - 1 >= 100 then W(i, 100)
    else
      begin
        for j := i * 3 - 1 to i * 3 + 1 do
        if j < 100 then W(i, j);
      end;
  Close(f);
end;

procedure CreateTest9; {Chi co 1 duong di: 1->2->3...->n}
var
  f: Text;
  i: Integer;
begin
  Assign(f, 'TIGER.IN9'); Rewrite(f);
  Writeln(f, 100);
  for i := 1 to 99 do Writeln(f, i, ' ', i + 1);
  Close(f);
end;

procedure CreateTest0; {Test ngau nhien, do thi khong lien thong}
var
  f: Text;
  i, j: Integer;
begin
  Randomize;
  Assign(f, 'TIGER.IN0'); Rewrite(f);
  Writeln(f, 100);
  for i := 1 to 100 do
    for j := i + 1 to 100 do
      if not (i in [2, 99]) and not(j in [2, 99]) and (Random(2) = 1)
            then Writeln(f, i, ' ', j);
  Writeln(f, '2 99');
  Close(f);
end;

begin
  CreateTest1;
  CreateTest2;
  CreateTest3;
  CreateTest4;
  CreateTest5;
  CreateTest6;
  CreateTest7;
  CreateTest8;
  CreateTest9;
  CreateTest0;
end.
