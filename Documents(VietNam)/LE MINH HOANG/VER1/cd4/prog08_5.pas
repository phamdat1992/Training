program Shortest_Path_by_Floyd;
const
  max = 100;
  maxC = 10000;
var
  c: array[1..max, 1..max] of Integer;
  Trace: array[1..max, 1..max] of Integer;
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

procedure Floyd;
var
  k, u, v: Integer;
begin
  for u := 1 to n do
    for v := 1 to n do Trace[u, v] := v;
  for k := 1 to n do
    for u := 1 to n do
      for v := 1 to n do
        if c[u, v] > c[u, k] + c[k, v] then
          begin
            c[u, v] := c[u, k] + c[k, v];
            Trace[u, v] := Trace[u, k];
          end;
end;

procedure PrintResult;
begin
  if c[S, F] = maxC
    then Writeln('Not found any path from ', S, ' to ', F)
  else
    begin
      Writeln('Distance from ', S, ' to ', F, ': ', c[S, F]);
      repeat
        Write(S, '->');
        S := Trace[S, F]; 
      until S = F;
      Writeln(F);
    end;
end;

begin
  Assign(Input, 'MINPATH.INP'); Reset(Input);
  Assign(Output, 'MINPATH.OUT'); Rewrite(Output);
  LoadGraph;
  Floyd;
  PrintResult;
  Close(Input);
  Close(Output);
end.
