var
  f: Text;
  x, y: array[1..1000] of Extended;
  a: Extended;
  n, k, i: Integer;

function Check(i: Integer): Boolean;
var
  j: Integer;
begin
  for j := 1 to i - 1 do
    if Sqrt(Sqr(x[i] - x[j]) + Sqr(y[i] - y[j])) < 2 then
      begin
        Check := False;
        Exit;
      end;
  Check := True;
end;

begin
  Randomize;
  Assign(f, 'TELECOM.IN0'); Rewrite(f);
  Write('n = '); Readln(n);
  for i := 1 to n do
    repeat
      x[i] := Random * 20000 - 10000;
      y[i] := Random * 20000 - 10000;
    until Check(i);
{  for i := 1 to n do
    begin
      a := i / n * 2 * Pi;
      x[i] := cos(a) * 10000;
      y[i] := sin(a) * 10000;
    end;}
  Writeln(f, n);
  for i := 1 to n do Writeln(f, x[i], ' ', y[i]);
  Close(f);
end.
