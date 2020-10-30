{$N+,E+}
program circle;
uses crt, visual;
const
  InputFile: string = 'CIRCLE.IN';
  OutputFile = 'CIRCLE.OUT';
  max = 5000;
  eps = 1E-5;
var
  d: array[1..2 * max + 1] of LongInt;
  Blue: array[1..2 * max + 1] of Boolean;
  n: Integer;
  Radius: Extended;
  ch: Char;
  f: Text;

procedure Enter;
var
  f: Text;
  i, x, y: LongInt;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    begin
      Readln(f, x, y);
      d[i] := Sqr(x) + Sqr(y);
      blue[i] := True;
    end;
  for i := 1 to n do
    begin
      Readln(f, x, y);
      d[i + n] := Sqr(x) + Sqr(y);
      blue[i + n] := False;
    end;
end;

procedure Swap(i, j: Integer);
var
  t: LongInt;
  b: Boolean;
begin
  t := d[i]; d[i] := d[j]; d[j] := t;
  b := Blue[i]; Blue[i] := Blue[j]; Blue[j] := b;
end;

procedure QSort(L, H: Integer);
var
  t, i, j: Integer;
  tmp: LongInt;
begin
  if L >= H then Exit;
  tmp := d[L + Random(H - L + 1)];
  i := L; j := H;
  repeat
    while d[i] < tmp do Inc(i);
    while d[j] > tmp do Dec(j);
    if i <= j then
      begin
        Swap(i, j);
        Inc(i); Dec(j);
      end;
  until i > j;
  QSort(L, j); QSort(i, H);
end;

procedure GetRadius;
var
  i: Integer;
  Count: Integer;
begin
  Count := 0;
  for i := 1 to 2 * n do
    begin
      if Blue[i] then Inc(Count) else Dec(Count);
      if (d[i] <> d[i + 1]) and (Count = 0) then
        begin
          Radius := d[i];
          Break;
        end;
    end;
  Radius := Sqrt(Radius);
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
  Caption('Bµi 132: "§­êng trßn"');
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
  HSRes: Extended;
begin
  Caption('ChÊm bµi 132: "§­êng trßn"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, HSRes);
  Writeln('B¸n kÝnh ®­êng trßn');
  Writeln('   §¸p ¸n    : ', Radius:1:6);
  Writeln('   Häc sinh  : ', HSRes:1:6);
  if Abs(HSRes - Radius) > eps then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  QSort(1, 2 * n);
  GetRadius;
  Test;
end.
