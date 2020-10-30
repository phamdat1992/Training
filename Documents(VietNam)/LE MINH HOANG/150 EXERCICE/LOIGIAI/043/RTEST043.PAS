program PolygonTest;

procedure Test1;
var
  f: Text;
begin
  Assign(f, 'POLYGON.IN1'); Rewrite(f);
  Writeln(f, 5);
  Writeln(f, '1 0');
  Writeln(f, '2 1');
  Writeln(f, '0 10');
  Writeln(f, '-2 1');
  Writeln(f, '-1 0');
  Close(f);
end;

procedure Test2;
var
  f: Text;
begin
  Assign(f, 'POLYGON.IN2'); Rewrite(f);
  Writeln(f, 8);
  Writeln(f, '3 0');
  Writeln(f, '2 2');
  Writeln(f, '0 3');
  Writeln(f, '-2 2');
  Writeln(f, '-3 0');
  Writeln(f, '-2 -2');
  Writeln(f, '0 -3');
  Writeln(f, '2 -2');
  Close(f);
end;

procedure Test3;
var
  f: Text;
begin
  Assign(f, 'POLYGON.IN3'); Rewrite(f);
  Writeln(f, 6);
  Writeln(f, '3 0');
  Writeln(f, '4 4');
  Writeln(f, '0 4');
  Writeln(f, '-2 2');
  Writeln(f, '0 0');
  Writeln(f, '2 -1');
  Close(f);
end;

procedure Test4;
var
  f: Text;
  a, r1, r2: Real;
  i, n: Integer;
begin
  Assign(f, 'POLYGON.IN4'); Rewrite(f);
  n := 20;
  Writeln(f, n);
  for i := 0 to n - 1 do
    begin
      a := i / n * 2 * Pi;
      if i < n div 2 then
        begin
          r1 := 50; r2 := 50;
        end
      else
        begin
          r1 := 50; r2 := 100;
        end;
      Writeln(f, r1 * cos(a):1:4, ' ', r2 * sin(a):1:4);
    end;
  Close(f);
end;

procedure Test5;
var
  f: Text;
  a, r1, r2: Real;
  i, n: Integer;
begin
  Assign(f, 'POLYGON.IN5'); Rewrite(f);
  n := 50;
  Writeln(f, n);
  for i := 0 to n - 1 do
    begin
      a := i / n * 2 * Pi;
      if i < n div 2 then
        begin
          r1 := 500; r2 := 500;
        end
      else
        begin
          r1 := 500; r2 := 1500;
        end;
      Writeln(f, r2 * sin(a):1:4, ' ', r1 * cos(a):1:4);
    end;
  Close(f);
end;

procedure Test6;
var
  f: Text;
  a, r1, r2: Real;
  i, n: Integer;
begin
  Assign(f, 'POLYGON.IN6'); Rewrite(f);
  n := 60;
  Writeln(f, n + 1);
  for i := 0 to n - 1 do
    begin
      a := i / n * Pi * 0.7;
      r1 := 500; r2 := 500;
      Writeln(f, r2 * sin(a):1:4, ' ', r1 * cos(a):1:4);
    end;
  Writeln(f, '0 0');
  Close(f);
end;

procedure Test7;
var
  f: Text;
  a, r1, r2: Real;
  i, n: Integer;
begin
  Assign(f, 'POLYGON.IN7'); Rewrite(f);
  n := 70;
  Writeln(f, n);
  for i := 0 to n - 1 do
    begin
      a := i / n * Pi * 2;
      r1 := 1000; r2 := 500;
      Writeln(f, r1 * cos(a):1:4, ' ', r2 * sin(a):1:4);
    end;
  Close(f);
end;

procedure Test8;
var
  f: Text;
  a, r1, r2: Real;
  i, n: Integer;
begin
  Assign(f, 'POLYGON.IN8'); Rewrite(f);
  n := 5;
  Writeln(f, n + 1);
  for i := 0 to n - 1 do
    begin
      a := i / n * Pi * 1;
      r1 := 500; r2 := 500;
      Writeln(f, r1 * cos(a):1:4, ' ', r2 * sin(a):1:4);
    end;
  Writeln(f, '0 0');
  Close(f);
end;

procedure Test9;
var
  f: Text;
  a, r1, r2: Real;
  i, n: Integer;
begin
  Assign(f, 'POLYGON.IN9'); Rewrite(f);
  n := 100;
  Writeln(f, n);
  for i := 0 to n - 1 do
    begin
      a := i / n * Pi * 1.4 - Pi / 8;
      r1 := 100; r2 := 200;
      Writeln(f, r1 * cos(a):1:4, ' ', r2 * sin(a):1:4);
    end;
  Close(f);
end;

procedure Test0;
var
  f: Text;
  a, r1, r2: Real;
  i, n: Integer;
begin
  Assign(f, 'POLYGON.IN0'); Rewrite(f);
  n := 100;
  Writeln(f, n);
  for i := 0 to n - 1 do
    begin
      a := Sqr(i / n) * Pi * 2;
      r1 := 4000; r2 := 3400;
      Writeln(f, r1 * cos(a):1:4, ' ', r2 * sin(a):1:4);
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
