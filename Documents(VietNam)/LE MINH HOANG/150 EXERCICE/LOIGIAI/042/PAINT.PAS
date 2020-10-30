program Automatical_Painting_Machine;
uses crt, graph;
const
  InputFile  = 'PAINT.INP';
  OutputFile = 'PAINT.OUT';
  maxColor = 15;
  maxN = 50;
type
  TRect = record
    X1, Y1, X2, Y2: Byte;
  end;
  TSolution = array[0..maxN] of Byte;
var
  R: array[1..maxN] of TRect;
  C: array[0..maxN] of Byte; {C[i] = mau can to R[i]}
  Upper: array[1..maxN, 1..maxN] of Boolean; {True neu R[i] nam tren R[j]}
  deg: array[1..maxN] of Byte; {deg[i] = So HCN chua to ma nam tren R[i]}

  Free: array[1..maxN] of Boolean;
  Best, Order: TSolution;
  BrushCount: array[0..maxN] of Byte;

  n, BrushBest: Byte;

  gd, gm: Integer;
  Time: LongInt absolute 0:$46C;
  OldTime: LongInt;

procedure Enter;
var
  f: Text;
  i: Byte;
begin
  C[0] := 0;
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    with R[i] do Readln(f, X1, Y1, X2, Y2, C[i]);
  Close(f);
end;

function IsUpper(A, B: TRect): Boolean;
var
  Sup, Inf: Byte;
begin
  if A.X2 > B.X2 then Sup := A.X2 else Sup := B.X2;
  if A.X1 < B.X1 then Inf := A.X1 else Inf := B.X1;
  IsUpper := (A.Y1 >= B.Y2) and
                        (Sup - Inf < A.X2 - A.X1 + B.X2 - B.X1);
end;

procedure Init;
var
  i, j: Byte;
begin
  for i := 1 to n do
    for j := 1 to n do
      Upper[i, j] := IsUpper(R[i], R[j]);
  FillChar(deg, SizeOf(deg), 0);
  for i := 1 to n do
    for j := 1 to n do
      if Upper[i, j] then Inc(deg[j]);
  BrushCount[0] := 0;
  BrushBest := 255;
  FillChar(Free, SizeOf(Free), True);
end;

function Accept(k: Byte): Boolean; {Thu xem HCN k da son duoc chua}
var
  i: Byte;
begin
  for i := 1 to n  do
    if Free[i] and Upper[i, k] then
      begin
        Accept := False;
        Exit;
      end;
  Accept := True;
end;

function ColorExists(Color: Byte): Byte; {So mau cua cac HCN con lai}
var
  i, count: Byte;
  S: set of Byte;
begin
  S := []; Count := 0;
  for i := 1 to n do
    if Free[i] and (C[i] in S) then
      begin
        Include(S, C[i]);
        Inc(Count);
      end;
  ColorExists := Count;
end;

procedure KeepResult; {Save Best Config}
begin
  Best := Order;
  BrushBest := BrushCount[n];
end;

procedure Try(i: Byte); {Thu cac cach chon HCN thu i trong thu tu son}
var
  j: Byte;
begin
  for j := 1 to n do {Find AutoPaint Rectangle}
    if Free[j] and (c[j] = c[Order[i - 1]]) and Accept(j) then
      begin
        Order[i] := j;
        Free[j] := False;
        BrushCount[i] := BrushCount[i - 1];
        if i = n then KeepResult
        else Try(i + 1);
        Free[j] := True;
        Exit;
      end;
  for j := 1 to n do
    if Free[j] and (c[j] <> c[Order[i - 1]]) and Accept(j) then
      begin
        Order[i] := j;
        Free[j] := False;
        BrushCount[i] := BrushCount[i - 1] + 1;
        if BrushCount[i] + ColorExists(j) < BrushBest then {Nhanh can}
          if i = n then KeepResult
          else Try(i + 1);
        Free[j] := True;
      end;
end;

procedure PrintResult;
var
  i: Byte;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, BrushBest);
  for i := 1 to n do Write(f, Best[i], ' ');
  Close(f);
end;

procedure Display; {Display Result on Graphic mode}
var
  maxX, maxY: Byte;
  rx, ry: Real;
  i, k, p, bCount: Byte;
  f: Text;
  procedure PaintRect(i: Byte; BrushCount: Byte); {Ve HCN thu i}
  var
    S: String[3];
    iX1, iY1, iX2, iY2: Integer;
  begin
    with R[i] do
      begin
        iX1 := Round(X1 * rx);
        iY1 := 480 - Round(Y2 * ry);
        iX2 := Round(X2 * rx);
        iY2 := 480 - Round(Y1 * ry);
      end;
    Bar(iX1, iY1, iX2, iY2);
    SetColor(0);
    Rectangle(iX1, iY1, iX2, iY2);
    SetTextJustify(1, 1);
    Str(BrushCount, S);
    if BrushCount <> 0 then OuttextXY((iX1 + iX2) div 2, (iY1 + iY2) div 2, S);
  end;

begin
  gd := 0;
  InitGraph(gd, gm, 'd:\Dayhoc');
  maxX := 0; maxY := 0;
  for i := 1 to n do
    begin
      if R[i].X2 > maxX then maxX := R[i].X2;
      if R[i].Y2 > maxY then maxY := R[i].Y2;
    end;
  rx := 640 / maxX; ry := 480 / maxY;
  if rx > ry then rx := ry else ry := rx;

  for i := 1 to n do
    begin
      SetFillStyle(8, C[i]);
      PaintRect(i, 0);
    end;
  Assign(f, 'PAINT.OUT'); Reset(f);
  Readln(f); {Bo qua dong dau tien}
  p := 0;
  bCount := 0;
  for i := 1 to n do
    begin
      if KeyPressed then
        begin
          CLoseGraph;
          Exit;
        end;
      Delay(100);
      Read(f, k);
      SetFillStyle(1, c[k]);
      if c[k] <> p then Inc(bCount);
      p := c[k];
      PaintRect(k, bCount);
    end;
  Close(f);
end;

begin
  OldTime := Time;
  Enter;
  Init;
  Try(1);
  PrintResult;
  Writeln((Time - OldTime) / 18.2:1:2, ' (s)');
  Writeln('Press Enter...');
  Readln;
  Display;
  Readln;
end.
7
4 0 6 3  2
0 0 4 2  1
4 3 6 5  1
2 5 6 6  2
2 2 4 5  2
0 4 2 6  1
0 2 2 4  1

10
0 0 1 1  1
1 0 3 1  2
3 0 4 1  1
0 1 2 2  2
2 1 4 2  1
0 2 1 3  2
1 2 3 3  1
3 2 4 3  2
0 3 2 4  1
2 3 4 4  2


