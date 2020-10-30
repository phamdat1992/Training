program Recoversequence;
const
  InputFile  = 'RECOVER.INP';
  OutputFile = 'RECOVER.OUT';
  max = 10000;
var
  x, t: array[1..max] of Integer;
  i, j, n, d: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Read(f, t[i]);
  Close(f);
  FillChar(x, SizeOf(x), 0);
  for i := 1 to n do
    begin
      d := 0;
      for j := 1 to n do
        if x[j] = 0 then
          begin
            Inc(d);
            if d = t[i] + 1 then
              begin
                x[j] := i; Break;
              end;
          end;
    end;
  Assign(f, OutputFile); Rewrite(f);
  for i := 1 to n do Write(f, x[i], ' ');
  Close(f);
end.
