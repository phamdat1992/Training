program Directivity_and_Bridges;
const
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  Numbering, Low: array[1..max] of Integer;
  n, Count: Integer;

procedure Enter;
var
  i, m, u, v: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Readln(n, m);
  for i := 1 to m do
    begin
      Readln(u, v);
      a[u, v] := True;
      a[v, u] := True;
    end;
end;

procedure Init;
begin
  FillChar(Numbering, SizeOf(Numbering), 0);
  Count := 0;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Inc(Count);
  Numbering[u] := Count;
  Low[u] := n + 1;
  for v := 1 to n do
    if a[u, v] then
      begin
        a[v, u] := False;
        if Numbering[v] = 0 then
          begin
            Visit(v);
            if Low[v] > Numbering[u] then Writeln('(', u, ', ', v, ')');
            if Low[u] > Low[v] then Low[u] := Low[v];
          end
        else
          if Low[u] > Numbering[v] then Low[u] := Numbering[v];
      end;
end;

procedure Solve;
var
  u, v: Integer;
begin
  Writeln('Bridges: ');
  for u := 1 to n do
    if Numbering[u] = 0 then Visit(u);
  Writeln('Directed Edges: ');
  for u := 1 to n do
    for v := 1 to n do
      if a[u, v] then Writeln(u, ' -> ', v);
end;

begin
  Assign(Input, 'GRAPH.INP'); Reset(Input);
  Assign(Output, 'GRAPH.OUT'); Rewrite(Output);
  Enter;
  Init;
  Solve;
  Close(Input);
  Close(Output);
end.
11 14
1 2
1 3
2 3
2 4
4 5
4 6
4 9
5 7
5 10
6 8
7 10
7 11
8 9
10 11
