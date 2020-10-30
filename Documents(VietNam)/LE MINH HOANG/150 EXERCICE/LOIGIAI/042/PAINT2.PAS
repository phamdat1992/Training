program Automatical_Painting_Machine;
uses crt, graph;
const
 InputFile  = 'PAINT.INP';
 OutputFile = 'PAINT.OUT';
 maxColor = 50;
 maxN = 50;
type
 TRect = record
  X1, Y1, X2, Y2: Real;
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
 Sup, Inf: Real;
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

procedure Save(i: Byte);
var
 Current, Previous, j: Byte;
begin
 Current := Order[i];
 Previous := Order[i - 1];
 if C[Current] <> C[Previous] then
  BrushCount[i] := BrushCount[i - 1] + 1
 else
  BrushCount[i] := BrushCount[i - 1];
 for j := 1 to n do
  if Upper[Current, j] then Dec(deg[j]);
 Free[Current] := False;
end;

procedure Leave(i: Byte);
var
 j: Byte;
begin
 for j := 1 to n do
  if Upper[Order[i], j] then Inc(deg[j]);
 Free[Order[i]] := True;
end;

function ColorExists(Color: Byte): Byte;
var
 i, count: Byte;
 S: set of Byte;
begin
 S := [Color];
 count := 0;
 for i := 1 to n do
  if Free[i] and not (c[i] in S) then
   begin
    Inc(count);
    S := S + [c[i]];
   end;
 ColorExists := count;
end;

procedure KeepResult;
begin
 Best := Order;
 BrushBest := BrushCount[n];
end;

procedure Try(i: Byte);
var
 j: Byte;
begin
 for j := 1 to n do
  if Free[j] and (deg[j] = 0) then
   begin
    Order[i] := j;
    Save(i);
    if BrushCount[i] + ColorExists(c[j]) < BrushBest then {Nhanh can}
     if i = n then KeepResult
     else Try(i + 1);
    Leave(i);
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

procedure Display;
var
 rx, ry, maxX, maxY: Real;
 i, k: Byte;
 f: Text;
 procedure PaintRect(i: Byte);
 begin
  with R[i] do
   Bar(Round(X1 * rx), 480 - Round(Y2 * ry),
            Round(X2 * rx), 480 - Round(Y1 * ry));
  SetColor(0);
  with R[i] do
   Rectangle(Round(X1 * rx), 480 - Round(Y2 * ry),
            Round(X2 * rx), 480 - Round(Y1 * ry));
 end;

begin
 gd := 0;
 InitGraph(gd, gm, 'D:\DAYHOC');
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
   SetFillStyle(11, C[i]);
   PaintRect(i);
  end;
 Assign(f, 'PAINT.OUT'); Reset(f);
 Readln(f, i);
 for i := 1 to n do
  begin
   Delay(1000);
   Read(f, k);
   SetFillStyle(1, c[k]);
   PaintRect(k);
  end;
 Close(f);
 Readln;
 CloseGraph;
end;

begin
 Enter;
 Init;
 Try(1);
 PrintResult;
 Display;
end.
7
4 0 6 3  2
0 0 4 2  1
4 3 6 5  1
2 5 6 6  2
2 2 4 5  2
0 4 2 6  1
0 2 2 4  1

