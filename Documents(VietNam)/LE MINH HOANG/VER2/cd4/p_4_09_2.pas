program Minimal_Spanning_Tree_by_Prim;
const
  InputFile  = 'MINTREE.INP';
  OutputFile = 'MINTREE.OUT';
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
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n, m);
  for u := 1 to n do
    for v := 1 to n do
      if u = v then c[u, v] := 0 else c[u, v] := maxC;	
  for i := 1 to m do
    begin
      ReadLn(f, u, v, c[u, v]);
      c[v, u] := c[u, v];
    end;
  Close(f);
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
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  if not Connected then 
    WriteLn(f, 'Error: Graph is not connected')
  else
    begin
      WriteLn(f, 'Minimal spanning tree: ');
      W := 0;
      for v := 2 to n do 
        begin
          WriteLn(f, '(', Trace[v], ', ', v, ') = ', c[Trace[v], v]);
          W := W + c[Trace[v], v];
        end;
      WriteLn(f, 'Weight = ', W);
    end;
  Close(f);
end;

begin
  LoadGraph;
  Init;
  Prim;
  PrintResult;
end.
6 9
1 2 1
1 3 1
2 4 1
2 3 2
2 5 1
3 5 1
3 6 1
4 5 2
5 6 2