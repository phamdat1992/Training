{$R-,Q-,S-}
program Traffic;
uses crt, visual;
const
  InputFile: string  = 'TRAFFIC.IN';
  OutputFile = 'TRAFFIC.OUT';
  max = 200;
var
  a: array[1..max, 1..max] of Byte;
  Numbering, Low, Stack: array[1..max] of Integer;
  Exist: array[1..max] of Boolean;
  Res, n, Count, nStack: Integer;
  FirstHead, LastHead: Integer;

  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  m, i, u, v: Integer;
begin
  FillChar(a, SizeOf(a), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      a[u, v] := 1;
    end;
  Close(f);
end;

function Min(x, y: Integer): Integer;
begin
  if x < y then Min := x else Min := y;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Inc(Count);
  Numbering[u] := Count; Low[u] := Count;
  Inc(nStack);
  Stack[nStack] := u;
  for v := 1 to n do
    if Exist[v] and (a[u, v] <> 0) then
      if (Numbering[v] <> 0) then
        Low[u] := Min(Low[u], Numbering[v])
      else
        begin
          Visit(v);
          Low[u] := Min(Low[u], Low[v]);
        end;
  if Low[u] = Numbering[u] then {u is the header of strong connected cmp}
    begin
      LastHead := u;
      if FirstHead = 0 then FirstHead := u;
      repeat
        v := Stack[nStack]; Dec(nStack); {Pop}
        Exist[v] := False;  {Remove}
      until v = u;
    end;
end;

procedure Number;
var
  u: Integer;
begin
  Count := 0;
  FillChar(Numbering, SizeOf(Numbering), 0);
  FillChar(Exist, SizeOf(Exist), True);
  nStack := 0;
  FirstHead := 0;
  for u := 1 to n do
    if Numbering[u] = 0 then Visit(u);
end;

procedure Solve;
begin
  repeat
    Number;
    if FirstHead = LastHead then Exit; {Only 1 head, Graph is strong connected}
    Inc(Res);
    a[FirstHead, LastHead] := 2;  {Add Arc from First to Last Head}
  until False;
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
  Caption('Bµi 117: "§­êng mét chiÒu"');
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

{$R+,Q+}

procedure Test;
var
  nHS, i, u, v: Integer;
begin
  Caption('ChÊm bµi 117: "§­êng mét chiÒu"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, nHS);
  Writeln('Sè ®o¹n ®­êng nèi thªm: ');
  Writeln('  + §¸p ¸n   : ', Res);
  Writeln('  + Häc sinh : ', nHS);
  if nHS > Res then
    begin
      Writeln('Tåi h¬n ®¸p ¸n!');
      Wrong;
    end;
  Writeln;
  Enter;
  for i := 1 to nHS do
    begin
      Readln(f, u, v);
      a[u, v] := 1;
    end;
  Number;
  if FirstHead <> LastHead then
    begin
      Writeln('Sau khi thªm ®Ønh ®å thÞ vÉn kh«ng liªn th«ng!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Res := 0;
  Solve;
  Test;
end.

13 15
1 9
1 12
2 3
3 4
4 1
4 5
5 2
6 7
7 1
7 8
8 6
9 10
10 11
11 9
12 13