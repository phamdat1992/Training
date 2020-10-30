program SubString;
uses crt, visual;
const
  InputFile: string[12]  = 'SUBSTR.IN';
  OutputFile = 'SUBSTR.OUT';
  max = 200;
type
  TBoard = array[1..max, 1..max] of Byte;
var
  sa, sb, a, b: string;
  fb: TBoard;
  res, m, n, delta: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, a); sa := a;
  Readln(f, b); sb := b;
  while a[1] <> b[1] do
    begin
      Inc(delta);
      Delete(a, 1, 1);
    end;
  while a[Length(a)] <> b[Length(b)] do Dec(a[0]);
  m := Length(a);
  n := Length(b);
  Close(f);
end;

{$R-,Q-}

procedure Init;
var
  i, j: Integer;
begin
  FillChar(fb, SizeOf(fb), $FF);
  for i := 1 to m do
    if a[i] = b[1] then fb[i, 1] := 0;
end;

function GetMax(x, y: Integer): Integer;
begin
  if x > y then GetMax := x else GetMax := y;
end;

procedure Optimize;
var
  i, j, k, t: Integer;
begin
  for j := 2 to n do
    for i := j to m do
      if a[i] = b[j] then
        for k := i - 1 downto j - 1 do
          begin
            if a[k] = b[j - 1] then
              begin
                t := GetMax(i - k, fb[k, j - 1]);
                if t < fb[i, j] then
                  fb[i, j] := t;
              end;
            if i - k >= fb[i, j] then Break;
          end;
end;

procedure GetTrace;
var
  i, j, t: Integer;
  p: array[1..max] of Integer;
begin
  res := maxInt;
  for i := 1 to m do
    if fb[i, n] < res then
      begin
        res := fb[i, n];
        t := i;
      end;
end;

{$R+,Q+}

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
  Caption('Bµi 122: "X©u con"');
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
  id: array[1..max] of Integer;
  j, i, nid, maxHS: Integer;
  t: string;
begin
  Caption('ChÊm bµi 122: "X©u con"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Writeln('KiÓm tra d·y:');
  Assign(f, OutputFile); Reset(f);
  nid := 0;
  while not SeekEoln(f) do
    begin
      Inc(nid);
      Read(f, id[nid]);
    end;
  Readln(f);
  for i := 2 to nid do
    if id[i] <= id[i - 1] then
      begin
        Writeln('  D·y kh«ng t¨ng!');
        Writeln('    * id[', i - 1, '] =', id[i - 1]);
        Writeln('    * id[', i, '] =', id[i]);
        Wrong;
      end;
  if nid <> n then
    begin
      Writeln('  Sè l­îng kh«ng ®óng!');
      Wrong;
    end;
  maxHS := 0;
  for i := 2 to nid do
    if id[i] - id[i - 1] > maxHS then
      maxHS := id[i] - id[i - 1];
  t := '';
  for i := 1 to nid do t := t + sa[id[i]];
  Writeln('D·y con chän theo ®¸p ¸n: ');
  Writeln(t);
  Writeln('D·y con b: ');
  Writeln(sb);
  if sb <> t then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('Hµm môc tiªu: ');
  Writeln('  + §¸p ¸n   : ', res);
  Writeln('  + Häc sinh : ', maxHS);
  if maxHS > res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  GetTrace;
  Test;
end.

