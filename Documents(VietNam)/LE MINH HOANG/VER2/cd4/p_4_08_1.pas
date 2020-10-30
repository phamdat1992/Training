program Shortest_Path_by_Ford_Bellman;
const
  InputFile  = 'MINPATH.INP';
  OutputFile = 'MINPATH.OUT';
  max = 100;
  maxC = 10000;
var
  c: array[1..max, 1..max] of Integer;
  d: array[1..max] of Integer;
  Trace: array[1..max] of Integer;
  n, S, F: Integer;

procedure LoadGraph;		
var
  i, m, u, v: Integer;
  fi: Text;
begin
  Assign(fi, InputFile); Reset(fi);
  ReadLn(fi, n, m, S, F);
  
  for u := 1 to n do
    for v := 1 to n do
      if u = v then c[u, v] := 0 else c[u, v] := maxC;
  for i := 1 to m do ReadLn(fi, u, v, c[u, v]);
  Close(fi);
end;

procedure Init; 				
var
  i: Integer;
begin
  for i := 1 to n do d[i] := MaxC;
  d[S] := 0;
end;

procedure Ford_Bellman; 			
var
  Stop: Boolean;
  u, v, CountLoop: Integer;
begin
  for CountLoop := 1 to n - 1 do
    begin
      Stop := True;
      for u := 1 to n do
        for v := 1 to n do
          if d[v] > d[u] + c[u, v] then 	
            begin
              d[v] := d[u] + c[u, v]; 
              Trace[v] := u; 						
              Stop := False; 
            end;
      if Stop then Break;
    end;
  
end;

procedure PrintResult;	
var
  fo: Text;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  if d[F] = maxC then 	
    WriteLn(fo, 'Path from ', S, ' to ', F, ' not found')
  else 								
    begin
      WriteLn(fo, 'Distance from ', S, ' to ', F, ': ', d[F]);
      while F <> S do
        begin
          Write(fo, F, '<-');
          F := Trace[F];
        end;
      WriteLn(fo, S);
    end;
  Close(fo);
end;

begin
  LoadGraph;
  Init;
  Ford_Bellman;
  PrintResult;
end.
6 7 1 4
1 2 1
1 6 20
2 3 2
3 4 20
3 6 3
5 4 5
6 5 4