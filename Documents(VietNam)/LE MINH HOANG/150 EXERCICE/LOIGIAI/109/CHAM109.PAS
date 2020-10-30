{$R-,S-,Q-}
program SerieA;
uses crt, visual;
const
  InputFile: String = 'SERIEA.IN';
  OutputFile = 'SERIEA.OUT';
  STDFile = 'SERIEA.STD';
  max = 1000;
type
  Str3 = String[3];
  FC = record
    nWin, nLost, nDraw: Integer;
    nG, Diff, Point: Integer;
    Name: Str3;
  end;
var
  n: Integer;
  FCs: array[0..max] of FC;
  f, g: Text;
  Ch: Char;

procedure SortName;
var
  i, j, h: Integer;
  V: FC;
begin
  h := n div 2;
  while h > 0 do
    begin
      for i := 1 + h to n do
        begin
          j := i - h; V := FCs[i];
          while (j > 0) and (FCs[j].Name > V.Name) do
            begin
              FCs[j + h] := FCs[j];
              j := j - h;
            end;
          FCs[j + h] := V;
        end;
      h := h div 2;
    end;
end;

function FindByName(Nm: Str3): Integer;
var
  inf, sup, median: Integer;
begin
  inf := 0; sup := n;
  repeat
    median := (inf + sup) div 2;
    if FCs[median].Name < Nm then inf := median
    else sup := median;
  until inf + 1 >= sup;
  FindByName := sup;
end;

procedure Enter;
var
  f: Text;
  i: Integer;
  name1, name2: Str3;
  space: Char;
  i1, i2, g1, g2: Integer;
begin
  FillChar(FCs, SizeOf(FCs), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Readln(f, FCs[i].Name);
  SortName;
  while not SeekEof(f) do
    begin
      Readln(f, name1, space, name2, g1, g2);
      i1 := FindByName(name1);
      i2 := FindByName(name2);
      if g1 > g2 then
        begin
          FCs[i1].Point := FCs[i1].Point + 3;
          Inc(FCs[i1].nWin);
          Inc(FCs[i2].nLost);
        end
      else
        if g1 < g2 then
          begin
            FCs[i2].Point := FCs[i2].Point + 3;
            Inc(FCs[i2].nWin);
            Inc(FCs[i1].nLost);
          end
        else
          begin
            Inc(FCs[i1].Point); Inc(FCs[i2].Point);
            Inc(FCs[i2].nDraw);
            Inc(FCs[i1].nDraw);
          end;
      with FCs[i1] do
        begin
          nG := nG + g1;
          Diff := Diff + g2;
        end;
      with FCs[i2] do
        begin
          nG := nG + g2;
          Diff := Diff + g1;
        end;
    end;
  for i := 1 to n do
    with FCs[i] do Diff := nG - Diff;
  Close(f);
end;

function Higher(a, b: FC): Boolean;
begin
  if a.Point > b.Point then
    begin
      Higher := True;
      Exit;
    end;
  if a.Point < b.Point then
    begin
      Higher := False;
      Exit;
    end;
  Higher := (a.Diff > b.Diff) or
            (a.Diff = b.Diff) and (a.nG > b.nG) or
            (a.Diff = b.Diff) and (a.nG = b.nG) and (a.Name < b.Name);
end;

procedure Solve;
var
  i, j, h: Integer;
  V: FC;
begin
  h := n div 2;
  while h > 0 do
    begin
      for i := 1 + h to n do
        begin
          V := FCs[i]; j := i - h;
          while (j > 0) and Higher(V, FCs[j]) do
            begin
              FCs[j + h] := FCs[j];
              j := j - h;
            end;
           FCs[j + h] := V;
        end;
      h := h div 2;
    end;
end;

procedure PrintAll;
var
  i: Integer;
  f: Text;
begin
  Assign(f, StdFile); Rewrite(f);
  for i := 1 to n do
    with FCs[i] do
      Writeln(f, Name, ' ', nWin + nLost + nDraw, ' ', Point, ' ',
                 nWin, ' ', nLost, ' ', nDraw, ' ',
                 nG, ' ', nG - Diff, ' ', Diff);
  Close(f);
end;

procedure Halt;
begin
  {$I-}
  Close(f); if IOResult = 0 then;
  Close(g); if IOResult = 0 then;
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
  Caption('Bµi 109 "Serie A"');
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
  i: Integer;
  S, T: String;
begin
  Caption('Ch m bµi 109: "Serie A"');
  Visual.Color := 159;
  FlatFrame(1, 7, 79, 23, 'Ki”m tra');
  Writeln('Danh s∏ch x’p hπng: ');
  Assign(f, OutputFile); Reset(f);
  Assign(g, StdFile); Reset(g);
  for i := 1 to n do
    begin
      Readln(f, S); Readln(g, T);
      Write(i:4, '.   ', S);
      if S <> T then
        begin
          Writeln('  K’t qu∂ sai!');
          TextAttr := 236;
          Writeln('ß∏p ∏n: ', T);
          Wrong;
        end
      else Writeln('  OK!');
    end;
  Write('K’t qu∂ ÆÛng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Solve;
  PrintAll;
  Test;
end.
6
JUV
MIL
ROM
BAR
INT
LAZ
JUV MIL 3 3
ROM BAR 4 1
JUV INT 2 1
JUV ROM 2 2
LAZ BAR 6 0
ROM INT 1 2
MIL ROM 2 2