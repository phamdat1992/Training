var
 S: array[1..13] of string;
 i, l: Byte;
 source: string;
function Count(S: String): Byte; {How many Source in S}
var
 i, c: Byte;
 p: ^String;
begin
 c := 0;
 if Length(S) >= l then
  for i := 0 to Length(S) - l do
   begin
    S[i] := Chr(l);
    p := @S[i];
    if p^ = Source then Inc(c);
   end;
 Count := c;
end;


begin
 s[1] := 'A'; s[2] := 'B';
 for i := 3 to 13 do s[i] := s[i - 1] + s[i - 2];
 source := 'BABABB';
 l := Length(Source);
 for i := 1 to 13 do Writeln(Count(S[i]));
end.
A
B
BA
BAB
BABBA
BABBABAB
BABBABABBABBA
xxxxxxxxxxxx
   xxxxxxxxxxxx
