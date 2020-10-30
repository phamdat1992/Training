program MatchingProblem;
const
  InputFile  = 'MATCH.INP';
  OutputFile = 'MATCH.OUT';
  max = 300;
type
  TLine = array[1..max] of Boolean;
var
  m, n: Integer;
  a: array[1..max] of ^TLine;
  matchX, matchY: array[1..max] of Integer;
  Trace: array[1..max] of Integer;
  res: Integer;

procedure Enter;
var
  i, j: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, m, n);
  for i := 1 to m do
    begin
      New(a[i]);
      FillChar(a[i]^, SizeOf(a[i]^), 0);
    end;
  while not SeekEof(f) do
    begin
      ReadLn(f, i, j);
      a[i]^[j] := True;
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
  {Greedy}
  for i := 1 to m do
    for j := 1 to n do
      if a[i]^[j] and (matchY[j] = 0) then
        begin
          matchX[i] := j;
          matchY[j] := i;
          Inc(res);
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
    if matchX[i] = 0 then
      begin
        Inc(last);
        Queue[last] := i;
      end;
  first := 1;
  while first <= last do
    begin
      i := Queue[first]; Inc(first);
      for j := 1 to n do
        if (Trace[j] = 0) and a[i]^[j] and (matchX[i] <> j) then
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
  i: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  WriteLn(f, res);
  for i := 1 to m do
    if matchX[i] <> 0 then
      WriteLn(f, i, ' ', matchX[i]);
  Close(f);
end;

begin
  Enter;
  Init;
  Solve;
  PrintResult;
end.
4 5
1 1
1 4
2 1
2 2
2 4
3 2
3 3
4 2
4 3