program L088TestsCreator;
var
 i, n: Integer;
 f: Text;

procedure CreateTest1;
var
 f: Text;
begin
 Assign(f, 'SOFTWARE.IN1'); Rewrite(f);
 Writeln(f, '6');
 Writeln(f, '1 20 3 4 5 9 20');
 Writeln(f, '3 4 5 6 19');
 Close(f);
end;

procedure CreateTest2;
var
 f: Text;
 i: Integer;
begin
 Assign(f, 'SOFTWARE.IN2'); Rewrite(f);
 n := 30;
 Writeln(f, n);
 for i := 1 to n do Write(f, i, ' ');
 Writeln(f);
 for i := 1 to n do Write(f, i + 2, ' ');
 Close(f);
end;

procedure CreateTest3;
var
 f: Text;
 i: Integer;
begin
 Assign(f, 'SOFTWARE.IN3'); Rewrite(f);
 n := 30;
 Writeln(f, n);
 for i := 1 to n do Write(f, i, ' ');
 Writeln(f);
 for i := n downto 1  do Write(f, i, ' ');
 Close(f);
end;

procedure CreateTest4;
var
 f: Text;
 i: Integer;
begin
 Assign(f, 'SOFTWARE.IN4'); Rewrite(f);
 n := 30;
 Writeln(f, n);
 for i := 1 to n do Write(f, 50 + Random(50), ' ');
 Writeln(f);
 for i := 1 to n do Write(f, Random(10) + 1, ' ');
 Close(f);
end;

procedure CreateTest5;
var
 f: Text;
 i: Integer;
begin
 Assign(f, 'SOFTWARE.IN5'); Rewrite(f);
 n := 100;
 Writeln(f, n);
 for i := 1 to n do Write(f, Random(10) + 1, ' ');
 Writeln(f);
 for i := 1 to n do Write(f, 50 + Random(50) + 1, ' ');
 Close(f);
end;

procedure CreateTest6;
var
 f: Text;
 i: Integer;
begin
 Assign(f, 'SOFTWARE.IN6'); Rewrite(f);
 Writeln(f, 100);
 for i := 1 to 200 do Write(f, 100, ' ');
 Close(f);
end;

procedure CreateTest7;
var
 f: Text;
 i: Integer;
begin
 Assign(f, 'SOFTWARE.IN7'); Rewrite(f);
 Writeln(f, 99);
 for i := 1 to 99 do Write(f, '1 ');
 Writeln(f);
 for i := 1 to 99 do Write(f, '100 ');
 Close(f);
end;

procedure CreateTest8;
var
 f: Text;
 i: Integer;
begin
 Assign(f, 'SOFTWARE.IN8'); Rewrite(f);
 Writeln(f, 99);
 for i := 1 to 99 do Write(f, '100 ');
 Writeln(f);
 for i := 1 to 99 do Write(f, '1 ');
 Close(f);
end;

procedure CreateTest9;
var
 f: Text;
 i: Integer;
begin
 Assign(f, 'SOFTWARE.IN9'); Rewrite(f);
 Writeln(f, 99);
 for i := 1 to 99 do Write(f, i, ' ');
 Writeln(f);
 for i := 1 to 99 do Write(f, i, ' ');
 Close(f);
end;

procedure CreateTest0;
var
 f: Text;
 i: Integer;
begin
 Assign(f, 'SOFTWARE.IN0'); Rewrite(f);
 Writeln(f, 99);
 for i := 1 to 99 do Write(f, Random(100) + 1, ' ');
 Writeln(f);
 for i := 1 to 99 do Write(f, Random(100) + 1, ' ');
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
