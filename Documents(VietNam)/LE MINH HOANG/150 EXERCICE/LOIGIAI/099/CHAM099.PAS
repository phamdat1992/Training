{
****************************************************************************
   CHUONG TRINH CHAM BAI THI OLYMPIC TIN HOC LOP 10 - 11 THANH PHO HA NOI
                          BAI: "GIA TRI NHO NHAT"
   NGUOI VIET: LE MINH HOANG - DON VI: Khoi PTCTT DHSPHN
****************************************************************************
}
program MinimalValueofString;
uses crt, visual;
const
  InputFile: String  = 'NUMBER.IN';
  OutputFile = 'NUMBER.OUT';
  max = 101;
var
  a, b: String[max];
  fb: array[1..2, 0..max] of String;
  m, n: Integer;
  Res: String;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, a);
  Readln(f, b);
  Close(f);
  m := Length(a); n := Length(b);
end;

procedure Init;
var
  j: Integer;
begin
  for j := 0 to n do fb[1, j] := Copy(b, 1, j);
end;

function GetMin(s1, s2: String): String;
begin
  while (Length(s1) <> 0) and (s1[1] = '0') do Delete(s1, 1, 1);
  while (Length(s2) <> 0) and (s2[1] = '0') do Delete(s2, 1, 1);
  if (Length(s1) < Length(s2)) or
     (Length(s1) = Length(s2)) and (s1 < s2) then GetMin := s1
  else GetMin := s2;
end;

procedure Optimize;
var
  i, j, x, y: Integer;
begin
  x := 1; y := 2;
  for i := 1 to m do
    begin
      fb[y][0] := Copy(a, 1, i);
      for j := 1 to n do
        if a[i] = b[j] then fb[y][j] := fb[x][j - 1] + a[i]
        else
          fb[y][j] := GetMin(fb[x][j] + a[i], fb[y][j - 1] + b[j]);
      x := 3 - x; y := 3 - y;
    end;
  Res := fb[x][n];
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
  Str(ReadP / 2:4:1, S);
  if Length(S) < 2 then S := '0' + S;
  Visual.Color := 30;
  MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
  WriteP(ReadP + 2);
  ShowP;
  if ReadP = 20 then
    Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong(p: Integer);
begin
  Visual.Color := 78;
  if p = 1 then MSG(20, 3, InputFile, '   B¹n cã 0.5 ®iÓm   '#7)
  else MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
  ShowP;
  Halt;
end;

procedure AskTest;
begin
  Caption('Bµi "Gi¸ trÞ nhá nhÊt"');
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

function Check(x, y: String): Boolean;
var
  i, j: Integer;
begin
  j := 0;
  for i := 1 to Length(x) do
    begin
      Inc(j);
      while (j <= Length(y)) and (y[j] <> x[i]) do Inc(j);
      if j > Length(y) then Break;
    end;
  Check := j <= Length(y);
end;

procedure Refine(var S: String);
var
  i: Integer;
begin
  for i := Length(S) downto 1 do
    if not (S[i] in ['0'..'9']) then Delete(S, i, 1);
  while (Length(S) > 1) and (S[1] = '0') do Delete(S, 1, 1);
end;

procedure Test;
var
  T: String;
begin
  Caption('ChÊm bµi: "Gi¸ trÞ nhá nhÊt"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Writeln('A = ', a);
  Writeln('B = ', b);
  Assign(f, Outputfile); Reset(f);
  Readln(f, t);
  Close(f);
  Refine(Res);
  Refine(T);
  Writeln('  + §¸p ¸n     : ', Res);
  Writeln('  + Häc sinh   : ', T);
  if not Check(a, T) then
    begin
      Writeln('Kh«ng ph¶i con cña sè A');
      Wrong(0);
    end;
  if not Check(b, T) then
    begin
      Writeln('Kh«ng ph¶i con cña sè B');
      Wrong(0);
    end;
  if GetMin(Res, T) <> T then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong(1);
    end;
  if T = Res then Writeln('§óng nh­ ®¸p ¸n!')
  else Writeln('Tèt h¬n ®¸p ¸n!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  Test;
end.
