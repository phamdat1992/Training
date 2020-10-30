program Analyse1;
const
  max = 100;
var
  F: array[0..max, 0..max] of LongInt;
  n, m, v: Integer;
begin
  Write('n = '); Readln(n);
  FillChar(F[0], SizeOf(F[0]), 0);
  F[0, 0] := 1;
  for m := 1 to n do
    for v := 0 to n do
      if v < m then F[m, v] := F[m - 1, v]
      else F[m, v] := F[m - 1, v] + F[m, v - m];
  Writeln(F[n, n], ' Analyses');
end.
