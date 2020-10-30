program Max_Flow_by_Ford_Fulkerson;
const
  InputFile  = 'MAXFLOW.IN0';
  OutputFile = 'MAXFLOW.OUT';
  max = 100;
  maxC = 10000;
var
  c, f: array[1..max, 1..max] of Integer;
  Trace: array[1..max] of Integer;
  Delta: array[1..max] of Integer;
  n: Integer;

procedure Enter;
var
  m, i, u, v: Integer;
  fi: Text;
begin
  Assign(fi, InputFile); Reset(fi);
  FillChar(c, SizeOf(c), 0);
  ReadLn(fi, n, m);
  for i := 1 to m do
    ReadLn(fi, u, v, c[u, v]);
  Close(fi);
end;

function Min(X, Y: Integer): Integer;
begin
  if X < Y then Min := X else Min := Y;
end;

function FindPath: Boolean;
var
  u, v: Integer;
  Queue: array[1..max] of Integer;
  First, Last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  First := 1; Last := 1; Queue[1] := 1;
  Trace[1] := n + 1;
  Delta[1] := maxC;
  repeat
    u := Queue[First]; Inc(First);		
    for v := 1 to n do
      if Trace[v] = 0 then 					
        begin
          if f[u, v] < c[u, v] then 	
            begin
              Trace[v] := u; 				
              Delta[v] := min(Delta[u], c[u, v] - f[u, v]);
            end
          else
            if f[v, u] > 0 then 			
              begin
                Trace[v] := -u;			
                Delta[v] := min(Delta[u], f[v, u]);
              end;
          if Trace[v] <> 0 then 			
            begin
              if v = n then
                begin
                  FindPath := True; Exit;
                end;
              Inc(Last); Queue[Last] := v;
            end;
        end;
  until First > Last;
  FindPath := False;
end;

procedure IncFlow;
var
  IncValue, u, v: Integer;
begin
  IncValue := Delta[n];
  v := n;
  repeat
    u := Trace[v];
    if u > 0 then f[u, v] := f[u, v] + IncValue
    else
      begin
        u := -u;
        f[v, u] := f[v, u] - IncValue;
      end;
    v := u;
  until v = 1;
end;

procedure PrintResult;
var
  u, v, m: Integer;
  fo: Text;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  m := 0;
  for v := 1 to n do m := m + f[1, v];
  Writeln(fo, m);
  for u := 1 to n do
    for v := 1 to n do
      if f[u, v] <> 0 then writeln(fo, u, ' ', v, ' ', f[u, v]);
  Close(fo);
end;

begin
  Enter;
  FillChar(f, SizeOf(f), 0);
  while FindPath do IncFlow;
  PrintResult;
end.
6 8
1 2 5
1 3 5
2 4 6
2 5 3
3 4 3
3 5 1
4 6 6
5 6 6