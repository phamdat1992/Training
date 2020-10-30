{$R-,S-,Q-}
program TestPhoneNumber;
uses Crt, Visual;
const
  InputFile: String = 'PHONE.IN';
  OutputFile = 'PHONE.OUT';
  STDFile = 'PHONE.TXT';
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

  f1, f2: Text;
  ch: Char;

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
  Assign(fo, STDFile); Rewrite(fo);
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

procedure Halt;
begin
  {$I-}
  Close(f1); If IOresult = 0 then;
  Close(f2); If IOResult = 0 then;
  Close(fi); If IOResult = 0 then;
  {$I+}
  ReadKey;
  System.Halt;
end;

procedure WriteP(p: Integer);
var
  f: file of Integer;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Integer;
var
  f: file of Integer;
  P: Integer;
begin
  {$I-}
  Assign(f, 'POINT.PNT'); Reset(f);
  if IOResult <> 0 then
    begin
      WriteP(0);
      Reset(f);
    end;
  {$I+}
  Read(f, p);
  Close(f);
  ReadP := p;
end;

procedure ShowP;
var
  S: String;
begin
  Str(ReadP, S);
  if Length(S) < 2 then S := '0' + S;
  Visual.Color := 30;
  MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Writeln('KÕt qu¶ chÝnh x¸c!');
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
  ShowP;
  Halt;
end;

procedure Refine(var s: String);
var
  i: Integer;
begin
  for i := 1 to Length(s) do
    if not (s[i] in ['a'..'z']) then s[i] := ' ';
  s := ' ' + s + ' ';
  for i := Length(S) downto 2 do
    if (S[i] = ' ') and (S[i - 1] = ' ') then Delete(S, i, 1);
end;

procedure AskTest;
var
  S: String[1];
begin
  Caption('Bµi 072: "C¸c sè ®iÖn tho¹i"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      S := ParamStr(1);
      ch := S[1];
    end
  else  ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  f1, f2: Text;
  t, s1, s2: String;
  i, c: Integer;
begin
  Caption('Bµi 072: "C¸c sè ®iÖn tho¹i"');
  Color := 159;
  Frame(4, 8, 76, 24, 'KiÓm tra');
  Assign(f1, STDFile); Reset(f1);
  Assign(f2, OutputFile); Reset(f2);
  Readln(f1, s1); Readln(f2, s2);
  Writeln('Dßng ®Çu tiªn:');
  Writeln('  + KÕt qu¶ ®óng:  ', s1);
  Writeln('  + KÕt qu¶ HS  :  ', s2);
  if s1 <> s2 then Wrong;
  if s1 = 'NO' then Correct;
  Readln(f1, s1); Readln(f2, s2);
  Refine(s1); Refine(S2);
  Writeln;
  Writeln('Dßng thø hai');
  Writeln('+ KÕt qu¶ ®óng: ''', s1, '''');
  Writeln('+ KÕt qu¶ HS  : ''', s2, '''');
  if s1 = s2 then Correct;
  t := '';
  Writeln;
  Writeln('KiÓm tra sè ®iÖn tho¹i');
  Writeln('  + Sè ®iÖn tho¹i ®óng: ', Source);
  for i := 1 to Length(s2) do
    if s2[i] <> ' ' then t := t + Code[S2[i]];
  Writeln('  + Sè ®iÖn tho¹i HS  : ', t);
  if t <> Source then
    begin
      Writeln('Sè ®iÖn tho¹i sai');
      Wrong;
    end;
  if Length(s1) <> Length(s2) then
    begin
      Writeln('Sè tõ kh«ng ®óng!');
      Wrong;
    end;
  Close(f1); Close(f2);
  Assign(fi, InputFile); Reset(fi);
  for i := 1 to 11 do Readln(fi);
  repeat
    Readln(fi, t);
    if t[1] = '#' then Break;
    i := Pos(' ' + t + ' ', s2);
    if i <> 0 then Delete(s2, i + 1, Length(t) + 1);
    if s2 = ' ' then Correct;
  until False;
  Writeln('Cac tu khong co trong tu dien: ');
  Writeln(s2);
  Wrong;
end;

begin
  AskTest;
  Enter;
  ReadFileToF;
  Optimize;
  Result;
  Test;
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
