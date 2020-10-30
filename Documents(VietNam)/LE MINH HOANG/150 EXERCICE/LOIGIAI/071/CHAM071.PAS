program DispatchMessages;
uses crt, Visual;
const
  InputFile: String = 'MESSAGE.IN';
  OutputFile = 'MESSAGE.OUT';
  max = 700;
  Bit: array[0..7] of Byte = (1, 2, 4, 8, 16, 32, 64, 128);

type
  TLine = array[1..max] of Boolean;
  PLine = ^TLine;
var
  a: array[1..max] of PLine;
  Free: array[1..max] of Boolean;
  Index: array[1..max] of Integer;
  nSelected, Count, n: Integer;
  Renumber: Boolean;
  Time: LongInt absolute 0:$46C;
  Start: LongInt;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for u := 1 to n do
    begin
      New(a[u]);
      FillChar(a[u]^, SizeOf(a[u]^), False);
    end;
  while not SeekEof(f) do
    begin
      Readln(f, u, v);
      a[u]^[v] := True;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(Free, SizeOf(Free), True);
  Count := 0;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Free[u] := False;
  for v := 1 to n do
    if Free[v] and a[u]^[v] then Visit(v);
  if Renumber then
    begin
      Inc(Count);
      Index[Count] := u;
    end;
end;

procedure Solve;
var
  i: Integer;
  f: Text;
begin
  {Danh so lai}
  Renumber := True;
  Init;
  for i := 1 to n do
    if Free[i] then Visit(i);
  {DFS mot lan nua}
  nSelected := 0;
  Renumber := False;
  Init;
  for i := n downto 1 do
    if Free[Index[i]] then
      begin
        Inc(nSelected);
        Visit(Index[i]);
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
  Assign(f, 'POINT.TXT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Integer;
var
  f: file of Integer;
  P: Integer;
begin
  Assign(f, 'POINT.TXT'); Reset(f);
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
  Color := 30;
  MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Color := 47;
  MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Color := 78;
  MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
  ShowP;
  Halt;
end;

procedure AskTest;
begin
  Caption('Bµi 071: Nh¾n tin');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: MESSAGE.IN  '#8#8);
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
  i, k, nS: Integer;
begin
  for i := 1 to n do Dispose(a[i]);
  Enter;
  Caption('ChÊm bµi 071: "Nh¾n tin"');
  Visual.Color := 159;
  Frame(5, 8, 75, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, nS);
  Writeln('KiÓm tra sè ng­êi: ');
  Writeln('  + §¸p ¸n  : ', nSelected);
  Writeln('  + Häc sinh: ', nS);
  if nS > nSelected then Wrong;
  Init;
  for i := 1 to nS do
    begin
      Read(f, k);
      if (k < 1) or (k > n) then
        begin
          Writeln('Kh«ng cã ng­êi thø ', k);
          Wrong;
        end;
      Visit(k);
    end;
  for i := 1 to n do
    if Free[i] then
      begin
        Writeln('Ng­êi thø ', i, ' kh«ng nhËn ®­îc tin');
        Wrong;
      end;
  Close(f);
  Writeln('TÊt c¶ mäi ng­êi ®· nhËn ®­îc tin');
  Writeln('Tèt!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Solve;
  Test;
end.

12
1 3
3 6
6 1
6 8
8 12
12 9
9 6
2 4
4 5
5 2
4 6
7 10
10 11
11 7
10 9
