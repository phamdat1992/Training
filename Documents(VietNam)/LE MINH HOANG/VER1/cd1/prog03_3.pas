program Arranges;
const
  max = 20;
var
  x: array[1..max] of Integer;
  c: array[1..max] of Boolean;
  n, k: Integer;

procedure PrintResult;
var
  i: Integer;
begin
  for i := 1 to k do Write(x[i],' ');
  Writeln;
end;

procedure Try(i: Integer);
var
  j: Integer;
begin
  for j := 1 to n do
    if c[j] then
      begin
        x[i] := j;
        if i = k then PrintResult
        else
          begin
            c[j] := False;
            Try(i + 1);
            c[j] := True;
          end;
      end;
end;

begin
  Assign(Input, 'ARRANGES.INP'); Reset(Input);
  Assign(Output, 'ARRANGES.OUT'); Rewrite(Output);
  Readln(n, k);
  FillChar(c, SizeOf(c), True);
  Try(1);
  Close(Input); Close(Output);
end.
