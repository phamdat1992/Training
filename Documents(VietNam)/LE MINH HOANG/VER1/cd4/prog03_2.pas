program Depth_First_Search_2;
const
  max = 100;
var
  a: array[1..max, 1..max] of Boolean; 
  Free: array[1..max] of Boolean; 
  Trace: array[1..max] of Integer; 
  Stack: array[1..max] of Integer; 
  n, S, F, Last: Integer; 

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

procedure Init;
begin
  FillChar(Free, n, True);
  Last := 0;
end;

procedure Push(V: Integer);
begin
  Inc(Last);
  Stack[Last] := V;
end;

function Pop: Integer; 
begin
  Pop := Stack[Last];
  Dec(Last);
end;

procedure DFS;
var
  u, v: Integer;
begin
  Write(S, ', '); Free[S] := False;
  Push(S);
  repeat
    u := Pop;
    for v := 1 to n do
      if Free[v] and a[u, v] then
        begin
          Write(v, ', '); Free[v] := False;
          Trace[v] := u;
          Push(u); Push(v);
          Break;
        end;
  until Last = 0;
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
  Init;
  DFS;
  Result;
  Close(Input);
  Close(Output);
end.
