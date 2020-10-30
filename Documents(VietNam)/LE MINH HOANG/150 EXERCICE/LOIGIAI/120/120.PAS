program TAX;
const
  InputFile  = 'TAX.INP';
  OutputFile = 'TAX.OUT';
  max = 600;
type
  TArray = array[1..max] of Boolean;
  PArray = ^TArray;
var
  a: array[1..max] of PArray;
  matchX, matchY: array[1..max] of Integer;
  Trace: array[1..max] of Integer;
  resX, resY, m, n: Integer;

  Time: LongInt absolute 0:$46C;
  Start: LongInt;

procedure Enter;
var
  f: Text;
  u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for u := 1 to m do
    begin
      New(a[u]);
      FillChar(a[u]^, SizeOf(a[u]^), False);
    end;
  while not SeekEof(f) do
    begin
      Readln(f, u, v);
      a[u]^[v] := True;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
end;

function FindAugmentingPath: Integer;
var
  Q: array[1..max] of Integer;
  i, j, first, last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  last := 0;
  for i := 1 to m do
    if matchX[i] = 0 then
      begin
        Inc(last); Q[last] := i;
      end;
  first := 1;
  while first <= last do
    begin
      i := Q[first]; Inc(first);
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
            Q[last] := matchY[j];
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
  Finish: Integer;
begin
  repeat
    Finish := FindAugmentingPath;
    if Finish <> 0 then Enlarge(Finish);
  until Finish = 0;
end;

procedure Result;
var
  f: Text;
  i, j: Integer;
  Mark: array[1..max] of Boolean;
begin
  FillChar(Mark, SizeOf(Mark), False);
  resY := 0;
  for j := 1 to n do
    if Trace[j] <> 0 then
      begin
        Inc(resY);
        Mark[matchY[j]] := True;
      end;
  resX := m;
  for i := 1 to m do
    if (matchX[i] = 0) or Mark[i] then Dec(resX);
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, resX, ' ', resY);
  for i := 1 to m do
    if (matchX[i] <> 0) and not Mark[i] then Writeln(f, i);
  for j := 1 to n do
    if Trace[j] <> 0 then Writeln(f, j);
  Close(f);
end;

begin
  Enter;
  Start := Time;
  Init;
  Solve;
  Result;
  Writeln(Time - Start);
end.

4 4
1 1
1 2
1 3
2 3
3 3
4 4
4 5
5 4