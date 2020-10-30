program Combinations;
const
  max = 30;
var
  x: array[0..max] of Integer;
  n, k: Integer;

procedure PrintResult;
var
  i: Integer;
begin
  Write('{');
  for i := 1 to k - 1 do Write(x[i], ', ');
  Writeln(x[k], '}');
end;

procedure Try(i: Integer);
var
  j: Integer;
begin
  for j := x[i - 1] + 1 to n - k + i do
    begin
      x[i] := j;
      if i = k then PrintResult
      else Try(i + 1);
    end;
end;

begin
  Assign(Input, 'SUBSET.INP'); Reset(Input);
  Assign(Output, 'SUBSET.OUT'); Rewrite(Output);
  Readln(n, k);
  x[0] := 0;
  Try(1);
  Close(Input); Close(Output);
end.
