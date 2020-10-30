{$R-,S-,Q-}
program PermuteStr;
uses crt, visual;
const
  InputFile: String = 'PERMUTE.IN';
  OutputFile = 'PERMUTE.OUT';
type
  Str9 = String[9];
var
  sx, x: Str9;
  n: Integer;
  S: LongInt;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, x);
  Close(f);
  sx := x;
end;

procedure Init;
var
  i, j: Integer;
  V: Char;
  Count, C: array['A'..'Z'] of Integer;
  y: Str9;
begin
  n := Length(x);
  FillChar(Count, SizeOf(Count), 0);
  for i := 1 to n do Inc(Count[x[i]]);
  C := Count;
  for V := 'B' to 'Z' do Count[V] := Count[Pred(V)] + Count[V];
  y[0] := x[0];
  for i := 1 to n do
    begin
      V := x[i];
      y[Count[V]] := x[i];
      Dec(Count[V]);
    end;
  x := y;
  S := 1;
  for i := 1 to n do S := S * i;
  for V := 'A' to 'Z' do
    for j := 2 to C[V] do S := S div j;
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
begin
  Caption('Bµi "Ho∏n vﬁ ch˜ c∏i"');
  MSG(40, 3, 'Input?', 'Cho t™n file d˜ li÷u: ' + InputFile + '  '#8#8);
  ch := ReadKey;
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
  i, j, l, h: Integer;
  T: LongInt;
  temp: Char;
  testS: Str9;
begin
  Caption('Ch m bµi: "Ho∏n vﬁ ch˜ c∏i"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Writeln('X©u ban Æ«u: ''', sx, ''''#10);
  Assign(f, OutputFile); Reset(f);
  Readln(f, T);
  Writeln('SË ho∏n vﬁ: ');
  Writeln('  + ß∏p ∏n  : ', S);
  Writeln('  + H‰c sinh: ', T);
  if S <> T then
    begin
      Writeln('K’t qu∂ sai!');
      Wrong;
    end;
  Writeln('K’t qu∂ ÆÛng!');
  Writeln;
  Writeln('Ki”m tra c∏c ho∏n vﬁ: ');
  t := 0;
  repeat
    Inc(t);
    Readln(f, TestS);
    if TestS <> x then
      begin
        Writeln('Ho∏n vﬁ th¯ ', t, ' kh´ng ÆÛng!');
        Writeln('  + ß∏p ∏n  : ''', x, '''');
        Writeln('  + H‰c sinh: ''', testS, '''');
        Wrong;
      end;
    i := n - 1;
    while (i > 0) and (x[i] >= x[i + 1]) do Dec(i);
    if i > 0 then
      begin
        j := n;
        while x[j] <= x[i] do Dec(j);
        temp := x[i]; x[i] := x[j]; x[j] := temp;
        l := i + 1; h := n;
        while l <= h do
          begin
            temp := x[l]; x[l] := x[h]; x[h] := temp;
            Inc(l); Dec(h);
          end;
      end;
  until i = 0;
  Writeln('C∏c ho∏n vﬁ Æ≠Óc li÷t k™ ÆÛng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Test;
end.
