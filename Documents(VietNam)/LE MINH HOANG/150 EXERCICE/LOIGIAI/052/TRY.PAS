program Try;
const
  InputFile  = 'NUMBER.INP';
  OutputFile = 'NUMBER.TXT';
var
  n, k, i, j, Count: LongInt;
  f: Text;
  s: string;

function Check(i: LongInt): Boolean;
var
  c: Integer;
begin
  c := 0;
  repeat
    if not Odd(i) then Inc(c);
    i := i shr 1;
  until (i = 0) or (c > k);
  Check := c = k;
end;

begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, k);
  Close(f);
  Assign(f, OutputFile); Rewrite(f);
  Count := 0;
  for i := 1 to n do
    if Check(i) then
      begin
        Inc(Count);
        s := '';
        j := i;
        repeat
          if Odd(j) then s := '1' + s
          else s := '0' + s;
          j := j shr 1;
        until j = 0;
        Writeln(f, Count:5, ')', i:5, ' = ', s);
      end;
  Close(f);
  Writeln('Number of Result: ', Count);
end.