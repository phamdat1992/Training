program Shortest_Path_by_Floyd;
const
  InputFile  = 'MINPATH.INP';
  OutputFile = 'MINPATH.OUT';
  max = 100;
  maxC = 10000;
var
  c: array[1..max, 1..max] of Integer;
  Trace: array[1..max, 1..max] of Integer;	
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

procedure Floyd;
var
  k, u, v: Integer;
begin
  for u := 1 to n do
    for v := 1 to n do Trace[u, v] := v;	
  for k := 1 to n do
    for u := 1 to n do
      for v := 1 to n do
        if c[u, v] > c[u, k] + c[k, v] then
          begin
            c[u, v] := c[u, k] + c[k, v];
            Trace[u, v] := Trace[u, k];
          end;
end;

procedure PrintResult;
var
  fo: Text;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  if c[S, F] = maxC
    then WriteLn(fo, 'Path from ', S, ' to ', F, ' not found')
  else
    begin
      WriteLn(fo, 'Distance from ', S, ' to ', F, ': ', c[S, F]);
      repeat
        Write(fo, S, '->');
        S := Trace[S, F];
      until S = F;
      WriteLn(fo, F);
    end;
  Close(fo);
end;

begin
  LoadGraph;
  Floyd;
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