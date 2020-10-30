program MaxNumber;
uses crt, Visual;
const
  InputFile: String = 'NUMBER.IN';
  OutputFile = 'NUMBER.OUT';
  max = 101;
type
  TStr = string[max];
  TLine = array[0..max] of TStr;
  PLine = ^TLine;
var
  a, b: TStr;
  m, n: Integer;
  S: String;
  Current, Next: PLine;
  f: Text;
  Ch: Char;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, a);
  while a[1] = '0' do Delete(a, 1, 1);
  m := Length(a);
  Readln(f, b);
  while b[1] = '0' do Delete(b, 1, 1);
  n := Length(b);
  Close(f);
  New(Current); New(Next);
  FillChar(Current^, SizeOf(Current^), 0);
  FillChar(Next^, SizeOf(Next^), 0);
end;

function GetMax(s1, s2, s3: TStr): TStr;
var
  i, t: Integer;
  S: String;
begin
  t := Length(s1);
  if t < Length(s2) then t := Length(s2);
  if t < Length(s3) then t := Length(s3);
  if s1 <> '' then
    for i := Length(s1) + 1 to t do s1 := '0' + s1;
  if s2 <> '' then
    for i := Length(s2) + 1 to t do s2 := '0' + s2;
  if s3 <> '' then
    for i := Length(s3) + 1 to t do s3 := '0' + s3;
  S := s1;
  if S < s2 then S := s2;
  if S < s3 then S := s3;
  GetMax := S;
end;

procedure Optimize;
var
  t, i, j: Integer;
  s1, s2, s3: string;
  temp: PLine;
begin
  for j := 1 to n do Current^[j] := '0';
  for i := 1 to m do
    begin
      for j := 1 to n do
        if a[i] = b[j] then Next^[j] := Current^[j - 1] + b[j]
        else
            Next^[j] := GetMax(Next^[j - 1], Current^[j - 1], Current^[j]);
      temp := Current; Current := Next; Next := temp;
    end;
end;

procedure Result;
var
  f: Text;
begin
  S := Current^[n];
  while (Length(S) > 1) and (S[1] = '0') do Delete(S, 1, 1);
end;

procedure Refine(var S: String);
var
  i: Integer;
begin
  for i := Length(S) downto 1 do
    if not (S[i] in ['0'..'9']) then Delete(S, i, 1);
  while (Length(S) > 1) and (S[1] = '0') do Delete(S, 1, 1);
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
  Caption('Bµi "Gi¸ trÞ lín nhÊt"');
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
  t: String;
begin
  Caption('ChÊm bµi: "Gi¸ trÞ lín nhÊt"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, Outputfile); Reset(f);
  Readln(f, t);
  Close(f);
  Refine(S);
  Refine(T);
  Writeln('  + Ket qua dung: ', S);
  Writeln('  + Ket qua HS  : ', T);
  if S <> T then Wrong
  else Correct;
end;

begin
  AskTest;
  Enter;
  Optimize;
  Result;
  Test;
end.
561256
125612
12
123
