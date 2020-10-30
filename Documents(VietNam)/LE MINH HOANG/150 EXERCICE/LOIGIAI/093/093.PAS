{$N+,E-}
{$M 65520 0 655360}
program Telecommunications;
const
  InputFile  = 'TELECOM.IN8';
  OutputFile = 'TELECOM.OUT';
  max = 1000;
  maxR = 15000; {> 10000*sqrt(2)}
  eps = 1E-7;
  Pi = System.Pi;
type
  Real = Extended;
  TArr = array[1..max] of Real;
var
  Sx, Sy, x, y: TArr;
  cInf, cX, cY, cR: Real;
  cRoot, Sn, n: Integer;
  StartTime: LongInt;
  Time: LongInt absolute 0:$46C;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    Readln(f, x[i], y[i]);
  Close(f);
end;

procedure GetBound;
var
  b: array[1..max] of Integer;
  DeltaX, DeltaY: Real;
  i, m, j: Integer;

  procedure GetRoot;
  var
    i, imin: Integer;
  begin
    imin := 1; DeltaX := x[1]; DeltaY := y[1];
    for i := 2 to n do
      if (y[i] < DeltaY) or (y[i] = DeltaY) and (x[i] < DeltaX) then
        begin
          DeltaY := y[i]; DeltaX := x[i];
          imin := i;
        end;
    for i := 1 to n do
      begin
        x[i] := x[i] - DeltaX; y[i] := y[i] - DeltaY;
      end;
    x[imin] := x[1]; y[imin] := y[1];
    x[1] := 0; y[1] := 0;
  end;

  function Lower(x1, y1, x2, y2: Real): Boolean; {x1/y1 > x2/y2}
  var
    t: Real;
  begin
    t := x1 * y2 - x2 * y1;
    Lower := (t > eps) or
          (Abs(t) < eps) and (Abs(x1) + Abs(y1) < Abs(x2) + Abs(y2));
  end;

  procedure ShellSort;
  var
    i, j, h: Integer;
    tmpx, tmpy: Real;
  begin
    h := (n - 1) shr 1;
    while h <> 0 do
      begin
        for i := 2 + h to n do
          begin
            tmpx := x[i]; tmpy := y[i];
            j := i - h;
            while (j > 1) and Lower(tmpx, tmpy, x[j], y[j]) do
              begin
                x[j + h] := x[j]; y[j + h] := y[j];
                j := j - h;
              end;
            x[j + h] := tmpx; y[j + h] := tmpy;
          end;
        h := h shr 1;
      end;
  end;

  procedure Refine;
  var
    i, j: Integer;
  begin
    i := n;
    j := i - 1;
    while (j > 2) and (Abs(x[i] * y[j] - x[j] * y[i]) < eps) do Dec(j);
    Inc(j);
    x[j] := x[n]; y[j] := y[n];
    n := j;
  end;

  function CCW(A, B, C: Integer): Boolean;
  var
    xAB, yAB, xBC, yBC: Real;
  begin
    xAB := x[B] - x[A]; yAB := y[B] - y[A];
    xBC := x[C] - x[B]; yBC := y[C] - y[B];
    CCW := xAB * yBC - xBC * yAB > eps;
  end;

begin
  GetRoot;
  ShellSort;
  Refine;
  m := 3;
  b[1] := 1; b[2] := 2; b[3] := 3;
  for i := 4 to n do
    begin
      while (m > 2) and not CCW(b[m  - 1], b[m], i) do Dec(m);
      Inc(m);
      b[m] := i;
    end;
  for i := 1 to m do
    begin
      x[i] := x[b[i]];
      y[i] := y[b[i]];
    end;
  n := m;
  for i := 1 to n do
    begin
      x[i] := x[i] + DeltaX;
      y[i] := y[i] + DeltaY;
    end;
end;
{--------------------- Het bao loi -------------------------------}
function Distance(x, y: Real): Real;
begin
  Distance := Sqrt(Sqr(x) + Sqr(y));
end;

procedure Init;
var
  i, j: Integer;
  t: Real;
begin
  Sx := x; Sy := y;
  Sn := n;
  Cinf := 0;
  for i := 1 to n do
    for j := i + 1 to n do
      begin
        t := Sqr(x[i] - x[j]) + Sqr(y[i] - y[j]);
        if t > Cinf then Cinf := t;
      end;
  Cinf := Sqrt(Cinf) / 2;
