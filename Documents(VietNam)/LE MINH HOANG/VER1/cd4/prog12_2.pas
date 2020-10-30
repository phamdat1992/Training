program AssignmentProblemSolve;
const
  max = 100;
  maxC = 10001;
var
  c: array[1..max, 1..max] of Integer;
  Fx, Fy, matchX, matchY: array[1..max] of Integer;
  Trace, Queue, d, arg: array[1..max] of Integer;
  first, last: Integer;
  start, finish: Integer;
  m, n, k: Integer;

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

procedure InitBFS;
var
  y: Integer;
begin
  first := 1; last := 1;
  Queue[1] := start;
  FillChar(Trace, SizeOf(Trace), 0);
  for y := 1 to k do
    begin
      d[y] := GetC(start, y);
      arg[y] := start;
    end;
  finish := 0;
end;

procedure Push(v: Integer);
begin
  Inc(last);
  Queue[last] := v;
end;

function Pop: Integer;
begin
  Pop := Queue[first];
  Inc(first);
end;

procedure FindAugmentingPath;
var
  i, j, w: Integer;
begin
  repeat
    i := Pop;
    for j := 1 to k do
      if Trace[j] = 0 then
        begin
          w := GetC(i, j);
          if w = 0 then
            begin
              Trace[j] := i;
              if matchY[j] = 0 then
                begin
                  finish := j;
                  Exit;
                end;
              Push(matchY[j]);
            end;
          if d[j] > w then
            begin
              d[j] := w;
              arg[j] := i;
            end;
        end;
  until first > last;
end;

procedure SubX_AddY;
var
  Delta: Integer;
  x, y: Integer;
begin
  Delta := maxC;
  for y := 1 to k do
    if (Trace[y] = 0) and (d[y] < Delta) then Delta := d[y];
  Fx[start] := Fx[start] + Delta;
  for y := 1 to k do
    if Trace[y] <> 0 then
      begin
        x := matchY[y];
        Fy[y] := Fy[y] - Delta;
        Fx[x] := Fx[x] + Delta;
      end
    else
      d[y] := d[y] - Delta;

  for y := 1 to k do
    if (Trace[y] = 0) and (d[y] = 0) then
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

procedure Solve;
var
  x, y: Integer;
begin
  for x := 1 to k do
    begin
      start := x;
      InitBFS;
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
5 6
1 1 0
1 2 0
2 1 0
2 4 2
3 2 1
3 3 0
4 3 0
4 4 9
5 4 9