program RandomTest;
var
  f: Text;
  k, i, n, max: Integer;
begin
  Randomize;
  Write('n, max = '); Readln(n, max);
  Assign(f, 'SZERO.IN0'); Rewrite(f);
  Writeln(f, n);
  for i := 1 to n do
    begin
      k := Random(max + 1);
      if Random(2) = 1 then k := - k;
      Write(f, k, ' ');
    end;
  Close(f);
end.