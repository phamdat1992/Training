program RandomTest;
var
  a: array[1..200, 1..200] of Boolean;
  Index: array[1..200] of Integer;
  n, i, j, u, v: Integer;
  f: Text;

procedure RandomIndex;
var
  i, j, t: Integer;
begin
  for i := 1 to n do Index[i] := i;
  for i := 1 to n do
    begin
      j := Random(n) + 1;
      t := Index[i]; Index[i] := Index[j]; Index[j] := t;
    end;
end;

begin
  Randomize;
  Write('n = '); Readln(n);
  RandomIndex;
  FillChar(a, SizeOf(a), False);
  for i := 2 to n do
    begin
      j := Random(i - 1) + 1;
      a[i, j] := True;
      a[j, i] := True;
    end;
  i := Random(n - 1) + 2;
  a[1, i] := True; a[i, 1] := True;
  for i := 1 to n div 2 do
    begin
      u := Random(n) + 1;
      v := Random(n) + 1;
      a[u, v] := True; a[v, u] := True;
    end;
  Assign(f, 'CIRCUIT.IN0'); Rewrite(f);
  Writeln(f, n, ' ', Index[1]);
  for u := 1 to n do
    for v := u + 1 to n do
      if a[u, v] then Writeln(f, Index[u], ' ', Index[v]);
  Close(f);
end.
