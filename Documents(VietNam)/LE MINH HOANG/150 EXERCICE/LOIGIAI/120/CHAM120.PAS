program TAX;
uses crt, visual;
const
  InputFile: string = 'TAX.IN';
  OutputFile = 'TAX.OUT';
  max = 600;
type
  TArray = array[1..max] of Boolean;
  PArray = ^TArray;
var
  a: array[1..max] of PArray;
  matchX, matchY: array[1..max] of Integer;
  Trace: array[1..max] of Integer;
  resX, resY, m, n: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for u := 1 to m do
    begin
      New(a[u]);
      FillChar(a[u]^, SizeOf(a[u]^), False);
    end;
  while not SeekEof(f) do
    begin
      Readln(f, u, v);
      a[u]^[v] := True;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
end;
{$R-}
function FindAugmentingPath: Integer;
var
  Q: array[1..max] of Integer;
  i, j, first, last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  last := 0;
  for i := 1 to m do
    if matchX[i] = 0 then
      begin
        Inc(last); Q[last] := i;
      end;
  first := 1;
  while first <= last do
    begin
      i := Q[first]; Inc(first);
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
            Q[last] := matchY[j];
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
  Finish: Integer;
begin
  repeat
    Finish := FindAugmentingPath;
    if Finish <> 0 then Enlarge(Finish);
  until Finish = 0;
end;

procedure Result;
var
  i, j: Integer;
  Mark: array[1..max] of Boolean;
begin
  FillChar(Mark, SizeOf(Mark), False);
  resY := 0;
  for j := 1 to n do
    if Trace[j] <> 0 then
      begin
        Inc(resY);
        Mark[matchY[j]] := True;
      end;
  resX := m;
  for i := 1 to m do
    if (matchX[i] = 0) or Mark[i] then Dec(resX);
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
  Caption('Bµi 120: "Thu thuÕ"');
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
  P, Q, i, j, k: Integer;
  MarkX, MarkY: array[1..max] of Boolean;
begin
  Caption('ChÊm bµi 120: "Thu thuÕ"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, P, Q);
  Writeln('Sè tr¹m thuÕ: ');
  Writeln('    + §¸p ¸n  : ', resX + resY, ' = ', resX, ' + ', resY);
  Writeln('    + Häc sinh: ', P + Q, ' = ', P, ' + ', Q);
  if resX + resY < P + Q then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Writeln;
  Writeln('KiÓm tra hÖ thèng tr¹m thuÕ');
  FillChar(MarkX, SizeOf(MarkX), False);
  FillChar(MarkY, SizeOf(MarkY), False);
  for i := 1 to P do
    begin
      Read(f, k);
      if (k < 1) or (k > m) then
        begin
          Writeln('Sai khu«n d¹ng Output!');
          Wrong;
        end;
      MarkX[k] := True;
    end;
  for j := 1 to Q do
    begin
      Read(f, k);
      if (k < 1) or (k > n) then
        begin
          Writeln('Sai khu«n d¹ng Output!');
          Wrong;
        end;
      MarkY[k] := True;
    end;
  for i := 1 to m do
    for j := 1 to n do
      if a[i]^[j] and not MarkX[i] and not MarkY[j] then
        begin
          Write(' Cã ®­êng bu«n lËu:');
          Writeln(' X[', i, '] <---> Y[', j, ']');
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

4 4
1 1
1 2
1 3
1 4
2 4
3 4
4 4