program CutVertices;
const
  InputFile  = 'GRAPH.INP';
  OutputFile = 'CUTV.OUT';
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;				
  Numbering, Low, nC: array[1..max] of Integer;	
  Mark: array[1..max] of Boolean;							
  n, Count: Integer;

procedure LoadGraph;
var
  i, m, u, v: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(a, SizeOf(a), False);
  ReadLn(f, n, m);
  for i := 1 to m do
    begin
      ReadLn(f, u, v);
      a[u, v] := True; a[v, u] := True;
    end;
  Close(f);
end;

procedure Visit(u: Integer);					
var
  v: Integer;
begin
  Inc(Count);
  Numbering[u] := Count; Low[u] := n + 1; nC[u] := 0;
  Mark[u] := False;
  for v := 1 to n do
    if a[u, v] then							
      if Numbering[v] = 0 then			
        begin
          Inc(nc[u]);
          Visit(v);								
          Mark[u] := Mark[u] or (Low[v] >= Numbering[u]);
          if Low[u] > Low[v] then Low[u] := Low[v];					
        end
      else
        if Low[u] > Numbering[v] then Low[u] := Numbering[v];	
end;

procedure Solve;
var
  u: Integer;
begin
  FillChar(Numbering, SizeOf(Numbering), 0); 	
  FillChar(Mark, SizeOf(Mark), False);				
  Count := 0; 
  for u := 1 to n do
    if Numbering[u] = 0 then						
      begin
        Visit(u);
        if nC[u] < 2 then								
          Mark[u] := False;							
      end;
end;

procedure Result;				
var
  i: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  WriteLn(f, 'Cut vertices:');
  for i := 1 to n do
    if Mark[i] then Write(f, i, ', ');
  Close(f);
end;

begin
  LoadGraph;
  Solve;
  Result;
end.
