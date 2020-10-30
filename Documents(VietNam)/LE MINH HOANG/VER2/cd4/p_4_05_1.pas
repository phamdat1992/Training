program Directivity_and_Bridges;
const
  InputFile  = 'GRAPH.INP';
  OutputFile = 'BRIDGES.OUT';
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;		
  Numbering, Low: array[1..max] of Integer;
  n, Count: Integer;
  fo: Text;

procedure Enter;
var
  f: Text;
  i, m, u, v: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n, m);
  for i := 1 to m do
    begin
      ReadLn(f, u, v);
      a[u, v] := True;
      a[v, u] := True;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(Numbering, SizeOf(Numbering), 0); 
  Count := 0;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Inc(Count);
  Numbering[u] := Count; 	
  Low[u] := n + 1;				
  for v := 1 to n do
    if a[u, v] then 
      begin
        a[v, u] := False; 					
        if Numbering[v] = 0 then		
          begin
            Visit(v);							
            if Low[v] > Numbering[u] then 
              WriteLn(fo, '(', u, ', ', v, ')');
            if Low[u] > Low[v] then Low[u] := Low[v];					
          end
        else
          if Low[u] > Numbering[v] then Low[u] := Numbering[v];	
      end;
end;

procedure Solve;
var
  u, v: Integer;
begin
  WriteLn(fo, 'Bridges: '); 				
  for u := 1 to n do
    if Numbering[u] = 0 then Visit(u);
  WriteLn(fo, 'Directed Edges: ');
  for u := 1 to n do
    for v := 1 to n do
      if a[u, v] then WriteLn(fo, u, ' -> ', v);
end;

begin
  Enter;
  Assign(fo, OutputFile); Rewrite(fo);
  Init;
  Solve;
  Close(fo);
end.
