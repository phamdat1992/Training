program Binary_Strings;
const
  InputFile  = 'BSTR.INP';
  OutputFile = 'BSTR.OUT';
  max = 30;
var
  x: array[1..max] of Integer;
  n, i: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n);
  Close(f);
  Assign(f, OutputFile); Rewrite(f);
  FillChar(x, SizeOf(x), 0);
  repeat
    for i := 1 to n do Write(f, x[i]);
    WriteLn(f);
    i := n;
    while (i > 0) and (x[i] = 1) do Dec(i);
    if i > 0 then
      begin
        x[i] := 1;
        FillChar(x[i + 1], (n - i) * SizeOf(x[1]), 0);
      end;
  until i = 0;
  Close(f);
end.
