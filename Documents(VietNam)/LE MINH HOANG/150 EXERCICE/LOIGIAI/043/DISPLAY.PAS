program Display;
uses crt, graph;
const
  InputFile  = 'POLYGON.IN0';
  OutputFile = 'POLYGON.OUT';
  max = 100;
var
  gd, gm: Integer;
  x, y: array[1..max] of Real;
  P: array[1..max, 1..2] of Integer;
  x1, y1, x2, y2: Real;
  rx, ry, ratio: Real;
  n: Byte;

procedure ReadPolygon;
var
  f: Text;
  i: Byte;
begin
  x1 := 1000000; y1 := 1000000; x2 := -x1; y2 := -y1;
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    begin
      Readln(f, x[i], y[i]);
      if x[i] < x1 then x1 := x[i];
      if x[i] > x2 then x2 := x[i];
      if y[i] < y1 then y1 := y[i];
      if y[i] > y2 then y2 := y[i];
    end;
  Close(f);
  rx := 600 / (x2 - x1);
  ry := 400 / (y2 - y1);
  if rx > ry then ratio := ry else ratio := rx;
end;

procedure CalP;
var
  i: Byte;
begin
  for i := 1 to n do
    begin
      p[i, 1] := Round((x[i] - x1) * ratio);
      p[i, 2] := 440 - Round((y[i] - y1) * ratio);
    end;
  SetFillStyle(1, 2); SetColor(10);
  FillPoly(n, p);
  DrawPoly(n, p);
end;

procedure Result;
var
  f: Text;
  s, t: Real;
  p1, p2, i: Byte;
begin
  Assign(f, OutputFile); Reset(f);
  Readln(f, s);
  SetColor(14);
  for i := 1 to n - 3 do
    begin
      Readln(f, p1, p2);
      Line(p[p1, 1], p[p1, 2], p[p2, 1], p[p2, 2]);
    end;
  Close(f);
end;

begin
  gd := 0;
  Initgraph(gd, gm, 'c:\tp');
  ReadPolygon;
  CalP;
  Result;
  Readln;
  CloseGraph;
end.
