program Depth_First_Search_1;
const
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  Free: array[1..max] of Boolean;
  Trace: array[1..max] of Integer;
  n, S, F: Integer;

procedure Enter;
var
  i, u, v, m: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Readln(n, m, S, F);
  for i := 1 to m do
    begin
      Readln(u, v);
      a[u, v] := True;
      a[v, u] := True;
    end;
end;

procedure DFS(u: Integer);
var
  v: Integer;
begin
  Write(u, ', ');
  Free[u] := False;
  for v := 1 to n do
    if Free[v] and a[u, v] then
      begin
        Trace[v] := u;
        DFS(v);
      end;
end;

procedure Result;
begin
  Writeln;
  if Free[F] then
    Writeln('Not found any path from ', S, ' to ', F)
  else
    begin
      while F <> S do
        begin
          Write(F, '<-');
          F := Trace[F];
        end;
      Writeln(S);
    end;
end;

begin
  Assign(Input, 'GRAPH.INP'); Reset(Input);
  Assign(Output, 'GRAPH.OUT'); Rewrite(Output);
  Enter;
  FillChar(Free, n, True);
  DFS(S);
  Result;
  Close(Input);
  Close(Output);
end.
