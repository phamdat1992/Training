program PhoneNumber;
const
  InputFile  = 'PHONE.INP';
  OutputFile = 'PHONE.OUT';
  max = 100;
  maxW = 50;
type
  TWord = string[maxW];
  PWord = ^TWord;
var
  Code: array['a'..'z'] of Char;
  F: array[1..max, 1..max] of Word;
  B: array[1..100] of Byte;
  Trace: array[1..100] of Byte;
  Index: array[1..100] of Word;
  W: array[1..100] of TWord;
  Source: string[max];
  n, nIndex: Integer;
  fi: Text;

  Time: LongInt absolute 0:$46C;
  Start: LongInt;


procedure Enter;
var
  i: Char;
  j: Integer;
  S: String[26];
begin
  Assign(fi, InputFile); Reset(fi);
  for i := '0' to '9' do
    begin
      Readln(fi, S);
      for j := 1 to Length(S) do Code[S[j]] := i;
    end;
  Readln(fi, Source);
  n := Length(Source);
end;

procedure PutToF(S: TWord; Count: Word);
var
  temp: String[100];
  p: PWord;
  l, i: Integer;
begin
  temp := Source;
  l := Length(S);
  for i := 0 to n - l do
    if f[i + 1, l] = 0 then
      begin
        temp[i] := Chr(l);
        p := @temp[i];
        if p^ = S then f[i + 1, l] := Count;
      end;
end;

procedure ReadFileToF;
var
  S: TWord;
  j: Integer;
  Count: Word;
begin
  FillChar(F, SizeOf(F), 0);
  Count := 0;
  repeat
    Readln(fi, S);
    if S[1] = '#' then Break;
    for j := 1 to Length(S) do S[j] := Code[S[j]];
    Inc(Count);
    PutToF(S, Count);
  until False;
  Close(fi);
end;

procedure Optimize;
var
  i, j: Integer;
begin
  FillChar(B, SizeOf(B), max + 1);
  for i := 1 to n do
    begin
      if F[1, i] <> 0 then
        begin
          B[i] := 1;
          Trace[i] := 0;
        end
      else
        for j := 1 to i - 1 do
          if (F[j + 1, i - j] <> 0) and (B[i] > B[j] + 1) then
            begin
              B[i] := B[j] + 1;
              Trace[i] := j;
            end;
    end;
end;

procedure GetWords;
var
  i, p, OldMin, Min: Word;
  S: TWord;
begin
  Assign(fi, InputFile); Reset(fi);
  for i := 1 to 11 do Readln(fi);
  OldMin := 0; p := 1;
  repeat
    Min := $FFFF;
    for i := 1 to nIndex do
      if (Index[i] > OldMin) and (Index[i] < Min) then Min := Index[i];
    if Min = $FFFF then Break;
    while p < Min do
      begin
        Inc(p); Readln(fi);
      end;
    Inc(p); Readln(fi, S);
    for i := 1 to nIndex do
      if Index[i] = Min then W[i] := S;
    OldMin := Min;
  until False;
  Close(fi);
end;

procedure Result;
var
  Res: string;
  fo: Text;
  t, next: Integer;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  if B[n] = 101 then Writeln(fo, 'NO')
  else
    begin
      Writeln(fo, 'YES');
      nIndex := 0; t := n;
      repeat
        next := Trace[t];
        Inc(nIndex); Index[nIndex] := F[next + 1, t - next];
        t := Next;
      until t = 0;
      GetWords;
      Res := '';
      for t := 1 to nIndex do Res := W[t] + ' ' + Res;
      Dec(Res[0]);
      Writeln(fo, Res);
    end;
  Close(fo);
end;

begin
  Start := Time;
  Enter;
  ReadFileToF;
  Optimize;
  Result;
  Writeln('Time = ', (Time - Start)/18.2:1:2, ' (s)');
end.
oqz
ij
abc
def
gh
kl
mn
prs
tuv
wxy
7325189087
it
your
reality
real
our
teacher
#
