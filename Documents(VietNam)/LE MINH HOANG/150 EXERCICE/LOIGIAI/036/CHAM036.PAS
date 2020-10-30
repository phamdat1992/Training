program Bai2;
uses crt, visual;
const
  InputFile: String  = 'PARTY.IN';
  OutputFile = 'PARTY.OUT';
  max = 20;
var
  a: array[1..max, 1..max] of Boolean;
  x: array[1..max + 1] of Integer;
  Free: array[1..max] of Boolean;
  s: array[1..max] of String;
  n: Integer;
  Found: Boolean;
  f: Text;
  ch: Char;

function Check(S1, S2: String): Boolean;
var
  S: Set of Char;
  i: Integer;
begin
  S := [];
  for i := 1 to Length(S1) do S := S + [S1[i]];
  for i := 1 to Length(S2) do
    if S2[i] in S then
      begin
        Check := True; Exit;
      end;
  Check := False;
end;

procedure Enter;
var
  f: Text;
  i, j: Integer;
  c: Char;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Readln(f, S[i]);
  Close(f);
  for i := 1 to n do
    for j := 1 to n do
      begin
        a[i, j] := Check(S[i], S[j]);
        a[j, i] := a[i, j];
      end;
  FillChar(Free, SizeOf(Free), True);
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
  MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/9');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 9 then
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
  Caption('Bµi "Dù tiÖc bµn trßn"');
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
  Caption('ChÊm bµi: "Dù tiÖc bµn trßn"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  FillChar(Free, SizeOf(Free), True);
  for i := 1 to n do
    begin
      Read(f, x[i]);
      if (x[i] < 1) or (x[i] > n) or not Free[x[i]] then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong;
        end;
      Free[x[i]] := False;
    end;
  x[n + 1] := 1;
  Writeln('C¸ch xÕp cña HS: ');
  for i := 1 to n do
    Writeln(i:5, '. ', x[i]:3, ' - (', S[x[i]], ')');
  for i := 1 to n do
    if not a[x[i], x[i + 1]] then
      begin
        Writeln(x[i], ' vµ ', x[i + 1], ' kh«ng thÓ xÕp c¹nh nhau!');
        Wrong;
      end;
  Close(f);
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Test;
end.
