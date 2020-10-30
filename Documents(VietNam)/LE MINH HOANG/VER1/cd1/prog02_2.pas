program Combinations;
const
  max = 30;
var
  x: array[1..max] of Integer;
  n, k, i, j: Integer;
begin
  Assign(Input, 'SUBSET.INP'); Reset(Input);
  Assign(Output, 'SUBSET.OUT'); Rewrite(Output);
  Readln(n, k);
  for i := 1 to k do x[i] := i;
  repeat
    Write('{');
    for j := 1 to k - 1 do Write(x[j], ', ');
    Writeln(x[k], '}');
    i := k;
    While (i > 0) and (x[i] = n - k + i) do Dec(i);
    if i > 0 then
      begin
        Inc(x[i]);
        for j := i + 1 to k do x[j] := x[j - 1] + 1;
      end;
  until i = 0;
  Close(Input); Close(Output);
end.
