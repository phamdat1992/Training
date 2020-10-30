program BalanceDivision;
const
  InputFile  = 'BALANCE.INP';
  OutputFile = 'BALANCE.OUT';
  max = 30;
var
  a: array[1..max, 1..max] of Byte;
  ancestor: array[1..max, 1..max] of Boolean;
  Trace: array[1..max] of Integer;
  n, Flow: Integer;

procedure Enter;
var
  i, m, u, v: Integer;
  f: Text;
begin
  FillChar(a, SizeOf(a), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      a[u, v] := 1;
      a[v, u] := 1;
    end;
  Close(f);
end;

procedure InitFlow;
var
  i: Integer;
begin
  Flow := 0;
  for i := 1 to n do
    begin
      a[i, 1] := 0;
      a[n, i] := 0;
    end;
end;

function FindPath(start, finish: Integer): Boolean;
var
  Q: array[1..max] of Integer;
  first, last, u, v: Integer;
begin
  Q[1] := start; first := 1; last := 1;
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[start] := -1;
  repeat
    u := Q[first]; Inc(first);
    for v := 1 to n do
      if (Trace[v] = 0) and (a[u, v] > 0) then
        begin
          Trace[v] := u;
          if v = finish then
            begin
              FindPath := True;
              Exit;
            end;
          Inc(last); Q[last] := v;
        end;
  until first > last;
  FindPath := False;
end;

procedure IncFlow;
var
  u, v: Integer;
begin
  v := n;
  repeat
    u := Trace[v];
    Dec(a[u, v]); Inc(a[v, u]);
    v := u;
  until v = 1;
  Inc(Flow);
end;

procedure FindMaxFlow;
begin
  InitFlow;
  repeat
    if not FindPath(1, n) then Break;
    IncFlow;
  until False;
  Writeln(Flow);
end;

procedure InitAncestor;
var
  i, j, k: Integer;
begin
  for i := 1 to n do
    for j := 1 to n do
      Ancestor[i, j] := (i = j) or (a[j, i] > 0);
  for k := 1 to n do
    for i := 1 to n do
      for j := 1 to n do
        Ancestor[i, j] := Ancestor[i, j] or Ancestor[i, k] and Ancestor[k, j];
end;

begin
  Enter;
  FindMaxFlow;
  InitAncestor;
end.
10 16
1 2
1 3
1 4
1 5
2 4
3 5
4 6
4 7
5 6
5 7
6 8
6 10
7 9
7 10
8 10
9 10