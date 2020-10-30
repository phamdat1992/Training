{$R-,S-,I-,Q-}
{$M 65520 0 655360}
program Test094;
uses crt, visual;
const
  InputFile: String = 'RECOVER.IN';
  OutputFile = 'RECOVER.OUT';
  max = 10000;
var
  x, t, st: array[1..max] of Integer;
  n: Integer;
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
  Caption('Bµi "Kh«i phôc ho¸n vÞ"');
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
  i, j, v: Integer;
begin
  Caption('ChÊm bµi: "Kh«i phôc ho¸n vÞ"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Read(f, t[i]);
  Close(f);
  Assign(f, OutputFile); Reset(f);
  for i := 1 to n do Read(f, x[i]);
  Close(f);
  Writeln('n = ', n);
  Writeln('D·y nghÞch thÕ: ');
  for i := 1 to n do Write(t[i], ', ');
  Writeln;
  Writeln('D·y ho¸n vÞ: ');
  for i := 1 to n do Write(x[i], ', ');
  Writeln;
  FillChar(st, SizeOf(st), 0);
  for i := 1 to n do
    begin
      if (x[i] < 1) or (x[i] > n) or (st[x[i]] <> 0) then
        begin
          Writeln('Kh«ng ph¶i d·y ho¸n vÞ');
          Wrong;
        end;
      st[x[i]] := 1;
    end;
  FillChar(st, SizeOf(st), 0);
  for i := 1 to n do
    begin
      v := x[i];
      for j := 1 to i - 1 do
        if x[j] > v then Inc(st[v]);
    end;
  for i := 1 to n do
    if st[i] <> t[i] then
      begin
        Writeln('D·y ho¸n vÞ sai!');
        Wrong;
      end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Test;
end.
