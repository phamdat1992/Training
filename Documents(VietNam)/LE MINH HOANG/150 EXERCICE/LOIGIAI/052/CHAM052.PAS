program Bai1;
uses crt, visual;
const
  InputFile: String = 'NUMBER.IN';
  OutputFile = 'NUMBER.OUT';
  max = 32;
var
  saven, res, n, k: LongInt;
  c, b: array[-1..max + 1, -1..max + 1] of LongInt;
  x: array[1..max] of LongInt;
  nd: LongInt;
  ch: Char;
  f: Text;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, k);
  saven := n;
  Close(f);
end;

procedure Initc;
var
  i, j: LongInt;
begin
  FillChar(c, SizeOf(c), 0);
  c[0, 0] := 1;
  for i := 1 to max do
    for j := 0 to max do
       c[i, j] := c[i - 1, j] + c[i - 1, j - 1];
end;

procedure Initb;
var
  i, j: LongInt;
begin
  FillChar(b, SizeOf(b), 0);
  b[0, 0] := 1;
  b[1, 0] := 1; b[1, 1] := 1;
  for i := 1 to max do
    for j := 0 to max do
      if b[i, j] = 0 then
        b[i, j] := b[i - 1, j] + c[i - 1, j];
end;

function Length(x: LongInt): LongInt;
var
  c: LongInt;
begin
  c := 0;
  repeat
    Inc(c);
    x := x shr 1;
  until x = 0;
  Length := c;
end;

procedure InterChange;
var
  m, i: LongInt;
begin
  i := 0;
  m := n;
  repeat
    Inc(i);
    x[i] := m and 1;
    m := m shr 1;
  until m = 0;
  nd := i;
end;

procedure Solve;
var
  i, e, t: LongInt;
begin
  if (k > nd) or (k < 0) then
    begin
      res := 0; Exit;
    end;
  res := b[nd - 1, k];
  e := k;
  for i := nd - 1 downto 1 do
    begin
      if x[i] = 1 then res := res + c[i - 1, e - 1]
      else Dec(e);
      if e < 0 then Break;
    end;
end;

procedure Refine;
var
  c: LongInt;
begin
  c := 0;
  repeat
    if not odd(n) then Inc(c);
    n := n shr 1;
  until n = 0;
  if c = k then Inc(Res);
end;

Procedure Halt;
begin
  {$I-}
  Close(f); if IOResult = 0 then;
  {$I+}
  ReadKey;
  TextMode(C80); Textattr := 7; Clrscr;
  System.Halt;
end;

Procedure WriteP(p: Integer);
var
  f: file of Integer;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

Function ReadP: Integer;
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

Procedure ShowP;
var
  S: String;
begin
  Str(ReadP, S);
  if System.Length(S) < 2 then S := '0' + S;
  Visual.Color := 30;
  MSG(60, 3, 'TÊng', 'TÊng Æi”m Æang lµ ' + S + '/10');
end;

Procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   Bπn c„ 1 Æi”m   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('ßÛng h’t c∏c test', 'Perfect! Perfect!');
  Halt;
end;

Procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, '   Bπn c„ 0 Æi”m   '#7);
  ShowP;
  Halt;
end;

Procedure AskTest;
var
  S: String[1];
begin
  Caption('Bµi Number');
  MSG(40, 3, 'Input?', 'Cho t™n file d˜ li÷u: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      S := ParamStr(1);
      ch := S[1];
    end
  else  ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then {ENTER}
    begin
      Visual.Color := 159;
      MSG(40, 13, 'ßi”m', 'TÊng Æi”m cÒa bπn Æang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

Procedure Test;
var
  r: LongInt;
begin
  Caption('Ch m bµi : "NUMBER"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Assign(f, Outputfile); Reset(f);
  Readln(f, r);
  Writeln;
  Writeln('n = ', saven, ';  k = ', k);
  Writeln('  + ß∏p ∏n  : ', res );
  Writeln('  + H‰c sinh: ', r);
  if res <> r then Wrong
  else Correct;
end;

begin
  AskTest;
  Enter;
  InitC;
  InitB;
  InterChange;
  Solve;
  Refine;
  Test;
end.