program RandomTest;
var
  f: Text;
  n, i: Integer;

procedure RandomS;
var
  i: Integer;
begin
  n := 9 + Random(10);
  for i := 1 to n do Write(f, Chr(Random(26) + 65));
  Writeln(f);
end;

begin
  Randomize;
  Assign(f, 'Encode.Inp'); Rewrite(f);
  for i := 1 to 97 do RandomS;
  for i := 1 to 100 do Write(f, 'A');
  Writeln(f);
  for i := 1 to 100 do
   if i <> 50 then Write(f, 'A')
   else Write(f, 'B');
  Writeln(f);
  for i := 0 to 99 do
   Write(f, Chr(i mod 26 + 65));
  Close(f);
end.
