type
 T = array[1..30000] of Word;
 P = ^T;
var
 n: Word;
 a, b: P;
 Count: LongInt;
procedure Init;
var
 i: Word;
begin
 Write('n = '); Readln(n);
 New(a); New(b);
 for i := 1 to 2 * n do a^[i] := i;
 Count := 0;
end;

procedure Insert;
var
 f: Boolean;
 i: Word;
begin
 f := True;
 for i := 1 to n do
  begin
   b^[i * 2 - 1] := a^[n + i];
   b^[i * 2] := a^[i];
  end;
 a^ := b^;
end;

procedure Print;
var
 i: Word;
begin
 Inc(Count); Write(Count, ')  ');
{ for i := 1 to 2 * n do Write(a^[i]:3, ' ');}
 for i := 1 to 2 * n do
  if a^[i] = 1 then Write(i:3, ' ');
end;

function OK: Boolean;
var
 i: Word;
begin
 for i := 1 to 2 * n do
  if a^[i] <> i then
   begin
    OK := False;
    Exit;
   end;
 OK := True;
end;

begin
 Init;
 repeat
  Insert;
  Print;
 until OK;
end.
