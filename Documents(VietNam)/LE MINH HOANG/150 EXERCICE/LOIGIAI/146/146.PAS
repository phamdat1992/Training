program Minimal_Spanning_Tree_by_Kruskal;
const
  InputFile  = 'MST.IN0';
  OutputFile = 'MST.OUT';
  maxV = 10000;
  maxE = 15000;
type
  TEdge = record
    u, v, c, id: Integer;
  end;
  PEdge = ^TEdge;
  TLab = array[1..maxV] of Integer;
var
  e: array[1..maxE] of PEdge;
  Lab: ^TLab;
  n, m: Integer;
  W: LongInt;

procedure LoadGraph;
var
  i: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      New(e[i]);
      Readln(f, e[i]^.u, e[i]^.v, e[i]^.c);
      e[i]^.id := i;
    end;
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  New(Lab);
  for i := 1 to n do Lab^[i] := -1;
end;

function GetRoot(v: Integer): Integer;
begin
  while Lab^[v] > 0 do v := Lab^[v];
  GetRoot := v;
end;

procedure Union(r1, r2: Integer);
var
  x: Integer;
begin
  x := Lab^[r1] + Lab^[r2];
  if Lab^[r1] > Lab^[r2] then
    begin
      Lab^[r1] := r2;
      Lab^[r2] := x;
    end
  else
    begin
      Lab^[r1] := x;
      Lab^[r2] := r1;
    end;
end;

procedure AdjustHeap(root, last: Integer);
var
  Key: PEdge;
  child: Integer;
begin
  Key := e[root];
  while root * 2 <= Last do
    begin
      child := root * 2;
      if (child < Last) and (e[child + 1]^.c < e[child]^.c)
        then Inc(child);
      if Key^.c <= e[child]^.c then Break;
      e[root] := e[child];
      root := child;
    end;
  e[root] := Key;
end;

procedure Kruskal;
var
  i, r1, r2, Count: Integer;
  tmp: PEdge;
begin
  W := 0;
  Count := 0;
  for i := m div 2 downto 1 do AdjustHeap(i, m);
  for i := m - 1 downto 0 do
    begin
      tmp := e[1]; e[1] := e[i + 1]; e[i + 1] := tmp;
      AdjustHeap(1, i);
      r1 := GetRoot(e[i + 1]^.u); r2 := GetRoot(e[i + 1]^.v);
      if r1 <> r2 then
        begin
          e[i + 1]^.id := -e[i + 1]^.id;
          W := W + e[i + 1]^.c;
          Inc(Count);
          if Count = n - 1 then Exit;
          Union(r1, r2);
        end;
    end;
end;

procedure PrintResult;
var
  i: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, W);
  for i := 1 to m do
    if e[i]^.id < 0 then Writeln(f, - e[i]^.Id);
  Close(f);
end;

begin
  LoadGraph;
  Init;
  Kruskal;
  PrintResult;
end.
6 9
1 2 1
1 3 1
2 4 1
2 3 2
2 5 1
3 5 1
3 6 1
4 5 2
5 6 2
