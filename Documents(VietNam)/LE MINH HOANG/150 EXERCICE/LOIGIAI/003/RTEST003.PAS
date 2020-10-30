program RandomTest;
var
 m, n, i, j, k: Integer;
 Map: array[1..80, 1..80] of Char;
 f: Text;

procedure PutChar(Ch: Char);
var
 i, j: Integer;
begin
 repeat
  i := Random(m) + 1;
  j := Random(n) + 1;
 until Map[i, j] in ['.', 'C'];
 Map[i, j] := ch;
end;

begin
 Write('m, n = '); Readln(m, n);
 Write('Mat do (%): '); Readln(k);
 FillChar(Map, SizeOf(Map), '.');
 Randomize;
 for i := 1 to m do
  for j := 1 to n do
   if Random(101) < k then Map[i, j] := '#';
 PutChar('*');
 PutChar('@');
 Putchar('$');
 Assign(f, 'CARGO.IN5'); Rewrite(f);
 Writeln(f, m, ' ', n);
 for i := 1 to m do
  begin
   for j := 1 to n do Write(f, Map[i, j]);
   Writeln(f);
  end;
 Close(f);
end.
