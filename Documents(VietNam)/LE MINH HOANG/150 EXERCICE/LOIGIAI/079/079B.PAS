program AssignmentProblemSolver;
const
 InputFile  = 'ASSIGN.INP';
 OutputFile = 'ASSIGN.OUT';
 max = 200;
 maxLong = 1000000001;
type
 TList = record
  n: Integer;
  a: array[1..max] of Integer;
 end;
 TLine = array[1..max] of LongInt;
var
 c: array[1..max] of ^TLine;
 Trace, Queue, matchX, matchY: array[1..max] of Integer;
 Fx, Fy: array[1..max] of Comp;
 vx, vy, freey: TList;
 First, Last, n: Integer;

 Time: LongInt absolute 0:$46C;
 Start: LongInt;

procedure Enter;
var
 f: Text;
 x, y: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 for x := 1 to n do New(c[x]);
 for x := 1 to n do
  for y := 1 to n do c[x]^[y] := -1;
 while not SeekEof(f) do
  begin
   Readln(f, x, y, c[x]^[y]);
  end;
 Close(f);
end;

procedure GoOut;
var
 f: Text;
begin
 Assign(f, OutputFile); Rewrite(f);
 Write(f, -1);
 Close(f);
 Halt;
end;

procedure Init;
var
 i, j: Integer;
begin
 FillChar(matchX, SizeOf(matchX), 0);
 FillChar(matchY, SizeOf(matchY), 0);
 for i := 1 to n do
  begin
   Fx[i] := maxLong;
   for j := 1 to n do
    if (c[i]^[j] <> -1) and (Fx[i] > c[i]^[j]) then Fx[i] := c[i]^[j];
  end;
 for j := 1 to n do
  begin
   Fy[j] := maxLong;
   for i := 1 to n do
    if (c[i]^[j] <> -1) and (Fy[j] > c[i]^[j] - Fx[i]) then
       Fy[j] := c[i]^[j] - Fx[i];
  end;
end;

procedure PushToList(var L: TList; v: Integer);
begin
 with L do
  begin
   Inc(n);
   a[n] := v;
  end;
end;

procedure RemoveFromList(var L: TList; Index: Integer);
begin
 with L do
  begin
   a[Index] := a[n];
   Dec(n);
  end;
end;

function FindAugmentingPath(XStart: Integer): Integer;
var
 ix, iy, x, y, nextx: Integer;
begin
 FillChar(Trace, SizeOf(Trace), 0);
 Queue[1] := xStart; First := 1; Last := 1;
 vx.n := 1; vx.a[1] := XStart;
 vy.n := 0; freey.n := 0;
 for y := 1 to n do PushToList(freey, y);
 repeat
  x := Queue[First]; Inc(First);
  for iy := freey.n downto 1 do
   begin
    y := freey.a[iy];
    if (c[x]^[y] <> -1) and (c[x]^[y] = Fx[x] + Fy[y]) and
       (matchX[x] <> y) then
     begin
      Trace[y] := x;
      if matchY[y] = 0 then
       begin
        FindAugmentingPath := y;
        Exit;
       end;
      PushToList(vy, y); RemoveFromList(freey, iy);
      nextx := matchY[y];
      PushToList(vx, nextx);
      Inc(Last); Queue[Last] := nextx;
     end;
   end;
 until First > Last;
 FindAugmentingPath := 0;
end;

procedure SubXAddY;
var
 i, j, x, y: Integer;
 Delta: LongInt;
begin
 Delta := maxLong;
 for i := 1 to vx.n do
   for j := 1 to freey.n do
    begin
     x := vx.a[i]; y := freey.a[j];
     if (c[x]^[y] <> -1) and (Delta > c[x]^[y] - Fx[x] - Fy[y]) then
           Delta := Round(c[x]^[y] - Fx[x] - Fy[y]);
    end;
 if Delta = maxLong then GoOut;
 for i := 1 to vx.n do
  Fx[vx.a[i]] := Fx[vx.a[i]] + Delta;
 for i := 1 to vy.n do
  Fy[vy.a[i]] := Fy[vy.a[i]] - Delta;
end;

procedure Enlarge(f: Integer);
var
 x, next: Integer;
begin
 repeat
  x := Trace[f];
  next := matchX[x];
  matchX[x] := f;
  matchY[f] := x;
  f := next;
 until f = 0;
end;

procedure Solve;
var
 i, k: Integer;
begin
 for i := 1 to n do
  begin
   repeat
    k := FindAugmentingPath(i);
    if k = 0 then SubXAddY;
   until k <> 0;
   Enlarge(k);
  end;
end;

procedure Result;
var
 f: Text;
 i: Integer;
 S: Extended;
begin
 S := 0;
 for i := 1 to n do S := S + Fx[i] + Fy[i];
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, S:0:0);
 for i := 1 to n do Writeln(f, matchX[i]);
 Close(f);
end;

begin
 Start := Time;
 Enter;
 Init;
 Solve;
 Result;
 Writeln('Time = ', (Time - Start)/18.2:1:4, ' (s)');
end.
4
1 1 1
1 2 2
2 1 2
2 2 5
3 2 1
2 3 1
3 3 10
4 3 10
4 4 7

6
1 1 10
1 2 10
1 3 10
1 4 10
2 1 10
2 2 10
2 3 10
2 4 10
3 1 10
3 2 10
3 3 10
3 4 10
4 1 10
4 2 10
4 3 10
4 4 10
5 1 0
5 5 10
6 5 0
6 6 10
