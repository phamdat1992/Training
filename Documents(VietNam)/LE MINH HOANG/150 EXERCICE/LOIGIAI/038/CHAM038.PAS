program Palindrom_String;
uses crt, visual;
const
  InputFile: String = 'STR.IN';
  OutputFile = 'STR.OUT';
  max = 128;
var
  S, T: String;
  B: array[1..max, 1..max] of Byte;
  n: Byte;
  f: Text;
  Ch: Char;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, S);
  n := Length(S);
  Close(f);
end;

function Min(a, b: Byte): Byte;
begin
  if a < b then Min := a else Min := b;
end;

procedure Optimize;
var
  i, j, l: Byte;
begin
  FillChar(B, SizeOf(B), 0);
  for i := 1 to n - 1 do
    if S[i] <> S[i + 1] then B[i, i + 1] := 1;
  for l := 3 to n do
    for i := 1 to n - l + 1 do
      begin
        j := i + l - 1;
        if S[i] = S[j] then B[i, j] := B[i + 1, j - 1]
        else
          B[i, j] := Min(B[i + 1, j], B[i, j - 1]) + 1;
      end;
end;

procedure Trace;
var
  T1, T2: String;
  C: Char;
  i, j: Byte;
begin
  T1 := ''; T2 := '';
  i := 1; j := n;
  while j - i > 1 do
    begin
      if S[i] = S[j] then
        begin
          C := S[i];
          Inc(i); Dec(j);
        end
      else
        if B[i, j] = B[i + 1, j] + 1 then
          begin
            C := S[i];
            Inc(i);
          end
        else
          begin
            C := S[j];
            Dec(j);
          end;
      T1 := T1 + C; T2 := C + T2;
    end;
  if i = j then T1 := T1 + S[i]
  else
    if S[i] = S[j] then T1 := T1 + S[i] + S[j]
    else T1 := T1 + S[i] + S[j] + S[i];
  T := T1 + T2;
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
  Caption('Bµi "X©u ®èi xøng"');
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

function Check1(x, y: String): Boolean;
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
  Check1 := j <= Length(y);
end;

function Check2(S: String): Boolean;
var
  i, j: Integer;
begin
  i := 1; j := Length(S);
  while i < j do
    begin
      if S[i] <> S[j] then
        begin
          Check2 := False;
          Exit;
        end;
      Inc(i); Dec(j);
    end;
  Check2 := True;
end;

procedure Test;
var
  St: String;
begin
  Caption('ChÊm bµi: "X©u ®èi xøng"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, St);
  Writeln('S = ''', S, '''');
  Writeln('X©u ®èi xøng : ');
  Writeln('  + §¸p ¸n: ''', T, '''');
  Writeln('  + HS    : ''', St, '''');
  if Length(St) > Length(T) then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  if not Check2(St) then
    begin
      Writeln('Kh«ng ®èi xøng!');
      Wrong;
    end;
  if not Check1(S, St) then
    begin
      Writeln('Kh«ng ph¶i x©u chøa S!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
  Close(f);
end;

begin
  AskTest;
  Enter;
  Optimize;
  Trace;
  Test;
end.
