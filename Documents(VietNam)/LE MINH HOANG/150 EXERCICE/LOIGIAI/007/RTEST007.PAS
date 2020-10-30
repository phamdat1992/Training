program RandomTest;
const
  mc = 100;
  maxc = 990;
type
  TMat = array[1..100, 1..100] of LongInt;
var
  a: TMat;
  b: ^TMat;
  Lab: array[1..100] of Integer;
  Id: array[1..100] of Integer;
  Head: array[0..4] of Integer;
  n, m, i, j, u, v, f1, f2: Integer;
  f: Text;

procedure Merge;
var
  u, v, l: Integer;
begin
  for l := 0 to 3 do
    begin
      repeat
        v := Random(n) + 1;
      until Lab[v] = l;
      a[1, v] := Random(mc) + 1;
      a[v, 1] := a[1, v];
    end;
end;

procedure CreateIndex;
var
  i, j, t: Integer;
begin
  for i := 1 to n do id[i] := i;
  for i := 1 to n do
    begin
      j := Random(n) + 1;
      t := id[i]; id[i] := id[j]; id[j] := t;
    end;
end;

procedure Floyd;
var
  u, v, k: Integer;
begin
  New(b); b^ := a;
  for k := 1 to n do
    for u := 1 to n do
      for v := u + 1 to n do
        if b^[u, v] > b^[u, k] + b^[k, v] then
          begin
            b^[u, v] := b^[u, k] + b^[k, v];
            b^[v, u] := b^[u, v];
          end;
end;

procedure GenCon;
var
  i: Integer;
  b: Boolean;
begin
  repeat
    FillChar(Head, SizeOf(Head), 0);
    for i := 2 to n do
      begin
        Lab[i] := Random(4);
        if Head[Lab[i]] = 0 then Head[Lab[i]] := i;
      end;
    Lab[1] := 4;
    b := False;
    for i := 0 to 3 do
      if Head[i] = 0 then b := True;
  until not b;
end;

begin
  Randomize;
  Write('n = '); Readln(n);
  CreateIndex;
  GenCon;
  for u := 1 to 100 do
    for v := 1 to 100 do a[u, v] := 1000000000;
  for v := 2 to n do
    if v <> Head[Lab[v]] then
      begin
        repeat
          u := Random(v - 1) + 1;
        until Lab[u] = Lab[v];
        a[u, v] := Random(mc) + 1;
        a[v, u] := a[u, v];
      end;
  for v := 2 to n do
    if v <> Head[Lab[v]] then
      begin
        repeat
          u := Random(v - 1) + 1;
        until Lab[u] = Lab[v];
        a[u, v] := Random(mc) + 1;
        a[v, u] := a[u, v];
      end;
  Merge;
  Floyd;
  repeat
    u := Random(n - 2) + 2;
    v := Random(n - 2) + 2;
  until (Lab[u] <> Lab[v]);
  if b^[u, 1] > b^[v, 1] then
    begin
      Inc(n);
      a[n, v] := b^[u, 1] - b^[v, 1];
      a[v, n] := a[n, v];
      Lab[n] := Lab[v];
      v := n;
      id[n] := n;
    end
  else
    if b^[u, 1] < b^[v, 1] then
      begin
        Inc(n);
        a[n, u] := b^[v, 1] - b^[u, 1];
        a[u, n] := a[n, u];
        Lab[n] := Lab[u];
        u := n;
        id[n] := n;
      end;
  repeat
    f1 := Random(n) + 1;
  until Lab[f1] <> Lab[u];
  repeat
    f2 := Random(n) + 1;
  until Lab[f2] <> Lab[v];
  Floyd;
  for i := 1 to n do
    for j := u + 1 to n do
      if (Random(2) = 1) and (a[i, j] = 1000000000) then
        begin
          a[u, v] := b^[u, v] + Random(3);
          a[v, u] := a[u, v];
        end;
  m := 0;
  for i := 1 to n do
    for j := 1 + i to n do
      if a[i, j] <> 1000000000 then Inc(m);
  Assign(f, 'FRIEND.IN0'); Rewrite(f);
  Writeln(f, n, ' ', m);
  Writeln(f, Id[u], ' ', Id[f1], ' ', Id[v], ' ', Id[f2]);
  for i := 1 to n do
    for j := 1 + i to n do
      if a[i, j] <> 1000000000 then Writeln(f, id[i], ' ', id[j], ' ', a[i, j]);
  Close(f);
end.