program SubSeq;
uses crt, visual;
const
  InputFile: String = 'SUBSEQ.IN';
  OutputFile = 'SUBSEQ.OUT';
  max = 1000;
  maxV = 10000;
var
  a: array[1..max] of Integer;
  b: array[0..maxV] of Integer;
  n, m, Res: Integer;
  s: LongInt;
  f: Text;
  Ch: Char;
{$R-}
procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  s := 0;
  for i := 1 to n do
    begin
      Read(f, a[i]);
      s := s + a[i];
    end;
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to maxV do b[i] := max + 1;
  b[0] := 0;
end;

procedure Optimize;
var
  i, v: Integer;
begin
  if (m < 0) or (m > s) then
    begin
      b[m] := max + 1;
      Exit;
    end;
  for i := 1 to n do
    for v := m downto a[i] do
      if b[v] > b[v - a[i]] + 1 then
        b[v] := b[v - a[i]] + 1;
end;

procedure Trace;
begin
  if b[m] = max + 1 then Res := -1 else Res := b[m];
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
  Assign(f, 'POINT.PNT'); Reset(f);
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
begin
  Caption('Bµi 097: "D·y con ng¾n nhÊt tæng = M"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
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

procedure Test;
var
  nHS: Integer;
  Mark: array[1..max] of Boolean;
  S, i, Index: LongInt;
begin
  Caption('ChÊm bµi 097: "D·y con ng¾n nhÊt tæng = M"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, nHS);
  Writeln('Sè phÇn tö: ');
  Writeln('  + §¸p ¸n  : ', res);
  Writeln('  + Häc sinh: ', nHS);
  if (Res = -1) xor (nHS = -1) then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  if nHS > Res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  if Res = -1 then Correct;
  Writeln('KiÓm tra d·y chØ sè:');
  FillChar(Mark, SizeOf(Mark), False);
  S := 0;
  for i := 1 to Res do
    begin
      Read(f, Index);
      if (Index < 1) or (Index > n) then
        begin
          Writeln('  ChØ sè ngoµi ph¹m vi: ', Index);
          Wrong;
        end;
      if Mark[Index] then
        begin
          Writeln('PhÇn tö thø ', Index, ' bÞ tÝnh hai lÇn!');
          Wrong;
        end;
      Mark[Index] := True;
      S := S + a[Index];
    end;
  if S <> m then
    begin
      Writeln('TÝnh tæng sai!');
      Wrong;
    end;
  Writeln('D·y hîp lÖ!');
  Writeln('KÕt qu¶ ®óng!');
  Correct;
  Close(f);
end;

begin
  Asktest;
  Enter;
  Init;
  Optimize;
  Trace;
  Test;
end.
10 55
1 2 3 4 5 6 7 8 9 10
