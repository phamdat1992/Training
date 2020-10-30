var
  a, b: string;
  m, n: Integer;
  f: text;

function RandomChar: Char;
begin
  RandomChar := Chr(65 + Random(3));
end;

function RandomS(l: Integer): string;
var
  s: string;
  i: Integer;
begin
  s := '';
  for i := 1 to l do s := s + RandomChar;
  RandomS := s;
end;

begin
  Randomize;
  Write('m, n = '); Readln(m, n);
  Assign(f, 'SUBSTR.IN0'); Rewrite(f);
  b := RandomS(n);
  a := b;
  while Length(a) < m do Insert(RandomChar, a, Random(Length(a) + 1) + 1);
  Writeln(f, a);
  Writeln(f, b);
  Close(f);
end.