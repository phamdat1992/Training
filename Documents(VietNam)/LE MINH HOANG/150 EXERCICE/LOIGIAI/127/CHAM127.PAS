program SegmentsandPoints;
uses crt, visual;
const
  InputFile: string  = 'PTS.IN';
  OutputFile = 'PTS.OUT';
  max = 60001;
type
  TArray = array[0..max] of Byte;
  PArray = ^TArray;
  TMark = array[0..max] of Boolean;
var
  LoLeft, HiLeft: PArray;
  MarkPtr: Pointer;
  Mark: ^TMark;
  res: Word;
  f: Text;
  ch: Char;

function GetLeft(p: Word): Word;
begin
  GetLeft := Word(HiLeft^[p]) * 256 + LoLeft^[p];
end;

procedure SetLeft(p, Value: Word);
begin
  HiLeft^[p] := Value shr 8;
  LoLeft^[p] := Value and 255;
end;

procedure Enter;
var
  n, i, L, R: LongInt;
  f: Text;
begin
  System.Mark(MarkPtr);
  New(LoLeft); New(HiLeft);
  FillChar(LoLeft^, SizeOf(LoLeft^), 0);
  FillChar(HiLeft^, SizeOf(HiLeft^), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    begin
      Readln(f, L, R);
      L := L + 30001;
      R := R + 30001;
      if L > GetLeft(R) then SetLeft(R, L);
    end;
  Close(f);
end;

procedure Counting;
var
  L, R: Word;
  p1, p2: Word;
begin
  p1 := 0;
  p2 := 0;
  res := 0;
  for R := 2 to max do
    begin
      L := GetLeft(R);
      if L = 0 then Continue;
      if L > p2 then
        if L > p1 then
          begin
            p1 := R; p2 := R - 1;
            res := res + 2;
          end
        else
          begin
            p2 := p1; p1 := R;
            Inc(res);
          end;
    end;
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
  Caption('Bµi 127: "§¹i diÖn"');
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
  nHS: LongInt;
  L, R, i, k, p1, p2, t: LongInt;
begin
  Caption('ChÊm bµi 127: "§¹i diÖn"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  New(Mark);
  FillChar(Mark^, SizeOf(Mark^), False);
  Assign(f, OutputFile); Reset(f);
  Readln(f, nHS);
  Writeln('Sè ®¹i diÖn: ');
  Writeln('  + §¸p ¸n   : ', res);
  Writeln('  + Häc sinh : ', nHS);
  if nHS > res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  for i := 1 to nHS do
    begin
      Read(f, k);
      k := k + 30001;
      Mark^[k] := True;
    end;
  p1 := 0; p2 := 0;
  for R := 2 to max do
    begin
      L := GetLeft(R);
      if L <= p2 then Continue;
      if L > p2 then
        begin
          t := L;
          while (t <= R) and not Mark^[t] do Inc(t);
          if t > R then
            begin
              Writeln('Kh«ng ®ñ ®¹i diÖn ®o¹n [', L - 30001, ', ', R - 30001, ']');
              Wrong;
            end;
          p2 := p1; p1 := t;
        end;
      if L > p2 then
        begin
          t := p1 + 1;
          while (t <= R) and not Mark^[t] do Inc(t);
          if t > R then
            begin
              Writeln('Kh«ng ®ñ ®¹i diÖn ®o¹n [', L - 30001, ', ', R - 30001, ']');
              Wrong;
            end;
          p2 := p1; p1 := t;
        end;
    end;
  Writeln('Mäi ®o¹n ®Òu cã 2 ®¹i diÖn ph©n biÖt!');
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Counting;
  Test;
end.

3
6 10
1 6
4 9