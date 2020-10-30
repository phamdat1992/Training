program Critical_Path;
const
  InputFile  = 'MINPATH.INP';
  OutputFile = 'MINPATH.OUT';
  max = 100;
  maxC = 10000;
var
  c: array[1..max, 1..max] of Integer;
  List, d, Trace: array[1..max] of Integer;	
  n, S, F, count: Integer;

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

procedure Number;		
var
  deg: array[1..max] of Integer;
  u, v: Integer;
  front: Integer;
begin
  
  FillChar(deg, SizeOf(deg), 0);
  for u := 1 to n do
    for v := 1 to n do
      if (v <> u) and (c[v, u] < maxC) then Inc(deg[u]);
  
  count := 0;
  for u := 1 to n do
    if deg[u] = 0 then
      begin
        Inc(count); List[count] := u;
      end;
  
  front := 1;
  while front <= count do		
    begin
      
      u := List[front]; Inc(front);	
      for v := 1 to n do
        if c[u, v] <> maxC then	
          begin
            Dec(deg[v]);
            if deg[v] = 0 then		
              begin						
                Inc(count);
                List[count] := v;
              end;
          end;
    end;
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to n do d[i] := maxC;
  d[S] := 0;
end;

procedure FindPath;			
var
  i, j, u, v: Integer;
begin
  for i := 1 to n - 1 do
    for j := i + 1 to n do
      begin
        u := List[i]; v := List[j];			
        if d[v] > d[u] + c[u, v] then	
          begin
            d[v] := d[u] + c[u, v];
            Trace[v] := u;
          end
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
  Number;
  Init;
  FindPath;
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