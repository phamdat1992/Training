program Brackets;
uses crt, visual;
const
  InputFile: String  = 'BRACKETS.IN';
  OutputFile = 'BRACKETS.OUT';
  max = 200;
type
  Str200 = String[200];
  TBoard = array[0..max, -2..max + 2] of Byte;
var
  S, T: Str200;
  b: TBoard;
  Res, n: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, S);
  n := Length(S);
  Close(f);
end;

procedure Init;
begin
  FillChar(b, SizeOf(b), max + 1);
  b[0, 0] := 0;
end;

function Min(x, y: Byte): Byte;
begin
  if x < y then Min := x else Min := y;
end;

procedure Optimize;
var
  i, V: Integer;
begin
  for i := 1 to n do
    for V := 0 to n do
      begin
        case S[i] of
          '(': b[i, V] := Min(b[i - 1, V - 1], b[i - 1, V + 1] + 1);
          ')': b[i, V] := Min(b[i - 1, V + 1], b[i - 1, V - 1] + 1);
        end;
      end;
end;

procedure Result;
var
  f: Text;
  i, V: Integer;
begin
  Res := b[n, 0];
  t[0] := S[0];
  V := 0;
  for i := n downto 1 do
    begin
      case S[i] of
       '(':  if b[i, V] = b[i - 1, V - 1] then T[i] := '('
             else T[i] := ')';
        ')': if b[i, V] = b[i - 1, V + 1] then T[i] := ')'
             else T[i] := '(';
      end;
      if T[i] = ')' then Inc(V) else Dec(V);
    end;
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
  Caption('Bµi 112: "Ch÷a ngoÆc"');
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
  h: Str200;
  i, c: Integer;
begin
  Caption('ChÊm bµi: "Ch÷a ngoÆc"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, h);
  Writeln('X©u ban ®Çu :', S);
  Write('X©u ®¸p ¸n  :');
  for i := 1 to Length(T) do
    begin
      if T[i] <> S[i] then TextAttr := 110
      else TextAttr := 159;
      Write(T[i]);
    end;
  TextAttr := 159; Writeln;
  Write('X©u häc sinh:');
  for i := 1 to Length(h) do
    begin
      if h[i] <> S[i] then TextAttr := 110
      else TextAttr := 159;
      Write(h[i]);
    end;
  TextAttr := 159; Writeln;
  if Length(h) <> n then
    begin
      Writeln('§é dµi x©u kh«ng ®óng!');
      Wrong;
    end;
  c := 0;
  for i := 1 to n do
    if h[i] <> S[i] then Inc(c);
  Writeln('Sè vÞ trÝ kh¸c nhau gi÷a x©u nguån vµ x©u ®Ých');
  Writeln('  + §¸p ¸n:  ', Res);
  Writeln('  + Häc sinh:', c);
  if c > Res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  c := 0;
  for i := 1 to n do
    begin
      if h[i] = '(' then Inc(c)
      else
        if h[i] = ')' then Dec(c)
        else
          begin
            Writeln('X©u kÕt qu¶ kh«ng lµ d·y ngoÆc ®óng!');
            Wrong;
          end;
      if c < 0 then
        begin
          Writeln('X©u kÕt qu¶ kh«ng lµ d·y ngoÆc ®óng!');
          Wrong;
        end;
    end;
  if c <> 0 then
    begin
      Writeln('X©u kÕt qu¶ kh«ng lµ d·y ngoÆc ®óng!');
      Wrong;
    end;
  Writeln('KÕt qu¶ chÝnh x¸c!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  Result;
  Test;
end.
