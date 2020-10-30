program Analyse4;
const
  max = 100;
var
  L: array[0..max] of LongInt; 
  n, m, v: Integer;
begin
  Write('n = '); Readln(n);
  FillChar(L, SizeOf(L), 0);
  L[0] := 1; 
  for m := 1 to n do 
    for v := m to n do 
      L[v] := L[v] + L[v - m]; 
  Writeln(L[n], ' Analyses');
end.
