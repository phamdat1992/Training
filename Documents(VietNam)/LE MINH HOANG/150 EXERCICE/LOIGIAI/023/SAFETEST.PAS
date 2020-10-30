{$R-,Q-,S-}
{$M 65520 0 655360}
program LargeNumberOperator;
uses crt, visual;
const
  InputFile: String  = 'OPT.IN';
  OutputFile = 'OPT.OUT';
  max1 = 1000;
  max = 2003;
type
  TNumber = record
    n: Integer;
    d: array[0..max] of Integer;
  end;
  TOperator = procedure (var a, b, result: TNumber);
var
  Sx, Sy, x, y, z: TNumber;
  fout: Text;
  ch: Char;
  f: Text;

procedure ReadFromFile(var f: Text; var x: TNumber);
var
  l, h, t, i, n: Integer;
  ch: Char;
begin
  FillChar(x, SizeOf(x), 0);
  n := -1;
  while not SeekEoln(f) do
    begin
      Read(f, ch);
      Inc(n);
      x.d[n] := Ord(ch) - Ord('0');
    end;
  l := 0; h := n;
  while l < h do
    begin
      t := x.d[l]; x.d[l] := x.d[h]; x.d[h] := t;
      Inc(l); Dec(h);
    end;
  for i := 0 to n div 2 do
    x.d[i] := x.d[i * 2] + x.d[i * 2 + 1] * 10;
  x.n := n div 2;
  with x do
    FillChar(d[n + 1], (max - n) * SizeOf(d[1]), 0);
end;

procedure Refine(var x: TNumber; limit: Integer);
var
  i: Integer;
begin
  with x do
    begin
      for i := 0 to Limit - 1 do
        begin
          while d[i] < 0 do
            begin
              d[i] := 100 + d[i];
              Dec(d[i + 1]);
            end;
          d[i + 1] := d[i + 1] + d[i] div 100;
          d[i] := d[i] mod 100;
        end;
      n := Limit;
      while (n > 0) and (d[n] = 0) do Dec(n);
    end;
end;

procedure SaveToFile(var f: Text; var x: TNumber);
var
  i, n: Integer;
begin
  Refine(x, x.n + 2);
  with x do
    begin
      Write(f, d[n]);
      for i := n - 1 downto 0 do
        if d[i] >= 10 then Write(f, d[i])
        else Write(f, '0', d[i]);
    end;
end;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadFromFile(f, x);
  Readln(f);
  ReadFromFile(f, y);
  Close(f);
end;

procedure Init;
begin
  Sx := x; Sy := y;
end;

{$F+}

procedure LAdd(a, b: TNumber; var c: TNumber);  {c := a + b}
var
  i, k, md: Integer;
begin
  if a.n > b.n then k := b.n else k := a.n;
  md := a.n + b.n - k;
  FillChar(c, SizeOf(c), 0);
  for i := 0 to k do
    c.d[i] := a.d[i] + b.d[i];
  for i := a.n + 1 to b.n do c.d[i] := b.d[i];
  for i := b.n + 1 to a.n do c.d[i] := a.d[i];
  Refine(c, md + 1);
end;

procedure LSub(a, b: TNumber; var c: TNumber);  {c := a - b}
var
  i: Integer;
begin
  FillChar(c, SizeOf(c), 0);
  for i := 0 to a.n do
    c.d[i] := a.d[i] - b.d[i];
  Refine(c, a.n);
end;

procedure LMul(a, b: TNumber; var c: TNumber);  {c := a * b}
var
  i, j, k, s: Integer;
begin
  FillChar(c, SizeOf(c), 0);
  for i := 0 to a.n do
    for j := 0 to b.n do
      begin
        k := i + j;
        s := c.d[k] + a.d[i] * b.d[j];
        c.d[k] := s mod 100;
        c.d[k + 1] := c.d[k + 1] + s div 100;
      end;
  Refine(c, a.n + b.n + 2);
end;

function Compare(var x, y: TNumber): Integer;
var
  i: Integer;
begin
  i := max;
  while (i >= 0) and (x.d[i] = y.d[i]) do Dec(i);
  if i < 0 then Compare := 0
  else
    if x.d[i] > y.d[i] then Compare := 1
    else Compare := -1;
end;

procedure SimpleMul(a: TNumber; k: Integer; var c: TNumber); {c := a * k}
var
  i: Integer;
begin
  FillChar(c, SizeOf(c), 0);
  for i := 0 to a.n do c.d[i] := a.d[i] * k;
  Refine(c, a.n + 1);
