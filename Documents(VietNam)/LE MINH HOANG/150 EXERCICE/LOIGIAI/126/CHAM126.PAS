program Olympic;
uses crt, visual;
const
  InputFile: string[12] = 'OLYMPIC.IN';
  OutputFile = 'OLYMPIC.OUT';
  max = 255;
type
  TSet = set of 1..max;
var
  Sx, Sy: array[1..max] of TSet;
  n, m: Integer;
  MarkX, MarkY: array[1..max] of Boolean;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  FillChar(Sx, SizeOf(Sx), 0);
  FillChar(Sy, SizeOf(Sy), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to n do
    begin
      while not SeekEoln(f) do
        begin
          Read(f, j);
          Include(Sx[i], (j));
        end;
      Readln(f);
    end;
  for i := 1 to n do
    begin
      while not SeekEoln(f) do
        begin
          Read(f, j);
          Include(Sy[i], (j));
        end;
      Readln(f);
    end;
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
  Caption('Bµi 125: "Giao l­u"');
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
  i, x, y, c: Integer;
begin
  Caption('ChÊm bµi 125: "Giao l­u"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  FillChar(MarkX, SizeOf(MarkX), 0);
  FillChar(MarkY, SizeOf(MarkY), 0);
  Assign(f, OutputFile); Reset(f);
  c := 0;
  for i := 1 to m do
    begin
      Readln(f, x, y);
      if x <> 0 then
        begin
          Inc(c);
          Writeln(c:4, '. ', 'AMS[', x, '] vs CVA[', y, ']');
        end;
      if (x < 0) or (x > n) then
        begin
          Writeln('Kh«ng cã häc sinh AMS[', x, ']');
          Wrong;
        end;
      if (y < 0) or (y > n) then
        begin
          Writeln('Kh«ng cã häc sinh CVA[', y, ']');
          Wrong;
        end;
      if (x = 0) then Continue;
      if MarkX[x] then
        begin
          Writeln('AMS[', x, '] ®­îc chän vµo 2 cÆp');
          Wrong;
        end;
      if MarkY[y] then
        begin
          Writeln('CVA[', y, '] ®­îc chän vµo 2 cÆp');
          Wrong;
        end;
      if not (i in Sx[x]) then
        begin
          Writeln('Bµi ', i, ' kh«ng ph¶i së tr­êng cña AMS[', x, ']');
          Wrong;
        end;
      if not (i in Sy[y]) then
        begin
          Writeln('Bµi ', i, ' kh«ng ph¶i së tr­êng cña CVA[', y, ']');
          Wrong;
        end;
    end;
  Writeln('Sè bµi to¸n ®em ra thi: ', c);
  if c <> n then
    begin
      Writeln('Kh¸c víi sè ng­êi: ', n);
      Wrong;
    end;
  Writeln('KÕt qu¶ chÝnh x¸c!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Test;
end.
