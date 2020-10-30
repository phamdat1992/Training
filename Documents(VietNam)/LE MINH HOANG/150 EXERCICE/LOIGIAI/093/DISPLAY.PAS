program Display;
uses crt, graph;
const
  InputFile  = 'TELECOM.INP';
  OutputFile = 'TELECOM.OUT';
type
  Real = Extended;
var
  gd, gm: Integer;
  x, y: array[1..1000] of Real;
  minx, miny, maxx, maxy, deltax, deltay, ratio, Rx, Ry: Real;
  sx, sy, cx, cy, cr: Real;
  f: Text;
  n, i: Integer;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  minx := 10000; maxx := -10000;
  miny := 10000; maxy := -10000;
  for i := 1 to n do
    begin
      Readln(f, x[i], y[i]);
      if x[i] < minx then minx := x[i];
      if y[i] < miny then miny := y[i];
      if x[i] > maxx then maxx := x[i];
      if y[i] > maxy then maxy := y[i];
    end;
  DeltaX := minX;
  DeltaY := minY;
  if maxX <> minX then Rx := 500/ (maxX - minX)
  else Rx := 1;
  if maxY <> minY then Ry := 320 / (maxY - minY)
  else Ry := 1;
  if rx < ry then ratio := rx
  else ratio := ry;
  Close(f);
end;

procedure change(var x, y: Real);
begin
  x := (x - DeltaX) * ratio;
  y := (y - DeltaY) * ratio;
end;

begin
  Enter;
  gd := 0;
  Initgraph(gd, gm, 'd:\dayhoc');
  SetViewPort(80, 400, 81, 401, False);
  Assign(f, OutputFile); Reset(f);
  Readln(f, cx, cy, cr);
  Change(cx, cy); cr := cr * ratio;
  SetColor(3);
  Circle(Round(cX), -Round(cy), Round(cr));
  Close(f);
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  SetColor(10); SetFillStyle(1, 10);
  for i := 1 to n do
    begin
      Change(x[i], y[i]);
      Pieslice(Round(x[i]), -Round(y[i]), 0, 360, 2);
    end;
  Close(f);
  Readln;
  CloseGraph;
end.
