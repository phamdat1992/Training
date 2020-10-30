program Max_Flow;
const
  max = 100;
  maxC = 10000;
var
  c, f, cf: array[1..max, 1..max] of Integer; 
  Trace: array[1..max] of Integer;
  n, A, B: Integer;

procedure Enter; 
var
  m, i, u, v: Integer;
begin
  FillChar(c, SizeOf(c), 0);
  Readln(n, m, A, B);
  for i := 1 to m do
    Readln(u, v, c[u, v]);
end;

procedure CreateGf; 
var
  u, v: Integer;
begin
  for u := 1 to n do
    for v := 1 to n do cf[u, v] := maxC;
  for u := 1 to n do
    for v := 1 to n do
      if c[u, v] > 0 then 
        begin
          if f[u, v] < c[u, v] then cf[u, v] := c[u, v] - f[u, v]; 
          if f[u, v] > 0 then cf[v, u] := -f[u, v]; 
        end;
end;

function FindPath: Boolean;
var
  Queue: array[1..max] of Integer; 
  Free: array[1..max] of Boolean;
  u, v, First, Last: Integer;
begin
  FillChar(Free, SizeOf(Free), True);
  First := 1; Last := 1; Queue[1] := A; 
  Free[A] := False; 
  repeat
    u := Queue[First]; Inc(First); 
    for v := 1 to n do
      if Free[v] and (cf[u, v] <> maxC) then 
        begin
          Trace[v] := u; 
          if v = B then 
            begin
              FindPath := True; Exit;
            end;
          Free[v] := False; 
          Inc(Last);
          Queue[Last] := v; 
        end;
  until First > Last; 
  FindPath := False; 
end;


procedure IncFlow;
var
  u, v, IncValue: Integer;
begin
  IncValue := maxC;
  v := B;
  while v <> A do
    begin
      u := Trace[v];
      if Abs(cf[u, v]) < IncValue then IncValue := Abs(cf[u, v]);
      v:= u;
    end;
  v := B;
  while v <> A do
    begin
      u := Trace[v];
      if cf[u, v] > 0 then f[u, v] := f[u, v] + IncValue 
      else f[v, u] := f[v, u] - IncValue; 
      v := u;
    end;
end;

procedure PrintResult;
var
  u, v, m: Integer;
begin
  m := 0;
  for u := 1 to n do
    for v := 1 to n do
      if c[u, v] > 0 then
        begin
          Writeln('f(', u, ', ', v, ') = ', f[u, v]);
          if u = A then m := m + f[A, v];
        end;
  Writeln('Max Flow: ', m);
end;

begin
  Assign(Input, 'MAXFLOW.INP'); Reset(Input);
  Assign(Output, 'MAXFLOW.OUT'); Rewrite(Output);
  Enter;
  FillChar(f, SizeOf(f), 0);
  repeat
    CreateGf;
    if not FindPath then Break;
    IncFlow;
  until False;
  PrintResult;
  Close(Input);
  Close(Output);
end.
6 8 1 6
1 2 5
1 3 5
2 4 6
2 5 3
3 4 3
3 5 1
4 6 6
5 6 6
