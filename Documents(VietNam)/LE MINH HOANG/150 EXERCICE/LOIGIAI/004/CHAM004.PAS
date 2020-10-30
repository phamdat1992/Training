program SubSequence;
uses crt, visual;
const
  InputFile:String = 'SEQ.IN';
  OutputFile = 'SEQ.OUT';
  max = 1000;
  maxK = 50;
var
  a: array[1..max] of Integer;
  Mark: array[1..max] of Boolean;
  B: array[0..max, 0..maxK - 1] of Byte;
  n, k, S, Res: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, k);
  S := 0;
  for i := 1 to n do
    begin
      Read(f, a[i]);
      a[i] := a[i] mod k;
      S := (S + a[i]) mod k;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(B[0], SizeOf(B[0]), maxK + 1);
  B[0, 0] := 0;
end;

function Subtract(a, b: Integer): Integer;
begin
  a := (a - b) mod k;
  if a < 0 then Subtract := a + k
  else Subtract := a;
end;

procedure Optimize;
var
  i, t: Integer;
begin
  for i := 1 to n do
    for t := 0 to k - 1 do
      if B[i - 1, t] < B[i - 1, Subtract(t, a[i])] + 1 then
        B[i, t] := B[i - 1, t]
      else
        B[i, t] := B[i - 1, Subtract(t, a[i])] + 1;
  Res := n - B[n, S];
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
  Caption('Bµi "D·y con cã tæng chia hÕt cho K"');
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
  j, i, m: Integer;
  S: LongInt;
begin
  Caption('ChÊm bµi: "D·y con cã tæng chia hÕt cho K"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Writeln('Test: ', InputFile);
  Writeln('       . n = ', n);
  Writeln('       . k = ', k);
  Assign(f, OutputFile); Reset(f);
  Readln(f, m);
  Writeln('§é dµi d·y con: ');
  Writeln('  + §¸p ¸n  :  ', Res);
  Writeln('  + Häc sinh:  ', m);
  if Res < m then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  FillChar(Mark, SizeOf(Mark), False);
  S := 0;
  for i := 1 to m do
    begin
      Read(f, j);
      if (j < 1) or (j > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong;
        end;
      if Mark[j] then
        begin
          Writeln('ChØ sè: ', j, ' bÞ ghi hai lÇn!');
          Wrong;
        end;
      S := S + a[j];
    end;
  Writeln('Tæng d·y t×m ®­îc chia ', k, ' d­: ', S mod k);
  if S mod k = 0 then Correct
  else Wrong;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  Test;
end.
