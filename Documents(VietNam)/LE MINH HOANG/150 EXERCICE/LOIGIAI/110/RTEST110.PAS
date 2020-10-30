program RandomTest;
var
  a: array[1..12] of Integer;
  p, fac: LongInt;
  n, i, j, t: Integer;
  f: text;
begin
  Randomize;
  Write('n = '); Readln(n);
  for i := 1 to n do a[i] := i;
  for i := 1 to n do
    begin
      j := Random(n) + 1;
      t := a[i]; a[i] := a[j]; a[j] := t;
    end;
  fac := 1;
  for i := 2 to n do fac := fac * i;
  repeat
    p := Round(Random * fac);
  until (p > 0) and (p <= fac);
  Assign(f, 'PERMUTE.IN0'); Rewrite(f);
  for i := 1 to n do Write(f, a[i], ' ');
  Writeln(f);
  Writeln(f, p);
  Close(f);
end.