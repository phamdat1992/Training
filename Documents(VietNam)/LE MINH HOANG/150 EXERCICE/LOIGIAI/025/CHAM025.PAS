{$N+,E+}
program DigitSum;
uses crt, visual;
const
  maxn = 30;
  maxk = 40;
  InputFile: String = 'DIGITSUM.IN';
  OutputFile = 'DIGITSUM.OUT';
type
  TDigit = 0..9;
var
  n, k: Integer;
  p: Comp;
  B: array[0..maxn, 0..maxk] of Comp;
  X: array[1..maxn] of TDigit;
  nNum: Comp;
  Number: String;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, k, p);
  Close(f);
end;

procedure Init;
begin
  B[0, 0] := 1;
  FillChar(B[0, 1], k * SizeOf(B[0, 1]), 0);
end;

procedure Optimize;
var
  i, j: Integer;
  d: TDigit;
begin
  for i := 1 to n do
    for j := 0 to k do
      begin
        B[i, j] := 0;
        for d := 0 to 9 do
          if d <= j then B[i, j] := B[i, j] + B[i - 1, j - d]
          else Break;
      end;
end;

function FindFirst(n, k: Integer; Post: Comp): TDigit;
var
  d: TDigit;
  S: Comp;
begin
  S := 0;
  for d := 0 to 9 do
    if d <= k then
      begin
        S := S + B[n - 1, k - d];
        if S >= Post then Break;
      end;
  FindFirst := d;
end;

procedure Trace;
var
  i, j: Integer;
  Pn, Pk: Integer;
  PPost: Comp;
begin
  Pn := n; Pk := k; PPost := p;
  for i := 1 to n do
    begin
      X[i] := FindFirst(Pn, Pk, PPost);
      if X[i] > 0 then
        for j := 0 to X[i] - 1 do
          PPost := PPost - B[Pn - 1, Pk - j];
      Dec(Pn);
      Pk := Pk - X[i];
    end;
end;

procedure Result;
var
  i: Integer;
begin
  nNum := B[n, k];
  i := 1;
  while (i < n) and (X[i] = 0) do Inc(i);
  Number := '';
  while i <= n do
    begin
      Number := Number + Chr(Ord('0') + x[i]);
      Inc(i);
    end;
end;

procedure Halt;
begin
  {$I-}
  Close(f); if IOResult = 0 then;
  {$I+}
  ReadKey;
  TextMode(C80); Textattr := 7; Clrscr;
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

procedure AskTest;
begin
  Caption('Bµi "Tæng c¸c ch÷ sè"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  ch := ReadKey;
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
  HSCount: Comp;
  HSNumber: String;
begin
  Caption('ChÊm bµi: "Tæng c¸c ch÷ sè"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, HSCount);
  Readln(f, HSNumber);
  while (HSNumber <> '') and (HSNumber[1] = ' ') do Delete(HSNumber, 1, 1);
  while (HSNumber <> '') and (HSNumber[Length(HSNumber)] = ' ') do
        Dec(HSNumber[0]);
  Close(f);
  Writeln('n = ', n, ';  k = ', k, ';  p = ', p:0:0);
  Writeln('Sè l­îng c¸c sè: ');
  Writeln('  + §¸p ¸n  : ', nNum:0:0);
  Writeln('  + Häc sinh: ', HSCount:0:0);
  Writeln('Sè thø ', p:0:0);
  Writeln('  + §¸p ¸n  : ', Number);
  Writeln('  + Häc sinh: ', HSNumber);
  if (nNum <> HSCount) or (Number <> HSNumber) then
    begin
      Writeln('KÕt qu¶ sai!'); Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  Trace;
  Result;
  Test;
end.
