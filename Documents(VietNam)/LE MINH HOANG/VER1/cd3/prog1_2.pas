program Analyse2;
const
  max = 100;
var
  Current, Next: array[0..max] of LongInt;
  n, m, v: Integer;
begin
  Write('n = '); Readln(n);
  FillChar(Current, SizeOf(Current), 0);
  Current[0] := 1;
  for m := 1 to n do
    begin
      for v := 0 to n do
        if v < m then Next[v] := Current[v]
        else Next[v] := Current[v] + Next[v - m];
      Current := Next;
    end;
  Writeln(Current[n], ' Analyses');
end.
