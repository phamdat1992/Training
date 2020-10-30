program AssignmentProblemSolve;
const
  max = 100;
  maxC = 10001;
var
  c: array[1..max, 1..max] of Integer;
  Fx, Fy, matchX, matchY, Trace: array[1..max] of Integer;
  m, n, k, start, finish: Integer;

procedure Enter;
var
  i, j: Integer;
begin
  Readln(m, n);
  if m > n then k := m else k := n; 
  for i := 1 to k do
    for j := 1 to k do c[i, j] := maxC;
  while not SeekEof do Readln(i, j, c[i, j]);
end;

procedure Init;
var
  i, j: Integer;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  for i := 1 to k do
    begin
      Fx[i] := maxC;
      for j := 1 to k do
        if c[i, j] < Fx[i] then Fx[i] := c[i, j];
    end;
  for j := 1 to k do
    begin
      Fy[j] := maxC;
      for i := 1 to k do
        if c[i, j] - Fx[i] < Fy[j] then Fy[j] := c[i, j] - Fx[i];
    end;
end;

function GetC(i, j: Integer): Integer;
begin
  GetC := c[i, j] - Fx[i] - Fy[j];
end;

procedure FindAugmentingPath;
var
  Queue: array[1..max] of Integer;
  i, j, first, last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Queue[1] := start;
  first := 1; last := 1;
  repeat
    i := Queue[first]; Inc(first);
    for j := 1 to k do
      if (Trace[j] = 0) and (GetC(i, j) = 0) then
        begin
          Trace[j] := i;
          if matchY[j] = 0 then
            begin
              finish := j;
              Exit;
            end;
          Inc(last); Queue[last] := matchY[j];
        end;
  until first > last;
end;

procedure SubX_AddY;
var
  i, j, t, Delta: Integer;
  VisitedX, VisitedY: set of Byte;
begin
  VisitedX := [start];
  VisitedY := [];
  for j := 1 to k do
    if Trace[j] <> 0 then
      begin
        Include(VisitedX, matchY[j]);
        Include(VisitedY, j);
      end;
  Delta := maxC;
  for i := 1 to k do
    if i in VisitedX then
      for j := 1 to k do
        if not (j in VisitedY) and (GetC(i, j) < Delta) then
          Delta := GetC(i, j);
  for t := 1 to k do
    begin
      if t in VisitedX then Fx[t] := Fx[t] + Delta;
      if t in VisitedY then Fy[t] := Fy[t] - Delta;
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

procedure Solve;
var
  x, y: Integer;
begin
  for x := 1 to k do
    begin
      start := x; finish := 0;
      repeat
        FindAugmentingPath;
        if finish = 0 then SubX_AddY;
      until finish <> 0;
      Enlarge;
    end;
end;

procedure Result;
var
  x, y, Count, W: Integer;
begin
  Writeln('Optimal assignment:');
  W := 0; Count := 0;
  for x := 1 to m do
    begin
      y := matchX[x];

      if c[x, y] < maxC then
        begin
          Inc(Count);
          Writeln(Count:5, ') X[', x, '] - Y[', y, ']  ', c[x, y]);
          W := W + c[x, y];
        end;
    end;
  Writeln('Cost: ', W);
end;

begin
  Assign(Input, 'ASSIGN.INP'); Reset(Input);
  Assign(Output, 'ASSIGN.OUT'); Rewrite(Output);
  Enter;
  Init;
  Solve;
  Result;
  Close(Input);
  Close(Output);
end.
