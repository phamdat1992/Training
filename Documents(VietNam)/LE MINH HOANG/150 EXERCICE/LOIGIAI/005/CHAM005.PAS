program FibinacciString;
uses crt, visual;
const
  InputFile: string = 'FIBISTR.IN';
  OutputFile = 'FIBISTR.OUT';
  max = 35;
var
  S: array[1..13] of String;
  F: array[1..40] of LongInt;
  OddCenter, EvenCenter: String;
  OddCount, EvenCount, OddP, EvenP: Integer;
  n, l: Integer;
  Source: String;
  fi, fo: Text;
  ch: Char;

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

procedure Halt;
begin
  {$I-}
  Close(fi); if IOResult = 0 then;
  Close(fo); if IOResult = 0 then;
  {$I+}
  ReadKey;
  TextMode(C80); Textattr := 7; Clrscr;
  System.Halt;
end;

procedure WriteP(p: Real);
var
  f: file of Real;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Real;
var
  f: file of Real;
  P: Real;
begin
  Assign(f, 'POINT.PNT'); Reset(f);
  Read(f, P);
  Close(f);
  ReadP := p;
end;

procedure ShowP;
var
  S: String;
begin
  Str(ReadP:5:2, S);
  Visual.Color := 30;
  MSG(60, 3, 'TÊng', 'TÊng Æi”m Æang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   Bπn c„ 1 Æi”m   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('ßÛng h’t c∏c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong(P: Real);
var
  S: String;
begin
  Visual.Color := 78;
  Str(P:5:2, S);
  MSG(20, 3, InputFile, '   Bπn c„ ' + S + ' Æi”m   '#7);
  WriteP(ReadP + P);
  ShowP;
  Halt;
end;

procedure AskTest;
var
  S: String;
  T: String[1];
begin
  Caption('Bµi 005: "X©u fibinacci"');
  MSG(40, 3, 'Input?', 'Cho t™n file d˜ li÷u: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      T := ParamStr(1);
      ch := T[1];
    end
  else
    ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      Str(ReadP:5:2, S);
      MSG(40, 13, 'ßi”m', 'TÊng Æi”m cÒa bπn Æang lµ: ' + S + '/10');
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  nTest, p: LongInt;
  res, hsres: LongInt;
  tmp: Char;
begin
  Caption('Ch m bµi 005: "X©u fibinacci"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  nTest := 0; p := 0;
  while not SeekEof(fi) do
    begin
      Inc(nTest);
      GotoXY(2, 4);
      ClrEol;
      Writeln('Dﬂng ', nTest:4, ':   ');
      ClrEol;
      Readln(fi, n, tmp, Source);
      Writeln('      n = ', n, '; Word = "', Source);
      res := Solve;
      Readln(fo, hsres);
      ClrEol;
      Writeln('       + ß∏p ∏n  : ', res);
      ClrEol;
      Writeln('       + H‰c sinh: ', hsres);
      ClrEol;
      if res <> hsres then Write('K’t qu∂ sai!'#7)
      else
        begin
          Write('K’t qu∂ ÆÛng!'); Inc(p);
        end;
    end;
  Writeln;
  Writeln;
  Writeln('T t c∂ ÆÛng Æ≠Óc ', p, '/', ntest, ' test!');
  if p = nTest then Correct
  else Wrong(p / nTest);
end;

begin
  AskTest;
  CommonInit;
  Assign(fi, InputFile); Reset(fi);
  Assign(fo, OutputFile); Reset(fo);
  Test;
end.
