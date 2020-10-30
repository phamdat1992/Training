program TT049;
var
 f: Text;
procedure Test1;
begin
 Assign(f, 'MESSAGE.IN1'); Rewrite(f);
 Writeln(f, '5 7 1 5');
 Writeln(f, '1 2 3');
 Writeln(f, '1 4 8');
 Writeln(f, '2 3 5');
 Writeln(f, '2 4 4');
 Writeln(f, '3 5 5');
 Writeln(f, '4 3 8');
 Writeln(f, '4 5 3');
 Close(f);
end;

procedure Test2;
var
 n, i: Integer;
begin
 n := 10;
 Assign(f, 'MESSAGE.IN2'); Rewrite(f);
 Writeln(f, n, ' ', 2 * n - 3, ' 1 ', n);
 for i := 1 to n - 1 do Writeln(f, i, ' ', i + 1, ' 1');
 for i := 1 to n - 2 do Writeln(f, i, ' ', i + 2, ' 2');
 Close(f);
end;

procedure Test3;
var
 n, i: Integer;
begin
 n := 100;
 Assign(f, 'MESSAGE.IN3'); Rewrite(f);
 Writeln(f, n, ' ', 2 * n - 3, ' 1 ', n);
 for i := 1 to n - 1 do Writeln(f, i, ' ', i + 1, ' 9');
 for i := 1 to n - 2 do Writeln(f, i, ' ', i + 2, ' 10');
 Close(f);
end;

procedure Test4;
var
 n, i, j: Integer;
begin
 n := 100;
 Assign(f, 'MESSAGE.IN4'); Rewrite(f);
 Writeln(f, n, ' ', n * (n - 1) div 2, ' 1 ', n);
 for i := 1 to n - 1 do
  for j := i + 1 to n do Writeln(f, i, ' ', j, ' ', Random(200) + 1);
 Close(f);
end;

procedure Test5;
var
 n, i, j: Integer;
begin
 n := 100;
 Assign(f, 'MESSAGE.IN5'); Rewrite(f);
 Writeln(f, n, ' ', n - 1, ' 1 ', n);
 for i := 1 to n - 1 do Writeln(f, i, ' ', i + 1, ' 1');
 Close(f);
end;

begin
 Randomize;
 Test1;
 Test2;
 Test3;
 Test4;
 Test5;
end.
