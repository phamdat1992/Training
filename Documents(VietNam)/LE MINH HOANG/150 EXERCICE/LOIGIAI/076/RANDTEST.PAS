program RandomTest;
const
 na: array[1..10] of Integer =
  (4, 10, 100, 1000, 2000, 3000, 4000, 7000, 9999, 10000);
 ma: array[1..10] of Integer =
  (10, 100, 200, 300, 1000, 10000, 10000, 10000, 10000, 10000);
 Inp: String = 'GUEST.IN';
 S: array[1..10] of Char = '1234567890';
type
 TList = array[1..10000] of Integer;
var
 f: Text;
 c, p, index: TList;
 i, n: Integer;
 InputFile: String;

procedure Create(n, m: Integer);
var
 i, j, i1, i2: Integer;
begin
 FillChar(index, SizeOf(index), 0);
 for i := 1 to n do
  begin
   repeat
    j := Random(n) + 1;
   until index[j] = 0;
   index[j] := i;
  end;
 for i := 2 to n do
  begin
   c[Index[i]] := Random(m);
   p[Index[i]] := Index[Random(i - 2) + 1];
  end;
 p[Index[1]] := 0; c[Index[1]] := Random(m);
 Assign(f, InputFile); Rewrite(f);
 Writeln(f, n);
 for i := 1 to n do
  Writeln(f, p[i], ' ', c[i]);
 Close(f);
end;

procedure Save(n: Integer);
var
 i: Integer;
begin
 Assign(f, InputFile); Rewrite(f);
 Writeln(f, n);
 for i := 1 to n do
  Writeln(f, (i + 1) mod (n + 1), ' ', 10000);
 Close(f);
end;

begin
 Randomize;
 for i := 1 to 10 do
  begin
   InputFile := Inp + S[i];
   Writeln(InputFile);
   if i <> 9 then Create(na[i], ma[i])
   else Save(na[i]);
  end;
end.
