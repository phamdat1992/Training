program RandomTest;
var
  f: Text;
  k, i, n, max: LongInt;
begin
  Randomize;
  Write('n, max = '); Readln(n, max);
  Assign(f, 'SEGMENT.IN3'); Rewrite(f);
  Writeln(f, n);
  for i := 1 to n do
    begin
      k := Random(max + 1);
      if Random(5) > 0 then k := - k;
      Write(f, k, ' ');
    end;
  Close(f);
end.