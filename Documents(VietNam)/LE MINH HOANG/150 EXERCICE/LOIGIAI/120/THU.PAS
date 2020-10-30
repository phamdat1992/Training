program MatchingProblem;
const
  max = 600;
type
  TLine = array[1..max] of Boolean;
var
  m, n: Integer;
  a: array[1..max] of ^TLine;
  matchX, matchY: array[1..max] of Integer;
  Trace: array[1..max] of Integer;

  Time: LongInt absolute 0:$46C;
  Start: LongInt;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  for i := 1 to 500 do
    begin
      New(a[i]);
      FillChar(a[i]^, SizeOf(a[i]^), 0);
    end;
  Assign(f, 'TAX.IN0'); Reset(f);
  Readln(f, m, n);
  while not SeekEof(f) do
    begin
      Readln(f, i, j);
      a[i]^[j] := True;
    end;
end;

procedure Init;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
end;


function FindAugmentingPath(xStart: Integer): Integer;
var
  Queue: array[1..max] of Integer;
  x, y, first, last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Queue[1] := xStart;
  first := 1; last := 1; 
  repeat
    x := Queue[first]; Inc(first); 
    for y := 1 to n do
      if (Trace[y] = 0) and a[x]^[y] and (matchX[x] <> y) then
        begin
          Trace[y] := x;
          if matchY[y] = 0 then 
            begin
              FindAugmentingPath := y; 
              Exit;
            end;
          Inc(last);
          Queue[last] := matchY[y]; 
        end;
  until first > last; 
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
  x, y: Integer;
begin
  for x := 1 to m do
    begin
      y := FindAugmentingPath(x);
      if y <> 0 then Enlarge(y);
    end;
end;

procedure PrintResult;
var
  i, Count: Integer;
begin
  Writeln('Match: ');
  Count := 0;
  for i := 1 to m do
    if matchX[i] <> 0 then
      begin
        Inc(Count);
        Writeln(Count, ') X[', i, '] - Y[', matchX[i], ']');
      end;
end;

begin
  Enter;
  Start := Time;
  Init;
  Solve;
  Writeln(Time - Start);
end.
