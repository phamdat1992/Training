{Sai roi}
{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program FindPermute;
const
 InputFile  = 'SLANTING.INP';
 OutputFile = 'SLANTING.OUT';
 max = 100;
 maxLong = 1000000000;
var
 a, b: array[1..max + 1] of Integer;
 Fx, Fy: array[1..max + 1] of LongInt;
 MatchX, MatchY: array[1..max + 1] of Integer;
 Queue: array[1..max + 1] of Integer;
 Trace: array[1..max + 1] of Integer;
 VisitedX, VisitedY: array[1..max + 1] of Boolean;
 n, First, Last: Integer ;

procedure Enter;
var
 f: Text;
 i: Integer;
begin
 Assign(f, 'SLANTING.INP'); Reset(f);
 Readln(f, n);
 for i := 1 to n do Readln(f, a[i], b[i + 1]);
 Close(f);
 b[1] := 1; a[n + 1] := 1;
end;

procedure Init;
begin
 FillChar(Fx, SizeOf(Fx), 0);
 FillChar(Fy, SizeOf(Fy), 0);
 FillChar(MatchX, SizeOf(MatchX), 0);
 FillChar(MatchY, SizeOf(MatchY), 0);
end;

procedure EmptyQueue;
begin
 Last := 0;
 First := 1;
end;

procedure Push(v: Integer);
begin
 Inc(Last);
 Queue[Last] := v;
end;

function Pop: Integer;
begin
 Pop := Queue[First];
 Inc(First);
end;

function c(x, y: Integer): LongInt;
begin
 if (y = x + 1) or (x = n + 1) and (y = 1) then c := maxLong
 else c := Abs(b[y] - a[x])
end;

function FindAugmentingPath(StartX: Integer): Integer;
var
 x, y: Integer;
begin
 FillChar(VisitedX, SizeOf(VisitedX), False);
 FillChar(VisitedY, SizeOf(VisitedY), False);
 EmptyQueue;
 VisitedX[StartX] := True; Push(StartX);
 repeat
  x := Pop;
  for y := 1 to n + 1 do
   if (c(x, y) = Fx[x] + Fy[y]) and not VisitedY[y] then
    begin
     Trace[y] := x;
     if MatchY[y] = 0 then
      begin
       FindAugmentingPath := y;
       Exit;
      end;
     Push(MatchY[y]);
     VisitedY[y] := True;
     VisitedX[MatchY[y]] := True;
    end;
 until First > Last;
 FindAugmentingPath := 0;
end;

procedure AddXSubY;
var
 x, y: Integer;
 min: LongInt;
begin
 min := MaxLong;
 for x := 1 to n + 1 do
  for y := 1 to n + 1 do
   if VisitedX[x] and not VisitedY[y] and
    (min > c(x, y) - Fx[x] - Fy[y]) then min := c(x, y) - Fx[x] - Fy[y];
 for x := 1 to n + 1 do
  if VisitedX[x] then Fx[x] := Fx[x] + min;
 for y := 1 to n + 1 do
  if VisitedY[y] then Fy[y] := Fy[y] - min;
end;

procedure Enlarge(EndY: Integer);
var
 x, Next: Integer;
begin
 repeat
  x := Trace[EndY];
  Next := MatchX[x];
  MatchX[x] := EndY;
  MatchY[Endy] := x;
  Endy := Next;
 until EndY = 0;
end;

procedure Solve;
var
 k, YEnd: Integer;
begin
 for k := 1 to n + 1 do
  begin
   repeat
    YEnd := FindAugmentingPath(k);
    if YEnd = 0 then AddXSubY;
   until YEnd <> 0;
   Enlarge(YEnd);
  end;
end;

procedure Result;
var
 w: LongInt;
 i, y: Integer;
 f: Text;
begin
 w := 0;
 for i := 1 to n + 1 do w := w + Fy[i] + Fx[i];
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, w);
 y := 1;
 for i := 1 to n do
  begin
   Writeln(f, MatchY[y]);
   y := MatchY[y];
  end;
 Close(f);
end;

begin
 Enter;
 Init;
 Solve;
 Result;
end.
2
5 5
6 6

7
1 10
2 8
3 9
4 7
5 8
6 20
8 21


