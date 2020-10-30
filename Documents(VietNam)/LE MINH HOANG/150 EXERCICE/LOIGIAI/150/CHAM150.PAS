program MatchingProblem;
uses crt, visual;
const
  InputFile: string = 'MATCH.IN';
  OutputFile = 'MATCH.OUT';
  max = 300;
type
  TLine = array[1..max] of Boolean;
var
  m, n: Integer;
  a: array[1..max] of ^TLine;
  matchX, matchY: array[1..max] of Integer;
  Trace: array[1..max] of Integer;
  res: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  i, j: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, m, n);
  for i := 1 to m do
    begin
      New(a[i]);
      FillChar(a[i]^, SizeOf(a[i]^), 0);
    end;
  while not SeekEof(f) do
    begin
      ReadLn(f, i, j);
      a[i]^[j] := True;
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
  {Greedy}
  for i := 1 to m do
    for j := 1 to n do
      if a[i]^[j] and (matchY[j] = 0) then
        begin
          matchX[i] := j;
          matchY[j] := i;
          Inc(res);
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
    if matchX[i] = 0 then
      begin
        Inc(last);
        Queue[last] := i;
      end;
  first := 1;
  while first <= last do
    begin
      i := Queue[first]; Inc(first);
      for j := 1 to n do
        if (Trace[j] = 0) and a[i]^[j] and (matchX[i] <> j) then
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
  MSG(60, 3, 'TÊng', 'TÊng Æi”m Æang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   Bπn c„ 1 Æi”m   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('ßÛng h’t c∏c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, '   Bπn c„ 0 Æi”m   '#7);
  ShowP;
  Halt;
end;

procedure AskTest;
var
  S: String[1];
begin
  Caption('Bµi 150: "BÈ gh–p c˘c Æπi"');
  MSG(40, 3, 'Input?', 'Cho t™n file d˜ li÷u: ' + InputFile + '  '#8#8);
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
      MSG(40, 13, 'ßi”m', 'TÊng Æi”m cÒa bπn Æang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  HSRes, x, y, i: Integer;
begin
  Caption('Ch m bµi 150: "BÈ gh–p c˘c Æπi"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, HSRes);
  Writeln('SË cπnh gh–p:');
  Writeln('  + ß∏p ∏n   : ', res);
  Writeln('  + H‰c sinh : ', hsres);
  if HSRes < Res then
    begin
      Writeln('Kh´ng tËi ≠u!');
      Wrong;
    end;
  Writeln('C∏c cπnh gh–p: ');
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  for i := 1 to HSRes do
    begin
      Readln(f, x, y);
      Writeln('  ', i, '. X[', x, '] - Y[', y, ']');
      if (x < 1) or (x > m) or (y < 1) or (y > n) or not a[x]^[y] then
        begin
          Writeln('Cπnh gh–p kh´ng hÓp l÷!');
          Wrong;
        end;
      if matchX[x] <> 0 then
        begin
          Writeln('ßÿnh X[', x, '] bﬁ gh–p 2 l«n!');
          Wrong;
        end;
      if matchY[y] <> 0 then
        begin
          Writeln('ßÿnh Y[', y, '] bﬁ gh–p 2 l«n!');
          Wrong;
        end;
      matchX[x] := y;
      matchY[y] := x;
    end;
  Writeln('K’t qu∂ ÆÛng');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Solve;
  Test;
end.
4 5
1 1
1 4
2 1
2 2
2 4
3 2
3 3
4 2
4 3