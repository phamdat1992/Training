{hinh nhu khi da dat do thi roi thi dung BFS cung xong, sau nay xem lai}
program Exhibition;
uses crt;
const
 dx: array[1..4] of ShortInt = (0, 1, -1, 0);
 dy: array[1..4] of ShortInt = (1, 0, 0, -1);
 max = 20;
 InputFile  = 'TL.IN9';
 OutputFile = 'TL.OUT';
type
 TMap = array[0..max + 1, 0..max + 1] of Char;
 TBoard = array[1..max, 1..max, 0..max - 1] of Byte;
var
 Map: TMap;
 A: TBoard;
 BestX, BestY: array[1..max * max] of Byte;
 Free: array[1..max, 1..max, 0..max - 1] of Boolean;
 m, n, MinSwapCount: Byte;

 Art: Char;
 ArtCount: Word;

 nBest: Byte;

procedure Enter;
var
 f: Text;
 i, j: Byte;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, m, n);
 Readln(f, Art);
 FillChar(Map, SizeOf(Map), '*');
 ArtCount := 0;
 for i := 1 to m do
  begin
   for j := 1 to n do
    begin
     Read(f, Map[i, j]);
     if Map[i, j] = Art then Inc(ArtCount);
    end;
   Readln(f);
  end;
 Close(f);
 if ArtCount < n then
  begin
   Assign(f, OutputFile); Rewrite(f);
   Write(f, 'NO SOLUTION');
   Close(f);
   Halt;
  end;
end;

procedure Print;
var
 i, j: Byte;
begin
 for i := 1 to m do
  for j := 1 to n do
   begin
    GotoXY(j * 3, i);
    if Odd(i + j) then TextBackGround(1)
    else TextBackGround(2);
    if UpCase(Map[i, j]) = Art then TextColor(14)
    else TextColor(4);
    Write(' ',UpCase(Map[i, j]),' ');
   end;
end;

procedure Init;
var
 i: Byte;
begin
 FillChar(A, SizeOf(A), $FF);
 for i := 1 to m do
  if Map[i, 1] = Art then A[i, 1, 0] := 1
  else A[i, 1, 1] := 1;
 FillChar(Free, SizeOf(Free), True);
 if ArtCount > m * n div 2 + n then
  ArtCount := m * n div 2 + n;
end;

procedure UpdateCell(X, Y, C: Byte);
var
 i: Byte;
 NewX, NewY, NewC: Byte;
begin
 for i := 1 to 4 do
  begin
   NewX := X + dx[i]; NewY := Y + dy[i];
   if Map[NewX, NewY] <> '*' then
    begin
     if Map[NewX, NewY] = Art then NewC := C
     else NewC := C + 1;
     if (NewC < n) and (A[NewX, NewY, NewC] > A[X, Y, C] + 1) then
       A[NewX, NewY, NewC] := A[X, Y, C] + 1;
    end;
  end;
end;

procedure Optimize; {Thuat toan Dijkstra}
var
 i, j, C, pX, pY, pC, min, MinCutC: Byte;
 Continue: Boolean;
begin
 MinCutC := n - 1;
 repeat
  min := ArtCount + 1;
  for i := 1 to m do
   for j := 1 to n do
    for C := 0 to MinCutC do
     if Free[i, j, c] and (A[i, j, c] < Min) then
      begin
       Min := A[i, j, c];
       pX := i; pY := j; pC := C;
      end;
  if min = ArtCount + 1 then Exit;
  if pY = n then MinCutC := pC;
  Free[pX, pY, pC] := False;
  UpdateCell(pX, pY, pC);
 until False;
end;

procedure Find(var X, Y, C: Byte);
var
 i, k, Min: Byte;
begin
 for k := 0 to n - 1 do
  begin
   X := 0; Min := ArtCount + 1;
   for i := 1 to m do
    if A[i, n, k] < Min then
     begin
      X := i; Y := n; C := k;
      Min := A[i, n, k];
     end;
   if X <> 0 then Exit;
  end;
end;

procedure Trace;
var
 i, X, Y, SwapCount: Byte;
 NewX, NewY, NewSwapCount: Byte;
begin
 Find(X, Y, SwapCount);
 MinSwapCount := SwapCount;
 nBest := 0;
 while Y <> 1 do
  begin
   Inc(nBest);
   BestX[nBest] := X;
   BestY[nBest] := Y;
   if Map[X, Y] = Art then NewSwapCount := SwapCount
   else NewSwapCount := SwapCount - 1;
   for i := 1 to 4 do
    begin
     NewX := X + dx[i]; NewY := Y + dy[i];
     if (Map[NewX, NewY] <> '*') and
        (A[NewX, NewY, NewSwapCount] = A[X, Y, SwapCount] - 1) then
         Break;
    end;
   X := NewX; Y := NewY; SwapCount := NewSwapCount;
  end;
 Inc(nBest);
 BestX[nBest] := X; BestY[nBest] := Y;
end;

function LowCase(Ch: Char): Char;
begin
 LowCase := Chr(Ord(ch) + Ord('a') - Ord('A'));
end;

procedure FindArt(var X, Y: Byte);
var
 i, j: Byte;
begin
 for i := 1 to m do
  for j := 1 to n do
   if Map[i, j] = Art then
    begin
     X := i; Y := j;
     Exit;
    end;
end;

