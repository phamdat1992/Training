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


begin
  Test1;
  Test2;
  Test3;
end.
