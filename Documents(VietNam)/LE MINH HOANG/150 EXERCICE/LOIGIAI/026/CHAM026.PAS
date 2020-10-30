program MaxPath;
uses crt, visual;
const
  InputFile: String  = 'MAX.IN';
  OutputFile = 'MAX.OUT';
  max = 100;
var
  a, b: array[1..max, 1..max] of Integer;
  res, m, n: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, a[i, j]);
      Readln(f);
    end;
  Close(f);
end;

procedure Optimize;
var
  i, j: Integer;
  d: ShortInt;
begin
  for i := 1 to m do b[i, n] := a[i, n];
  for j := n - 1 downto 1 do
    for i := 1 to m do
      begin
        b[i, j] := -MaxInt;
        for d := -1 to 1 do
          if (i + d >= 1) and (i + d <= m) and
                (b[i + d, j + 1] + a[i, j] > b[i, j]) then
              b[i, j] := b[i + d, j + 1] + a[i, j];
      end;
end;

procedure PrintResult;
var
  i, k: Integer;
begin
  i := 1;
  for k := 2 to m do
    if b[k, 1] > b[i, 1] then i := k;
  res := b[i, 1];
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
  Caption('Bµi "ß≠Íng Æi nhi“u Æi”m nh t"');
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
  T, S, i, j, prev: Integer;
begin
  Caption('Ch m bµi: "ß≠Íng Æi nhi“u Æi”m nh t"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, T);
  Writeln('Ki”m tra tÊng c∏c sË tr™n Æ≠Íng Æi: ');
  Writeln('  + ß∏p ∏n   : ', Res);
  Writeln('  + H‰c sinh : ', T);
  if T < Res then
    begin
      Writeln('Kh´ng tËi ≠u!');
      Wrong;
    end;
  Writeln('Ki”m tra Æ≠Íng Æi:');
  Readln(f, prev);
  if (prev < 1) or (prev > m) then
    begin
      Writeln('Sai khu´n dπng d˜ li÷u!');
      Wrong;
    end;
  Write('(', prev, ', ', 1, ') -> ');
  S := a[prev, 1];
  for j := 2 to n do
    begin
      Readln(f, i);
      Write('(', i, ', ', j, ') -> ');
      if (i < 1) or (i > m) then
         begin
           Writeln('Sai khu´n dπng d˜ li÷u!');
           Wrong;
        end;
      if Abs(i - prev) > 1 then
         begin
           Writeln('ßi Æ≠Íng rıng!');
           Wrong;
         end;
       S := S + a[i, j];
       prev := i;
    end;
  Writeln('SË Æi”m t›nh theo Æ≠Íng Æi: ', S);
  if S <> T then
    begin
      Writeln('Ti“n hÀu b t nh t!');
      Wrong;
    end;
  Writeln('ß≠Íng Æi hÓp l÷, t›nh Æi”m ÆÛng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Optimize;
  PrintResult;
  Test;
end.