procedure PrintResult;
var
 i, X, Y: Byte;
 f: Text;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, MinSwapCount);
 for i := 1 to nBest do
  Map[BestX[i], BestY[i]] :=  LowCase(Map[BestX[i], BestY[i]]);
 for i := 1 to nBest do
  begin
   if Map[BestX[i], BestY[i]] <> LowCase(Art) then
    begin
     FindArt(X, Y);
     Writeln(f, BestX[i], ' ', BestY[i], ' ', X, ' ', Y);
     Map[X, Y] := LowCase(Map[X, Y]);
    end;
  end;
 Writeln(f, nBest);
 for i := nBest downto 1 do
  Writeln(F, BestX[i], ' ', BestY[i]);
 Close(f);
end;

procedure VisualDisplay;
var
 i, j, k, x1, y1, x2, y2: Byte;
 f: Text;
begin
 for i := 1 to m do
  for j := 1 to n do
   begin
    Map[i, j] := UpCase(Map[i, j]);
    if Odd(i + j) then TextAttr := 3 * 16 + 15
    else TextAttr := 2 * 16 + 15;
    GotoXY(j * 3, i); Write(' ', Map[i, j], ' ');
   end;
 TextAttr := 78;
 for i := 1 to nBest do
  begin
   GotoXY(BestY[i] * 3, BestX[i]);
   Write(' ', Map[BestX[i], BestY[i]], ' ');
  end;
 TextAttr := 30 + 128;
 Assign(f, OutputFile); Reset(f);
 Readln(f, k);
 for i := 1 to k do
  begin
   Readln(f, x1, y1, x2, y2);
   GotoXY(y1 * 3, x1); Write(' ', Map[x1, y1], ' ');
   GotoXY(y2 * 3, x2); Write(' ', Map[x2, y2], ' ');
  end;
 Close(f);
 Readln;
end;

begin
 TextMode(C80);
 TextAttr := 7;
 clrscr;
 Enter;
 Init;
 Optimize;
 Trace;
 PrintResult;
end.

Test1: Duyet chac chan chet
20 20
A
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB
ABBBBBBBBBBBBBBBBBBB

Test 2: Duyet chac chan chet
20 20
B
BBBBBBAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAABBBBBBBBBBBBBBB
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA


Test 3: Duong di ngan nhat thi thoat
20 20
I
IIIIIIIIIIIIIIIIIIOO
OOOOOOOOOOOOOOOOOIOO
OIIIIIIIIIIIIIIIIIOO
OIOOOOOOOOOOOOOOOOOO
OIIIIIIIIIIIIIIIIIOO
OOOOOOOOOOOOOOOOOIOO
OIIIIIIIIIIIIIIIIIOO
OIOOOOOOOOOOOOOOOOOO
OIIIIIIIIIIIIIIIIIIO
OOOOOOOOOOOOOOOOOOIO
OIIIIIIIIIIIIIIIIIIO
OIOOOOOOOOOOOOOOOOOO
OIIIIIIIIIIIIIIIII0O
OOOOOOOOOOOOOOOOOI0O
OIIIIIIIIIIIIIIIII0O
OIOOOOOOOOOOOOOOOOOO
OIIIIIIIIIIIIIIIII0O
OOOOOOOOOOOOOOOOOI0O
OIIIIIIIIIIIIIIIII0O
OOOOOOOOOOOOOOOOOOII

Test 4: Duong di ngan nhat thi thoat
20 20
I
IIIIIIIIIIIIIIIIIIIO
OOOOOOOOOOOOOOOOOOIO
OIIIIIIIIIIIIIIIIIIO
OIOOOOOOOOOOOOOOOOOO
OIIIIIIIIIIIIIIIIIIO
OOOOOOOOOOOOOOOOOOIO
OIIIIIIIIIIIIIIIIIIO
OIOOOOOOOOOOOOOOOOOO
OIIIIIIIIIIIIIIIIIIO
OOOOOOOOOOOOOOOOOOIO
OIIIIIIIIIIIIIIIIIIO
OIOOOOOOOOOOOOOOOOOO
OIIIIIIIIIIIIIIIIIIO
OOOOOOOOOOOOOOOOOOIO
OIIIIIIIIIIIIIIIIIIO
OIOOOOOOOOOOOOOOOOOO
OIIIIIIIIIIIIIIIIIIO
OOOOOOOOOOOOOOOOOOIO
OIIIIIIIIIIIIIIIIIIO
OOOOOOOOOOOOOOOOOOII

Test 5: Ap dung truc tiep duong di ngan nhat thi chet o day thoi
4 8
X
XXXXXXOO
OOOOOXXO
OOOOOOOO
OOOOOOOO

Very Hard Test - Qua duoc 2 test nay chac la thuat toan dung

Test 6:
10 20
X
XXXOOOOOOOOOOOOOOOOO
OOOXXOOOOOOOOOOOOOOO
OOOOXXXXXXXXXXOOOOOO
OOOOOOOOOOOOOXXOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOXXXXXXXXXXXXOO

Test 7:
6 20
X
XXXOOOOOOOOOOOOOOOOO
OOXXXXOOOOOOOOOOOOOO
OOOOOXXXOOOOOOOOOOOO
OOOOOOOXXXXOOOOOOOOO
OOOOOOOOOOXXXOOOOOOO
OOOOOOOOOOOOXXXOOOOO
