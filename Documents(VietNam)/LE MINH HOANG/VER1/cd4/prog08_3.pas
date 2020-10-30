program Shortest_Path_by_Dijkstra;
const
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
  head: ^THeader;
  d: array[1..max] of LongInt;
  Trace: array[1..max] of Integer;
  Free: array[1..max] of Boolean;
  Heap, Pos: array[1..max] of Integer;
  n, S, F, nHeap: Integer;

procedure LoadGraph;
var
  i, m: Integer;
  u, v, c: Integer;
  inp: Text;
begin
  Assign(inp, 'MINPATH.INP'); Reset(inp);
  Readln(inp, n, m, S, F);
  New(head);
  New(adj); New(adjCost);
  FillChar(head^, SizeOf(head^), 0);
  for i := 1 to m do
    begin
      Readln(inp, u);
      Inc(head^[u]);
    end;
  for i := 2 to n do head^[i] := head^[i - 1] + head^[i];
  Close(inp);
  Reset(inp);
  Readln(inp);
  for i := 1 to m do
    begin
      Readln(inp, u, v, c);
      adj^[head^[u]] := v;
      adjCost^[head^[u]] := c;
      Dec(head^[u]);
    end;
  head^[n + 1] := m;
  Close(inp);
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
  while (parent > 0) and (d[Heap[parent]] > d[v]) do
    begin
      Heap[child] := Heap[parent];
      Pos[Heap[child]] := child;
      child := parent;
      parent := child div 2;
    end;
  Heap[child] := v;
  Pos[v] := child;
end;

function Pop: Integer;
var
  r, c, v: Integer;
begin
  Pop := Heap[1];
  v := Heap[nHeap];
  Dec(nHeap);
  r := 1;
  while r * 2 <= nHeap do
    begin
      c := r * 2;
      if (c < nHeap) and (d[Heap[c + 1]] < d[Heap[c]]) then Inc(c);
      if d[v] <= d[Heap[c]] then Break;
      Heap[r] := Heap[c];
      Pos[Heap[r]] := r;
      r := c;
    end;
  Heap[r] := v;
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
    for iv := head^[u] + 1 to head^[u + 1] do
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
  out: Text;
begin
  Assign(out, 'MINPATH.OUT'); Rewrite(out);
  if d[F] = maxC then
    Writeln(out, 'Not found any path from ', S, ' to ', F)
  else
    begin
      Writeln(out, 'Distance from ', S, ' to ', F, ': ', d[F]);
      while F <> S do
        begin
          Write(out, F, '<-');
          F := Trace[F];
        end;
      Writeln(out, S);
    end;
  Close(out);
end;

begin
  LoadGraph;
  Init;
  Dijkstra;
  PrintResult;
end.
