{$M 65520 0 655360}
program BurrowsWheelerEncode;
const
  max = 10000;
  CName: array[1..10] of Char = '1234567890';
  CnTest: array[1..10] of Integer = (10, 20, 30, 40, 50, 100, 100, 100, 1, 100);
  Cnmin: array[1..10] of Integer = (5, 5, 5, 5, 5, 10, 10, 100, 9000, 9000);
  Cnmax: array[1..10] of Integer = (15, 20, 30, 40, 50, 1000, 3000, 5000, 9999, 10000);
  CRange: array[1..10] of Integer = (3, 5, 7, 9, 10, 10, 10, 12, 1, 26);
type
  TCharArray = array[1..2 * max] of Char;
  TIntArray = array[1..2 * max] of Integer;
  TArray = array[1..max] of Integer;
var
  a: ^TCharArray;
  c: ^TIntArray;
  Index: array[1..max] of Integer;
  n, nTest, nmin, nmax, Range: Integer;
  start: LongInt;
  Time: LongInt absolute 0:$46C;
  fOut: Text;
  count, ctest: Integer;
  OutputFile: String;

procedure Openfile;
begin
  New(a); New(c);
  Assign(fOut, OutputFile); Rewrite(fOut);
end;

procedure CloseFile;
begin
  Dispose(a); Dispose(c);
  Close(fOut);
end;

procedure Enter;
var
  i: Integer;
begin
  n := nmin + Random(nmax - nmin + 1);
  for i := 1 to n do a^[i] := Chr(Random(Range) + Ord('a'));
end;

procedure Init;
var
  i, m, j: Integer;
begin
  Move(a^[1], a^[n + 1], n * SizeOf(a^[1]));
  m := 2 * n - 1;
  for i := 1 to n do
    begin
      if (i = 1) or (a^[i] <> a^[i - 1]) then j := i
      else j := i - 1 + c^[i - 1];
      while (j < i + n) and (a^[j] = a^[i]) do Inc(j);
      c^[i] := j - i;
    end;
  for i := 1 to n do Index[i] := i;
end;

function Compare(x, y: Integer): Integer;
var
  i, jump, totaljump: Integer;
begin
  if x = 0 then
    begin
      Compare := -1; Exit;
    end
  else
    if y = 0 then
      begin
        Compare := 1; Exit;
      end;
  totaljump := 0;
  repeat
    if a^[x] <> a^[y] then
      begin
        if a^[x] > a^[y] then Compare := 1
        else Compare := -1;
        Exit;
      end;
    if c^[x] < c^[y] then jump := c^[x]
    else jump := c^[y];
    x := x + jump; y := y + jump;
    if x > n then x := x - n;
    if y > n then y := y - n;
    totaljump := totaljump + jump;
  until totaljump >= n;
  Compare := 0;
end;

procedure InsertionSortByIndex;
var
  i, V, inf, sup, median: Integer;
  Sign: Integer;
begin
  for i := 2 to n do
    begin
      V := Index[i];
      inf := 0; sup := i;
      repeat
        median := (inf + sup) shr 1;
        Sign := Compare(Index[median], V);
        if Sign = 1 then sup := median
        else inf := median;
      until inf + 1 >= sup;
      if sup <> i then
        begin
          Move(Index[sup], Index[sup + 1], (i - sup) * SizeOf(Index[1]));
          Index[sup] := V;
        end;
    end;
end;

procedure Result;
var
  i: Integer;
begin
  for i := 1 to n do Write(fOut, a^[Index[i] + n - 1]);
  Writeln(fOut);
  for i := 1 to n do
    if Index[i] = 1 then Break;
  Writeln(fOut, i);
end;

begin
  for count := 1 to 10 do
    begin
      Outputfile := 'DECODE.IN' + CName[count];
      Writeln(OutputFile);
      nTest := CnTest[count];
      nMin := CnMin[count];
      nMax := CnMax[count];
      Range := CRange[count];
      OpenFile;
      for ctest := 1 to nTest do
        begin
          Enter;
          Init;
          InsertionSortByIndex;
          Result;
        end;
      CloseFile;
    end;
end.
