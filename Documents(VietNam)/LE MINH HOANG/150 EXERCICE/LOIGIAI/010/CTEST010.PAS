program TaoTest010;
var
 f: Text;

procedure Test1;
begin
 Assign(f, 'ACTIVITY.IN1'); Rewrite(f);
 Writeln(f, 5);
 writeln(f, '7 9');
 writeln(f, '2 4');
 writeln(f, '1 3');
 writeln(f, '1 6');
 writeln(f, '3 5');
 Close(f);
end;

procedure Test2;
var
 n, i: Integer;
begin
 Assign(f, 'ACTIVITY.IN2'); Rewrite(f);
 n := 20;
 Writeln(f, n);
 for i := 1 to n do
  if odd(i) then Writeln(f, i div 2 + 1, ' ', i div 2 + 10)
  else Writeln(f, i div 2, ' ', i div 2 + 1);
 Close(f);
end;

procedure Test3;
var
 n, i: Integer;
begin
 Assign(f, 'ACTIVITY.IN3'); Rewrite(f);
 n := 10000;
 Writeln(f, n);
 for i := 1 to n do
  if odd(i) then Writeln(f, i div 2 + 1, ' ', i div 2 + 10)
  else Writeln(f, i div 2, ' ', i div 2 + 1);
 Close(f);
end;

procedure Test4;
var
 n, i: Integer;
begin
 Assign(f, 'ACTIVITY.IN4'); Rewrite(f);
 n := 5000;
 Writeln(f, n);
 for i := n downto 1 do
  Writeln(f, i, ' ', i + 1);
 Close(f);
end;

procedure Test5;
var
 n, i: Integer;
begin
 Assign(f, 'ACTIVITY.IN5'); Rewrite(f);
 n := 10000;
 Writeln(f, n);
 for i := n downto 1 do
  Writeln(f, i, ' ', i + 1);
 Close(f);
end;

procedure Test6;
var
 n, i: Integer;
begin
 Assign(f, 'ACTIVITY.IN6'); Rewrite(f);
 n := 10000;
 Writeln(f, n);
 for i := 1 to n div 2 do
  Writeln(f, i, ' ', i + 1);
 for i := n div 2 downto 1 do
  Writeln(f, i, ' ', i + 1);
 Close(f);
end;

procedure Test7;
var
 n, i, a, b: Integer;
begin
 Assign(f, 'ACTIVITY.IN7'); Rewrite(f);
 n := 7;
 Writeln(f, n);
 for i := 1 to n do
   begin
     a := Random(30000) + 1;
     b := a + Random(32000 - a) + 1;
     Writeln(f, a , ' ', b);
   end;
 Close(f);
end;

procedure Test8;
var
 n, i, a, b: Integer;
begin
 Assign(f, 'ACTIVITY.IN8'); Rewrite(f);
 n := 1000;
 Writeln(f, n);
 for i := 1 to n do
   begin
     a := Random(30000) + 1;
     b := a + Random(32000 - a) + 1;
     Writeln(f, a , ' ', b);
   end;
 Close(f);
end;

procedure Test9;
var
 n, i, a, b: Integer;
begin
 Assign(f, 'ACTIVITY.IN9'); Rewrite(f);
 n := 10000;
 Writeln(f, n);
 a := Random(30000) + 1;
 b := a + Random(32000 - a) + 1;
 for i := 1 to n do
   Writeln(f, a, ' ', b);
 Close(f);
end;

procedure Test0;
var
 n, i, a, b: Integer;
begin
 Assign(f, 'ACTIVITY.IN0'); Rewrite(f);
 n := 10000;
 Writeln(f, n);
 for i := 1 to n do
   begin
     a := Random(30000) + 1;
     b := a + Random(32000 - a) + 1;
     Writeln(f, a , ' ', b);
   end;
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
