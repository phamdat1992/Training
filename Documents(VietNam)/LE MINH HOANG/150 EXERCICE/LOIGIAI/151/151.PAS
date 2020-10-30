program AssignmentProblemSolve;
const
  InputFile  = 'MATCH.INP';
  OutputFile = 'MATCH.OUT';
  max = 200;
  maxC = 40001;
var
  c: array[1..max, 1..max] of Byte;
  Fx, Fy: array[1..max] of LongInt;
  matchX, matchY: array[1..max] of Integer;
  Trace, Queue: array[1..max] of Integer;
  d: array[1..max] of LongInt;
  arg: array[1..max] of Integer;
  first, last: Integer;
  start, finish: Integer;
  n: Integer;

procedure Enter;
var
  i, j: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n);
  for i := 1 to n do
    for j := 1 to n do c[i, j] := 255;
  while not SeekEof(f) do ReadLn(f, i, j, c[i, j]);
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  for i := 1 to n do
    begin
      Fx[i] := maxC;
      for j := 1 to n do
        if c[i, j] < Fx[i] then Fx[i] := c[i, j];
    end;
  for j := 1 to n do
    begin
      Fy[j] := maxC;
      for i := 1 to n do
        if c[i, j] - Fx[i] < Fy[j] then Fy[j] := c[i, j] - Fx[i];
    end;
end;

function GetC(i, j: Integer): LongInt;
begin
  if c[i, j] <> 255 then
    GetC := LongInt(c[i, j]) - Fx[i] - Fy[j]
  else
    GetC := LongInt(MaxC) - Fx[i] - Fy[j];
end;

procedure InitBFS;
var
  y: Integer;
begin
  first := 1; last := 1;
  Queue[1] := start;
  FillChar(Trace, SizeOf(Trace), 0);
  for y := 1 to n do
    begin
      d[y] := GetC(start, y);
      arg[y] := start;
    end;
  finish := 0;
end;

procedure Push(v: Integer);
begin
  Inc(last); Queue[last] := v;
end;

function Pop: Integer;
begin
  Pop := Queue[first]; Inc(first);
end;

procedure FindAugmentingPath;
var
  i, j: Integer;
  w: LongInt;
begin
  repeat
    i := Pop;
    for j := 1 to n do
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
  Delta: Word;
  x, y: Integer;
begin
  Delta := maxC;
  for y := 1 to n do
    if (Trace[y] = 0) and (d[y] < Delta) then Delta := d[y];
  Fx[start] := Fx[start] + Delta;
  for y := 1 to n do
    if Trace[y] <> 0 then
      begin
        x := matchY[y];
        Fy[y] := Fy[y] - Delta;
        Fx[x] := Fx[x] + Delta;
      end
    else
      d[y] := d[y] - Delta;
  for y := 1 to n do
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
  for x := 1 to n do
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
  x, y: Integer;
  W: Word;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  W := 0;
  for x := 1 to n do
    begin
      y := matchX[x];
      W := W + c[x, y];
    end;
  Writeln(f, W);
  for x := 1 to n do
    Writeln(f, x, ' ', matchX[x]);
  Close(f);
end;

begin
  Enter;
  Init;
  Solve;
  Result;
end.
