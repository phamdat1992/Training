program Breadth_First_Search_2;
const
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  Free: array[1..max] of Boolean;
  Trace: array[1..max] of Integer;
  Old, New: set of Byte;
  n, S, F: Byte;

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
  Old := [S]; 
end;

procedure BFS; 
var
  u, v: Byte;
begin
  repeat 
    New := [];
    for u := 1 to n do 
      if u in Old then 
        begin
          Write(u, ', '); 
          for v := 1 to n do 
            if Free[v] and a[u, v] then 
              begin
                Free[v] := False; 
                Trace[v] := u;
                New := New + [v]; 
              end;
        end;
    Old := New; 
  until Old = []; 
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