end;

procedure Power100(a: TNumber; level: Integer; var c: TNumber); {c := a * 100^level}
begin
  FillChar(c, SizeOf(c), 0);
  Move(a.d[0], c.d[level], (max - level + 1) * SizeOf(a.d[1]));
  c.n := a.n + level
end;

procedure LDiv(a, b: TNumber; var c: TNumber);  {c := a div b}
var
  i, k: Integer;
  tmp: TNumber;

  procedure FindDigit(p: Integer);
  var
    inf, sup, median, sign: Integer;
    d, temp: TNumber;
  begin
    inf := 0; sup := 100;
    Power100(b, p, d);
    repeat
      median := (inf + sup) div 2;
      SimpleMul(d, median, temp);
      sign := Compare(temp, a);
      if sign = 1 then sup := median
      else inf := median;
    until inf + 1 >= sup;
    SimpleMul(d, inf, temp);
    LSub(a, temp, d);
    a := d;
    c.d[p] := inf;
  end;

begin
  Refine(a, a.n); Refine(b, b.n);
  FillChar(c, SizeOf(c), 0);
  k := a.n - b.n + 1;
  for i := k downto 0 do FindDigit(i);
  c.n := k;
  Refine(c, c.n + 1);
end;

{$F-}

procedure Solve(Opt: TOperator);
begin
  x := Sx; y := Sy;
  Opt(x, y, z);
  SaveToFile(fout, z);
  Writeln(fout);
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
  Read(f, p);
  Close(f);
  ReadP := p;
end;

procedure ShowP;
var
  S: String;
begin
  Str(ReadP:4:1, S);
  Visual.Color := 30;
  MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure CorrectP(P: Real);
var
  S: String;
begin
  Str(P:4:1, S);
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   B¹n cã ' + S + ' ®iÓm   ');
  WriteP(ReadP + P);
  ShowP;
  if ReadP = 10 then
    Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
  Halt;
end;

procedure AskTest;
var
  S: String;
begin
  Caption('Bµi "PhÐp to¸n trªn sè lín"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      Str(ReadP:4:1, S);
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ: ' + S + '/10');
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  x, y, z, t: TNumber;
  Sign, s1: Integer;
  p: Real;
begin
  Caption('ChÊm bµi: "PhÐp to¸n trªn sè lín"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  p := 0;
  Write('  + PhÐp céng: ');
  x := sx; y := sy;
  ReadFromFile(f, z); Readln(f);
  LSub(z, y, x);
  Sign := Compare(x, Sx);
  if Sign = 0 then
    begin
      Writeln('OK!');
      p := p + 0.2;
    end
  else Writeln('Error!'#7);

  Write('  + PhÐp trõ : ');
  x := sx; y := sy;
  ReadFromFile(f, z); Readln(f);
  LAdd(z, y, x);
  Sign := Compare(x, Sx);
  if Sign = 0 then
    begin
      Writeln('OK!');
      p := p + 0.2;
    end
  else Writeln('Error!'#7);

  Write('  + PhÐp nh©n: ');
  x := sx; y := sy;
  ReadFromFile(f, z); Readln(f);
  LDiv(z, y, x);
  Sign := Compare(x, Sx);
  if Sign = 0 then
    begin
      Writeln('OK!');
      p := p + 0.2;
    end
  else Writeln('Error!'#7);

  Write('  + PhÐp div : ');
  x := sx; y := sy;
  ReadFromFile(f, z); Readln(f);
  LMul(z, y, x);
  Sign := Compare(x, Sx);
  if Sign <> 1 then
    begin
      LSub(Sx, x, z);
      s1 := Compare(z, y);
    end;
  if (Sign <> 1) and (s1 = -1) then
    begin
      Writeln('OK!');
      p := p + 0.2;
    end
  else Writeln('Error!'#7);

  Write('  + PhÐp mod : ');
  x := sx; y := sy;
  ReadFromFile(f, z); Readln(f);
  Sign := Compare(z, y);
  if Sign <> 1 then
    begin
      LSub(x, z, x);
      LDiv(x, y, z);
      LMul(z, y, z);
      s1 := Compare(z, x);
    end;
  if (Sign <> 1) and (s1 = 0) then
    begin
      Writeln('OK!');
      p := p + 0.2;
    end
  else Writeln('Error!'#7);
  CorrectP(P);
end;

begin
  AskTest;
  Enter;
  Init;
  Test;
end.
