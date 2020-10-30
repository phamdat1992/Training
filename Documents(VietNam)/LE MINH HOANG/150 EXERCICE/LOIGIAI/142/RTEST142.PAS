program RandomTest;
var
  f: Text;
  i, j, m, n, c: Integer;
begin
  Writeln('m, n, c: Integer: '); readln(m, n, c);
  Assign(f, 'CARGO.IN0'); Rewrite(f);
  Writeln(f, m, ' ', n, ' ', c);
  for i := 1 to m do
    begin
      for j := 1 to n do
        if Random(4) = 1 then Write(f, '#')
        else Write(f, '.');
      Writeln(f);
    end;
  Close(f);
end.
