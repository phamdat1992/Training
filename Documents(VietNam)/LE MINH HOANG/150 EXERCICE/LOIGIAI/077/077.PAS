program Recover;
const
  InputFile  = 'BRACKETS.INP';
  OutputFile = 'BRACKETS.OUT';
  max = 10000;
var
  c: array[1..max + max] of Char;
  k, i, n: Integer;
  fr, fw: Text;
begin
  Assign(fr, InputFile); Reset(fr);
  Assign(fw, OutputFile); Rewrite(fw);
  Readln(fr, n);
  FillChar(c, 2 * n, '?');
  for i := 1 to 2 * n do
    begin
      if c[i] = '?' then
        begin
          Read(fr, k); c[i] := '('; c[i + k + 1] := ')';
        end;
      Write(fw, c[i]);
    end;
  Close(fr); Close(fw);
end.
