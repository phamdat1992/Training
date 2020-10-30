{$M 65520 0 $40000}
program Strongconnectivity;  {Thuat toan Tarjan}
const
  InputFile  = 'GRAPH.INP';
  OutputFile = 'GRAPH.OUT';
  maxN = 1000;
  maxM = 5000;
var
  adj: array[1..maxM] of Integer;
  head: array[1..maxN + 1] of Integer;
  Stack, Numbering, Low, NV, List: array[1..maxN] of Integer;
  Free: array[1..maxN] of Boolean;
  Count, n, nComponent, Last, nList: Integer;

procedure Enter;
var
  f: Text;
  i, u, v, m: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  FillChar(head, SizeOf(head), 0);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      Inc(head[u]);
    end;
  for u := 2 to n do Head[u] := Head[u - 1] + Head[u];
  Close(f);
  Reset(f);
  Readln(f);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      adj[head[u]] := v;
      Dec(head[u]);
    end;
  Head[n + 1] := m;
end;

procedure Init;
begin
  FillChar(Numbering, SizeOf(Numbering), 0);
  FillChar(Free, SizeOf(Free), True);
  FillChar(nV, SizeOf(nV), 0);
  Last := 0;
  Count := 0;
  nComponent := 0;
end;

procedure Push(V: Integer);
begin
  Inc(Last); Stack[Last] := V;
end;

function Pop: Integer;
begin
  Pop := Stack[Last];
  Dec(Last);
end;

function Min(a, b: Integer): Integer;
begin
  if a < b then Min := a else Min := b;
end;

procedure Visit(u: Integer);
var
  iv, v: Integer;
begin
  Inc(Count);
  Numbering[u] := Count; Low[u] := Count;
  Push(u);
  for iv := Head[u] + 1 to Head[u + 1] do
    begin
      v := adj[iv]; {v la 1 dinh ke u}
      if not Free[v] then Continue; {v da bi loai khoi do thi thi bo qua}
      if Numbering[v] <> 0 then Low[u] := min(Low[u], Numbering[v])
      else
        begin
          Visit(v);
          Low[u] := min(Low[u], Low[v]);
        end
    end;
  if Numbering[u] = Low[u] then
    begin
      Inc(nComponent);
      repeat
        Inc(nList);
        Inc(nV[nComponent]);
        v := Pop;
        List[nList] := v;
        Free[v] := False;
      until v = u;
    end;
end;

procedure Solve;
var
  u: Integer;
begin
  for u := 1 to n do
    if Numbering[u] = 0 then Visit(u);
end;

procedure Result;
var
  f: Text;
  c, i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, nComponent);
  c := 1;
  for i := 1 to n do
    begin
      Write(f, List[i], ' ');
      Dec(nV[c]);
      if nV[c] = 0 then
        begin
          Writeln(f);
          Inc(c);
        end;
    end;
  Close(f);
end;

begin
  Enter;
  Init;
  Solve;
  Result;
end.
INP
16 21
1 2
1 3
2 4
3 5
3 6
4 7
5 8
6 8
7 2
8 3
9 10
9 11
10 12
11 13
12 14
12 15
13 12
13 16
14 9
15 14
16 11

OUT
4
5 8 6 3 
7 4 2 
1 
10 14 15 12 16 13 11 9 
