program CutVertices_CutEdges;
const
  InputFile  = 'GRAPH.INP';
  OutputFile = 'GRAPH.OUT';
  maxN = 1000;
  maxM = 10000;
var
  adj: array[1..2 * maxM] of Integer;
  head: array[1..maxN + 1] of Integer;
  Parent, Numbering, Low1, Low2, nC: array[1..maxN] of Integer;
  CutV: array[1..maxN] of Integer;
  CutE: array[1..maxN, 1..2] of Integer;
  n, m, Count, nCutV, nCutE: Integer;

procedure Enter;
var
  f: Text;
  i, u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(head, SizeOf(head), 0);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      Inc(head[u]); Inc(head[v]);
    end;
  Close(f);
  Reset(f);
  for i := 2 to n do head[i] := head[i - 1] + head[i];
  Readln(f);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      adj[head[u]] := v;
      Dec(head[u]);
      adj[head[v]] := u;
      Dec(head[v]);
    end;
  head[n + 1] := 2 * m;
end;

procedure Init;
begin
  FillChar(Parent, SizeOf(Parent), 0);
  FillChar(Numbering, SizeOf(Numbering), 0);
  nCutV := 0;
  nCutE := 0;
  Count := 0;
end;

function Min(x, y: Integer): Integer;
begin
  if x < y then Min := x else Min := y;
end;

procedure Visit(u: Integer);
var
  iv, v: Integer;
  isCutV: Boolean;
begin
  Inc(Count);
  Numbering[u] := Count; Low1[u] := n + 1; Low2[u] := n + 1;
  isCutV := False;
  nC[u] := 0;
  for iv := head[u] + 1 to head[u + 1] do
    begin
      v := adj[iv];
      if Numbering[v] <> 0 then
        begin
          Low1[u] := Min(Low1[u], Numbering[v]);
          if v <> Parent[u] then Low2[u] := Min(Low2[u], Numbering[v]);
        end
      else
        begin
          Parent[v] := u;
          Inc(nC[u]);
          Visit(v);
          isCutV := isCutV or (Low1[v] >= Numbering[u]);
          if Low2[v] > Numbering[u] then
            begin
              inc(nCutE);
              CutE[nCutE, 1] := u;
              CutE[nCutE, 2] := v;
            end;
          Low2[u] := Min(Low2[u], Low2[v]);
          Low1[u] := Min(Low1[u], Low1[v]);
        end;
    end;
  if isCutV then
    begin
      Inc(nCutV);
      CutV[nCutV] := u;
    end;
end;

procedure Solve;
var
  u: Integer;
begin
  for u := 1 to n do
    if Numbering[u] = 0 then
      begin
        Visit(u);
        if nC[u] = 1 then Dec(nCutV);
      end;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, nCutV, ' ', nCutE);
  for i := 1 to nCutV do Writeln(f, CutV[i]);
  for i := 1 to nCutE do Writeln(f, CutE[i, 1], ' ', CutE[i, 2]);
  Close(f);
end;

begin
  Enter;
  Init;
  Solve;
  Result;
end.

9
1 2
1 3
2 4
4 5
5 2
3 6
6 7
7 4
7 8
8 9
9 7
