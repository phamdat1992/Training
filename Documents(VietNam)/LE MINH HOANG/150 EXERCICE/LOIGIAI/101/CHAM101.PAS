{$R-,S-,Q-}
program WriteFilestoDisks;
uses crt, visual;
const
  InputFile: String = 'DISKS.IN';
  OutputFile = 'DISKS.OUT';
  max = 100;
  maxSpace = 10000;
  TIMEOVER = 2 * 18;
type
  TArray = array[1..max] of Integer;
var
  a, Index, Disk, Lab, Free, SaveLab: TArray;
  Res, n, m, minDisks, Tmin: Integer;
  Start: LongInt;
  Time: LongInt absolute 0:$46C;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to n do Read(f, a[i]);
  Close(f);
end;

procedure Sort;
var
  i, j, temp1, temp2: Integer;
begin
  for i := 1 to n do Index[i] := i;
  for i := 2 to n do
    begin
      temp1 := a[i]; temp2 := Index[i];
      j := i - 1;
      while (j > 0) and (a[j] < temp1) do
        begin
          a[j + 1] := a[j];
          Index[j + 1] := Index[j];
          Dec(j);
        end;
      a[j + 1] := temp1;
      Index[j + 1] := temp2;
    end;
end;

procedure Init;
var
  i: Integer;
  S: LongInt;
begin
  for i := 1 to n do Free[i] := m;
  FillChar(Disk, SizeOf(Disk), 0);
  minDisks := n + 1;
  S := 0;
  for i := 1 to n do S := S + a[i];
  if S mod m = 0 then Tmin := S div m
  else Tmin := S div m + 1;
end;

function CheckByGreedy: Integer;
var
  i, jmin, j, minspace, nDisks: Integer;
  FreeS: TArray;
begin
  Move(Disk, Lab, n * SizeOf(Disk[1]));
  Move(Free, FreeS, n * SizeOf(Disk[1]));
  for i := 1 to n do
    if Lab[i] = 0 then
      begin
        minspace := maxspace + 1;
        for j := 1 to n do
          if (FreeS[j] >= a[i]) and (FreeS[j] < minspace) then
            begin
              minspace := FreeS[j];
              jmin := j;
            end;
        Lab[i] := jmin;
        FreeS[jmin] := FreeS[jmin] - a[i];
      end;
  nDisks := n;
  while FreeS[nDisks] = m do Dec(nDisks);
  CheckByGreedy := nDisks;
end;

procedure Update;
var
  t: Integer;
begin
  t := CheckByGreedy;
  if t < minDisks then
    begin
      minDisks := t;
      SaveLab := Lab;
    end;
end;

procedure Try(prev, d, nFiles: Integer);
var
  j: Integer;
  Stop: Boolean;
begin
  if (d >= minDisks) or (minDisks = Tmin) or (nFiles <= 0)
     or (Time - Start >= TIMEOVER) then Exit;
  Update;
  Stop := True;
  for j := prev + 1 to n do
    if (Disk[j] = 0) and (Free[d] >= a[j]) then
      begin
        Stop := False;
        Disk[j] := d;
        Free[d] := Free[d] - a[j];
        Try(j, d, nFiles - 1);
        Disk[j] := 0;
        Free[d] := Free[d] + a[j];
        if (d >= minDisks) or (minDisks = Tmin)
           or (Time - Start >= TIMEOVER) then Exit;
      end;
  if Stop then Try(0, d + 1, nFiles);
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

procedure WriteP(p: Real);
var
  f: file of Real;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Real;
var
  f: file of Real;
  P: Real;
begin
  Assign(f, 'POINT.PNT'); Reset(f);
  Read(f, P);
  Close(f);
  ReadP := p;
end;

procedure ShowP;
var
  S: String;
begin
  Str(ReadP:5:2, S);
  Visual.Color := 30;
  MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP >= 10 then
    Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong(P: Real);
var
  S: String;
begin
  Visual.Color := 78;
  Str(P:5:2, S);
  MSG(20, 3, InputFile, '   B¹n cã ' + S + ' ®iÓm   '#7);
  WriteP(ReadP + P);
  ShowP;
  Halt;
end;

procedure AskTest;
var S: String;
begin
  Caption('Bµi "Ghi ®Üa"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      Str(ReadP:5:2, S);
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ: ' + S + '/10');
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  T, i, j: Integer;
begin
  Caption('ChÊm bµi: "Ghi ®Üa"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, T);
  Writeln('Sè ®Üa ph¶i dïng: ');
  Writeln(  '+ §¸p ¸n  :  ', minDisks);
  Writeln(  '+ Häc sinh:  ', T);
  if T > minDisks then Writeln('Tåi h¬n ®¸p ¸n!')
  else
    if T = minDisks then Writeln('Tåi nh­ ®¸p ¸n!')
    else Writeln('Tèt h¬n ®¸p ¸n!');
  Writeln;
  Writeln('KiÓm tra ph­¬ng ¸n ghi ®Üa');
  Enter;
  for i := 1 to n do Free[i] := m;
  FillChar(Disk, SizeOf(Disk), 0);
  for i := 1 to T do
    begin
      while not SeekEoln(f) do
        begin
          Read(f, j);
          if Disk[j] <> 0 then
            begin
              Writeln('File thø ', j, ' bÞ ghi vµo 2 ®Üa!');
              Wrong(0);
            end;
          Free[i] := Free[i] - a[j];
          Disk[j] := i;
          if Free[i] < 0 then
            begin
              Writeln('§Üa thø ', i, ' trµn! ');
              Wrong(0);
            end;
        end;
      Readln(f);
    end;
  Close(f);
  for j := 1 to n do
    if Disk[j] = 0 then
      begin
        Writeln('File thø ', j, ' ch­a ®­îc ghi vµo ®Üa nµo!');
        Wrong(0);
      end;
  Writeln('C¸ch ghi ®Üa hîp lÖ!');
  if T <= minDisks then Correct
  else Wrong(Sqr(minDisks / T));
end;

begin
  AskTest;
  Start := Time;
  Enter;
  Sort;
  Init;
  Try(0, 1, n);
  Test;
end.
