{$R-,Q-}
program Fair; {Dijkstra voi cau truc Heap}
uses crt, visual;
const
  InputFile: string[12] = 'FAIR.IN';
  OutputFile = 'FAIR.OUT';
  dx: array[1..4] of Integer = (1, -1, 0, 0);
  dy: array[1..4] of Integer = (0, 0, 1, -1);
  max = 200;
  maxk = 20;
  maxC = 40001;
type
  TByteBoard = array[-maxk..max + maxk, -maxk..max + maxk] of Byte;
  TWordLine = array[1..max] of Word;
  TWordBoard = array[1..max] of ^TWordLine;
  THeapCmp = array[1..max * max] of Byte;
var
  a: ^TByteBoard;
  Pos, d: TWordBoard;
  heapX, heapY: ^THeapCmp;
  resx, resy, distance, m, n, k, nHeap: Word;
  ch: Char;
  f: Text;


procedure MemAlloc;
var
  i: Integer;
begin
  New(a);
  for i := 1 to max do
    begin
      New(Pos[i]);
      New(d[i]);
    end;
  New(heapX); New(heapY);
  FillChar(heapX^, SizeOf(heapX^), 0);
  FillChar(heapY^, SizeOf(heapY^), 0);
end;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, k);
  FillChar(a^, SizeOf(a^), $FF);
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, a^[i, j]);
      Readln(f);
    end;
  Close(f);
end;

procedure Push(x, y: Integer);
var
  r, c, tx, ty: Word;
begin
  c := pos[x]^[y];
  if c = 0 then
    begin
      Inc(nHeap);
      c := nHeap;
    end;
  r := c shr 1;
  while r > 0 do
    begin
      tx := heapX^[r]; ty := heapY^[r];
      if d[tx]^[ty] <= d[x]^[y] then Break;
      heapX^[c] := heapX^[r];
      heapY^[c] := heapY^[r];
      pos[tx]^[ty] := c;
      c := r;
      r := c shr 1;
    end;
  heapX^[c] := x;
  heapY^[c] := y;
  pos[x]^[y] := c;
end;

procedure Pop(var x, y: Integer);
var
  tx, ty, r, c: Integer;
begin
  x := heapX^[1];
  y := heapY^[1];
  tx := heapX^[nHeap];
  ty := heapY^[nHeap];
  Dec(nHeap);
  r := 1;
  while r shl 1 <= nHeap do
    begin
      c := r shl 1;
      if (c < nHeap) and
         (d[heapX^[c]]^[heapY^[c]] > d[heapX^[c + 1]]^[heapY^[c + 1]]) then
           Inc(c);
      if d[tx]^[ty] <= d[heapX^[c]]^[heapY^[c]] then Break;
      heapX^[r] := heapX^[c];
      heapY^[r] := heapY^[c];
      Pos[heapX^[r]]^[heapY^[r]] := r;
      r := c;
    end;
  heapX^[r] := tx;
  heapY^[r] := ty;
  Pos[tx]^[ty] := r;
end;

procedure Init;
var
  i, j: Integer;
begin
  for i := 1 to m do
    begin
      for j := 1 to n do d[i]^[j] := maxC;
      FillChar(Pos[i]^, SizeOf(Pos[i]^), 0);
    end;
  nHeap := 0;
  for i := 1 to m do
    begin
      d[i]^[1] := a^[i, 1];
      Push(i, 1);
    end;
end;

procedure BFS1(tx, ty: Integer);
var
  i, j, di: Integer;
  td, TraceCode: Word;
begin
  td := d[tx]^[ty];
  TraceCode := LongInt(tx) shl 8 + ty;
  if a^[tx, ty] = 0 then
    begin
      for i := - k to k do
        for j := -(k - Abs(i)) to (k - Abs(i)) do
          if (a^[tx + i, ty + j] <> $FF) and (d[tx + i]^[ty + j] > td) then
            begin
              d[tx + i]^[ty + j] := td;
              Push(tx + i, ty + j);
            end;
    end
  else
    for di := 1 to 4 do
      begin
        i := tx + dx[di]; j := ty + dy[di];
        if (a^[i, j] <> $FF) and (d[i]^[j] > td + a^[i, j]) then
          begin
            d[i]^[j] := td + a^[i, j];
            Push(i, j);
          end;
      end;
end;

procedure Dijkstra;
var
  tx, ty: Integer;
begin
  repeat
    Pop(tx, ty);
    if ty = n then
      begin
        ResX := tx; ResY := ty;
        Break;
      end;
    BFS1(tx, ty);
    a^[tx][ty] := $FF;
  until False;
  Distance := d[tx]^[ty];
end;

{$R+,Q+}

function Adjance(x1, y1, x2, y2: Integer): Boolean;
begin
  Adjance := Abs(x1 - x2) + Abs(y1 - y2) = 1;
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
  Caption('Bµi 128: "Héi chî"');
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

procedure Test;
var
  HSRES, Total: LongInt;
  x1, y1, x, y, t: Integer;
begin
  Caption('ChÊm bµi 128: "Héi chî"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, HSRes);
  Writeln('Chi phÝ: ');
  Writeln('   + §¸p ¸n  : ', distance);
  Writeln('   + Häc sinh: ', HSRes);
  if HSRes > distance then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Enter;
  Readln(f, x, y);
  if a^[x, y] = 0 then t := k else t := 0;

  if a^[x, y] = $FF then Writeln('Kh«ng cã « (', x, ', ', y, ') ');
  Total := a^[x, y];
  while not SeekEof(f) do
    begin
      Readln(f, x1, y1);
      if a^[x1, y1] = $FF then Writeln('Kh«ng cã « (', x1, ', ', y1, ') ');
      if not Adjance(x, y, x1, y1) then
        begin
          Writeln('§i ®­êng rõng (', x, ', ', y, ') - (', x1, ', ', y1, ')');
          Wrong;
        end;
      if t >= 0 then Dec(t);
      if a^[x1, y1] = 0 then t := k;
      if t < 0 then total := total + a^[x1, y1];
      x := x1; y := y1;
    end;
  Writeln('Chi phÝ tÝnh theo ®­êng: ', Total);
  if Total <> HSRes then
    begin
      Writeln('TÝnh tæng sai!');
      Wrong;
    end;
  if y <> n then
    begin
      Writeln('¤ kÕt thóc: (', x, ', ', y, ') ');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  MemAlloc;
  Enter;
  Init;
  Dijkstra;
  Test;
end.
