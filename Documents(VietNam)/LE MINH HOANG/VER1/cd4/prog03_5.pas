program Depth_First_Search_3;
const
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  Trace: array[1..max] of Integer;
  m, n, S, F: Integer;

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

function FindNext(u: Integer): Integer; 
var
  v: Integer;
begin
  repeat
    for v := 1 to n do
      if a[u, v] and (Trace[v] = 0) then 
        begin
          Trace[v] := u; 
          FindNext := v;
          Exit; 
        end;
    u := Trace[u]; 
  until u = n + 1;
  FindNext := 0;
end;

procedure DFS;
var
  u: Integer;
begin
  Trace[S] := n + 1;
  u := S;
  repeat
    Write(u, ', ');
    u := FindNext(u);
  until u = 0;
end;

procedure Result;
begin
  Writeln;
  if Trace[F] = 0 then
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
  DFS;
  Result;
  Close(Input);
  Close(Output);
end.
