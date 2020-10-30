program RandomTest;
const
  InputFile  = 'MESSAGE.IN5';
type
  TLine = array[1..700] of Boolean;
  PLine = ^TLine;
var
  f: Text;
  ntree, n, m, u, v, i, j: Integer;
  index: array[1..700] of Integer;
  Lab: array[1..700] of Integer;
  a: array[1..700] of PLine;
begin
  Randomize;
  for u := 1 to 700 do
    begin
      New(a[u]);
      FillChar(a[u]^, SizeOf(a[u]^), False);
    end;
  Assign(f, InputFile); Rewrite(f);
  Write('n, ntree = '); Readln(n, ntree);
  for i := 1 to n do index[i] := i;
  for i := 1 to n do
    begin
      j := Random(n) + 1;
      u := Index[i]; Index[i] := Index[j]; Index[j] := u;
    end;
  for i := 1 to n do Lab[i] := Random(ntree);
  for i := 1 to ntree do Lab[i] := i - 1;
  for i := 2 to n do
    begin
      repeat
        j := Random(i - 1) + 1;
      until (i <= ntree) or (Lab[i] = Lab[j]);
      if Lab[i] = Lab[j] then a[j]^[i] := True;
    end;
  for i := 1 to n do
    begin
      u := Random(n) + 1;
      v := Random(n) + 1;
      a[u]^[v] := True;
    end;
  Writeln(f, n);
  for u := 1 to n do
    for v := 1 to n do
      if (u <> v) and a[u]^[v] then Writeln(f, Index[u], ' ', Index[v]);
  Close(f);
end.
