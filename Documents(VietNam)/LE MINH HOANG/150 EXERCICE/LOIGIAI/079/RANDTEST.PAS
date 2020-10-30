program RandomTest;
const
 m = 1000000000;
type
 TLine = array[1..200] of LongInt;
var
 a: array[1..200] of ^TLine;
 n, k, i, j, r: Integer;
 Index: array[1..200] of Integer;
 f: Text;

procedure Create1;
var
 i, j: Integer;
begin
 Writeln('n la so nguoi, viec. k<n la do lon hard test, r % la ti le canh: ');
 Writeln('n, k, r = '); Readln(n, k, r);
 for i := 1 to n do
  for j := 1 to n do a[i]^[j] := -1;
 a[1]^[1] := m;
 for i := 2 to k do
  begin
   a[i]^[i - 1] := 0;
   a[i]^[i] := m;
  end;
 for i := k + 1 to n do
  for j := k + 1 to n do
   if Random(100) < r then a[i]^[j] := Round(Random * m);
 FillChar(Index, SizeOf(Index), 0);
 for i := 1 to n do
  begin
   repeat
    j := Random(n) + 1;
   until Index[j] = 0;
   Index[j] := i;
  end;
 Assign(f, 'ASSIGN.INP'); Rewrite(f);
 Writeln(f, n);
 for i := 1 to n do
  for j := 1 to n do
   if a[i]^[j] <> -1 then
    Writeln(f, Index[i], ' ', Index[j], ' ', a[i]^[j]);
 Close(f);
end;

begin
 Randomize;
 for i := 1 to 200 do New(a[i]);
 Create1;
end.
