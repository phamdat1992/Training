program Paint;
uses crt, visual;
const
  InputFile: String = 'PAINT.IN';
  OutputFile = 'PAINT.OUT';
  max = 100;
var
  A: array[0..max + 1, 0..max + 1] of Integer;
  m, n, i, j: Byte;
  S: LongInt;
  f: Text;
  ch: Char;

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
  Assign(f, 'POINT.PNT'); Reset(f);
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
  Caption('Bµi ""');
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
  T: LongInt;
begin
  Caption('ChÊm bµi: "S¬n cét"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, T);
  Close(f);
  Writeln('Tæng sè diÖn tÝch cÇn s¬n:');
  Writeln('  + §¸p ¸n   : ', S);
  Writeln('  + Häc sinh : ', T);
  if S <> T then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Assign(f, InputFile); Reset(f);
  FillChar(A, SizeOf(A), 0);
  Readln(f, m, n);
  for i := 1 to m do
    for j := 1 to n do Read(f, A[i, j]);
  Close(f);
  S := 0;
  for i := 0 to m do
    for j := 0 to n do
      begin
        S := S + Abs(A[i, j] - A[i, j + 1]) + Abs (A[i, j] - A[i + 1, j]);
        if A[i, j] <> 0 then Inc(S);
      end;
  Test;
end.

2 3
4 3 4
1 2 1
