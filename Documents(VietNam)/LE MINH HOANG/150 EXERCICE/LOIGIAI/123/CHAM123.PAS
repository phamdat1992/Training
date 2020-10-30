program RollingCube;
uses crt, visual;
const
  InputFile: string[12] = 'ROLL.IN';
  OutputFile = 'ROLL.OUT';
  max = 80;
  LeftCode: array[1..6, 1..6] of Byte =
  (
  (0, 4, 2, 5, 3, 0),
  (3, 0, 6, 1, 0, 4),
  (5, 1, 0, 0, 6, 2),
  (2, 6, 0, 0, 1, 5),
  (4, 0, 1, 6, 0, 3),
  (0, 3, 5, 2, 4, 0)
  );
type
  TLayer = array[1..max, 1..max] of Word;
  PLayer = ^TLayer;
  THeapCmp = array[1..max * max * 4] of Byte;
  PHeapCmp = ^THeapCmp;
  TGoProc = function(sk, sx, sy: Word; var rk, rx, ry: Word): Boolean;
var
  map: array[0..max + 1, 0..max + 1] of Byte;
  d, pos: array[1..6] of PLayer;
  heapK, heapX, heapY: PHeapCmp;
  m, n, xStart, yStart, nHeap: Word;
  res: Word;

  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, j: Word;
begin
  FillChar(map, SizeOf(map), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, xStart, yStart);
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, map[i, j]);
      Readln(f);
    end;
  Close(f);
end;

procedure InitMem;
var
  l: Word;
  tmp: LongInt;
begin
  tmp := MemAvail;
  for l := 1 to 6 do
    begin
      New(d[l]);
      New(pos[l]);
      FillChar(pos[l]^, SizeOf(pos[l]^), 0);
      FillChar(d[l]^, SizeOf(d[l]^), $FF);
    end;
  New(HeapK); New(HeapX); New(HeapY);
end;

procedure GetValue(p: Word; var k, x, y: Word);
begin
  k := heapK^[p];
  x := heapX^[p];
  y := heapY^[p];
end;

procedure SetValue(p: Word; k, x, y: Word);
begin
  heapK^[p] := k;
  heapX^[p] := x;
  heapY^[p] := y;
  pos[k]^[x, y] := p;
end;

function Higher(p1, p2: Word): Boolean;
var
  k1, x1, y1, k2, x2, y2: Word;
begin
  GetValue(p1, k1, x1, y1); GetValue(p2, k2, x2, y2);
  Higher := d[k1]^[x1, y1] < d[k2]^[x2, y2];
end;

procedure Push(k, x, y: Word);
var
  c, r: Word;
  pk, px, py: Word;
begin
  c := Pos[k]^[x, y];
  if c = 0 then {Add}
    begin
      Inc(nHeap);
      c := nHeap;
    end;
  r := c shr 1;
  while r <> 0 do
    begin
      GetValue(r, pk, px, py);
      if d[pk]^[px, py] <= d[k]^[x, y] then Break;
      SetValue(c, heapK^[r], heapX^[r], heapY^[r]);
      c := r;
      r := c shr 1;
    end;
  SetValue(c, k, x, y);
end;

procedure Pop(var k, x, y: Word);
var
  r, c: Word;
  pk, px, py: Word;
  dtmp: Word;
begin
  GetValue(1, k, x, y);
  GetValue(nHeap, pk, px, py);
  dtmp := d[pk]^[px, py];
  Dec(nHeap);
  r := 1;
  while r shl 1 <= nHeap do
    begin
      c := r shl 1;
      if (c < nHeap) and (Higher(c + 1, c)) then Inc(c);
      if not Higher(c, nHeap + 1) then Break;
      SetValue(r, heapK^[c], heapX^[c], heapY^[c]);
      r := c;
    end;
  SetValue(r, pk, px, py);
end;

procedure DijkstraInit;
var
  i, j, k: Word;

  function Check(k, x, y: Word): Boolean;
  begin
    Check := (map[x, y] <> 0) and (map[x, y] <> k) and
             (map[x, y] <> 7 - k);
  end;

begin
  for k := 1 to 6 do
    begin
      for i := 1 to m do
        begin
          if Check(k, i, 1) then d[k]^[i, 1] := 7 - map[i, 1];
          if Check(k, i, n) then d[k]^[i, n] := 7 - map[i, n];
        end;
      for j := 2 to n - 1 do
        begin
          if Check(k, 1, j) then d[k]^[1, j] := 7 - map[1, j];
          if Check(k, m, j) then d[k]^[m, j] := 7 - map[m, j];
        end;
    end;
  nHeap := 0;
  for i := 1 to m do
    for k := 1 to 6 do
      begin
        if d[k]^[i, 1] <> $FFFF then Push(k, i, 1);
        if d[k]^[i, n] <> $FFFF then Push(k, i, n);
    end;
  for j := 2 to n - 1 do
    for k := 1 to 6 do
      begin
        if d[k]^[1, j] <> $FFFF then Push(k, 1, j);
        if d[k]^[m, j] <> $FFFF then Push(k, m, j);
      end;
