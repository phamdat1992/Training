program RandomTest;
var
  i, n, maxa, maxb: Integer;
  s: Longint;
  f: Text;
  a, b: array[1..10000] of Integer;
begin
  Randomize;
  Write('n, maxa, maxb = '); Readln(n, maxa, maxb);
  s := 0;
  for i := 1 to n do
    begin
      a[i] := Random(maxa) + 1;
      b[i] := Random(maxb) + 1;
      s := s + a[i];
    end;
  Assign(f, 'BUY.IN0'); Rewrite(f);
  Writeln(f,  3 * s div 4, ' ', n);
  for i := 1 to n do Writeln(f, a[i], ' ', b[i]);
  Close(f);
end.
