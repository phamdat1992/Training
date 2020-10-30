program RandomTest;
type
  PAdj = ^TAdj;
  TAdj = record
    v: Integer;
    Link: PAdj;
  end;
var
  Adj: array[1..1000] of PAdj;
  Index: array[1..1000] of Integer;
  P: PAdj;
  n, m, k, u, v, i: Integer;
  f: Text;

procedure Init;
var
  i, j, t: Integer;
begin
  FillChar(Adj, SizeOf(Adj), 0);
  for i := 1 to n do Index[i] := i;
  for i := 1 to n do
    begin
      j := Random(n) + 1;
      t := Index[i]; Index[i] := Index[j]; Index[j] := t;
    end;
end;

function Insert(u, v: Integer): Boolean;
var
  t: Integer;
  P: Padj;
begin
  if u > v then
    begin
      t := u; u := v; v := t;
    end;
  P := Adj[u];
  while P <> nil do
    begin
      if P^.v = v then
        begin
          Insert := False;
          Exit;
        end;
      P := P^.Link;
    end;
  New(P); P^.v := v;
  P^.Link := Adj[u]; Adj[u] := P;
end;

procedure gen1;
begin
  k := 0;
  for u := 2 to n do
    begin
      v := Random(u - 1) + 1;
      if Insert(u, v) then Inc(k);
      if k = m then Exit;
    end;
  while k < m do
    begin
      u := Random(n) + 1;
      v := Random(n) + 1;
      if (u <> v) and Insert(u, v) then Inc(k);
    end;
end;

procedure gen2;
var
  Lab: array[1..1000] of Integer;
  i: Integer;
begin
  for i := 1 to n do Lab[i] := Random(5);
  k := 0;
  while k < m do
    begin
      u := Random(n) + 1;
      v := Random(n) + 1;
      if (u <> v) and (Lab[u] = Lab[v]) and Insert(u, v) then Inc(k);
    end;
end;

procedure gen3;
begin
  k := 0;
  for u := 2 to n do
    begin
      v := Random(u - 1) + 1;
      if Insert(u, v) then Inc(k);
      if k = m then Exit;
    end;
  for u := 2 to n do
    begin
      v := Random(u - 1) + 1;
      if Insert(u, v) then Inc(k);
      if k = m then Exit;
    end;
  while k < m do
    begin
      u := Random(n) + 1;
      v := Random(n) + 1;
      if (u <> v) and Insert(u, v) then Inc(k);
    end;
end;

procedure gen4;
begin
  k := 0;
  for u := 1 to n - 1 do
    begin
      v := u + 1;
      if Insert(u, v) then Inc(k);
      if k = m then Exit;
    end;
  m := n - 1;
end;


begin
  Randomize;
  Write('n, m: '); Readln(n, m);
  Init;
  Gen4;
  Assign(f, 'GRAPH.IN4'); Rewrite(f);
  Writeln(f, n, ' ', m);
  for u := 1 to n do
    begin
      P := Adj[u];
      while P <> nil do
        begin
          Writeln(f, Index[u], ' ', Index[P^.v]);
          P := P^.Link;
        end;
    end;

  Close(f);
end.
