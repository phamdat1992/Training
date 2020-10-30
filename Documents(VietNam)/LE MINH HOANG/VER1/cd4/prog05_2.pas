program CutVertices;
const
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  Numbering, Low, nC: array[1..max] of Integer;
  Mark: array[1..max] of Boolean;
  n, Count: Integer;

procedure LoadGraph;
var
  i, m, u, v: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Readln(n, m);
  for i := 1 to m do
    begin
      Readln(u, v);
      a[u, v] := True; a[v, u] := True;
    end;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Inc(Count);
  Numbering[u] := Count; Low[u] := n + 1;
  nC[u] := 0;
  Mark[u] := False;
  for v := 1 to n do
    if a[u, v] then
      if Numbering[v] = 0 then
        begin
          Inc(nc[u]);
          Visit(v);
          Mark[u] := Mark[u] or (Low[v] >= Numbering[u]);
          if Low[u] > Low[v] then Low[u] := Low[v];
        end
      else
        if Low[u] > Numbering[v] then Low[u] := Numbering[v];
end;

procedure Solve;
var
  u: Integer;
begin
  FillChar(Numbering, SizeOf(Numbering), 0);
  FillChar(Mark, SizeOf(Mark), False);
  Count := 0; 
  for u := 1 to n do
    if Numbering[u] = 0 then
      begin
        Visit(u);
        if nC[u] < 2 then
            Mark[u] := False;
      end;
end;

procedure Result;
var
  i: Integer;
begin
  Writeln('Cut vertices:');
  for i := 1 to n do
    if Mark[i] then Write(i, ', ');
end;

begin
  Assign(Input, 'GRAPH.INP'); Reset(Input);
  Assign(Output, 'GRAPH.OUT'); Rewrite(Output);
  LoadGraph;
  Solve;
  Result;
  Close(Input);
  Close(Output);
end.
13 15
1 3
2 4
2 5
3 6
3 7
4 8
5 9
5 10
6 7
8 11
8 12
9 10
9 13
10 5
11 12
