program RandomTest;
var
  f: Text;
  i, j, u, v, n, m: Integer;
  a: array[1..100, 1..100] of Integer;
  Index: array[1..100] of Integer;

procedure CreateIndex;
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
  CreateIndex;
  for u := 1 to n do
    for v := 1 to n do a[u, v] := maxInt;
  for v := 2 to n do
    begin
      u := Random(v - 1) + 1;
      a[u, v] := Random(200) + 1; a[v, u] := a[u, v];
    end;
  for v := 2 to n do
    begin
      u := Random(v - 1) + 1;
      a[u, v] := Random(200) + 1; a[v, u] := a[u, v];
    end;
{  for i := 1 to n * 3 div 2 do
    begin
      u := Random(n) + 1;
      v := Random(n) + 1;
      if u <> v then
        begin
          a[u, v] := Random(200) + 1;
          a[v, u] := Random(200) + 1;
        end;
    end;}
  m := 0;
  for i := 1 to n do
    for j := i + 1 to n do
      if a[i, j] <> maxInt then Inc(m);
  Assign(f, 'Message.IN0'); Rewrite(f);
  Writeln(f, n, ' ', m, ' ', Index[1], ' ', Index[n]);
  for i := 1 to n do
    for j := i + 1 to n do
      if a[i, j] <> maxInt then Writeln(f, Index[i], ' ', Index[j], ' ', a[i, j]);
  Close(f);
end.