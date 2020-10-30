program LongestSubSequence;
uses crt, visual;
const
  InputFile: string = 'INCSEQ.IN';
  OutputFile = 'INCSEQ.OUT';
  max = 10000;
type
  TArr = array[0..max + 1] of Integer;
var
  a, StartOf: TArr;
  Length: ^TArr;
  n, m, res: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  i: Word;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n);
  for i := 1 to n do Read(f, a[i]);
  Close(f);
end;

procedure Init;
begin
  a[0] := -32768;
  a[n + 1] := 32767;
  m := 1;
  new(Length);
  Length^[n + 1] := 1;
  StartOf[1] := n + 1;
end;

function Find(i: Integer): Integer;
var
  inf, sup, median, j: Integer;
begin
  inf := 1; sup := m + 1;
  repeat
    median := (inf + sup) div 2;
    j := StartOf[median];
    if a[j] > a[i] then inf := median
    else sup := median;
  until inf + 1 = sup;
  Find := StartOf[inf];
end;

procedure Optimize;
var
  i, j, t: Integer;
begin
  for i := n downto 0 do
    begin
      j := Find(i);
      t := Length^[j] + 1;
      if t > m then
        begin
          m := t;
          StartOf[m] := i;
        end
      else
        if a[StartOf[t]] < a[i] then
          StartOf[t] := i;
      Length^[i] := t;
    end;
end;

procedure Result;
begin
  Res := Length^[0] - 2;
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
  if System.Length(S) < 2 then S := '0' + S;
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
  Caption('Bµi 148: "D∑y con Æ¨n Æi÷u t®ng dµi nh t"');
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
  prev, next, i, hsres: Integer;
begin
  Caption('Ch m bµi 148: "D∑y con Æ¨n Æi÷u t®ng dµi nh t"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, HSRes);
  Writeln('ßÈ dµi d∑y con Æ¨n Æi÷u t®ng:');
  Writeln('  + ß∏p ∏n   : ', res);
  Writeln('  + H‰c sinh : ', HSRes);
  if HSRes < res then
    begin
      Writeln('Kh´ng tËi ≠u!');
      Wrong;
    end;
  prev := 0;
  for i := 1 to HSRes do
    begin
      Read(f, next);
      if (next <= prev) or (next > n) then
        begin
          Writeln('Chÿ sË i[', i, '] = ', next, ' nªm ngoµi kho∂ng');
          Wrong;
        end;
      if a[prev] >= a[next] then
        begin
          Writeln('D∑y kh´ng t®ng!');
          Wrong;
        end;
      prev := next;
    end;
  Writeln('K’t qu∂ ÆÛng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  Result;
  Test;
end.
