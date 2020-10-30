program Test093;
uses crt, visual;
const
  InputFile:String = 'TELECOM.IN';
  OutputFile = 'TELECOM.OUT';
  Res: array['0'..'9'] of Double = (
    205.878877,
    100.000000,
    115.401734,
    207.335194,
    64.262142,
    200.000000,
    100.000000,
    92.968721,
    10000.000000,
    207.150431
  );
  max = 1000;
  eps = 1E-4;
type
  Real = Extended;
  TArr = array[1..max] of Real;
var
  f: Text;
  ch: Char;
  x, y: TArr;
  n: Integer;
  cx, cy, cr: Real;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    Readln(f, x[i], y[i]);
  Close(f);
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
  Caption('Bµi "Phñ sãng"');
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
  i: Integer;
begin
  Caption('ChÊm bµi: "Phñ sãng"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Enter;
  Assign(f, OutputFile); Reset(f);
  Readln(f, cx, cy, cr);
  Writeln('B¸n kÝnh phñ sãng: ');
  Writeln('  + §¸p ¸n:    ', Res[ch]:1:4);
  Writeln('  + Häc sinh:  ', cr:1:4);
  if cr - Res[ch] > eps then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('TÝnh ®óng ®¾n: ');
  cr := Sqr(cr + eps);
  for i := 1 to n do
    if sqr(x[i] - cx) + sqr(y[i] - cy) > cr then
      begin
        Writeln('Tr¹m ', i, ' kh«ng thu ®­îc sãng!');
        Wrong;
      end;
  Writeln('KÕt qu¶ ®óng ®¾n!');
  Correct;
end;

begin
  AskTest;
  Test;
end.
