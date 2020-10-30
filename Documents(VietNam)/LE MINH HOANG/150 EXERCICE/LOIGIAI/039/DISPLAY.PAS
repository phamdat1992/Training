uses crt, graph;
type
  Real = Single;
var
  gd, gm: Integer;
  f: Text;
  i, u, v: Word;
  X, Y: array[1..1000] of Real;
  tx, ty: array[1..1000] of Integer;
  minx, miny, maxx, maxy: Real;
  n, m, K: Word;
  r, rx, ry: Real;
  ch: Char;
  s: String;
begin
  Write('Display Result of NET.IN'); ch := ReadKey; Writeln(ch);
  Assign(f, 'NET.IN' + ch); Reset(f);
  Readln(f, n, m);
  minx := 1001; miny := 1001;
  maxx := -1001; maxy := -1001;
  for i := 1 to n do
    begin
      Readln(f, x[i], y[i]);
      if x[i] > maxx then maxx := x[i];
      if x[i] < minx then minx := x[i];
      if y[i] > maxy then maxy := y[i];
      if y[i] < miny then miny := y[i];
    end;
  s := '';
  repeat
    gd := InstallUserDriver('VESA16', nil);
    gm := 0;
    InitGraph(gd, gm, s);
    if GraphResult = 0 then Break;
    Write('Enter Path to .BGI: '); Readln(s);
    if s = '' then Halt;
  until False;
  CloseGraph;
  gm := 2;
  repeat
    gd := InstallUserDriver('VESA16', nil);
    InitGraph(gd, gm, s);
    if GraphResult = 0 then Break;
    Dec(gm);
  until False;
  rx := (getmaxx - 20) / (maxx - minx);
  ry := (getmaxy - 20) / (maxy - miny);
  if rx < ry then r := rx else r := ry;
  for i := 1 to n do
    begin
      tx[i] := Round((x[i] - minx) * r);
      ty[i] := Round((y[i] - miny) * r);
    end;
  SetViewPort(10, 10, 11, 11, False);
  SetColor(8);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      Line(tX[u], tY[u], tX[v], tY[v]);
    end;
  Close(f);
  SetColor(10);
  Assign(f, 'NET.OUT'); Reset(f);
  Readln(f, K);
  for i := 1 to k do
    begin
      Readln(f, u, v);
      Line(tX[u], tY[u], tX[v], tY[v]);
    end;
  Close(f);
  SetColor(14); SetFillStyle(1, 14);
  for i := 1 to n do
    PieSlice(tX[i], tY[i], 0, 360, 2);
  Readln;
  CloseGraph;
end.
