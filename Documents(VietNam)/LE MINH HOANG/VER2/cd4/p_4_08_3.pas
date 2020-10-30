program Shortest_Path_by_Dijkstra_and_Heap;
const
  InputFile  = 'MINPATH.INP';
  OutputFile = 'MINPATH.OUT';
  max = 5000;
  maxE = 10000;
  maxC = 1000000000;
type
  TAdj = array[1..maxE] of Integer;
  TAdjCost = array[1..maxE] of LongInt;
  THeader = array[1..max + 1] of Integer;
var
  adj: ^TAdj;							
  adjCost: ^TAdjCost;				
  h: ^THeader;							
  d: array[1..max] of LongInt;
  Trace: array[1..max] of Integer;
  Free: array[1..max] of Boolean;
  heap: array[1..max] of Integer;	
  Pos: array[1..max] of Integer;
  n, S, F, nHeap: Integer;

procedure LoadGraph;
var
  i, m, u, v, c: Integer;
  fi: Text;
begin
  Assign(fi, InputFile); Reset(fi);
  ReadLn(fi, n, m, S, F);
  New(h);
  New(adj); New(adjCost);
  FillChar(h^, SizeOf(h^), 0);
  for i := 1 to m do
    begin
      ReadLn(fi, u);
      Inc(h^[u]);
    end;
  for i := 2 to n do h^[i] := h^[i - 1] + h^[i];
  Close(fi);
  Reset(fi);
  ReadLn(fi);
  for i := 1 to m do
    begin
      ReadLn(fi, u, v, c);
      adj^[h^[u]] := v;
      adjCost^[h^[u]] := c;
      Dec(h^[u]);
    end;
  h^[n + 1] := m;
  Close(fi);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to n do d[i] := maxC;
  d[S] := 0;
  FillChar(Free, SizeOf(Free), True);
  FillChar(Pos, SizeOf(Pos), 0);
  nHeap := 0;
end;

procedure Update(v: Integer);
var
  parent, child: Integer;
begin
  child := Pos[v];
  if child = 0 then
    begin
      Inc(nHeap); child := nHeap;
    end;
  parent := child div 2;
  while (parent > 0) and (d[heap[parent]] > d[v]) do
    begin
      heap[child] := heap[parent];
      Pos[heap[child]] := child;
      child := parent;
      parent := child div 2;
    end;
  heap[child] := v;
  Pos[v] := child;
end;

function Pop: Integer;
var
  r, c, v: Integer;
begin
  Pop := heap[1];
  v := heap[nHeap];
  Dec(nHeap);
  r := 1;
  while r * 2 <= nHeap do
    begin
      c := r * 2;
      if (c < nHeap) and (d[heap[c + 1]] < d[heap[c]]) then Inc(c);
      if d[v] <= d[heap[c]] then Break;
      heap[r] := heap[c];
      Pos[heap[r]] := r;
      r := c;
    end;
  heap[r] := v;
  Pos[v] := r;
end;

procedure Dijkstra;
var
  i, u, iv, v: Integer;
  min: Integer;
begin
  Update(1);
  repeat
    u := Pop;
    if u = F then Break;
    Free[u] := False;
    for iv := h^[u] + 1 to h^[u + 1] do
      begin
        v := adj^[iv];
        if Free[v] and (d[v] > d[u] + adjCost^[iv]) then
          begin
            d[v] := d[u] + adjCost^[iv];
            Trace[v] := u;
            Update(v);
          end;
      end;
  until nHeap = 0;
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
  Dijkstra;
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