program RandomTest;
var
  f: Text;
  n, i: Integer;

procedure RandomS;
var
  i: Integer;
begin
  n := 9000 + Random(1001);
  for i := 1 to n do Write(f, Chr(Random(26) + 65));
  Writeln(f);
end;

begin
  Randomize;
  Assign(f, 'Encode.Inp'); Rewrite(f);
  for i := 1 to 97 do RandomS;
  for i := 1 to 10000 do Write(f, 'A');
  Writeln(f);
  for i := 1 to 10000 do
   if i <> 50000 then Write(f, 'A')
   else Write(f, 'B');
  Writeln(f);
  for i := 0 to 999 do
   Write(f, Chr(i mod 26 + 65));
  Close(f);
end.
