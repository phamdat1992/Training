program Activity;
uses crt, visual;
const
  InputFile: String = 'ACTIVITY.IN';
  OutputFile = 'ACTIVITY.OUT';
  max = 10000;
  maxV = 32000;
type
  TArr = array[0..maxV] of Integer;
var
  a, b, Index: array[1..max] of Integer;
  Count,  n: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Readln(f, a[i], b[i]);
  Close(f);
end;

procedure SortByIndex;
var
  C: ^TArr;
  i, v: Integer;
begin
  New(C);
  FillChar(C^, SizeOf(C^), 0);
  for i := 1 to n do Inc(C^[b[i]]);
  for v := 1 to maxV do C^[v] := C^[v - 1] + C^[v];
  for i := n downto 1 do
    begin
      v := b[i];
      Index[C^[v]] := i;
      Dec(C^[v]);
    end;
  Dispose(C);
end;

procedure Solve;
var
  i, j, endt: Integer;
begin
  Count := 0; endt := 0;
  for i := 1 to n do
    begin
      j := Index[i];
      if a[j] >= endt then
        begin
          Inc(Count);
          Index[i] := -Index[i];
          endt := b[j];
        end;
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
  Caption('Bµi "Bè trÝ phßng häp"');
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
  i, x, y, K: Integer;
begin
  Caption('ChÊm bµi: "Bè trÝ phßng häp"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, k);
  Writeln('Sè cuéc häp: ');
  Writeln('  + §¸p ¸n  : ', Count);
  Writeln('  + Häc sinh: ', k);
  if k < Count then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Readln(f, x);
  for i := 1 to k - 1 do
    begin
      Readln(f, y);
      if (y < 1) or (y > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liªu!');
          Wrong;
        end;
      if a[y] < b[x] then
        begin
          Writeln('Lçi: ');
          Writeln('Cuéc häp thø ', x, ': [', a[x], ', ', b[x], ']');
          Writeln('Thùc hiÖn tr­íc cuéc häp thø ', y,
                        ': [', a[y], ', ', b[y], ']');
          Wrong;
        end;
      x := y;
    end;
  Close(f);
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  SortByIndex;
  Solve;
  Test;
end.
5
7 9
2 4
1 3
1 6
3 5
