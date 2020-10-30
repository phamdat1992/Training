program Strong_connectivity;
const
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  Free: array[1..max] of Boolean;
  Numbering, Low, Stack: array[1..max] of Integer;
  n, Count, ComponentCount, Last: Integer;

procedure Enter; 
var
  i, u, v, m: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Readln(n, m);
  for i := 1 to m do
    begin
      Readln(u, v);
      a[u, v] := True;
    end;
end;

procedure Init;
begin
  FillChar(Numbering, SizeOf(Numbering), 0);
  FillChar(Free, SizeOf(Free), True);
  Last := 0;
  Count := 0; 
  ComponentCount := 0; 
end;

procedure Push(v: Integer); 
begin
  Inc(Last);
  Stack[Last] := v;
end;

function Pop: Integer; 
begin
  Pop := Stack[Last];
  Dec(Last);
end;

function Min(x, y: Integer): Integer;
begin
  if x < y then Min := x else Min := y;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Inc(Count); Numbering[u] := Count;
  Low[u] := Numbering[u];
  Push(u);
  for v := 1 to n do
    if Free[v] and a[u, v] then
      if Numbering[v] <> 0 then
        Low[u] := Min(Low[u], Numbering[v])
      else
        begin
          Visit(v);
          Low[u] := Min(Low[u], Low[v]);
        end;
  if Numbering[u] = Low[u] then
    begin
      Inc(ComponentCount);
      Writeln('Component ', ComponentCount, ': ');
      repeat
        v := Pop;
        Write(v, ', ');
        Free[v] := False;
      until v = u;
      Writeln;
    end;
end;

procedure Solve;
var
  u: Integer;
begin
  for u := 1 to n do
    if Numbering[u] = 0 then Visit(u);
end;

begin
  Assign(Input, 'GRAPH.INP'); Reset(Input);
  Assign(Output, 'GRAPH.OUT'); Rewrite(Output);
  Enter;
  Init;
  Solve;
  Close(Input);
  Close(Output);
end.
