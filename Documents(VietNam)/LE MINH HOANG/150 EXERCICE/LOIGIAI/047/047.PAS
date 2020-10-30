program AnimalMoving;
const
  InputFile  = 'MOVE.INP';
  OutputFile = 'MOVE.OUT';
  max = 200;
  maxT = 20000;
var
  a: array[1..max, 1..max] of Boolean;
  t: array[1..max] of Integer;
  Queue, Trace: array[1..max] of Integer;
  n, Start, Finish, First, Last: Integer;
  Res: Integer;

procedure Enter;
var
  f: Text;
  i, u, v: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, Start, Finish);
  for i := 1 to n do Read(f, t[i]);
  Readln(f);
  while not SeekEof(f) do
    begin
      Readln(f, u, v);
      a[u, v] := True; a[v, u] := True;
    end;
  Close(f);
end;

procedure InitBFS;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[Finish] := n + 1; {<> 0}
  Queue[1] := Finish;
  First := 1; Last := 1;
end;

procedure Push(V: Integer);
begin
  Inc(Last); Queue[Last] := V;
end;

function Pop: Integer;
begin
  Pop := Queue[First]; Inc(First);
end;

function GetPath(Threshold: Integer): Boolean;
var
  u, v: Integer;
begin
  InitBFS;
  repeat
    u := Pop;
    for v := 1 to n do
      if a[u, v] and (Trace[v] = 0) and (Abs(t[u] - t[v]) <= Threshold) then
        begin
          Trace[v] := u;
          if v = Start then
            begin
              GetPath := True;
              Exit;
            end;
          Push(v);
        end;
  until First > Last;
  GetPath := False;
end;

procedure Solve;
var
  inf, sup, median: Integer;
begin
  inf := -1; sup := maxT + 1;
  while inf + 1 < sup do
    begin
      median := (LongInt(inf) + sup) div 2;
      if GetPath(median) then sup := median
      else inf := median;
    end;
  if GetPath(sup) then Res := Sup
  else Res := -1;
end;

procedure Result;
var
  f: Text;
  v: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Res);
  if Res <> -1 then
    begin
      v := Start;
      repeat
        Write(f, v, ' ');
        v := Trace[v];
      until v = Finish;
      Write(f, Finish);
    end;
  Close(f);
end;

begin
  Enter;
  Solve;
  Result;
end.
7 1 4
20 22 29 30 24 27 26
1 2
1 3
1 4
2 4
2 5
3 4
3 6
4 5
4 6
5 7
6 7
