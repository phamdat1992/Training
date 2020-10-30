program TheTours;
const
  InputFile  = 'TOURS.INP';
  OutputFile = 'TOURS.OUT';
  max = 200;
type
  TBoard = array[1..max, 1..max] of Byte;
var
  c: TBoard;
  flow:^TBoard;
  Queue, Trace, Go, Back: array[1..max] of Integer;
  n, nGo, nBack, Start, Finish, first, last, MaxFlow: Integer;

procedure Enter;
var
  f: Text;
  m, i, u, v: Integer;
begin
  FillChar(c, SizeOf(c), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m, Start, Finish);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      c[u, v] := 1;
      c[v, u] := 1;
    end;
  Close(f);
  for i := 1 to n do
    begin
      c[i, Start] := 0;
      c[Finish, i] := 0;
    end;
  New(Flow);
  FillChar(Flow^, SizeOf(Flow^), 0);
end;

function FindPath(S, F: Integer): Boolean;
var
  u, v: Integer;
begin
  Queue[1] := S; first := 1; last := 1;
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[S] := n + 1;
  repeat
    u := Queue[first]; Inc(first);
    for v := 1 to n do
      if Trace[v] = 0 then
        begin
          if c[u, v] > flow^[u, v] then Trace[v] := u
          else
            if flow^[v, u] > 0 then Trace[v] := -u;
          if Trace[v] <> 0 then
            begin
              Inc(last); Queue[last] := v;
              if v = F then
                begin
                  FindPath := True;
                  Exit;
                end;
            end;
        end;
  until first > last;
  FindPath := False;
end;

procedure IncFlow;
var
  t, prev: Integer;
begin
  Inc(MaxFlow);
  t := Finish;
  repeat
    prev := Trace[t]; {prev -> t}
    if prev > 0 then Inc(flow^[prev, t])
    else Dec(flow^[t, -prev]);
    t := Abs(prev);
  until t = Start;
end;

procedure Refine;
var
  u, v: Integer;
begin
  for u := 1 to n do
    for v := 1 to n do
      if (flow^[u, v] <> 0) and (flow^[v, u] <> 0) then
        begin
          flow^[u, v] := 0;
          flow^[v, u] := 0;
        end;
  FillChar(c, SizeOf(c), 0);
  for u := 1 to n do
    for v := 1 to n do
      if flow^[u, v] = 1 then c[u, v] := 1;
  FillChar(flow^, SizeOf(flow^), 0);
end;

procedure FindMaxFlow;
begin
  while FindPath(Start, Finish) do IncFlow;
end;

procedure FindTour;
var
  t, next, prev: Integer;
begin
  nGo := 0; nBack := 0;
  FindPath(Start, Finish);
  t := Finish;
  repeat
    Inc(nGo);
    Go[nGo] := t;
    next := Trace[t];
    if next <> n + 1 then c[next, t] := 0;
    t := next;
  until t = n + 1;
  FindPath(Start, Finish);
  t := Finish;
  repeat
    Inc(nBack);
    Back[nBack] := t;
    prev := Trace[t];
    if prev <> n + 1 then c[prev, t] := 0;
    t := prev;
  until t = n + 1;
end;

procedure Result;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, maxflow div 2);
  for i := 1 to maxflow div 2 do
    begin
      FindTour;
      for j := nGo downto 2 do Write(f, Go[j], ' ');
      for j := 1 to nBack do Write(f, Back[j], ' ');
      Writeln(f);
    end;
  Close(f);
end;

begin
  Enter;
  FindMaxFlow;
  Refine;
  Result;
end.
10 14 1 4
1 2
1 6
2 3
2 5
3 4
3 6
4 5
1 7
7 2
3 8
8 4
1 9
9 10
10 4
