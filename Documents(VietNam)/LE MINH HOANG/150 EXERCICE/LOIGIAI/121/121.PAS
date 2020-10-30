program AssignProblemSolver;
const
  InputFile  = 'ASSIGN.INP';
  OutputFile = 'ASSIGN.OUT';
  maxM = 200;
  maxN = 1000;
type
  TLine = array[1..maxN] of Boolean;
  PLine = ^TLine;
var
  a: array[1..maxM] of PLine;
  matchX: array[1..maxN] of Integer;
  matchY: array[1..maxN] of Integer;
  head: array[0..maxM + 1] of Integer;
  Trace: array[1..maxM] of Integer;
  m, n: Integer;
  minWork, maxWork: Integer;
  Solution: Boolean;
  Start: LongInt;
  Time: LongInt absolute 0:$46C;

procedure Enter;
var
  f: Text;
  x, y: Integer;
  mark: array[1..maxN] of Boolean;
  c: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  FillChar(mark, SizeOf(mark), True);
  c := 0;
  for x := 1 to m do
    begin
      New(a[x]);
      FillChar(a[x]^, SizeOf(a[x]^), False);
      repeat
        Read(f, y);
        if y = 0 then Break;
        a[x]^[y] := True;
        if mark[y] then
          begin
            mark[y] := False;
            Inc(c);
          end;
      until False;
      Readln(f);
    end;
  Close(f);
  Solution := c = n;
end;

procedure Init;
begin
  minWork := 0;
  maxWork := 0;
  FillChar(matchX, SizeOf(matchX), 0);
end;

procedure CreateAdjmatchY;
var
  i, j: Integer;
begin
  {Distribution counting}
  FillChar(head, SizeOf(head), 0);
  for j := 1 to n do
    begin
      i := matchX[j];
      if i <> 0 then Inc(head[i]);
    end;
  for i := 2 to m do head[i] := head[i - 1] + head[i];
  head[m + 1] := head[m];
  {Add to adj list}
  for j := 1 to n do
    begin
      i := matchX[j];
      if i <> 0 then
        begin
          matchY[head[i]] := j;
          Dec(head[i]);
        end;
    end;
  {match(X[i]) thuoc vao doan tu matchY[head[i] + 1] den matchY[head[i + 1]]}
end;

function FindAugmentingPath(threshold: Integer): Integer;
var
  Q: array[1..maxN] of Integer;
  free: array[0..maxN] of Boolean;
  i, j, id: Integer;
  first, last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  FillChar(free, SizeOf(free), True);
  CreateAdjmatchY;
  last := 0;
  for j := 1 to n do
    if matchX[j] = 0 then
      begin
        Inc(last);
        Q[last] := j;
        free[j] := False;
      end;
  first := 1;
  while first <= last do
    begin
      j := Q[first]; Inc(first);
      for i := 1 to m do
        begin
          if (Trace[i] = 0) and (a[i]^[j]) and (matchX[j] <> i) then
            begin
              Trace[i] := j;
              if head[i + 1] - head[i] < threshold then
                begin
                  FindAugmentingPath := i;
                  Exit;
                end;
              for id := head[i] + 1 to head[i + 1] do
                if free[matchY[id]] then
                  begin
                    Inc(last);
                    Q[last] := matchY[id];
                    free[matchY[id]] := False;
                  end;
            end;
        end;
    end;
  FindAugmentingPath := 0;
end;

procedure Enlarge(finish: Integer);
var
  j, next: Integer;
begin
  repeat
    j := Trace[finish];
    next := matchX[j];
    matchX[j] := finish;
    finish := next;
  until finish = 0;
end;

procedure Solve;
var
  finish, c, w: Integer;
begin
  w := 0;
  c := 0;
  repeat
    Inc(w);
    repeat
      finish := FindAugmentingPath(w);
      if finish <> 0 then
        begin
          Inc(c);
          Enlarge(finish);
        end
      else Break;
    until False;
  until c = n;
end;

procedure Result;
var
  f: Text;
  i, id: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  if not Solution then Writeln(f, 'NO')
  else
    begin
      Writeln(f, 'YES');
      minWork := maxInt; maxWork := 0;
      CreateAdjmatchY;
      for i := 1 to m do
        begin
          if head[i + 1] - head[i] > maxWork then
            maxWork := head[i + 1] - head[i];
          if head[i + 1] - head[i] < minWork then
            minWork := head[i + 1] - head[i];
        end;
      Writeln(f, maxWork);
      for i := 1 to m do
        begin
          for id := head[i] + 1 to head[i + 1] do
            Write(f, matchY[id], ' ');
          Writeln(f, 0);
        end;
    end;
  Close(f);
end;

begin
  Start := Time;
  Enter;
  if Solution then
    begin
      Init;
      Solve;
    end;
  Result;
  Write((Time - Start) / 18.2:1:4, ' (s)');
end.

