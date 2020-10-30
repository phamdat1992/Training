program FibinacciString;
const
  InputFile  = 'FIBISTR.IN0';
  OutputFile = 'FIBISTR.OUT';
  max = 35;
var
  S: array[1..13] of String;
  F: array[1..40] of LongInt;
  OddCenter, EvenCenter: String;
  OddCount, EvenCount, OddP, EvenP: Integer;
  n, l: Integer;
  Source: String;
  tmp: Char;
  fi, fo: Text;

function Count(S: String): Integer; {How many Source in S}
var
  i, c: Integer;
  p: ^String;
begin
  c := 0;
  for i := 0 to Length(S) - l do
    begin
      S[i] := Chr(l);
      p := @S[i];
      if p^ = Source then Inc(c);
    end;
  Count := c;
end;

procedure CommonInit;
var
  i: Integer;
begin
  S[1] := 'A';
  S[2] := 'B';
  for i := 3 to 13 do
    S[i] := S[i - 1] + S[i - 2];
  OddCenter := S[12] + S[11];
  EvenCenter := S[11] + S[10];
  OddP := Length(S[12]) + 1;
  EvenP := Length(S[11]) + 1;
end;

function Solve: LongInt;
var
    i, k, t: Integer;
begin
  l := Length(Source);
  t := l - 1;
  k := 1;
  while Length(S[k]) < l do Inc(k);
  FillChar(F, k shl 2, 0);
  F[k] := Count(S[k]);
  F[k + 1] := Count(S[k + 1]);
  if n <= k + 1 then
    begin
      Solve := F[n];
      Exit;
    end;
  OddCount := Count(Copy(OddCenter, OddP - t, t + t));
  EvenCount := Count(Copy(EvenCenter, EvenP - t, t + t));
  for i := k + 2 to n do
    if Odd(i) then F[i] := F[i - 1] + F[i - 2] + OddCount
    else F[i] := F[i - 1] + F[i - 2] + EvenCount;
  Solve := F[n];
end;

begin
  CommonInit;
  Assign(fi, InputFile); Reset(fi);
  Assign(fo, OutputFile); Rewrite(fo);
  while not SeekEof(fi) do
    begin
      Readln(fi, n, tmp, Source);
      Writeln(fo, Solve);
    end;
  Close(fi);
  Close(fo);
end.
