program MinimalSpending;
uses crt, visual;
const
  InputFile: String = 'BUY.IN';
  OutputFile = 'BUY.OUT';
  max = 10000;
var
  a, b, Index: array[1..max] of Integer;
  n: Integer;
  sm, m, Spending: LongInt;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for i := 1 to n do
    begin
      Readln(f, a[i], b[i]);
      Index[i] := i;
    end;
  Close(f);
  Spending := 0;
  sm := m;
end;

procedure Adjust(root, EndNode: Integer);
var
  k, c: Integer;
begin
  k := Index[root];
  while Root * 2 <= EndNode do
    begin
      c := Root * 2;
      if (c < EndNode) and (b[Index[c]] > b[Index[c + 1]]) then Inc(c);
      if b[Index[c]] >= b[k] then Break;
      Index[Root] := Index[c]; Root := c;
    end;
  Index[root] := k;
end;

procedure Select(var m: LongInt; shop: Integer);
var
  q: LongInt;
begin
  if m > a[shop] then q := a[shop]
  else q := m;
  a[shop] := q;
  m := m - q;
  Spending := Spending + q * b[shop];
end;

procedure HeapSort;
var
  i, j, t: Integer;
begin
  for i := n div 2 downto 1 do Adjust(i, n);
  for i := n - 1 downto 1 do
    begin
      t := Index[1]; Index[1] := Index[i + 1]; Index[i + 1] := t;
      Select(m, t);
      if m = 0 then Break;
      Adjust(1, i);
    end;
  if m <> 0 then Select(m, Index[1])
  else
    for j := 1 to i do a[Index[j]] := 0;
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

procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
  ShowP;
  Halt;
end;

procedure AskTest;
begin
  Caption('Bµi "Mua hµng"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  s, sm, news: LongInt;
  i, x: Integer;
begin
  Caption('ChÊm bµi: "Mua hµng"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, s);
  Writeln('Chi phÝ: ');
  Writeln('  + §¸p ¸n:    ', Spending);
  Writeln('  + Häc sinh:  ', S);
  if S > Spending then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  sm := 0; news := 0;
  for i := 1 to n do
    begin
      Readln(f, x);
      if (x < 0) or (x > a[i]) then
        begin
          Writeln('Sè m¸y mua ë cöa hµng ', i, ' kh«ng hîp lý!');
          Wrong;
        end;
      sm := sm + x;
      news := news + LongInt(x) * b[i];
    end;
  if sm <> m then
    begin
      Writeln('Yªu cÇu mua ', m, ' m¸y cßn häc sinh mua ', sm, ' m¸y!');
      Wrong;
    end;
  if news <> s then
    begin
      Writeln('Häc sinh th«ng b¸o chi phÝ lµ ', S, ' trong khi chi phÝ lµ: ', news);
      Wrong;
    end;
  Writeln('KÕt qu¶ chÝnh x¸c!');
  Correct;
end;

begin
  AskTest;
  Enter;
  HeapSort;
  m := sm;
  Test;
end.
