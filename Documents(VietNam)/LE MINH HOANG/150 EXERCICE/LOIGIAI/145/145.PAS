program IOI2003;
const
  maxN = 101;
  maxK = 1001;
  maxC = 1000000000;
  InputFile  = 'IOI.IN0';
  OutputFile = 'IOI.OUT';
type
  TMatchArr = array[1..maxN + 1] of Integer;
var
  Expect: array[1..maxN + 1, 1..maxK] of Integer;
  r: array[1..maxN * maxN + maxN] of Integer;
  c: array[1..maxN + 1, 1..maxN + 1] of LongInt;
  Fx, Fy: array[1..maxN + 1] of LongInt;
  MatchX, MatchY: TMatchArr;
  DayMark: array[1..maxN + 1, 1..maxN + 1] of LongInt;
  n, k, start, finish, first, last: Integer;
  dis: array[1..maxN + 1] of LongInt;
  arg: array[1..maxN + 1] of Integer;
  Queue: array[1..maxN + 1] of Integer;
  Trace: array[1..maxN + 1] of Integer;
  Lab: array[1..maxN * maxN + maxN] of Integer;
  res: LongInt;

procedure Enter;
var
  i, x, y, c: Integer;
  f: Text;
begin
  FillChar(Expect, SizeOf(Expect), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, k);
  for i := 1 to n * n + n do Read(f, r[i]);
  Readln(f);
  while not SeekEof(f) do
    Readln(f, x, y, Expect[x, y]);
  Close(f);
end;

procedure InitF;
var
  i: Integer;
begin
  for i := 1 to n + 1 do
    begin
      Fx[i] := MaxC;
      Fy[i] := 0;
    end;
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
end;

procedure CopyDayExpect(day: Integer);
var
  i, j, d, e: Integer;
begin
  d := n * (day - 1);
  for i := 1 to n + 1 do
    for j := 1 to n do
      begin
        e := r[d + j];
        c[i, j] := Expect[i, e];
      end;
end;

procedure InitBFS;
var
  y: Integer;
begin
  first := 1; last := 1;
  Queue[1] := Start;
  FillChar(Trace, SizeOf(Trace), 0);
  for y := 1 to n do
    begin
      dis[y] := fx[start] + fy[y] - c[start, y];
      arg[y] := start;
    end;
end;

procedure Push(x: Integer);
begin
  Inc(last);
  Queue[last] := x;
end;

function Pop: Integer;
begin
  Pop := Queue[first];
  Inc(first);
end;

procedure FindAugmentingPath;
var
  x, y: Integer;
  w: LongInt;
begin
  repeat
    x := Pop;
    for y := 1 to n do
      if Trace[y] = 0 then
        begin
          w := fx[x] + fy[y] - c[x, y];
          if w = 0 then
            begin
              Trace[y] := x;
              if matchY[y] = 0 then
                begin
                  finish := y;
                  Exit;
                end;
              Push(matchY[y]);
            end;
          if dis[y] > w then
            begin
              dis[y] := w;
              arg[y] := x;
            end;
        end;
  until first > last;
end;

procedure SubX_AddY;
var
  Delta: LongInt;
  x, y: Integer;
begin
  Delta := MaxC;
  for y := 1 to n do
    if (Trace[y] = 0) and (dis[y] < Delta) then Delta := dis[y];
  Fx[start] := Fx[start] - Delta;
  for y := 1 to n do
    if Trace[y] <> 0 then
      begin
        x := matchY[y];
        Fx[x] := Fx[x] - Delta;
        Fy[y] := Fy[y] + Delta;
      end
    else dis[y] := dis[y] - Delta;
 for y := 1 to n do
   if (Trace[y] = 0) and (dis[y] = 0) then
     begin
       Trace[y] := arg[y];
       if matchY[y] = 0 then
         begin
           finish := y;
           Exit;
         end;
       Push(matchY[y]);
     end;
end;

procedure Enlarge;
var
  x, next: Integer;
begin
  repeat
    x := Trace[finish];
    next := matchX[x];
    matchX[x] := finish;
    matchY[finish] := x;
    finish := Next;
  until finish = 0;
end;

function GetMaximalMatching(disable: Integer): LongInt;
var
  x: Integer;
  w: LongInt;
begin
  for x := 1 to n + 1 do
    if (x <> disable) and (matchX[x] = 0) then
      begin
        start := x; finish := 0;
        InitBFS;
        repeat
          FindAugmentingPath;
          if finish = 0 then SubX_AddY;
        until finish <> 0;
        Enlarge;
      end;
  w := 0;
  for x := 1 to n + 1 do
    if (x <> disable) then w := w + c[x, matchX[x]];
  GetMaximalMatching := w;
end;

procedure CalculateDayMark;
var
  day, disable, yfree: Integer;
begin
  for day := 1 to n + 1 do
    begin
      CopyDayExpect(day);
      initF;
      for disable := 1 to n + 1 do
        begin
          Fx[Disable] := maxC;
          yfree := matchX[disable];
          matchX[disable] := 0;
          if yfree <> 0 then matchY[yfree] := 0;
          DayMark[disable, day] := GetMaximalMatching(disable);
        end;
    end;
end;

procedure GetOptimizedSolution;
var
  x, y, yd: Integer;
  DisableArr: TMatchArr;
begin
  Inc(n);
  InitF;
  for x := 1 to n do
    for y := 1 to n do
      c[x, y] := DayMark[x, y];
  for x := 1 to n do
    begin
      start := x; finish := 0;
      InitBFS;
      repeat
        FindAugmentingPath;
        if finish = 0 then SubX_AddY;
      until finish <> 0;
      Enlarge;
    end;

  res := 0;
  for x := 1 to n do
    res := res + c[x, matchX[x]];
  DisableArr := MatchY;
  Dec(n);

  for y := 1 to n + 1 do
    begin
      CopyDayExpect(y);
      x := DisableArr[y];
      InitF;
      GetMaximalMatching(x);
      for yd := 1 to n do Lab[yd + (y - 1) * n] := MatchY[yd];
    end;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, res);
  for i := 1 to n * n + n do Writeln(f, Lab[i]);
  Close(f);
end;

begin
  Enter;
  initf;
  CalculateDayMark;
  GetOptimizedSolution;
  Result;
end.
3 4
1 2 3 4 3 3 1 4 2 3 2 2
1 1 2
1 2 3
1 4 6
2 3 4
2 1 3
2 4 7
3 2 1
3 1 4
4 1 2
4 3 9
4 2 8
