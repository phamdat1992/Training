program AssignmentProblemSolver;
const
  InputFile  = 'ASSIGN.INP';
  OutputFile = 'ASSIGN.OUT';
  max = 400;
  maxE = 10001;
  maxC = max * maxE + 1;
type
  TLine = array[1..max] of Integer;
  PLine = ^TLine;
  TBoard = array[0..max + 1] of PLine;
var
  cost: TBoard;
  mincost, superman: TLine;
  typ: array[1..max] of Integer;
  matchX, matchY: array[1..max] of Integer;
  d: array[1..max] of LongInt;
  arg: array[1..max] of Integer;
  Queue: array[1..max] of Integer;
  Trace: array[1..max] of Integer;
  Fx, Fy: array[1..max] of LongInt;
  nAdd, m, n, r, k, first, last, start, finish: Integer;
  res: LongInt;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  for i := 0 to max + 1 do
    begin
      New(cost[i]);
      FillChar(cost[i]^, SizeOf(cost[i]^), $FF); {-1}
    end;
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, r);
  FillChar(typ, SizeOf(typ), 0);
  for i := 1 to m do Read(f, typ[i]);
  Readln(f);
  while not SeekEof(f) do
    Read(f, i, j, cost[i]^[j]);
  Close(f);
  for j := 1 to n do
    begin
      minCost[j] := maxE;
      for i := 1 to r do
        if (cost[i]^[j] <> -1) and (cost[i]^[j] < minCost[j]) then
          begin
            minCost[j] := cost[i]^[j];
            superman[j] := i;
          end;
    end;
  Cost[0]^ := minCost;
end;

function c(i, j: Integer): LongInt;
var
  t: LongInt;
begin
  if cost[typ[i]]^[j] = -1 then c := maxC
  else c := cost[typ[i]]^[j];
end;

procedure Init;
var
  i, j: Integer;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  if m > n then k := m else k := n;
  for i := m + 1 to k do typ[i] := max + 1;
  for i := 1 to k do
    begin
      Fx[i] := maxC;
      for j := 1 to k do
        if Fx[i] > c(i, j) then Fx[i] := c(i, j);
    end;
  for j := 1 to k do
    begin
      Fy[j] := maxC;
      for i := 1 to k do
        if Fy[j] > c(i, j) - Fx[i] then
          Fy[j] := c(i, j) - Fx[i];
    end;
end;

procedure InitBFS;
var
  y: Integer;
begin
  first := 1; last := 1;
  Queue[1] := start;
  FillChar(Trace, SizeOf(Trace), 0);
  for y := 1 to k do
    begin
      d[y] := maxC;
      arg[y] := start;
    end;
  finish := 0;
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
  tmp: LongInt;
begin
  repeat
    x := Pop;
    for y := 1 to k do
      if Trace[y] = 0 then
        begin
          tmp := c(x, y) - Fx[x] - Fy[y];
          if tmp = 0 then
            begin
              Trace[y] := x;
              if matchY[y] = 0 then
                begin
                  finish := y;
                  Exit;
                end;
              Push(matchY[y]);
            end;
          if d[y] > tmp then
            begin
              d[y] := tmp;
              arg[y] := x;
            end;
        end;
  until first > last;
end;

procedure SubX_AddY;
var
  Delta: LongInt;
  y, x: Integer;
begin
  Delta := maxC;
  for y := 1 to k do
    if (Trace[y] = 0) and (d[y] < Delta) then Delta := d[y];
  for y := 1 to k do
    if Trace[y] <> 0 then
      begin
        x := matchY[y];
        Fy[y] := Fy[y] - Delta;
        Fx[x] := Fx[x] + Delta;
      end;
  Fx[start] := Fx[start] + Delta;
  for y := 1 to k do
    if Trace[y] = 0 then
      begin
        d[y] := d[y] - Delta;
        if d[y] = 0 then
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
    finish := next;
  until finish = 0;
end;

procedure Solve;
var
  i, j: Integer;
  front, rear: Integer;
begin
  Init;
  for i := 1 to k do
    begin
      start := i;
      InitBFS;
      repeat
        FindAugmentingPath;
        if finish = 0 then SubX_AddY;
      until finish <> 0;
      Enlarge;
    end;
  for j := 1 to k do
    begin
      i := matchY[j];
      if c(i, j) = maxC then {X[i] to be superman}
        typ[i] := 0;
    end;
  front := 0;
  for rear := 1 to k do
    if typ[rear] <> 0 then
      begin
        Inc(front);
        typ[front] := typ[rear];
      end;
  for rear := front + 1 to n do typ[rear] := 0;
  m := n;
  Init;
  for i := 1 to n do
    begin
      start := i;
      InitBFS;
      repeat
        FindAugmentingPath;
        if finish = 0 then SubX_AddY;
      until finish <> 0;
      Enlarge;
    end;
  nAdd := 0; res := 0;
  for j := 1 to n do
    begin
      i := matchY[j];
      if typ[i] = 0 then
        begin
          typ[i] := superman[j];
          Inc(nAdd);
        end;
      res := res + c(i, j);
    end;
end;

procedure Result;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, nAdd, ' ', res);
  for j := 1 to n do
    begin
      i := matchY[j];
      Writeln(f, typ[i]);
    end;
  Close(f);
end;

begin
  Enter;
  Solve;
  Result;
end.

1 2 3
1
1 1 10
1 2 30
3 1 1
3 2 25
2 2 40

10 4 6
1 3 5 5 5 5 5 5 5 5
1 1 10
1 2 10
1 3 10
3 1 10
3 2 10
3 3 10
2 2 9
2 1 8
4 2 6
4 3 5
6 4 0

5 6 6
1 2 3 4 5
1 1 10000
2 1 0
2 2 10000
3 2 0
3 3 10000
4 3 0
4 4 10000
5 4 0
5 5 10000
6 5 0
6 6 10000