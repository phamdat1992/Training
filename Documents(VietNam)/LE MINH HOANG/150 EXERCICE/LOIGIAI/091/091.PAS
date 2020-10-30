program Bound;
const
  InputFile  = 'BOUND.INP';
  OutputFile = 'BOUND.OUT';
  max = 1000;
var
  b, x, y: array[1..max] of Integer;
  nBound, DeltaX, DeltaY, n: Integer;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Readln(f, x[i], y[i]);
  Close(f);
end;

function Lower(x1, y1, x2, y2: LongInt): Boolean;
begin
  if y1 < 0 then
    begin
      x1 := -x1; y1 := -y1;
    end;
  if y2 < 0 then
    begin
      x2 := -x2; y2 := -y2;
    end;
  if y1 * x2 = y2 * x1 then Lower := Sqr(y1) + Sqr(x1) <= Sqr(y2) + Sqr(x2);
  Lower := x1 * y2 > x2 * y1;
end;

procedure Init;
var
  imin, i, tmp: Integer;
begin
  imin := 1;
  for i := 2 to n do
    if (y[i] < y[imin]) or (y[i] = y[imin]) and (x[i] < x[imin]) then
      imin := i;
  DeltaX := x[imin]; DeltaY := y[imin];
  for i := 1 to n do
    begin
      x[i] := x[i] - DeltaX;
      y[i] := y[i] - DeltaY;
    end;
  Move(x[imin + 1], x[imin], (n - imin) * SizeOf(x[1]));
  Move(y[imin + 1], y[imin], (n - imin) * SizeOf(y[1]));
end;

procedure ShellSort;
var
  sx, sy, i, j, h, m: Integer;
begin
  m := n - 1;
  h := 1;
  while h <> 0 do
    begin
      for i := h + 1 to m do
        begin
          sx := x[i]; sy := y[i];
          j := i - h;
          while (j > 0) and Lower(sx, sy, x[j], y[j]) do
            begin
              x[j + h] := x[j]; y[j + h] := y[j];
              j := j - h;
            end;
          x[j + h] := sx; y[j + h] := sy;
        end;
      h := h shr 1;
    end;
  i := m;
  while LongInt(x[i]) * y[i - 1] = LongInt(x[i - 1]) * y[i] do Dec(i);
  Inc(i); j := m;
  while i < j do
    begin
      sx := x[i]; x[i] := x[j]; x[j] := sx;
      sy := y[i]; y[i] := y[j]; y[j] := sy;
      Inc(i); Dec(j);
    end;
end;

procedure Refine;
begin
  Move(x[1], x[2], (n - 1) * SizeOf(x[1]));
  Move(y[1], y[2], (n - 1) * SizeOf(y[1]));
  x[1] := 0; y[1] := 0;
end;

function ccw(i, j, k: Integer): Boolean;
var
  v1x, v1y, v2x, v2y: LongInt;
begin
  v1x := x[j] - x[i]; v1y := y[j] - y[i];
  v2x := x[k] - x[j]; v2y := y[k] - y[j];
  ccw := v1x * v2y - v1y * v2x <= 0;
end;

procedure GetBound;
var
  i: Integer;
begin
  b[1] := 1; b[2] := 2; b[3] := 3;
  nBound := 3;
  for i := 4 to n do
    begin
      while (nBound > 2) and ccw(b[nBound - 1], b[nBound], i) do Dec(nBound);
      Inc(nBound);
      b[nBound] := i;
    end;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  writeln(f, nBound);
  for i := 1 to nBound do
    Writeln(f, x[b[i]] + DeltaX, ' ', y[b[i]] + DeltaY);
  Close(f);
end;

begin
  Enter;
  Init;
  ShellSort;
  Refine;
  GetBound;
  Result;
end.
10
0 -1
1 0
1 -3
2 4
3 -3
4 1
4 2
5 -1
6 -2
7 -1
