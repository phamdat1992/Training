{$N+,E+}
program Factorial;
uses crt, visual;
const
  InputFile: String = 'FDIGIT.IN';
  OutputFile = 'FDIGIT.OUT';
type
  Int = LongInt;
var
  m, n: LongInt;
  a, b: Int;
  lge: Extended;
  f: Text;
  ch: Char;

procedure Init;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  Close(f);
  lge := 1 / ln(10);
end;

procedure Solve;
var
  S: Extended;
begin
  Dec(m);
  S := 0;
  while S < m do
    begin
      Inc(a);
      S := S + lge * ln(a);
    end;
  b := a;
  while S <= n do
    begin
      Inc(b);
      S := S + lge * ln(b);
    end;
  Dec(b);
  Inc(m);
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
  Caption('Bµi "SË ch˜ sË cÒa giai thıa"');
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
 sa, sb: Int;
 c: Boolean;
begin
  Caption('Ch m bµi: "SË ch˜ sË cÒa giai thıa"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Writeln;
  Writeln('                              m = ', m, '  n = ', n);
  Writeln;
  Assign(f, OutputFile); Reset(f);
  Readln(f, sa, sb);
  Close(f);
  Writeln('Ki”m tra Æoπn [a, b]: ');
  Writeln('  + ß∏p ∏n:   [', a, ', ', b, ']');
  Writeln('  + H‰c sinh: [', sa, ', ', sb, ']');
  if a > b then c := sa > sb
  else c := (sa = a) and (sb = b);
  if c then
    begin
      Writeln('Ch›nh x∏c !');
      Correct;
    end
  else
    begin
      Writeln('K’t qu∂ sai!');
      Wrong;
    end;
end;

begin
  AskTest;
  Init;
  Solve;
  Test;
end.
