program MatchingProblem;
uses crt, visual;
const
  InputFile: string = 'GRID.IN';
  OutputFile = 'GRID.OUT';
  max = 200;
var
  res, m, n: Integer;
  a: array[1..max, 1..max] of Char;
  matchX, matchY: array[1..max] of Integer;
  FreeX, FreeY: array[1..max] of Boolean;
  Trace: array[1..max] of Integer;
  LampOn: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  i, j: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(a, SizeOf(a), False);
  FillChar(FreeX, SizeOf(FreeX), True);
  FilLChar(FreeY, SizeOf(FreeY), True);
  ReadLn(f, m, n);
  LampOn := 0;
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, a[i, j]);
          if a[i, j] = '*' then
            begin
              FreeX[i] := False;
              FreeY[j] := False;
              Inc(LampOn);
            end;
        end;
      Readln(f);
    end;
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  res := 0;
  for i := 1 to m do
    if FreeX[i] then
      for j := 1 to n do
        if FreeY[j] and (a[i, j] = '+') and (matchY[j] = 0) then
          begin
            Inc(res);
            matchX[i] := j;
            matchY[j] := i;
            Break;
          end;
end;

function FindAugmentingPath: Integer;
var
  Queue: array[1..max] of Integer;
  i, j, first, last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  last := 0;
  for i := 1 to m do
    if FreeX[i] and (matchX[i] = 0) then
      begin
        Inc(last);
        Queue[last] := i;
      end;
  first := 1;
  while first <= last do
    begin
      i := Queue[first]; Inc(first);
      for j := 1 to n do
        if FreeY[j] and (Trace[j] = 0) and (a[i, j] = '+') then
          begin
            Trace[j] := i;
            if matchY[j] = 0 then
              begin
                FindAugmentingPath := j;
                Exit;
              end;
            Inc(last);
            Queue[last] := matchY[j];
          end;
    end;
  FindAugmentingPath := 0;
end;

procedure Enlarge(f: Integer);
var
  x, next: Integer;
begin
  repeat
    x := Trace[f];
    next := matchX[x];
    matchX[x] := f;
    matchY[f] := x;
    f := next;
  until f = 0;
end;

procedure Solve;
var
  finish: Integer;
begin
  repeat
    finish := FindAugmentingPath;
    if finish <> 0 then
      begin
        Inc(res);
        Enlarge(finish);
      end;
  until finish = 0;
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
  Caption('Bµi ""');
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
  hsres: Integer;
  c: Char;
  row, col: array[1..max] of Integer;
  i, j, total: Integer;
begin
  Caption('ChÊm bµi 153: "Dµn ®Ìn"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Enter;
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsres);
  Writeln('Sè ®Ìn bËt thªm: ');
  Writeln('  + §¸p ¸n:   ', res);
  Writeln('  + Häc sinh: ', hsres);
  if hsres < res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  FillChar(row, SizeOf(row), 0);
  FillChar(col, SizeOf(col), 0);
  total := 0;
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, c);
          if not (c in ['.', '+', '*']) then
            begin
              Writeln('Ký tù l¹ (', i, ', ', j, ') = ', c);
              Wrong;
            end;
          if (a[i, j] = '*') then
            begin
              Inc(row[i]); Inc(col[j]);
            end;
          if (a[i, j] = '+') and (c = '*') then
            begin
              Inc(row[i]); Inc(col[j]);
              Inc(Total);
            end
          else
            if c <> a[i, j] then
              begin
                Writeln('¤ (', i, ', ', j, ') sai!');
                Wrong;
              end;
        end;
      Readln(f);
    end;
  Writeln('KÕt qu¶ kiÓm tra l­íi: ');
  Writeln('  Sè ®Ìn bËt thªm: ', Total);
  if Total <> hsres then
    begin
      Writeln('TiÒn hËu bÊt nhÊt!');
      Wrong;
    end;
  for i := 1 to m do
    if row[i] > 1 then
      begin
        Writeln('Hµng ', i, ' cã ', row[i], ' ®Ìn s¸ng!');
        Wrong;
      end;
  for j := 1 to m do
    if col[j] > 1 then
      begin
        Writeln('Cét ', j, ' cã ', col[j], ' ®Ìn s¸ng!');
        Wrong;
      end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
  Close(f);
end;

begin
  AskTest;
  Enter;
  Init;
  Solve;
  Test;
end.
4 5
+..*.
++.+.
.++..
.++..
