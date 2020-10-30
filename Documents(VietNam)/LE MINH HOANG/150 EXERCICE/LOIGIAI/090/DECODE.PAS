program DecodeBurrowsWheeler;
const
  InputFile  = 'DECODE.INP';
  OutputFile = 'DECODE.OUT';
  max = 10000;
var
  a: array[1..max] of Char;
  Index: array[1..max] of Integer;
  n, code: Integer;
  fInp, fOut: Text;

procedure OpenFile;
begin
  Assign(fInp, InputFile); Reset(fInp);
  Assign(fOut, OutputFile); Rewrite(fOut);
end;

procedure CloseFile;
begin
  Close(fInp); Close(fOut);
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
begin
  t := Code;
  for i := 1 to n do
    begin
      t := Index[t];
      Write(fOut, a[t]);
    end;
  Writeln(fOut);
end;

begin
  OpenFile;
  while not SeekEof(fInp) do
    begin
      Enter;
      DistributionCounting;
      Result;
    end;
  CloseFile;
end.
