program AssignProblemSolver;
uses crt, visual;
const
  InputFile: string  = 'ASSIGN.IN';
  OutputFile = 'ASSIGN.OUT';
  maxM = 200;
  maxN = 1000;
type
  TLine = array[1..maxN] of Boolean;
  PLine = ^TLine;
var
  a: array[1..maxM] of PLine;
  matchX: array[1..maxN] of Integer;
  matchY: array[1..maxN] of Integer;
  head: array[0..maxM + 1] of Integer;
  Trace: array[1..maxM] of Integer;
  m, n: Integer;
  minWork, maxWork: Integer;
  Solution: Boolean;

  f: Text;
  ch: Char;
{$R-,Q-}
procedure Enter;
var
  f: Text;
  x, y: Integer;
  mark: array[1..maxN] of Boolean;
  c: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  FillChar(mark, SizeOf(mark), True);
  c := 0;
  for x := 1 to m do
    begin
      New(a[x]);
      FillChar(a[x]^, SizeOf(a[x]^), False);
      repeat
        Read(f, y);
        if y = 0 then Break;
        a[x]^[y] := True;
        if mark[y] then
          begin
            mark[y] := False;
            Inc(c);
          end;
      until False;
      Readln(f);
    end;
  Close(f);
  Solution := c = n;
end;

procedure Init;
begin
  minWork := 0;
  maxWork := 0;
  FillChar(matchX, SizeOf(matchX), 0);
end;
{$R-}
procedure CreateAdjmatchY;
var
  i, j: Integer;
begin
  {Distribution counting}
  FillChar(head, SizeOf(head), 0);
  for j := 1 to n do
    begin
      i := matchX[j];
      if i <> 0 then Inc(head[i]);
    end;
  for i := 2 to m do head[i] := head[i - 1] + head[i];
  head[m + 1] := head[m];
  {Add to adj list}
  for j := 1 to n do
    begin
      i := matchX[j];
      if i <> 0 then
        begin
          matchY[head[i]] := j;
          Dec(head[i]);
        end;
    end;
  {match(X[i]) thuoc vao doan tu matchY[head[i] + 1] den matchY[head[i + 1]]}
end;

function FindAugmentingPath(threshold: Integer): Integer;
var
  Q: array[1..maxN] of Integer;
  free: array[0..maxN] of Boolean;
  i, j, id: Integer;
  first, last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  FillChar(free, SizeOf(free), True);
  CreateAdjmatchY;
  last := 0;
  for j := 1 to n do
    if matchX[j] = 0 then
      begin
        Inc(last);
        Q[last] := j;
        free[j] := False;
      end;
  first := 1;
  while first <= last do
    begin
      j := Q[first]; Inc(first);
      for i := 1 to m do
        begin
          if (Trace[i] = 0) and (a[i]^[j]) and (matchX[j] <> i) then
            begin
              Trace[i] := j;
              if head[i + 1] - head[i] < threshold then
                begin
                  FindAugmentingPath := i;
                  Exit;
                end;
              for id := head[i] + 1 to head[i + 1] do
                if Free[matchY[id]] then
                  begin
                    Inc(last);
                    Q[last] := matchY[id];
                    free[matchY[id]] := False;
                  end;
            end;
        end;
    end;
  FindAugmentingPath := 0;
end;

procedure Enlarge(finish: Integer);
var
  j, next: Integer;
begin
  repeat
    j := Trace[finish];
    next := matchX[j];
    matchX[j] := finish;
    finish := next;
  until finish = 0;
end;

procedure Solve;
var
  finish, c, w: Integer;
begin
  w := 0;
  c := 0;
  repeat
    Inc(w);
    repeat
      finish := FindAugmentingPath(w);
      if finish <> 0 then
        begin
          Inc(c);
          Enlarge(finish);
        end
      else Break;
    until False;
  until c = n;
end;

procedure Result;
var
  i, id: Integer;
begin
  minWork := maxInt; maxWork := 0;
  CreateAdjmatchY;
  for i := 1 to m do
    begin
      if head[i + 1] - head[i] > maxWork then
        maxWork := head[i + 1] - head[i];
      if head[i + 1] - head[i] < minWork then
        minWork := head[i + 1] - head[i];
    end;
end;

{$R+}
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
  Caption('Bµi 121: "Ph©n c«ng"');
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
  msg, hsmsg: string;
  i, j, HSRes, HSMin: Integer;
  Mark: array[1..maxN] of Integer;
begin
  Caption('ChÊm bµi 121: "Ph©n c«ng"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Writeln('Dßng ®Çu tiªn: ');
  if solution then msg := 'YES' else msg := 'NO';
  Writeln('  + §¸p ¸n  : ', msg);
  Readln(f, hsmsg);
  Writeln('  + Häc sinh: ', hsmsg);
  if msg <> hsmsg then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  if msg = 'NO' then Correct;
  Readln(f, HSRes);
  Writeln('Thêi gian thùc hiÖn: ');
  Writeln('  + §¸p ¸n  : ', maxWork);
  Writeln('  + Häc sinh: ', HSRes);
  if HSRes > maxWork then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Writeln('KiÓm tra phÐp ph©n c«ng: ');
  FillChar(Mark, SizeOf(Mark), False);
  for i := 1 to m do
    begin
      repeat
        Read(f, j);
        if (j > n) or (j < 0) then
          begin
            Writeln('Sai khu«n d¹ng Output!');
            Wrong;
          end;
        if j <> 0 then
          begin
            if Mark[j] <> 0 then
              begin
                Writeln('ViÖc ', j, ' ph©n c«ng 2 lÇn!');
                Wrong;
              end;
            Mark[j] := i;
          end;
      until j = 0;
      Readln(f);
    end;
  for j := 1 to n do
    if Mark[j] = 0 then
      begin
        Writeln('ViÖc ', j, ' ch­a ®­îc ph©n c«ng!');
        Wrong;
      end;
  Writeln('  OK!');
  for j := 1 to n do matchX[j] := Mark[j];
  CreateAdjMatchY;
  HSMin := maxInt;
  for i := 1 to m do
    if head[i + 1] - head[i] < HSMin then
      HSMin := head[i + 1] - head[i];
  Writeln('Sè viÖc tèi thiÓu ph©n cho 1 thî: ');
  Writeln('  + §¸p ¸n   : ', minWork);
  Writeln('  + Häc sinh : ', HSMin);
  if HSMin < minWork then
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
  if Solution then
    begin
      Init;
      Solve;
      Result
    end;
  Test;
end.

