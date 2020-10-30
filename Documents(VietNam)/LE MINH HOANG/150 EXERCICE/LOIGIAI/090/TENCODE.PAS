{$M 65520 0 655360}
program EncodeBurrowsWheelerTest;
uses crt, visual;
const
  TestFile  = 'ENCODE.OUT';
  InputFile = 'ENCODE.INP';
  max = 10000;
var
  a: array[1..max] of Char;
  Index: array[1..max] of Integer;
  count, n, code: Integer;
  fTest, fInp: Text;
  Point: Integer;
  S: String;

procedure OpenFile;
begin
  Assign(fTest, TestFile); Reset(fTest);
  Assign(fInp, InputFile); Reset(fInp);
end;

procedure CloseFile;
begin
  {$I-}
  Close(fTest);
  if IOResult = 0 then
  Close(fInp);
  if IOResult = 0 then
  {$I+}
end;

procedure Enter;
begin
  n := 0;
  while not SeekEoln(fTest) do
    begin
      Inc(n);
      Read(fTest, a[n]);
    end;
  Readln(fTest);
  Readln(fTest, code);
end;

procedure DistributionCounting;
var
  c: array[Char] of Integer;
  i: Integer;
  V: Char;
begin
  FillChar(c, SizeOf(c), 0);
  for i := 1 to n do Inc(c[a[i]]);
  for V := #1 to #255 do c[V] := c[Pred(V)] + c[V];
  for i := n downto 1 do
    begin
      V := a[i];
      Index[c[V]] := i;
      Dec(c[V]);
    end;
end;

procedure Result;
var
  i, t: Integer;
  b, c: array[1..max] of Char;
begin
  t := Code;
  for i := 1 to n do
    begin
      t := Index[t];
      b[i] := a[t];
    end;
  for i := 1 to n do
    begin
      if SeekEoln(fInp) then c[i] := #255
      else Read(fInp, c[i]);
      if c[i] <> b[i] then
        begin
          Readln(fInp);
          Writeln('Sai!'#7);
          Exit;
        end;
    end;
  if not SeekEoln(fInp) then Writeln('Sai'#7)
  else
    begin
      writeln('ßÛng');
      Inc(Point);
    end;
  Readln(fInp);
end;

begin
  Color := 159;
  Caption('Ch m ph«n: "M∑ ho∏"');
  Frame(3, 8, 77, 22, 'Ki”m tra k’t qu∂');
  OpenFile;
  count := 0; Point := 0;
  while not SeekEof(fTest) do
    begin
      Inc(count);
      Write('           * Test th¯: ', count:4, '...');
      Enter;
      if (code < 1) or (code > n) then
        begin
          Readln(fInp); Writeln('Sai'#7);
        end
      else
        begin
          DistributionCounting;
          Result;
        end;
    end;
  CloseFile;
  Color := 47; Str(Point:4, S);
  MSG(40, 3, 'TÊng Æi”m: ', 'Bπn c„ t t c∂ ' + S + '/ 100 Æi”m');
  ReadKey;
  Default;
  TextAttr := 7; Clrscr;
end.