end;

procedure Rotate(alpha: Real);
var
  cosine, sine, xp, yp: Real;
  i: Integer;
begin
  cosine := Cos(alpha); sine := Sin(alpha);
  for i := 1 to n do
    begin
      xp := x[i] * cosine - y[i] * sine;
      yp := x[i] * sine + y[i] * cosine;
      x[i] := xp; y[i] := yp;
    end;
end;

function GetAngle(x, y: Real): Real;
var
  a: Real;
begin
  if Abs(x) < eps then
    if y > 0 then GetAngle := Pi / 2
    else GetAngle := -Pi / 2
  else
    begin
      a := Arctan(y / x);
      if x < 0 then GetAngle := a + Pi
      else GetAngle := a;
    end;
end;

procedure RefineXY(Root: Integer);
var
  a, xp, yp, iX, iY: Real;
  i, next: Integer;
begin
  if Root = n then next := 1 else next := Root + 1;
  iX := - y[next] + y[Root]; iY := x[next] - x[Root];
  xp := x[Root]; yp := y[Root];
  for i := 1 to n do
    begin
      x[i] := x[i] - xp; y[i] := y[i] - yp;
    end;
  a := GetAngle(iX, iY);
  Rotate(-GetAngle(iX, iY));
  x[Root] := x[1]; y[Root] := y[1];
  x[1] := 0; y[1] := 0;
end;

procedure GetArc(i: Integer; Radius: Real; var a, b: Real);
var
  dx, dy: Real;
  ang, Rang: Real;
begin
  dx := Distance(x[i], y[i]) / 2;
  dy := Sqrt(Sqr(Radius) - Sqr(dx));
  ang := Arctan(dy / dx);
  Rang := GetAngle(x[i], y[i]);
  a := Rang - ang; b := Rang + ang;
end;

procedure GetMinMax(Radius: Real; var maxStart, minEnd: Real);
var
  i: Integer;
  a, b: Real;
begin
  maxStart := -2 * Pi; minEnd := 2 * Pi;
  for i := 2 to n do
    begin
      GetArc(i, Radius, a, b);
      if a > maxStart then maxStart := a;
      if b < minEnd then minEnd := b;
      if maxStart > minEnd then Exit;
    end;
end;

procedure Solve1(var centerX, centerY, Radius: Real);
var
  inf, sup, median, maxStart, minEnd: Real;
  i: Integer;
begin
  Inf := CInf; Sup := CR;
  repeat
    median := (inf + sup) / 2;
    GetMinMax(median, maxStart, minEnd);
    if maxStart > minEnd then inf := median
    else sup := median;
  until inf + eps >= sup;
  GetMinMax(sup, maxStart, minEnd);
  if maxStart > minEnd then
    begin
      Radius := maxR; Exit;
    end
  else
    Radius := sup;
  median := (maxStart + minEnd) / 2;
  centerX := Radius * cos(median);
  centerY := Radius * sin(median);
end;

procedure Solve;
var
  Root: Integer;
  tx, ty, tr: Real;
begin
  CR := maxR;
  for Root := 1 to n do
    begin
      x := Sx; y := Sy; n := Sn;
      RefineXY(Root);
      Solve1(tx, ty, tr);
      if tr < CR then
        begin
          CX := tx; CY := ty; CR := tr;
          CRoot := Root;
        end;
      if Abs(CR - CInf) < eps then Break;
    end;
end;

procedure Result;
var
  f: Text;
  xp, yp, iX, iY, a: Real;
  next: Integer;
begin
  x := Sx; y := Sy; n := Sn;
  if CRoot = n then next := 1 else next := CRoot + 1;
  iX := - y[next] + y[CRoot]; iY := x[next] - x[CRoot];
  a := GetAngle(iX, iY);
  xp := cX * cos(a) - cY * sin(a);
  yp := cX * sin(a) + cY * cos(a);
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, xp + x[cRoot]:1:6, ' ',
             yp + y[cRoot]:1:6, ' ',
             cR:1:6);
  Close(f);
end;

begin
  StartTime := Time;
  Enter;
  GetBound;
  Init;
  Solve;
  Result;
  Writeln((Time - StartTime) / 18.2:1:4);
end.
7
2 2
0 1
0 2
0 0
1 0
2 0
1 1
