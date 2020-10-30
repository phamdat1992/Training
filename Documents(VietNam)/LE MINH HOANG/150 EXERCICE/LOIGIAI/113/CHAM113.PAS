program DecodeBurrowsWheeler;
uses crt, visual;
const
  InputFile: String  = 'DECODE.IN';
  OutputFile = 'DECODE.OUT';
  max = 10000;
var
  a, res: array[1..max] of Char;
  Index: array[1..max] of Integer;
  ch: Char;
  n, code, p, nTest: Integer;
  fInp, fOut: Text;

procedure OpenFile;
begin
  Assign(fInp, InputFile); Reset(fInp);
  Assign(fOut, OutputFile); Reset(fOut);
  nTest := 0; p := 0;
end;

procedure CloseFile;
begin
  Close(fInp); if IOResult = 0 then;
  Close(fOut); if IOResult = 0 then; {Erase(fOut)}
end;

procedure Enter;
begin
  n := 0;
  while not SeekEoln(fInp) do
    begin
      Inc(n);
      Read(fInp, a[n]);
    end;
  Readln(fInp);
  Readln(fInp, code);
  Inc(nTest);
end;

procedure DistributionCounting;
var
  c: array[Char] of Integer;
  i: Integer;
  V: Char;
begin
  FillChar(c, SizeOf(c), 0);
  for i := 1 to n do Inc(c[a[i]]);
  for V := #1 to #255 do c[V] := c[Pred(V)] + c[V];
  for i := n downto 1 do
    begin
      V := a[i];
      Index[c[V]] := i;
      Dec(c[V]);
    end;
end;

procedure Result;
var
  i, t: Integer;
begin
  t := Code;
  for i := 1 to n do
    begin
      t := Index[t];
      Res[i] := a[t];
    end;
end;

procedure Halt;
begin
  CloseFile;
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

procedure Wrong(P: Real);
var
  S: String;
begin
  Visual.Color := 78;
  Str(P:5:2, S);
  MSG(20, 3, InputFile, '   Bπn c„ ' + S + ' Æi”m   '#7);
  WriteP(ReadP + P);
  ShowP;
  Halt;
end;

procedure AskTest;
var
  S: String;
  T: String[1];
begin
  Caption('Bµi "M∑ ho∏ Burrows Wheeler"');
  MSG(40, 3, 'Input?', 'Cho t™n file d˜ li÷u: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      T := ParamStr(1);
      ch := T[1];
    end
  else
    ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      Str(ReadP:5:2, S);
      MSG(40, 13, 'ßi”m', 'TÊng Æi”m cÒa bπn Æang lµ: ' + S + '/10');
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Check;
var
  i: Integer;
  c: Char;
  W: Boolean;
begin
  Write(#13);
  Write('  + Tı th¯: ', nTest, ' ... ');
  i := 0;
  W := False;
  while not SeekEoln(fOut) do
    begin
      Inc(i);
      Read(fOut, c);
      if c <> Res[i] then
        begin
          W := True;
          Break;
        end;
    end;
  if i <> n then W := True;
  if W then Writeln('Sai! ')
  else
    begin
      Write('ßÛng!'#13);
      Inc(p);
    end;
  Readln(fOut);
end;

procedure TestResult;
begin
  if p = nTest then Correct
  else Wrong(p / nTest);
end;

begin
  AskTest;
  Caption('Ch m bµi: "M∑ ho∏ Burrows Wheeler"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Writeln('Ki”m tra c∏c tı gi∂i m∑:');
  OpenFile;
  while not SeekEof(fInp) do
    begin
      Enter;
      DistributionCounting;
      Result;
      Check;
    end;
  ClrEol;
  Writeln;
  Writeln('Tÿ l÷ ÆÛng: ', p, ' / ', nTest, ' tı');
  TestResult;
end.
-