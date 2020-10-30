program TestCreator;
var
 a: array[1..200, 1..200] of Boolean;
 n, k, i, j: Integer;
 f: Text;
procedure CreateTest1;
begin
 Assign(f, 'FLOWERS.IN1'); Rewrite(f);
 Writeln(f, '12');
 Writeln(f, '1 2');
 Writeln(f, '1 3');
 Writeln(f, '1 9');
 Writeln(f, '2 12');
 Writeln(f, '3 6');
 Writeln(f, '4 5');
 Writeln(f, '5 2');
 Writeln(f, '6 5');
 Writeln(f, '6 7');
 Writeln(f, '7 3');
 Writeln(f, '8 11');
 Writeln(f, '9 8');
 Writeln(f, '10 9');
 Writeln(f, '11 10');
 Writeln(f, '12 4');
 Close(f);
end;

procedure CreateTest2;
begin
 Assign(f, 'FLOWERS.IN2'); Rewrite(f);
 Writeln(f, '16');
 Writeln(f, '1 2');
 Writeln(f, '2 3');
 Writeln(f, '3 4');
 Writeln(f, '4 5');
 Writeln(f, '5 2');
 Writeln(f, '4 11');
 Writeln(f, '11 6');
 Writeln(f, '6 7');
 Writeln(f, '7 8');
 Writeln(f, '8 9');
 Writeln(f, '9 10');
 Writeln(f, '10 11');
 Writeln(f, '8 12');
 Writeln(f, '12 13');
 Writeln(f, '13 14');
 Writeln(f, '14 15');
 Writeln(f, '15 16');
 Writeln(f, '16 12');
 Close(f);
end;

procedure CreateTest3;
begin
 Assign(f, 'FLOWERS.IN3'); Rewrite(f);
 Writeln(f, 200);
 Close(f);
end;

procedure CreateTest4;
var
 i: Integer;
begin
 Assign(f, 'FLOWERS.IN4'); Rewrite(f);
 n := 199; {Odd}
 Writeln(f, n);
 for i := 1 to n - 2 do Writeln(f, i, ' ', i + 2);
 Writeln(f, n, ' 1');
 Writeln(f, n - 1, ' 2');
 Close(f);
end;

procedure CreateTest5;
var
 i, j: Integer;
begin
 Assign(f, 'FLOWERS.IN5'); Rewrite(f);
 n := 199;
 Writeln(f, n);
 for i := 1 to n do
  for j := 1 to n do
   if (i <> j) and ((i - j) mod 10 = 0) then Writeln(f, i, ' ', j);
 Close(f);
end;

procedure CreateTest6;
var
 i, j: Integer;
 Level: array[1..200] of Integer;
begin
 Assign(f, 'FLOWERS.IN6'); Rewrite(f);
 n := 127;
 Level[1] := 1;
 for i := 2 to n do Level[i] := Level[i div 2] + 1;
 Writeln(f, n);
 for i := 1 to n do
  for j := 1 to n do
   if Level[i] = Level[j] then Writeln(f, i, ' ', j);
 for i := 1 to 6 do Writeln(f, 1 shl (i - 1), ' ', 1 shl i);
 Close(f);
end;

procedure CreateTest7;
var
 i, j: Integer;
begin
 Assign(f, 'FLOWERS.IN7'); Rewrite(f);
 n := 200;
 Writeln(f, n);
 for i := 1 to n do
  for j := 1 to n do
   if (i <> j) then Writeln(f, i, ' ', j);
 Close(f);
end;

procedure CreateTest8;
var
 i, j: Integer;
begin
 Assign(f, 'FLOWERS.IN8'); Rewrite(f);
 n := 200;
 Writeln(f, n);
 for i := 1 to n - 2 do Writeln(f, i, ' ', i + 1);
 Writeln(f, (n - 1), ' ', n div 2);
 Writeln(f, 1, ' ', n);
 Writeln(f, n, ' ', 1);
 Close(f);
end;

procedure CreateTest9;
var
 i, j: Integer;
begin
 Assign(f, 'FLOWERS.IN9'); Rewrite(f);
 n := 200;
 Writeln(f, n);
 for i := 1 to n - 1 do Writeln(f, i, ' ', i + 1);
 Close(f);
end;

procedure CreateTest0;
var
 f: Text;
 i, j: Integer;
 Index: array[1..200] of Integer;
begin
 Assign(f, 'FLOWERS.IN0'); Rewrite(f);
 n := 200;
 Writeln(f, n);
 FillChar(a, SizeOf(a), False);
 for i := 1 to n do
  for j := 1 to n do
   if (i < j) or (j > n * 2 div 3) then  a[i, j] := True;
 FillChar(Index, SizeOf(Index), 0);
 for i := 1 to n do
  begin
   repeat
    j := Random(n) + 1;
   until Index[j] = 0;
   Index[j] := i;
  end;
 for i := 1 to n do
  for j := 1 to n do
   if a[i, j] then Writeln(f, Index[i], ' ', Index[j]);
 Close(f);
end;

begin
 Randomize;
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
