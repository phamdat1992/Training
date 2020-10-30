{$A+,B-,D-,E-,F-,G-,I-,L+,N+,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 65520,0,655360}
program Chords;
uses crt, Visual;
const
  InputFile: String  = 'CHORDS.IN';
  OutputFile = 'CHORDS.OUT';
  max = 10000; {n khong qua 5000}
  maxV = 10000;
type
  TColor = (clRed, clBlue);
  TPoint = record
    x: Integer;
    y: ShortInt;
  end;
  TList = array[1..max] of TPoint;
  TIndex = array[1..max] of Integer;
var
  XY: TList;
  Index, Code: ^TIndex;
  Color: array[1..max] of Char;
  match: array[1..max div 2, 1..2] of Integer;
  n, m: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  ch: Char;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n); m := n shl 1;
  for i := 1 to m do
    Readln(f, Color[i], XY[i].x, XY[i].y);
  Close(f);
end;

procedure Sort;
type
  TCount = array[-10000..10000] of Integer;
var
  i, v, t, add: Integer;
  Count: ^TCount;
begin
  New(Count);
  FillChar(Count^, SizeOf(Count^), 0);
  New(Index);
  for i := 1 to m do
    if XY[i].y < 0 then Inc(Count^[xy[i].x]);
  for v := -maxV + 1 to maxV do
    Count^[v] := Count^[v - 1] + Count^[v];
  add := Count^[maxV];
  for i := 1 to m do
    if XY[i].y < 0 then
      begin
        t := XY[i].x;
        Index^[Count^[t]] := i;
        Dec(Count^[t]);
      end;
  FillChar(Count^, SizeOf(Count^), 0);
  for i := 1 to m do
    if XY[i].y > 0 then Inc(Count^[xy[i].x]);
  for v := maxV - 1 downto -maxV do
    Count^[v] := Count^[v + 1] + Count^[v];
  for i := 1 to m do
    if XY[i].y > 0 then
      begin
        t := XY[i].x;
        Index^[Count^[t] + add] := i;
        Dec(Count^[t]);
      end;
  Dispose(Count);
end;

procedure InitCode;
var
  i: Integer;
begin
  New(Code);
  for i := 1 to m do
    Code^[Index^[i]] := i;
  FillChar(Index^, SizeOf(Index^), 0);
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
  Assign(f, 'POINT.TXT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Integer;
var
  f: file of Integer;
  P: Integer;
begin
  Assign(f, 'POINT.TXT'); Reset(f);
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
  MSG(20, 3, InputFile, 'B¹n cã 1 ®iÓm');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, 'B¹n cã 0 ®iÓm'#7);
  ShowP;
  Halt;
end;

procedure AskTest;
begin
  Caption('Bµi 080: D©y cung');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: CHORDS.IN  '#8#8);
  ch := ReadKey;
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

function Cut(m1, m2: Integer): Boolean;
var
  i, i1, i2, i3, i4: LongInt;
  f1, f2: Boolean;
begin
  i1 := Code^[match[m1, 1]];
  i2 := Code^[match[m1, 2]];
  if i1 > i2 then
    begin
      i := i1; i1 := i2; i2 := i;
    end;
  i3 := Code^[match[m2, 1]];
  i4 := Code^[match[m2, 2]];

  f1 := (i3 > i1) and (i3 < i2);
  f2 := (i4 > i1) and (i4 < i2);
  Cut := f1 xor f2;
end;

procedure Check(k: Integer);
var
  i: Integer;
begin
  for i := 1 to k - 1 do
    if Cut(k, i) then
      begin
        Writeln('§o¹n thø ', k, ' ®o¹n thø ', i);
        Wrong;
      end;
end;

procedure Test;
var
  i: Integer;
begin
  Caption('ChÊm bµi 080: "D©y cung"');
  Visual.Color := 159;
  Frame(5, 8, 75, 23, 'KiÓm tra');
  Writeln('§äc d÷ liÖu vµ kiÓm tra kÕt qu¶: ');
  Assign(f, OutputFile); Reset(f);
  for i := 1 to n do
    begin
      Readln(f, match[i, 1], match[i, 2]);
      Write(#13, i:4, ')  . ', match[i, 1]:6, Color[match[i, 1]],
                              match[i, 2]:6, Color[match[i, 2]]);
      if (match[i, 1] = 0) or (match[i, 2] = 0)
            or (match[i, 1] > m) or (match[i, 2] > m) then
        begin
          Writeln('  + Sai khu«n d¹ng d÷ liÖu');
          Wrong;
        end;
      if Color[match[i, 1]] = Color[match[i, 2]] then
        begin
          Writeln('  + Nèi hai ®iÓm cïng mµu:');
          Wrong;
        end;
      if (Index^[match[i, 1]] <> 0) or (Index^[match[i, 2]] <> 0) then
        begin
          Writeln('  + 1 ghÐp víi nhiÒu, kh«ng ph¶i bé ghÐp 1 - 1');
          Wrong;
        end;
      Index^[match[i, 1]] := 1; Index^[match[i, 2]] := 1;
      Check(i);
    end;
  Close(f);
  Writeln;
  Writeln('Tèt');
  Correct;
end;

begin
  AskTest;
  Enter;
  Sort;
  InitCode;
  Test;
end.
