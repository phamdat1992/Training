program Domino;
uses crt, visual;
const
  InputFile: String = 'DOMINO.IN';
  OutputFile = 'DOMINO.OUT';
  maxN = 100;
type
  TBoard = array[0..maxN, -6..maxN * 6] of Byte;
var
  F: ^TBoard;
  a, b: array[1..maxN] of Byte;
  n: Byte;
  Diff, nFlip, m, Sum: Integer;
  OutFile: Text;
  ch: Char;

procedure Enter;
var
  InFile: Text;
  i: Byte;
begin
  Assign(InFile, InputFile); Reset(InFile);
  Readln(InFile, n);
  for i := 1 to n do Read(InFile, a[i]); Readln(InFile);
  for i := 1 to n do Read(InFile, b[i]);
  Close(InFile);
end;

function Min(x, y: Byte): Byte;
begin
  if x < y then Min := x else Min := y;
end;

function Max(x, y: Byte): Byte;
begin
  if x > y then Max := x else Max := y;
end;

procedure Init;
var
  i: Byte;
begin
  New(F);
  FillChar(F^, SizeOf(F^), maxN + 1);
  F^[0, 0] := 0;
  m := 0; Sum := 0;
  for i := 1 to n do
    begin
      m := m + Max(a[i], b[i]);
      Sum := Sum + a[i] + b[i];
    end;
end;

procedure Optimize;
var
  k: Byte;
  V: Integer;
begin
  for k := 1 to n do
    for V := 0 to m do
      F^[k, V] := Min(F^[k - 1, V - a[k]], F^[k - 1, V - b[k]] + 1);
end;

procedure Trace;
var
  V, p, d: Integer;
  i: Byte;

  function Better(a, b: Integer): Boolean;
  var
    other2, other1: Integer;
  begin
    other1 := Sum - a; other2 := Sum - b;
    Better := (Abs(a - other1) < Abs(b - other2)) or
                        (Abs(a - other1) = Abs(b - other2)) and (F^[n, a] < F^[n, b]);
  end;

begin
  p := 0;
  while F^[n, p] = maxN + 1 do Inc(p);
  for V := p + 1 to m do
    if (F^[n, V] <> maxN + 1) and Better(V, p) then p := V;
  d := Sum - 2 * p;
  Diff := Abs(d);
  nFlip := F^[n, p];
end;

procedure Halt;
begin
  {$I-}
  Close(OutFile); if IOResult = 0 then;
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
  Caption('Bµi "LÀt ß´-mi-n´"');
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
  s1, s2, HSDIff, HSFlip, i, j, t: Integer;
begin
  Caption('Ch m bµi: "LÀt ß´-mi-n´"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Assign(OutFile, OutputFile); Reset(OutFile);
  Readln(OutFile, HSFlip);
  for i := 1 to HSFlip do
    begin
      Read(OutFile, j);
      if (j < 1) or (j > n) then
        begin
          Writeln('Sai khu´n dπng d˜ li÷u!');
          Wrong;
        end;
      t := a[j]; a[j] := b[j]; b[j] := t;
    end;
  Readln(OutFile);
  Readln(OutFile, HsDiff);
  Close(OutFile);
  Writeln('C∏ch lÀt: ');
  Writeln('  + ß∏p ∏n: LÀt ', nFlip, ' qu©n, ÆÈ l÷ch: ', Diff);
  Writeln('  + HS    : LÀt ', HSFlip, ' qu©n, ÆÈ l÷ch: ', HSDiff);
  if (Diff < HSDiff) or (Diff = HSDiff) and (nFlip < HSFlip) then
    begin
      Writeln('Kh´ng tËi ≠u!');
      Wrong;
    end;
  s1 := 0; s2 := 0;
  for i := 1 to n do
    begin
      s1 := s1 + a[i]; s2 := s2 + b[i];
    end;
  Writeln('ßÈ l÷ch theo c∏ch t›nh cÒa HS: ', Abs(s1 - s2));
  if Abs(s1 - s2) <> HSDiff then
    begin
      Writeln('Ti“n hÀu b t nh t!');
      Wrong;
    end;
  Writeln('K’t qu∂ ch›nh x∏c!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  Trace;
  Test;
end.
