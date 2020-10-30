{$R-,S-,Q-}
program HeapDemo; {Queue with priority}
uses crt, visual;
const
  InputFile: String  = 'IO.IN';
  OutputFile = 'IO.OUT';
  max = 15000;
type
  TArr = array[1..max] of LongInt;
var
  a: TArr;
  b: ^TArr;
  n, nRes: Integer;
  Flag: Byte;
  f: Text;
  ch: Char;

procedure Init;
begin
  n := 0;
  Flag := 0;
end;

procedure Push(V: LongInt);
var
  r, c: Integer;
begin
  if n = max then Exit;
  c := n + 1;
  r := c shr 1;
  while (r >= 1) and (a[r] < V) do
    begin
      a[c] := a[r]; c := r; r := r shr 1;
    end;
  a[c] := V;
  Inc(n);
end;

procedure Adjust;
var
  r, c: Integer;
  Key: LongInt;
begin
  Key := a[1];
  r := 1;
  while r shl 1 <= n do
    begin
      c := r shl 1;
      if (c < n) and (a[c] < a[c + 1]) then Inc(c);
      if a[c] <= Key then Break;
      a[r] := a[c]; r := c;
    end;
  a[r] := Key;
end;

procedure Pop;
var
  Value: LongInt;
begin
  if n = 0 then Exit;
  Value := a[1];
  while (n > 0) and (a[1] = Value) do
    begin
      a[1] := a[n]; Dec(n);
      Adjust;
    end;
end;

procedure Solve;
var
  ch: Char;
  i: Integer;
  V, Last: LongInt;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  while not SeekEof(f) do
    begin
      Read(f, ch);
      if ch = '-' then
        begin
          Pop;
          Readln(f);
        end
      else
        begin
          Readln(f, V);
          Push(V);
        end;
    end;
  Close(f);
  Last := -1;
  nRes := 0;
  New(b);
  for i := n downto 1 do
    begin
      V := a[1]; a[1] := a[n];
      Dec(n);
      Adjust;
      if V <> Last then
        begin
          Inc(nRes);
          b^[nRes] := V;
        end;
      Last := V;
    end;
end;

procedure Result;
var
  i: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, nRes);
  for i := 1 to nRes do Write(f, b^[i], ' ');
  Close(f);
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
var
  S: String[1];
begin
  Caption('Bµi "Hµng ®îi víi ®é ­u tiªn (HEAP)"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
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
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure QSort(L, H: Integer);
var
  i, j: Integer;
  Key, temp: LongInt;
begin
  if L >= H then Exit;
  Key := a[L + Random(H - L + 1)];
  i := L; j := H;
  repeat
    while a[i] > Key do Inc(i);
    while a[j] < Key do Dec(j);
    if i <= j then
      begin
        temp := a[i]; a[i] := a[j]; a[j] := temp;
        Inc(i); Dec(j);
      end;
  until i > j;
  QSort(L, j); QSort(i, H);
end;

procedure Test;
var
  i, tres: Integer;
begin
  Caption('ChÊm bµi: "Hµng ®îi víi ®é ­u tiªn (HEAP)"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Writeln('Sè gi¸ trÞ cßn l¹i');
  Assign(f, Outputfile); Reset(f);
  Readln(f, tres);
  Writeln('    + §¸p ¸n  : ', nRes);
  Writeln('    + Häc sinh: ', tres);
  if tres <> nres then
    begin
      Writeln('  KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('  KÕt qu¶ ®óng!');
  Write('S¾p xÕp d·y kÕt qu¶ cña häc sinh...');
  for i := 1 to nres do Read(f, a[i]);
  QSort(1, nres);
  Writeln('Done');
  for i := 1 to nRes do
    begin
      Write('Gi¸ trÞ thø ', i, ': ');
      if a[i] <> b^[i] then
        begin
          Writeln;
          Writeln('  + §¸p ¸n  : ', b^[i]);
          Writeln('  + Häc sinh: ', a[i]);
          Writeln('KÕt qu¶ sai!');
          Wrong;
        end;
      Write(a[i], ' (OK)                 '#13);
    end;
  ClrEol;
  Writeln;
  Writeln('KÕt qu¶ chÝnh x¸c!');
  Correct;
end;

begin
  Asktest;
  Init;
  Solve;
  Test;
end.
+1
+3
+2
+3
-
+4
+4
-
+2
+7
+8
+9
-
