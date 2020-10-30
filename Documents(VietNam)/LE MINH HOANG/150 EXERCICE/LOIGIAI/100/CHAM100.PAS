{$R-,S-,Q-,D-,I-}
program Wires;
uses crt, visual;
const
  InputFile: String = 'LINES.IN';
  OutputFile = 'LINES.OUT';
  max = 5000;
var
  a, b, Length, Trace: array[0..max + 1] of Integer;
  LeftID: array[0..max + 1] of Integer;
  n, m: Integer;
  Time: LongInt absolute 0:$46C;
  Start: LongInt;
  res: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i: Integer;
  pos: array[0..max + 1] of Integer;
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
  Pos: array[0..max + 1] of Integer;
begin
  a[0] := 0; b[0] := 0;
  a[n + 1] := n + 1; b[n + 1] := n + 1;
  for i := 0 to n + 1 do Pos[b[i]] := i;
  b := a;
  Length[0] := 1;
  for i := 0 to n + 1 do a[i] := Pos[a[i]];
  for i := 0 to n + 1 do LeftId[i] := max + max;
  LeftId[0] := 0;
  LeftId[1] := 0;
  m := 1;
end;

function Find(i, V: Integer): Integer;
var
  inf, sup, median: Integer;
begin
  inf := 0; sup := m + 1;
  repeat
    median := (inf + sup) div 2;
    if (LeftId[Median] < i) and (a[LeftId[Median]] < V) then inf := median
    else sup := median;
  until inf + 1 >= sup;
  Find := LeftId[inf];
end;

procedure Optimize;
var
  i, jmin, t: Integer;
begin
  for i := 1 to n + 1 do
    begin
      jmin := Find(i, a[i]);
      Trace[i] := jmin;
      Length[i] := Length[jmin] + 1;
      t := Length[i];
      if t > m then m := t;
      if (LeftId[t] > n) or (a[LeftId[t]] > a[i]) then
        LeftId[t] := i;
    end;
end;

procedure Result;
var
  t: Integer;
  r: array[1..max] of Integer;
begin
  res := 0;
  t := Trace[n + 1];
  repeat
    Inc(res);
    r[res] := b[t];
    t := Trace[t];
  until t = 0;
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
  Str(ReadP:4:1, S);
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
  Str(P:4:1, S);
  MSG(20, 3, InputFile, '   B¹n cã ' + S + ' ®iÓm   '#7);
  WriteP(ReadP + P);
  ShowP;
  Halt;
end;

procedure AskTest;
begin
  Caption('Bµi "Nèi d©y"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ:  '#8#8);
      Write(ReadP:4:1);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  i, R, t: Integer;
  Mark: array[1..max] of Boolean;
  pos: array[0..max + 1] of Integer;
begin
  Caption('ChÊm bµi: "Nèi d©y"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, R);
  Writeln('Sè d©y nèi: ');
  Writeln('  + §¸p ¸n:   ', Res);
  Writeln('  + Häc sinh: ', R);
  if R < Res then
    Writeln('Kh«ng tèi ­u!');
  Enter;
  for i := 1 to n do Pos[a[i]] := i;
  FillChar(Mark, SizeOf(Mark), False);
  for i := 1 to R do
    begin
      Read(f, t);
      if (t < 1) or (t > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong(0);
        end;
      if Mark[Pos[t]] then
        begin
          Writeln('D©y ', t, ' bÞ liÖt kª 2 lÇn!');
          Wrong(0);
        end;
      Mark[Pos[t]] := True;
    end;
  Close(f);
  for i := 0 to n + 1 do Pos[b[i]] := i;
  t := 0; {Day noi truoc day la day t}
  for i := 1 to n do
    if Mark[i] then {diem thu i tren duong thang d1 co day noi}
      begin
        if Pos[a[i]] <= Pos[t] then
          begin
            Writeln('D©y ', a[i], ' c¾t d©y ', t);
            Wrong(0);
          end;
        t := a[i];
      end;
  Writeln('KÕt qu¶ hîp lÖ!');
  if Res > R then Wrong(Sqr(R / Res))
  else Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  Result;
  Test;
end.
6
2 3 1 5 6 4
3 2 5 6 1 4
