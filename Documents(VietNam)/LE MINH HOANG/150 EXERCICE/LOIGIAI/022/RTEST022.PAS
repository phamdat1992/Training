program RandomTest;
type
  T = set of 1..16;
var
  f: Text;
  k, i, j, u, v, Cc, Ac, n, m: Integer;
  a: array[1..100, 1..100] of T;
  id: array[1..100] of Integer;

procedure Result;
var
  i, j, k: Integer;
begin
  Assign(f, 'AIRLINES.IN8'); Rewrite(f);
  repeat
    i := Random(n) + 1;
    j := Random(n) + 1;
  until i <> j;
  Writeln(f, n, ' ', m, ' ', Cc, ' ', Ac, ' ', i, ' ', j);
  for i := 1 to n do
    for j := i + 1 to n do
      if a[i, j] <> [] then
        begin
          Write(f, id[i], ' ', id[j]);
          for k := 1 to 16 do
            if k in a[i, j] then Write(f, ' ', k);
          Writeln(f);
        end;
  Close(f);
end;

begin
  Randomize;
  Write('n, C, A = '); Readln(n, Cc, Ac);
  for i := 1 to n do id[i] := i;
 { for i := 1 to n do
    begin
      j := Random(n) + 1;
      k := id[i]; id[i] := id[j]; id[j] := k;
    end;
   FillChar(a, SizeOf(a), 0);
  for i := 2 to n do
    begin
      j := Random(i - 1) + 1;
      a[i, j] := [Random(16) + 1];
      a[j, i] := a[i, j];
    end;
  for k := 1 to 10 do
    begin
      repeat
        i := Random(n) + 1;
        j := Random(n) + 1;
      until i <> j;
      a[i, j] := [Random(16) + 1];
      a[j, i] := a[i, j];
    end;
}
  for i := 1 to n - 1 do
    a[i, i + 1] := [1];
  m := 0;
  for i := 1 to n do
    for j := 1 + i to n do
      if a[i, j] <> [] then Inc(m);
  Result;
end.