end;

{$F+}
function Up(sk, sx, sy: Word; var rk, rx, ry: Word): Boolean;
var
  Face: Word;
begin
  Face := sk;
  rx := sx - 1; ry := sy;
  if map[rx, ry] <> Face then Up := False
  else
    begin
      rk := 7 - map[sx, sy];
      Up := True;
    end;
end;

function Down(sk, sx, sy: Word; var rk, rx, ry: Word): Boolean;
var
  Face: Word;
begin
  Face := 7 - sk;
  rx := sx + 1; ry := sy;
  if map[rx, ry] <> Face then Down := False
  else
    begin
      rk := map[sx, sy];
      Down := True;
    end;
end;

function Left(sk, sx, sy: Word; var rk, rx, ry: Word): Boolean;
var
  Face: Word;
begin
  Face := LeftCode[map[sx, sy], sk];
  rx := sx; ry := sy - 1;
  if map[rx, ry] <> Face then Left := False
  else
    begin
      rk := sk;
      Left := True;
    end;
end;

function Right(sk, sx, sy: Word; var rk, rx, ry: Word): Boolean;
var
  Face: Word;
begin
  Face := 7 - LeftCode[map[sx, sy], sk];
  rx := sx; ry := sy + 1;
  if map[rx, ry] <> Face then Right := False
  else
    begin
      rk := sk;
      Right := True;
    end;
end;
{$F-}

procedure Update(pk, px, py: Word);
var
  k, x, y: Word;
  dp: Word;
begin
  dp := d[pk]^[px, py];
  if Up(pk, px, py, k, x, y) and (d[k]^[x, y] > dp + 7 - map[x, y]) then
    begin
      d[k]^[x, y] := dp + 7 - map[x, y];
      Push(k, x, y);
    end;
  if Down(pk, px, py, k, x, y) and (d[k]^[x, y] > dp + 7 - map[x, y]) then
    begin
      d[k]^[x, y] := dp + 7 - map[x, y];
      Push(k, x, y);
    end;
  if Left(pk, px, py, k, x, y) and (d[k]^[x, y] > dp + 7 - map[x, y]) then
    begin
      d[k]^[x, y] := dp + 7 - map[x, y];
      Push(k, x, y);
    end;
  if Right(pk, px, py, k, x, y) and (d[k]^[x, y] > dp + 7 - map[x, y]) then
    begin
      d[k]^[x, y] := dp + 7 - map[x, y];
      Push(k, x, y);
    end;
end;

procedure DijkstraSolve;
var
  pk, px, py: Word;
begin
  repeat
    Pop(pk, px, py);
    if (pk = 2) and (px = xStart) and (py = yStart) then Break;
    Update(pk, px, py);
  until nHeap = 0;
end;

procedure Result;
begin
  Res := d[2]^[Xstart, Ystart];
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

procedure WriteP(p: Word);
var
  f: file of Word;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Word;
var
  f: file of Word;
  P: Word;
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
  Caption('Bµi 123: "Rolling Cube"');
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
  i, Sum: Word;
  c: Char;
  Go: TGoProc;
  x1, y1, k1, x2, y2, k2: Word;
begin
  Caption('ChÊm bµi 123: "Rolling Cube"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Writeln('KiÓm tra ®­êng l¨n:');
  Assign(f, OutputFile); Reset(f);
  x1 := XStart; y1 := YStart; k1 := 2;
  i := 0;
  Sum := 1;
  while not SeekEoln(f) do
    begin
      Inc(i);
      Read(f, c);
      case c of
        'L': Go := Left;
        'R': Go := Right;
        'U': Go := Up;
        'D': Go := Down;
      end;
      if not Go(k1, x1, y1, k2, x2, y2) then
        begin
          Writeln;
          Writeln('PhÐp l¨n thø ', i, ' kh«ng hîp lÖ!');
          Wrong;
        end;
      Write(c);
      Sum := Sum + 7 - map[x2, y2];
      k1 := k2;
      x1 := x2;
      y1 := y2;
    end;
  if (x1 <> 1) and (x1 <> m) and (y1 <> 1) and (y1 <> n) then
    begin
      Writeln;
      Writeln('¤ kÕt thóc: (', x1, ', ', y1, ')');
      Writeln('Kh«ng l¨n ®­îc ra biªn!');
      Wrong;
    end;
  Writeln;
  Writeln('Träng sè phÐp l¨n: ');
  Writeln('  + §¸p ¸n  : ', res);
  Writeln('  + Häc sinh: ', Sum);
  if Sum > Res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  InitMem;
  DijkstraInit;
  DijkstraSolve;
  Result;
  Test;
end.

9 6 3 3
0 0 0 0 0 0
0 0 2 4 0 0
1 4 6 6 6 6
0 0 2 3 0 0
0 0 0 1 0 0
0 0 0 4 0 0
0 0 0 6 0 0
0 0 0 3 0 0