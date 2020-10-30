program Sequence;
uses crt, visual;
const
  InputFile: string = 'SEGMENT.IN';
  OutputFile = 'SEGMENT.OUT';
type
  TLine = array[0..1023] of LongInt;
  TWLine = array[0..1023] of Word;
var
  t: array[0..59] of ^TLine;
  min: array[0..59] of ^TWLine;
  n: Word;
  L, H, res: Word;
  f: Text;
  ch: Char;
{$R-,Q-}
procedure Sett(i: Word; Value: LongInt);
begin
  t[i shr 10]^[i and 1023] := Value;
end;

function Gett(i: Word): LongInt;
begin
  Gett := t[i shr 10]^[i and 1023];
end;

procedure Setmin(i: Word; Value: Word);
begin
  min[i shr 10]^[i and 1023] := Value;
end;

function Getmin(i: Word): Word;
begin
  Getmin := min[i shr 10]^[i and 1023];
end;

procedure Enter;
var
  f: Text;
  i, imin: Word;
  a: Integer;
  v, m: LongInt;
begin
  for i := 0 to 59 do
    begin
      new(t[i]);
      new(min[i]);
    end;
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  Sett(0, 0); Setmin(0, 0);
  m := 0; imin := 0;
  for i := 1 to n do
    begin
      Read(f, a);
      v := Gett(i - 1) + a;
      Sett(i, v);
      if v < m then
        begin
          m := v; imin := i;
        end;
      Setmin(i, imin);
    end;
  Close(f);
end;

procedure Solve;
var
  i, j: Word;
begin
  L := 0; H := 0;
  i := Getmin(n); j := n;
  repeat
    while (j > i) and (j - i > H - L) and (gett(j) <= gett(i)) do
      Dec(j);
    if j - i > H - L then
      begin
        L := i; H := j;
      end;
    if i = 0 then Break;
    i := Getmin(i - 1);
  until False;
  Inc(L);
  res := H - L + 1;
end;

{$R+,Q+}
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
var
  S: String[1];
begin
  Caption('Bµi 135: "SEGMENT"');
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
  hsL, hsR: LongInt;
begin
  Caption('ChÊm bµi 135: "SEGMENT"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsL, hsR);
  Writeln('KiÓm tra ®o¹n liªn tiÕp t×m ®­îc:');
  Writeln('  + §¸p ¸n  : tõ a[', L, '] ®Õn a[', H, ']; ®é dµi: ', res);
  Writeln('  + Häc sinh: tõ a[', hsL, '] ®Õn a[', hsR, ']; ®é dµi: ',
               hsR - hsL + 1);
  if (hsL < 1) or (hsL > n) or (hsR < 1) or (hsR > n) then
    begin
      Writeln('Sai khu«n d¹ng Output!');
      Wrong;
    end;
  if hsR - hsL + 1 < res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Writeln('Tæng c¸c sè trong ®o¹n cña häc sinh: ', Gett(hsR) - Gett(hsL - 1));
  if Gett(hsR) < Gett(hsL - 1) then
    begin
      Writeln('Kh«ng ®óng yªu cÇu!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Solve;
  Test;
end.
9
2 7 5 -3 -2 4 -9 -2 -1

7
0 0 0 0 0 0 0 0