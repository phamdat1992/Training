program Shortest_Path_by_Dijkstra;
const
  max = 100;
  maxC = 10000;
var
  c: array[1..max, 1..max] of Integer;
  d: array[1..max] of Integer;
  Trace: array[1..max] of Integer;
  Free: array[1..max] of Boolean; 
  n, S, F: Integer;

procedure LoadGraph;
var
  i, m: Integer;
  u, v: Integer;
begin
  Readln(n, m, S, F);
  for u := 1 to n do
    for v := 1 to n do
      if u = v then c[u, v] := 0 else c[u, v] := maxC;
  for i := 1 to m do Readln(u, v, c[u, v]);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to n do
    begin
      d[i] := c[S, i];
      Trace[i] := S;
    end;
  FillChar(Free, SizeOf(Free), True);
end;

procedure Dijkstra;
var
  i, u, v: Integer;
  min: Integer;
begin
  repeat
    u := 0; min := maxC;
    for i := 1 to n do
      if Free[i] and (d[i] < min) then
        begin
          min := d[i];
          u := i;
        end;
    if (u = 0) or (u = F) then Break;
    Free[u] := False;
    for v := 1 to n do
      if Free[v] and (d[v] > d[u] + c[u, v]) then
        begin
          d[v] := d[u] + c[u, v];
          Trace[v] := u;
        end;
  until False;
end;

procedure PrintResult;
begin
  if d[F] = maxC then
    Writeln('Not found any path from ', S, ' to ', F)
  else
    begin
      Writeln('Distance from ', S, ' to ', F, ': ', d[F]);
      while F <> S do
        begin
          Write(F, '<-');
          F := Trace[F];
        end;
      Writeln(S);
    end;
end;

begin
  Assign(Input, 'MINPATH.INP'); Reset(Input);
  Assign(Output, 'MINPATH.OUT'); Rewrite(Output);
  LoadGraph;
  Init;
  Dijkstra;
  PrintResult;
  Close(Input);
  Close(Output);
end.
