program MatchingProblem;
const
  InputFile  = 'GRID.INP';
  OutputFile = 'GRID.OUT';
  max = 200;
var
  res, m, n: Integer;
  a: array[1..max, 1..max] of Char;
  matchX, matchY: array[1..max] of Integer;
  FreeX, FreeY: array[1..max] of Boolean;
  Trace: array[1..max] of Integer;

procedure Enter;
var
  i, j: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(a, SizeOf(a), False);
  FillChar(FreeX, SizeOf(FreeX), True);
  FilLChar(FreeY, SizeOf(FreeY), True);
  ReadLn(f, m, n);
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, a[i, j]);
          if a[i, j] = '*' then
            begin
              FreeX[i] := False;
              FreeY[j] := False;
            end;
        end;
      Readln(f);
    end;
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  res := 0;
  for i := 1 to m do
    if FreeX[i] then
      for j := 1 to n do
        if FreeY[j] and (matchY[j] = 0) then
          begin
            Inc(res);
            matchX[i] := j;
            matchY[j] := i;
            Break;
          end;
end;

function FindAugmentingPath: Integer;
var
  Queue: array[1..max] of Integer;
  i, j, first, last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  last := 0;
  for i := 1 to m do
    if FreeX[i] and (matchX[i] = 0) then
      begin
        Inc(last);
        Queue[last] := i;
      end;
  first := 1;
  while first <= last do
    begin
      i := Queue[first]; Inc(first);
      for j := 1 to n do
        if FreeY[j] and (Trace[j] = 0) and (a[i, j] = '+') then
          begin
            Trace[j] := i;
            if matchY[j] = 0 then
              begin
                FindAugmentingPath := j;
                Exit;
              end;
            Inc(last);
            Queue[last] := matchY[j];
          end;
    end;
  FindAugmentingPath := 0;
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
  finish: Integer;
begin
  repeat
    finish := FindAugmentingPath;
    if finish <> 0 then
      begin
        Inc(res);
        Enlarge(finish);
      end;
  until finish = 0;
end;

procedure PrintResult;
var
  i, j, Count: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  WriteLn(f, res);
  Count := 0;
  for i := 1 to m do
    if matchX[i] <> 0 then a[i, matchX[i]] := '*';
  for i := 1 to m do
    begin
      for j := 1 to n do Write(f, a[i, j]);
      Writeln(f);
    end;
  Close(f);
end;

begin
  Enter;
  Init;
  Solve;
  PrintResult;
end.
4 5
+..*.
++.+.
.++..
.++..
