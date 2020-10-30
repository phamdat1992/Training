program Breadth_First_Search_1;
const
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  Free: array[1..max] of Boolean;
  Trace: array[1..max] of Integer;
  Queue: array[1..max] of Integer;
  n, S, F, First, Last: Integer;

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
  Free[S] := False;
  Queue[1] := S;
  Last := 1;
  First := 1;
end;

procedure Push(V: Integer);
begin
  Inc(Last);
  Queue[Last] := V;
end;

function Pop: Integer;
begin
  Pop := Queue[First];
  Inc(First);
end;

procedure BFS;
var
  u, v: Integer;
begin
  repeat
    u := Pop;
    Write(u, ', ');
    for v := 1 to n do
      if Free[v] and a[u, v] then
        begin
          Push(v);
          Free[v] := False;
          Trace[v] := u;
        end;
  until First > Last;
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
  BFS;
  Result;
  Close(Input);
  Close(Output);
end.