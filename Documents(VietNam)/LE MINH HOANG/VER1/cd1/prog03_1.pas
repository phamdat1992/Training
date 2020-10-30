program BinaryStrings;
const
  max = 30;
var
  x: array[1..max] of Integer;
  n: Integer;

procedure PrintResult;
var
  i: Integer;
begin
  for i := 1 to n do Write(x[i]);
  Writeln;
end;

procedure Try(i: Integer);
var
  j: Integer;
begin
  for j := 0 to 1 do
    begin
      x[i] := j;
      if i = n then PrintResult
      else Try(i + 1);
    end;
end;

begin
  Assign(Input, 'BSTR.INP'); Reset(Input);
  Assign(Output, 'BSTR.OUT'); Rewrite(Output);
  Readln(n);
  Try(1);
  Close(Input);
  Close(Output);
end.
