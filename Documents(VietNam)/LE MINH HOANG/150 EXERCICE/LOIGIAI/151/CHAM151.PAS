program AssignmentProblemSolve;
uses crt, visual;
const
  InputFile: string  = 'MATCH.IN';
  OutputFile = 'MATCH.OUT';
  max = 200;
  maxC = 40001;
var
  c: array[1..max, 1..max] of Byte;
  Fx, Fy: array[1..max] of LongInt;
  matchX, matchY: array[1..max] of Integer;
  Trace, Queue: array[1..max] of Integer;
  d: array[1..max] of LongInt;
  arg: array[1..max] of Integer;
  first, last: Integer;
  start, finish: Integer;
  n: Integer;
  f: Text;
  ch: Char;
  res: LongInt;

procedure Enter;
var
  i, j: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n);
  for i := 1 to n do
    for j := 1 to n do c[i, j] := 255;
  while not SeekEof(f) do ReadLn(f, i, j, c[i, j]);
  Close(f);
end;
{$R-,Q-}
procedure Init;
var
  i, j: Integer;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  for i := 1 to n do
    begin
      Fx[i] := maxC;
      for j := 1 to n do
        if c[i, j] < Fx[i] then Fx[i] := c[i, j];
    end;
  for j := 1 to n do
    begin
      Fy[j] := maxC;
      for i := 1 to n do
        if c[i, j] - Fx[i] < Fy[j] then Fy[j] := c[i, j] - Fx[i];
    end;
end;

function GetC(i, j: Integer): LongInt;
begin
  if c[i, j] <> 255 then
    GetC := LongInt(c[i, j]) - Fx[i] - Fy[j]
  else
    GetC := LongInt(MaxC) - Fx[i] - Fy[j];
end;

procedure InitBFS;
var
  y: Integer;
begin
  first := 1; last := 1;
  Queue[1] := start;
  FillChar(Trace, SizeOf(Trace), 0);
  for y := 1 to n do
    begin
      d[y] := GetC(start, y);
      arg[y] := start;
    end;
  finish := 0;
end;

procedure Push(v: Integer);
begin
  Inc(last); Queue[last] := v;
end;

function Pop: Integer;
begin
  Pop := Queue[first]; Inc(first);
end;

procedure FindAugmentingPath;
var
  i, j: Integer;
  w: LongInt;
begin
  repeat
    i := Pop;
    for j := 1 to n do
      if Trace[j] = 0 then
        begin
          w := GetC(i, j);
          if w = 0 then
            begin
              Trace[j] := i;
              if matchY[j] = 0 then
                begin
                  finish := j;
                  Exit;
                end;
              Push(matchY[j]);
            end;
          if d[j] > w then
            begin
              d[j] := w;
              arg[j] := i;
            end;
        end;
  until first > last;
end;

procedure SubX_AddY;
var
  Delta: Word;
  x, y: Integer;
begin
  Delta := maxC;
  for y := 1 to n do
    if (Trace[y] = 0) and (d[y] < Delta) then Delta := d[y];
  Fx[start] := Fx[start] + Delta;
  for y := 1 to n do
    if Trace[y] <> 0 then
      begin
        x := matchY[y];
        Fy[y] := Fy[y] - Delta;
        Fx[x] := Fx[x] + Delta;
      end
    else
      d[y] := d[y] - Delta;
  for y := 1 to n do
    if (Trace[y] = 0) and (d[y] = 0) then
      begin
        Trace[y] := arg[y];
        if matchY[y] = 0 then
          begin
            finish := y;
            Exit;
          end;
        Push(matchY[y]);
      end;
end;

procedure Enlarge;
var
  x, next: Integer;
begin
  repeat
    x := Trace[finish];
    next := matchX[x];
    matchX[x] := finish;
    matchY[finish] := x;
    finish := Next;
  until finish = 0;
end;

procedure Solve;
var
  x, y: Integer;
begin
  for x := 1 to n do
    begin
      start := x;
      InitBFS;
      repeat
        FindAugmentingPath;
        if finish = 0 then SubX_AddY;
      until finish <> 0;
      Enlarge;
    end;
end;

procedure Result;
var
  x, y: Integer;
  W: Word;
begin
  W := 0;
  for x := 1 to n do
    begin
      y := matchX[x];
      W := W + c[x, y];
    end;
  Res := W;
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
  Caption('Bµi 151: "Bé ghÐp ®Çy ®ñ träng sè cùc tiÓu"');
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
  HSW, W: LongInt;
  k, i, j: Integer;
begin
  Caption('ChÊm bµi 151: "Bé ghÐp ®Çy ®ñ träng sè cùc tiÓu"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, HSW);
  Writeln('Träng sè bé ghÐp: ');
  Writeln('  + §¸p ¸n:   ', res);
  Writeln('  + Häc sinh: ', HSW);
  if HSW > res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  W := 0;
  for k := 1 to n do
    begin
      Readln(f, i, j);
      Writeln(k, '. X[', i, ']-Y[', j, ']');
      if (i < 1) or (i > n) or (j < 1) or (j > n) then
        begin
          Writeln('ChØ sè kh«ng hîp lÖ!');
          Wrong;
        end;
      if c[i, j] = 255 then
        begin
          Writeln('Kh«ng ph¶i lµ c¹nh!');
          Wrong;
        end;
      W := W + c[i, j];
    end;
  Writeln('Chi phÝ tÝnh theo bé ghÐp: ', W);
  if W <> HSW then
    begin
      Writeln('TiÒn hËu bÊt nhÊt!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Solve;
  Result;
  Test;
end.
