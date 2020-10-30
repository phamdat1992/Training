program RandomTest;
var
  f: Text;
  k, m, n, i, j, S: Integer;

begin
  Randomize;
  Write('m, n, C, S: '); Readln(m, n, C, S);
  Assign(f, 'TRAFFIC.INP'); Rewrite(f);
  Writeln(f, m, ' ', n, ' ', C, ' ', S);
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          if (i = 1) and (j = 1) or
             (i = m) and (j = n) then k := 0
          else k := Random(101);
          Write(f, k:3, ' ');
        end;
      Writeln(f);
    end;
  Close(f);
end.