program Combination;
const
  InputFile  = 'SUBSET.INP';
  OutputFile = 'SUBSET.OUT';
  max = 30;
var
  x: array[1..max] of Integer;
  n, k, i, j: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n, k);
  Close(f);
  Assign(f, OutputFile); Rewrite(f);
  for i := 1 to k do x[i] := i;
  repeat
    Write(f, '{');
    for i := 1 to k - 1 do Write(f, x[i], ', ');
    WriteLn(f, x[k], '}');
    i := k;
    while (i > 0) and (x[i] = n - k + i) do Dec(i);
    if i > 0 then
      begin
        Inc(x[i]);
        for j := i + 1 to k do x[j] := x[j - 1] + 1;
      end;
  until i = 0;
  Close(f);
end.
