{$M 65520 0 $40000}
program Strongconnectivity;  {Thuat toan danh so}
const
  InputFile  = 'GRAPH.INP';
  OutputFile = 'GRAPH.OUT';
  maxN = 1000;
  maxM = 5000;
type
  TAdj = array[1..maxM] of Integer;
  THead = array[1..maxN + 1] of Integer;
var
  adj: TAdj;
  head: THead;
  Index, List, nV: array[1..maxN] of Integer;
  NotV, Free: array[1..maxN] of Boolean;
  Count, n, m, nComponent, nList, nIndex: Integer;
  Number: Boolean;

procedure Enter;
var
  f: Text;
  i, u, v: Integer;
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
  FilLChar(NotV, SizeOf(NotV), True);
  FillChar(Free, SizeOf(Free), True);
  FillChar(nV, SizeOF(nV), 0);
  nIndex := 0;
  Count := 0;
  nList := 0;
  nComponent := 0;
end;

procedure Visit(u: Integer);
var
  iv, v: Integer;
begin
  notV[u] := False;
  for iv := Head[u] + 1 to Head[u + 1] do
    begin
      v := adj[iv]; {v la 1 dinh ke u}
      if not Free[v] then Continue; {v da bi loai khoi do thi thi bo qua}
      if NotV[v] then Visit(v);
    end;
  if Number then
    begin
      Inc(nIndex);
      Index[nIndex] := u;
    end
  else
    begin
      Inc(nList);
      List[nList] := u;
      Inc(nV[nComponent]);
      Free[u] := False;
    end;
end;

procedure ChangeDirection; {Dao chieu, xay dung danh sach ke moi}
var
  SHead: THead;
  SAdj: TAdj;
  u, v, iv: Integer;
begin
  FillChar(SHead, SizeOF(SHead), 0);
  FillChar(SAdj, SizeOF(SAdj), 0);
  for u := 1 to n do
    for iv := Head[u] + 1 to Head[u + 1] do
      begin
        v := Adj[iv];
        Inc(SHead[v]);
      end;
  for u := 2 to n do
    SHead[u] := SHead[u - 1] + Shead[u];
  for u := 1 to n do
    for iv := Head[u] + 1 to Head[u + 1] do
      begin
        v := Adj[iv];
        SAdj[SHead[v]] := u;
        Dec(SHead[v]);
      end;
  SHead[n + 1] := m;
  Head := SHead;
  Adj := SAdj;
end;

procedure Solve;
var
  u: Integer;
begin
  Init;
  Number := True;
  for u := 1 to n do
    if notV[u] then Visit(u);
  ChangeDirection;
  Init;
  Number := False;
  for u := n downto 1 do
    if notV[Index[u]] then
      begin
        Inc(nComponent);
        Visit(Index[u]);
      end;
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
