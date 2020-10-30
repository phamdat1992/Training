program Analyses;
const
  max = 30;
var
  n: Integer;
  x: array[0..max] of Integer;
  t: array[0..max] of Integer;

procedure Init;
begin
  Readln(n);
  x[0] := 1;
  t[0] := 0;
end;

procedure PrintResult(k: Integer);
var
  i: Integer;
begin
  Write(n,' = ');
  for i := 1 to k - 1 do Write(x[i], '+');
  Writeln(x[k]);
end;

procedure Try(i: Integer);
var
  j: Integer;
begin
  for j := x[i - 1] to (n - T[i - 1]) div 2 do
    begin
      x[i] := j;
      t[i] := t[i - 1] + j;
      Try(i + 1);
    end;
  x[i] := n - T[i - 1];
  PrintResult(i);
end;

begin
  Assign(Input, 'ANALYSE.INP'); Reset(Input);
  Assign(Output, 'ANALYSE.OUT'); Rewrite(Output);
  Init;
  Try(1);
  Close(Input);
  Close(Output);
end.
