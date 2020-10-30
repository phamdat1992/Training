program Binary_Strings;
const
  max = 30;
var
  x: array[1..max] of Integer;
  n, i: Integer;
begin
  Assign(Input, 'BSTR.INP'); Reset(Input);
  Assign(Output, 'BSTR.OUT'); Rewrite(Output);
  Readln(n);
  FillChar(x, SizeOf(x), 0);
  repeat
    for i := 1 to n do Write(x[i]);
    Writeln;
    i := n;
    while (i > 0) and (x[i] = 1) do Dec(i);
    if i > 0 then
      begin
        x[i] := 1;
        FillChar(x[i + 1], (n - i) * SizeOf(x[1]), 0);
      end;
  until i = 0;
  Close(Input); Close(Output);
end.
