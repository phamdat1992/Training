{$R-,S-,Q-}
program ViterbiAlgorithm;
uses crt, visual;
const
  InputFile: string = 'VITERBI.IN';
  OutputFile = 'VITERBI.OUT';
  max = 200;
type
  TBoard = array[1..max, 1..max] of Byte;
var
  a, b: ^TBoard;
  Trace: TBoard;
  Line: array[1..2, 1..max] of Word;
  Min: Word;
  ArgMin, n, m, T: Integer;
  O: array[1..max] of Integer;
  f: Text;
  Ch: Char;

procedure Enter;
var
  f: Text;
  i, j, v, k: Integer;
begin
  New(a); New(b);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m, T);
  for k := 1 to T do Read(f, O[k]);
  Readln(f);
  for i := 1 to n do
    begin
      for j := 1 to n do Read(f, a^[i, j]);
      Readln(f);
    end;
  for i := 1 to n do
    begin
      for v := 1 to m do Read(f, b^[i, v]);
      Readln(f);
    end;
  Close(f);
end;

procedure Optimize;
var
  k, i, j, x, y: Integer;
begin
  for i := 1 to n do Line[1, i] := b^[i, O[1]];  {Init}
  x := 1; y := 2;
  for k := 2 to T do {Dynamic Optimization}
    begin
      for j := 1 to n do
        begin
          Line[y, j] := $FFFF;
          for i := 1 to n do
            if Line[y, j] > Line[x, i] + a^[i, j] + b^[j, O[k]] then
              begin
                Line[y, j] := Line[x, i] + a^[i, j] + b^[j, O[k]];
                Trace[k, j] := i;
              end;
        end;
      x := 3 - x; y := 3 - y;
    end;
  Min := $FFFF;
  for i := 1 to n do
    if Line[x, i] < Min then
      begin
        Min := Line[x, i];
        ArgMin := i;
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
  Caption('Bµi 116: "L¾p r¸p m¸y tÝnh"');
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

{$R+,Q+}
procedure Test;
var
  THS, Total: LongInt;
  q: array[1..max] of Integer;
  i: Integer;
begin
  Caption('ChÊm bµi 116: "L¾p r¸p m¸y tÝnh"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, THS);
  Writeln('Thêi gian l¾p r¸p:');
  Writeln('  + §¸p ¸n    : ', Min);
  Writeln('  + Häc sinh  : ', THS);
  if THS > Min then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Writeln;
  for i := 1 to T do Read(f, q[i]);
  Total := 0;
  for i := 1 to T - 1 do Total := Total + a^[q[i], q[i + 1]];
  for i := 1 to T do Total := Total + b^[q[i], O[i]];
  Writeln('Thêi gian tÝnh theo lÞch: ', Total);
  if Total <> THS then
    begin
      Writeln('TiÒn hËu bÊt nhÊt!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Optimize;
  Test;
end.

3 4 8
1 2 3 4 1 2 3 4
0 9 1
1 0 9
9 1 0
8 8 1 5
8 1 8 8
1 8 8 8
