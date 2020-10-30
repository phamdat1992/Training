program Analyse3;
const
  max = 100;
var
  B: array[1..2, 0..max] of LongInt;
  n, m, v, x, y: Integer;
begin
  Write('n = '); Readln(n);
  FillChar(B[1], SizeOf(B[1]), 0);
  B[1][0] := 1;
  x := 1; y := 2;
  for m := 1 to n do
    begin
      for v := 0 to n do
        if v < m then B[y][v] := B[x][v]
        else B[y][v] := B[x][v] + B[y][v - m];
      x := 3 - x; y := 3 - y;
    end;
  Writeln(B[x][n], ' Analyses');
end.
