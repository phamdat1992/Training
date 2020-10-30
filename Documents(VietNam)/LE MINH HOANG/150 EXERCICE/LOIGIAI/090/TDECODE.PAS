{$M 65520 0 655360}
program EncodeBurrowsWheelerTest;
uses crt, visual;
const
  TestFile  = 'DECODE.OUT';
  InputFile = 'DECODE.INP';
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
  if IOResult = 0 then Erase(fTest);
  Close(fInp);
  if IOResult = 0 then
  {$I+}
end;

procedure Enter;
begin
  n := 0;
  while not SeekEoln(fInp) do
    begin
      Inc(n);
      Read(fInp, a[n]);
    end;
  Readln(fInp);
  Readln(fInp, code);
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
      if SeekEoln(fTest) then c[i] := #255
      else Read(fTest, c[i]);
      if c[i] <> b[i] then
        begin
          Readln(fTest);
          Writeln('Sai!'#7);
          Exit;
        end;
    end;
  if not SeekEoln(fTest) then Writeln('Sai'#7)
  else
    begin
      Writeln('ßÛng');
      Inc(Point);
    end;
  Readln(fTest);
end;

begin
  Color := 159;
  Caption('Ch m ph«n: "Gi∂i m∑"');
  Frame(3, 8, 77, 22, 'Ki”m tra k’t qu∂');
  OpenFile;
  count := 0; Point := 0;
  while not SeekEof(fInp) do
    begin
      Inc(count);
      Write('           * Test th¯: ', count:4, '...');
      Enter;
      DistributionCounting;
      Result;
    end;
  CloseFile;
  Color := 47; Str(Point:4, S);
  MSG(40, 3, 'TÊng Æi”m: ', 'Bπn c„ t t c∂ ' + S + '/ 100 Æi”m');
  ReadKey;
  Default;
  TextAttr := 7; Clrscr;
end.
