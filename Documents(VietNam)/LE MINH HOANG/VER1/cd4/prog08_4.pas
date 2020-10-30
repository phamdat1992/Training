program Critical_Path;
const
  max = 100;
  maxC = 10000;
var
  c: array[1..max, 1..max] of Integer;
  List, d, Trace: array[1..max] of Integer;
  n, S, F, count: Integer;

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

procedure Number;
var
  deg: array[1..max] of Integer;
  u, v: Integer;
  front: Integer;
begin
  FillChar(deg, SizeOf(deg), 0);
  for u := 1 to n do
    for v := 1 to n do
      if (v <> u) and (c[v, u] < maxC) then Inc(deg[u]);
  count := 0;
  for u := 1 to n do
    if deg[u] = 0 then
      begin
        Inc(count); List[count] := u;
      end;
  front := 1;
  while front <= count do
    begin
      u := List[front]; Inc(front);
      for v := 1 to n do
        if c[u, v] <> maxC then
          begin
            Dec(deg[v]);
            if deg[v] = 0 then
              begin
                Inc(count);
                List[count] := v;
              end;
          end;
    end;
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
end;

procedure FindPath;
var
  i, j, u, v: Integer;
begin
  for i := 1 to n - 1 do
    for j := i + 1 to n do
      begin
        u := List[i]; v := List[j];
        if d[v] > d[u] + c[u, v] then
          begin
            d[v] := d[u] + c[u, v];
            Trace[v] := u;
          end
      end;
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
  Number;
  if Count < n then
    Writeln('Error: Circuit Exist')
  else
    begin
      Init;
      FindPath;
      PrintResult;
    end;
  Close(Input);
  Close(Output);
end.
