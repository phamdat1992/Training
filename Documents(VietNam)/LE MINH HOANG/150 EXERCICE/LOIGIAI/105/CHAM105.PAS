{$N+,E+}
{R-,Q-,S-}
program Schedule;
uses crt, visual;
const
  InputFile: String  = 'SCHEDULE.IN';
  OutputFile = 'SCHEDULE.OUT';
  max = 10000;
var
  a, b, Index: array[1..max] of Integer;
  n: Integer;
  Res: Comp;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Read(f, a[i]);
  Readln(f);
  for i := 1 to n do Read(f, b[i]);
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to n do Index[i] := i;
end;

function Lower(i, j: Integer): Boolean; {= a[i]/b[i] > a[j]/b[j]}
begin
  Lower := LongInt(a[i]) * b[j] > LongInt(a[j]) * b[i];
end;

procedure Adjust(root, EndNode: Integer);
var
  i, c: Integer;
  Key: Integer;
begin
  Key := Index[root];
  while root shl 1 <= EndNode do
    begin
      c := root shl 1;
      if (c < EndNode) and Lower(Index[c], Index[c + 1]) then Inc(c);
      if  Lower(Index[c], Key) then Break;
      Index[root] := Index[c]; root := c;
    end;
  Index[root] := Key;
end;

procedure HeapSort;
var
  i, t: Integer;
begin
  for i := n shr 1 downto 1 do Adjust(i, n);
  for i := n - 1 downto 1 do
    begin
      t := Index[1]; Index[1] := Index[i + 1]; Index[i + 1] := t;
      Adjust(1, i);
    end;
end;

procedure Solve;
var
  t: LongInt;
  i, j: Integer;
begin
  t := 0; Res := 0;
  for i := 1 to n do
    begin
      j := Index[i];
      t := t + b[j];
      Res := Res + a[j] * (t + 0.0);
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
  if ReadP = 10 then
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
var
  S: String[1];
begin
  Caption('Bµi "LÞch söa ch÷a « t«"');
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
      Str(ReadP:5:2, S);
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ: ' + S + '/10');
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  T, S: Comp;
  i, j: Integer;
  Time: LongInt;
begin
  Caption('ChÊm bµi: "LÞch söa ch÷a « t«"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, Outputfile); Reset(f);
  Readln(f, T);
  Writeln('Sè tiÒn ph¹t tèi thiÓu: ');
  Writeln('  + §¸p ¸n  : ', Res:1:0);
  Writeln('  + Häc sinh: ', T:1:0);
  if T > Res then Writeln('Kh«ng tèi ­u!');
  if T = Res then Writeln('Tèt nh­ ®¸p ¸n!');
  if T < Res then Writeln('Tèt h¬n ®¸p ¸n!');
  Writeln(#13#10'KiÓm tra lÞch thi hµnh:');
  Time := 0; S := 0;
  FillChar(Index, SizeOf(Index), 0);
  for i := 1 to n do
    begin
      Read(f, j);
      if (j < 1) or (j > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong(0);
        end;
      if Index[j] <> 0 then
        begin
          Writeln('¤ t« thø ', j, ' bÞ söa hai lÇn!');
          Wrong(0);
        end;
      Index[j] := i;
      Time := Time + b[j];
      S := S + Time * (a[j] + 0.0);
      GotoXY(1, 8);
      Writeln(i:5, ') Xe ', j:5);
      Writeln('          + BÞ ph¹t  : ', Time * (a[j] + 0.0):14:0);
      Writeln('          + Tæng ph¹t: ', S:14:0);
      GotoXY(1, 11);
    end;
  Writeln;
  Writeln('Chi phÝ tÝnh theo lÞch: ', S:0:0);
  if S <> T then
    begin
      Writeln('TiÒn hËu bÊt nhÊt!');
      Wrong(0);
    end;
  Writeln('LÞch thi hµnh hîp lÖ!');
  if T = Res then Correct
  else Wrong(Sqr(Res / T));
end;

begin
  AskTest;
  Enter;
  Init;
  HeapSort;
  Solve;
  Test;
end.
2
1 1
1 2
