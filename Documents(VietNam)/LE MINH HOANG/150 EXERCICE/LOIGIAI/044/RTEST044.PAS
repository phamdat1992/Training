program RandomTest;
type
  PNode = ^TNode;
  TNode = record
    V: Integer;
    Link: PNode;
  end;
var
  Adj: array[1..1000] of PNode;
  Index: array[1..1000] of Integer;
  clab: array[1..1000] of Integer;
  p: PNode;
  i, u, v, n, m, nc: Integer;
  f: Text;

procedure Init;
begin
  FillChar(Adj, SizeOf(Adj), 0);
  for i := 1 to n do cLab[i] := Random(nc) + 1;
end;

function InsertEdge(u, v: Integer): Boolean;
var
  p: PNode;
begin
  p := adj[u];
  while p <> nil do
    begin
      if p^.v = v then
        begin
          InsertEdge := False;
          Exit;
        end;
      p := p^.Link;
    end;
  New(p);
  p^.V := v;
  p^.Link := adj[u];
  adj[u] := p;
  InsertEdge := True;
end;

procedure RandomIndex;
var
  i, j: Integer;
begin
  FillChar(Index, SizeOf(Index), 0);
  for i := 1 to n do
    begin
      repeat
        j := Random(n) + 1;
      until Index[j] = 0;
      Index[j] := i;
    end;
end;

begin
  Randomize;
  Write('n, m, ncomponent: '); Readln(n, m, nc);
  RandomIndex;
  Init;
  Assign(f, 'GRAPH.IN0'); Rewrite(f);
  Writeln(f, n, ' ', m);
  for v := 2 to n do
    begin
      u := Random(v - 1) + 1;
      if cLab[u] = cLab[v] then
        begin
          InsertEdge(u, v);
          Dec(m);
        end;
    end;
  for i := 1 to m do
    begin
      repeat
        u := Random(n) + 1;
        v := Random(n) + 1;
      until (u <> v) and (clab[u] = clab[v]) and InsertEdge(u, v);
    end;
  for u := 1 to n do
    begin
      p := Adj[u];
      while p <> nil do
        begin
          v := p^.v;
          Writeln(f, Index[u], ' ', Index[v]);
          p := p^.Link;
        end;
    end;
  Close(f);
end.
