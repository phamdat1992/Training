{
****************************************************************************
   CHUONG TRINH CHAM BAI THI OLYMPIC TIN HOC LOP 10 - 11 THANH PHO HA NOI
                          BAI: "BIEN DOI DAY SO"
   NGUOI VIET: LE MINH HOANG - DON VI: Khoi PTCTT DHSPHN
****************************************************************************
}
program SequenceTest;
uses crt, visual;
const
  InputFile: String = 'SEQ.IN';
  OutputFile = 'SEQ.OUT';
  max = 100;
  maxV = 100;
  maxF = max * maxV + 1;
var
  a: array[1..max] of Integer;
  b, t: array[1..max, 1..maxV] of Integer;
  Res, n: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Read(f, a[i]);
  Close(f);
end;

procedure Init;
var
  i, v: Integer;
begin
  for v := 1 to maxV do
    begin
      b[1, v] := Abs(v - a[1]);
      t[1, v] := 0;
    end;
end;

procedure Optimize;
var
  i, v, min, vmin, j: Integer;
begin
  for i := 2 to n do
    for v := 1 to maxV - n + i do
      begin
        min := maxF;
        for j := i - 1 to v - 1 do
          if b[i - 1, j] < min then
            begin
              min := b[i - 1, j];
              vmin := j;
            end;
         b[i, v] := min + Abs(v - a[i]);
         t[i, v] := vmin;
      end;
end;

procedure Trace;
var
  v, vmin, i, j: Integer;
  cf: Char;
  f: Text;
begin
  Res := maxF;
  for v := 1 to maxV do
    if b[n, v] < Res then
      Res := b[n, v];
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
  WriteP(ReadP + p);
  ShowP;
  Halt;
end;

procedure AskTest;
begin
  Caption('Bµi "BiÕn ®æi d·y sè"');
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
  i, S, p: Integer;
  c: Char;
begin
  Caption('ChÊm bµi: "BiÕn ®æi d·y sè"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, S);
  Writeln('Sè phÐp biÕn ®æi: ');
  Writeln('  + §¸p ¸n  : ', Res);
  Writeln('  + Häc sinh: ', S);
  for i := 1 to S do
    begin
      Readln(f, c, p);
      if not (c in ['+', '-']) or (p < 1) or (p > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong(0);
        end;
      case c of
        '+': Inc(a[p]);
        '-': Dec(a[p]);
      end;
    end;
  Close(f);
  Writeln('D·y sau khi biÕn ®æi: ');
  for i := 1 to n do Write(a[i], ' ');
  Writeln;
  for i := 1 to n do
    if (a[i] < 1) or (a[i] > maxV) then
      begin
         Writeln('PhÇn tö a[', i, '] = ', a[i], ' kh«ng hîp lÖ!');
         Wrong(0);
      end;
  for i := 1 to n - 1 do
    if a[i] >= a[i + 1] then
      begin
         Writeln('PhÇn tö a[', i, '] = ', a[i]);
         Writeln('PhÇn tö a[', i + 1, '] = ', a[i + 1]);
         Writeln('D·y kh«ng t¨ng!');
         Wrong(0);
      end;
  if S > Res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong(1);
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
  Test;
end.


