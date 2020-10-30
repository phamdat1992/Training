program Horses;
const
 InputFile  = 'HORSES.INP';
 OutputFile = 'HORSES.OUT';
 max = 100;
 maxLong = $FFFF;
 dx: array[1..8] of ShortInt  = (1, -1, 1, -1, 2, -2, 2, -2);
 dy: array[1..8] of ShortInt  = (2, 2, -2, -2, 1, 1, -1, -1);
type
 TBoard = array[-1..max + 2, -1..max + 2] of Integer;
 PBoard = ^TBoard;
 TMap = array[-1..max + 2, -1..max + 2] of Char;
var
 xS, yS, xD, yD: array[1..max] of Integer;
 Map: ^TMap;
 Board: ^TBoard;
 Q: array[1..max * max] of Word;
 c: array[1..max, 1..max] of Word;
 Fx, Fy: array[1..max] of LongInt;
 Trace, matchX, matchY: array[1..max] of Integer;
 VisitedX, VisitedY: array[1..max] of Boolean;
 n, k, First, Last: Integer;

 Time: LongInt absolute 0:$46C;
 Start: LongInt;

procedure Enter;
var
 f: Text;
 i, j, m1, m2: Integer;
begin
 New(Map);
 FillChar(Map^, SizeOf(Map^), 'C');
 m1 := 0; m2 := 0;
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 for i := 1 to n do
  begin
   for j := 1 to n do
    begin
     Read(f, Map^[i, j]);
     if Map^[i, j] = 'S' then
      begin
       Inc(m1);
       xS[m1] := i; yS[m1] := j;
      end;
     if Map^[i, j] = 'D' then
      begin
       Inc(m2);
       xD[m2] := i; yD[m2] := j;
      end;
    end;
   Readln(f);
  end;
 k := m1;
 Close(f);
end;

procedure Init;
begin
 New(Board);
end;

procedure Destroy;
begin
 Dispose(Board); Dispose(Map);
end;

procedure InitQueue;
begin
 First := 0; Last := 0;
end;

procedure Push(x, y: Integer);
begin
 Inc(Last);
 Q[Last] := x or (y shl 8);
end;

procedure Pop(var x, y: Integer);
begin
 Inc(First);
 x := Lo(Q[First]); y := Hi(Q[First]);
end;

procedure Push1(x: Integer);
begin
 Inc(Last); Q[Last] := x;
end;

function Pop1: Integer;
begin
 Inc(First); Pop1 := Q[First];
end;

procedure BFS(Start, Finish: Integer); {Finish = 0 <=> Loang tat}
var
 x, y, newx, newy, d, c: Integer;
begin
 FillChar(Board^, SizeOf(Board^), 255);
 for x := 1 to n do
  for y := 1 to n do
   if Map^[x, y] <> 'C' then Board^[x, y] := 0;
 Board^[xD[Start], yD[Start]] := 1;
 InitQueue; Push(xD[Start], yD[Start]);
 c := 0;
 repeat
  Pop(x, y);
  for d := 1 to 8 do
   begin
    newx := x + dx[d]; newy := y + dy[d];
    if Board^[newx, newy] = 0 then
     begin
      Board^[newx, newy] := Board^[x, y] + 1;
      if Map^[newx, newy] = 'S' then
       begin
        Inc(c);
        if c = k then Exit;
        if (Finish <> 0) and
           (newx = xS[Finish]) and (newy = yS[Finish]) then Exit;
       end;
      Push(newx, newy);
     end;
   end;
 until First >= Last;
end;

procedure GetShortestPaths;
var
 i, j: Integer;
begin
 for i := 1 to k do
  for j := 1 to k do c[i, j] := maxLong;
 for i := 1 to k do
  begin
   BFS(i, 0);
   for j := 1 to k do
    if Board^[xS[j], yS[j]] <> 0 then c[i, j] := Board^[xS[j], yS[j]] - 1;
  end;
end;

procedure GoOut;
var
 f: Text;
begin
 Assign(f, OutputFile); Rewrite(f);
 Write(f, -1);
 Close(f);
 Destroy;
 Writeln('Time = ', (Time - Start) /18.2:1:2, ' (s)');
 Halt;
end;

procedure HungarianInit;
var
 i, j: Integer;
begin
 FillChar(Fx, SizeOf(Fx), 0);
 FillChar(Fy, SizeOf(Fy), 0);
 FillChar(matchX, SizeOf(matchX), 0);
 FillChar(matchY, SizeOf(matchY), 0);
end;

function FindAugmentingPath(xStart: Integer): Integer;
var
 x, y: Integer;
begin
 FillChar(VisitedX, k, False);
 FillChar(VisitedY, k, False);
 InitQueue;
 Push1(xStart);
 VisitedX[xStart] := True;
 repeat
  x := Pop1;
  for y := 1 to k do
   if not VisitedY[y] and (matchX[x] <> y)
      and (c[x, y] <> maxLong) and (c[x, y] = Fx[x] + Fy[y]) then
    begin
       Trace[y] := x;
       if matchY[y] = 0 then
        begin
         FindAugmentingPath := y; Exit;
        end;
       VisitedY[y] := True;
       VisitedX[matchY[y]] := True;
       Push1(matchY[y]);
    end;
 until first >= last;
 FindAugmentingPath := 0;
end;

procedure SubXAddY;
var
 i, j, t: Integer;
 Delta: LongInt;
begin
 Delta := maxLong;
 for i := 1 to k do
  if VisitedX[i] then
   for j := 1 to k do
    if not VisitedY[j] and (c[i, j] - Fx[i] - Fy[j] < Delta)
       and (c[i, j] <> maxLong) then Delta := c[i, j] - Fx[i] - Fy[j];
 if Delta = maxLong then GoOut;
 for t := 1 to k do
  begin
   if VisitedX[t] then Fx[t] := Fx[t] + Delta;
   if VisitedY[t] then Fy[t] := Fy[t] - Delta;
  end;
end;

procedure Enlarge(s, f: Integer);
var
 x, next: Integer;
begin
 repeat
  x := Trace[f];
  next := matchX[x];
  matchX[x] := f; matchY[f] := x;
  f := next;
 until x = s;
end;

procedure Solve;
var
 x, y: Integer;
begin
 for x := 1 to k do
  begin
   repeat
    y := FindAugmentingPath(x);
    if y = 0 then SubXAddy;
   until y <> 0;
   Enlarge(x, y);
  end;
end;

procedure Result;
var
 f: Text;
 i, j, x, y, c, nextx, nexty, d: Integer;
 nStep: LongInt;
begin
 nStep := 0;
 for i := 1 to k do nStep := nStep + Fx[i] + Fy[i];
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, nStep);
 for i := 1 to k do
  begin
   j := matchX[i]; BFS(i, j);
   x := xS[j]; y := yS[j];
   repeat
    c := Board^[x, y];
    for d := 1 to 8 do
     begin
      nextx := x + dx[d]; nexty := y + dy[d];
      if (Map^[nextx, nexty] <> 'C') and (Board^[nextx, nexty] = c - 1) then
       Break;
     end;
    Writeln(f, x, ' ', y, ' ', nextx, ' ', nexty);
    x := nextx; y := nexty;
   until (x = xD[i]) and (y = yD[i]);
  end;
 Close(f);
end;

begin
 Start := Time;
 Enter;
 Init;
 GetShortestPaths;
 HungarianInit;
 Solve;
 Result;
 Destroy;
 Writeln('Time = ', (Time - Start) /18.2:1:2, ' (s)');
end.

6
C.C..S
...SD.
..C...
..SC..
CC.SDD
C....D
