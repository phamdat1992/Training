program Minimal_Spanning_Tree_by_Prim;
const
  max = 100;
  maxC = 10000;
var
  c: array[1..max, 1..max] of Integer;
  d: array[1..max] of Integer;
  Free: array[1..max] of Boolean;
  Trace: array[1..max] of Integer; 
  n, m: Integer;
  Connected: Boolean;

procedure LoadGraph;
var
  i, u, v: Integer;
begin
  Readln(n, m);
  for u := 1 to n do
    for v := 1 to n do
      if u = v then c[u, v] := 0 else c[u, v] := maxC;
  for i := 1 to m do
    begin
      Readln(u, v, c[u, v]);
      c[v, u] := c[u, v];
    end;
end;

procedure Init;
var
  v: Integer;
begin
  d[1] := 0; 
  for v := 2 to n do d[v] := maxC; 
  FillChar(Free, SizeOf(Free), True); 
end;

procedure Prim;
var
  k, i, u, v, min: Integer;
begin
  Connected := True;
  for k := 1 to n do
    begin
      u := 0; min := maxC; 
      for i := 1 to n do
        if Free[i] and (d[i] < min) then
          begin
            min := d[i];
            u := i;
          end;
      if u = 0 then 
        begin
          Connected := False;
          Break;
        end;
      Free[u] := False; 
      for v := 1 to n do
        if Free[v] and (d[v] > c[u, v]) then 
          begin
            d[v] := c[u, v]; 
            Trace[v] := u; 
          end;
    end;
end;

procedure PrintResult;
var
  v, W: Integer;
begin
  if not Connected then 
    Writeln('Error: Graph is not connected')
  else
    begin
      Writeln('Minimal spanning tree: ');
      W := 0;
      for v := 2 to n do 
        begin
          Writeln('(', Trace[v], ', ', v, ') = ', c[Trace[v], v]);
          W := W + c[Trace[v], v];
        end;
      Writeln('Weight = ', W);
    end;
end;

begin
  Assign(Input, 'MINTREE.INP'); Reset(Input);
  Assign(Output, 'MINTREE.OUT'); Rewrite(Output);
  LoadGraph;
  Init;
  Prim;
  PrintResult;
  Close(Input);
  Close(Output);
end.
