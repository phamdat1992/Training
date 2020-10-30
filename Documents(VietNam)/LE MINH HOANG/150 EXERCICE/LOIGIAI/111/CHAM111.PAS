{$R-,S-,Q-}
program Thetour;
uses crt, visual;
const
  InputFile: String  = 'SEQ.IN';
  OutputFile = 'SEQ.OUT';
  max = 100;
var
  a: array[1..101] of Integer;
  n, k: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, k);
  for i := 1 to n do Read(f, a[i]);
  Close(f);
end;

procedure R(i: Integer);
begin
  a[i] := a[i] - a[i + 1];
  Move(a[i + 2], a[i + 1], (n - i - 1) * SizeOf(a[1]));
  Dec(n);
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
  Caption('Bµi "Co d·y sè"');
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
  i, p, j: Integer;

  procedure Print(i: Integer);
  var
    j: Integer;
  begin
    Write(' a = (');
    for j := 1 to n do
      begin
        if (j = i) or (j = i + 1) then TextAttr := 236
        else TextAttr := 159;
        if j <> n then Write(a[j], ',')
        else Write(a[j], ')');
      end;
    TextAttr := 159;
    Writeln('; n = ', n);
  end;

begin
  Caption('ChÊm bµi: "Co d·y sè"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Write(' a = (');
  for j := 1 to n - 1 do Write(a[j], ', ');
  Writeln(a[n], '); n = ', n);
  for i := 1 to n - 1 do
    begin
      Readln(f, j);
      if (j < 1) or (j > n - 1) then
        begin
          Writeln('PhÐp co kh«ng hîp lÖ!');
          Wrong;
        end;
      Print(j);
      R(j);
      Writeln('R(', j, '): ');
    end;
  Print(-2);
  Writeln('Sè cuèi cïng theo yªu cÇu: ', k);
  if k <> a[1] then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ chÝnh x¸c!');
  Correct;
end;

begin
  Asktest;
  Enter;
  Test;
end.
5 5
1 3 2
2 4 2
3 5 2
4 1 2
5 2 2
1 2 3
2 3 3
3 4 3
4 5 3
5 1 3
