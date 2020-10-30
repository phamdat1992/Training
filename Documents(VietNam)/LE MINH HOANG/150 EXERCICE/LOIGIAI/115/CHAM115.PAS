{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program Bracket;
uses crt, visual;
const
  InputFile: string  = 'BRACKET.IN';
  OutputFile = 'BRACKET.OUT';
  max = 200;
  CharCode: String[4] = '[()]';
type
  TBoard = array[1..200, 1..200] of Byte;
var
  n: Integer;
  S: String;
  a: array[1..max] of Integer;
  b: TBoard;
  f: Text;
  ch: Char;
  res: Integer;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, S);
  n := Length(S);
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  for i := 1 to Length(S) do
    case S[i] of
      '[': a[i] := 1;
      ']': a[i] := 4;
      '(': a[i] := 2;
      ')': a[i] := 3;
    end;
  for i := 1 to n do
    for j := 1 to n do
      if i > j then b[i, j] := 0
      else
        if i = j then b[i, j] := 1
        else b[i, j] := 255;
end;

procedure Optimize;
var
  i, j, l, k: Integer;
  min: Byte;
begin
  for l := 1 to n do
    for i := 1 to n - l do
      begin
        j := i + l;
        min := 255;
        if (a[i] < 3) and (a[i] + a[j] = 5) then
          min := b[i + 1, j - 1];
        for k := i to j - 1 do
          if min > b[i, k] + b[k + 1, j] then
            min := b[i, k] + b[k + 1, j];
        b[i, j] := min;
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
var
  S: String[1];
begin
  Caption('Bµi 115: "D·y ngoÆc"');
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
  x: array[1..1000] of Char;
  i, j, ns: Integer;

  procedure Delete(i: Integer);
  begin
    Move(x[i + 2], x[i], ns - i - 1);
    Dec(ns, 2);
    FillChar(x[ns + 1], 1000 - ns, ' ');
  end;

begin
  Caption('ChÊm bµi 115: "D·y ngoÆc"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  ns := 0;
  while not SeekEoln(f) do
    begin
      Inc(ns);
      Read(f, x[ns]);
      if not (x[ns] in ['(', ')', '[', ']']) then
        begin
          Writeln('D·y ngoÆc cã ký hiÖu l¹!');
          Wrong;
        end;
    end;
  Writeln('ChiÒu dµi d·y ngoÆc ®óng: ');
  Writeln('  + §¸p ¸n  : ', res);
  Writeln('  + Häc sinh: ', ns);
  if ns > res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Writeln('§èi s¸nh víi d·y ngoÆc vµo');
  i := 1;
  for j := 1 to ns do
    if x[j] = s[i] then
      begin
        Inc(i);
        if i = n + 1 then Break;
      end;
  if i <> n + 1 then
    begin
      Writeln('  D·y Output kh«ng chøa d·y Input!');
      Wrong;
    end;
  Writeln('  D·y Output cã chøa d·y Input! OK!');
  Writeln('KiÓm tra tÝnh ®óng ®¾n');
  for j := ns - 1 downto 1 do
    if (x[j] + x[j + 1] = '()') or
       (x[j] + x[j + 1] = '[]') then Delete(j);
  if ns <> 0 then
    begin
      Writeln('  D·y ngoÆc kh«ng ®óng ®¾n!');
      Wrong;
    end;
  Writeln('  D·y ngoÆc ®óng ®¾n!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  res := b[1, n] + n;
  Test;
end.
([(]
([[((())())]()])[]