program Strong_connectivity;
const
  InputFile  = 'GRAPH.INP';
  OutputFile = 'SCONNECT.OUT';
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  Free: array[1..max] of Boolean;
  Numbering, Low, Stack: array[1..max] of Integer;
  n, Count, ComponentCount, Last: Integer;
  fo: Text;

procedure Enter; 			
var
  i, u, v, m: Integer;
  fi: Text;
begin
  Assign(fi, InputFile); Reset(fi);
  FillChar(a, SizeOf(a), False);
  ReadLn(fi, n, m);
  for i := 1 to m do
    begin
      ReadLn(fi, u, v);
      a[u, v] := True;
    end;
  Close(fi);
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
      WriteLn(fo, 'Component ', ComponentCount, ': ');
      repeat
        v := Pop;						
        Write(fo, v, ', ');		
        Free[v] := False;			
      until v = u;						
      WriteLn(fo);
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
  Enter;
  Assign(fo, OutputFile); Rewrite(fo);
  Init;
  Solve;
  Close(fo);
end.
11 15
1 2
18
2 3
3 4
4 2
4 5
5 6
6 7
7 5
8 9
9 4
9 10
10 8
10 11
11 8