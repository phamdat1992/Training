{$M 65520 0 655360}
program BurrowsWheelerEncode;
const
  InputFile  = 'ENCODE.INP';
  OutputFile = 'ENCODE.OUT';
  max = 10000;
type
  TCharArray = array[1..2 * max] of Char;
  TIntArray = array[1..2 * max] of Integer;
  TArray = array[1..max] of Integer;
var
  a: ^TCharArray;
  c: ^TIntArray;
  Index: array[1..max] of Integer;
  n: Integer;
  start: LongInt;
  Time: LongInt absolute 0:$46C;
  fInp, fOut: Text;

procedure Openfile;
begin
  New(a); New(c);
  Assign(fInp, InputFile); Reset(fInp);
  Assign(fOut, OutputFile); Rewrite(fOut);
end;

procedure CloseFile;
begin
  Dispose(a); Dispose(c);
  Close(fInp);  Close(fOut);
end;

procedure Enter;
begin
  n := 0;
  while not SeekEoln(fInp) do
    begin
      Inc(n);
      Read(fInp, a^[n]);
    end;
  Readln(fInp);
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
  Start := Time;
  OpenFile;
  while not SeekEof(fInp) do
    begin
      Enter;
      Init;
      InsertionSortByIndex;
      Result;
    end;
  CloseFile;
  Writeln(Time - Start);
end.
yesterday
all
my
troubles
seemed
so
far
away