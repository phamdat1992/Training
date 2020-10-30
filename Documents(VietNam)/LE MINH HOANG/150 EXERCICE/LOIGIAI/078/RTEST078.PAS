program Randomtest;
const
 na: array[1..10] of Integer =
    (10, 20, 100, 1000, 2000, 5000, 7000, 8000, 9999, 10000);
 ma: array[1..10] of Integer =
    (3, 5, 10, 100, 200, 500, 700, 800, 99, 100);
 name: array[1..10] of Char = '1234567890';
var
 p, index: array[1..10000] of Integer;
 i: Integer;
 inp: String;

procedure Create(n, m: Integer; Filename: String);
var
 i, j: Integer;
 f: Text;
begin
 for i := m + 1 to n do p[i] := Random(m) + 1;
 for i := 2 to m do p[i] := i - 1;
 p[1] := 0;
 FillChar(Index, SizeOf(Index), 0);
 for i := 1 to n do
  begin
   repeat
    j := Random(n) + 1;
   until Index[j] = 0;
   Index[j] := i;
  end;
 Assign(f, Filename); Rewrite(f);
 Writeln(f, n);
 for i := 2 to n  do
  Writeln(f, Index[i], ' ', Index[p[i]]);
 Close(f);
end;

begin
 for i := 1 to 10 do
  begin
   INP := 'CHAIN.IN' + name[i];
   Writeln(Inp);
   Create(na[i], ma[i], Inp);
  end;
end.
