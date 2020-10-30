program MaxString;
uses crt, visual;
const
  InputFile: String = 'STR.IN';
  OutputFile = 'STR.OUT';
  max = 255;
type
  TLine = array[0..max] of Integer;
  PLine = ^TLine;
var
  Fb: array[0..max] of PLine;
  c, a, b: String;
  m, n: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, a); Readln(f, b);
  m := Length(a); n := Length(b);
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 0 to m do New(Fb[i]);
  FillChar(Fb[0]^, SizeOf(Fb[0]^), 0);
  for i := 1 to m do Fb[i]^[0] := 0;
end;

function Max3(x, y, z: Integer): Integer;
begin
  if y > x then x := y;
  if z > x then x := z;
  Max3 := x;
end;

procedure Optimize;
var
  i, j: Integer;
begin
  for i := 1 to m do
    for j := 1 to n do
      if a[i] = b[j] then Fb[i]^[j] := Fb[i - 1]^[j - 1] + 1
      else
        Fb[i]^[j] := Max3(Fb[i - 1]^[j - 1], Fb[i - 1]^[j], Fb[i]^[j - 1]);
end;

procedure Trace;
var
  i, j: Integer;
begin
  c := '';
  i := m; j := n;
  while (i <> 0) and (j <> 0) do
    if a[i] = b[j] then
      begin
        c := a[i] + c;
        Dec(i); Dec(j);
      end
    else
      if Fb[i]^[j] = Fb[i - 1]^[j - 1] then
        begin
          Dec(i); Dec(j);
        end
      else
        if Fb[i]^[j] = Fb[i - 1]^[j] then Dec(i)
        else Dec(j);
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
  Caption('Bµi "X©u con chung dµi nhÊt"');
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

procedure Test;
var
  T: String;
begin
  Caption('ChÊm bµi: "X©u con chung dµi nhÊt"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, T);
  Writeln('A = ''', a, '''');
  Writeln('B = ''', b, '''');
  Writeln('X©u con chung dµi nhÊt: ');
  Writeln('  + §¸p ¸n  : ', c);
  Writeln('  + Häc sinh: ', T);
  if Length(T) < Length(c) then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  if not Check(T, a) then
    begin
      Writeln('X©u t×m ®­îc kh«ng ph¶i lµ con x©u A!');
      Wrong;
    end;
  if not Check(T, b) then
    begin
      Writeln('X©u t×m ®­îc kh«ng ph¶i lµ con x©u b!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng');
  Correct;
  Close(f);
end;


begin
  AskTest;
  Enter;
  Init;
  Optimize;
  Trace;
  Test;
end.
