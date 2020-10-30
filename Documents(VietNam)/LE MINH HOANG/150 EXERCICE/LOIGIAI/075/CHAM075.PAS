{$R-,Q-,I-,S-,D-}
program HorsesTest;
uses crt, Visual;
const
 InputFile: String = 'HORSES.IN';
 OutputFile = 'HORSES.STD';
 YourFile   = 'HORSES.OUT';
 max = 100;
 maxLong = 1000000000;
 dx: array[1..8] of ShortInt  = (1, -1, 1, -1, 2, -2, 2, -2);
 dy: array[1..8] of ShortInt  = (2, 2, -2, -2, 1, 1, -1, -1);
type
 TBoard = array[-1..max + 2, -1..max + 2] of Integer;
 PBoard = ^TBoard;
 TMap = array[-1..max + 2, -1..max + 2] of Char;
 TCost = array[1..max, 1..max] of LongInt;
var
 xS, yS, xD, yD: array[1..max] of Integer;
 Map: ^TMap;
 Board: ^TBoard;
 Q: array[1..max * max] of Word;
 c: ^TCost;
 Fx, Fy: array[1..max] of LongInt;
 Trace, matchX, matchY: array[1..max] of Integer;
 VisitedX, VisitedY: array[1..max] of Boolean;
 n, k, First, Last, p: Integer;
 noSolution: Boolean;
 f: Text;
 ch: Char;

procedure Enter;
var
 f: Text;
 i, j, m1, m2: Integer;
begin
 New(Map);
 FillChar(Map^, SizeOf(Map^), 'C');
 m1 := 0; m2 := 0;
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 for i := 1 to n do
  begin
   for j := 1 to n do
    begin
     Read(f, Map^[i, j]);
     if Map^[i, j] = 'S' then
      begin
       Inc(m1);
       xS[m1] := i; yS[m1] := j;
      end;
     if Map^[i, j] = 'D' then
      begin
       Inc(m2);
       xD[m2] := i; yD[m2] := j;
      end;
    end;
   Readln(f);
  end;
 k := m1;
 Close(f);
end;

procedure Init;
begin
 New(Board);
end;

procedure Destroy;
begin
 Dispose(Board); Dispose(Map);
end;

procedure InitQueue;
begin
 First := 0; Last := 0;
end;

procedure Push(x, y: Integer);
begin
 Inc(Last);
 Q[Last] := x or (y shl 8);
end;

procedure Pop(var x, y: Integer);
begin
 Inc(First);
 x := Lo(Q[First]); y := Hi(Q[First]);
end;

procedure Push1(x: Integer);
begin
 Inc(Last); Q[Last] := x;
end;

function Pop1: Integer;
begin
 Inc(First); Pop1 := Q[First];
end;

procedure BFS(Start, Finish: Integer); {Finish = 0 <=> Loang tat}
var
 x, y, newx, newy, d, c: Integer;
begin
 FillChar(Board^, SizeOf(Board^), 255);
 for x := 1 to n do
  for y := 1 to n do
   if Map^[x, y] <> 'C' then Board^[x, y] := 0;
 Board^[xD[Start], yD[Start]] := 1;
 InitQueue; Push(xD[Start], yD[Start]);
 c := 0;
 repeat
  Pop(x, y);
  for d := 1 to 8 do
   begin
    newx := x + dx[d]; newy := y + dy[d];
    if Board^[newx, newy] = 0 then
     begin
      Board^[newx, newy] := Board^[x, y] + 1;
      if Map^[newx, newy] = 'S' then
       begin
        Inc(c);
        if c = k then Exit;
        if (Finish <> 0) and
           (newx = xS[Finish]) and (newy = yS[Finish]) then Exit;
       end;
      Push(newx, newy);
     end;
   end;
 until First >= Last;
end;

procedure GetShortestPaths;
var
 i, j: Integer;
begin
 New(c);
 for i := 1 to k do
  for j := 1 to k do c^[i, j] := maxLong;
 for i := 1 to k do
  begin
   BFS(i, 0);
   for j := 1 to k do
    if Board^[xS[j], yS[j]] <> 0 then c^[i, j] := Board^[xS[j], yS[j]] - 1;
  end;
end;

procedure HungarianInit;
var
 i, j: Integer;
begin
 FillChar(Fx, SizeOf(Fx), 0);
 FillChar(Fy, SizeOf(Fy), 0);
 FillChar(matchX, SizeOf(matchX), 0);
 FillChar(matchY, SizeOf(matchY), 0);
 noSolution := False;
end;

function FindAugmentingPath(xStart: Integer): Integer;
var
 x, y: Integer;
begin
 FillChar(VisitedX, k, False);
 FillChar(VisitedY, k, False);
 InitQueue;
 Push1(xStart);
 VisitedX[xStart] := True;
 repeat
  x := Pop1;
  for y := 1 to k do
   if not VisitedY[y] and (matchX[x] <> y)
      and (c^[x, y] <> maxLong) and (c^[x, y] = Fx[x] + Fy[y]) then
    begin
       Trace[y] := x;
       if matchY[y] = 0 then
        begin
         FindAugmentingPath := y; Exit;
        end;
       VisitedY[y] := True;
       VisitedX[matchY[y]] := True;
       Push1(matchY[y]);
    end;
 until first >= last;
 FindAugmentingPath := 0;
end;

procedure SubXAddY;
var
 i, j, t: Integer;
 Delta: LongInt;
begin
 Delta := maxLong;
 for i := 1 to k do
  if VisitedX[i] then
   for j := 1 to k do
    if not VisitedY[j] and (c^[i, j] - Fx[i] - Fy[j] < Delta)
       and (c^[i, j] <> maxLong) then Delta := c^[i, j] - Fx[i] - Fy[j];
 if Delta = maxLong then
  begin
   noSolution := True;
   Exit;
  end;
 for t := 1 to k do
  begin
   if VisitedX[t] then Fx[t] := Fx[t] + Delta;
   if VisitedY[t] then Fy[t] := Fy[t] - Delta;
  end;
end;

procedure Enlarge(s, f: Integer);
var
 x, next: Integer;
begin
 repeat
  x := Trace[f];
  next := matchX[x];
  matchX[x] := f; matchY[f] := x;
  f := next;
 until x = s;
end;

procedure Solve;
var
 x, y: Integer;
begin
 for x := 1 to k do
  begin
   repeat
    y := FindAugmentingPath(x);
    if y = 0 then
     begin
      SubXAddy;
      if noSolution then Exit;
     end;
   until y <> 0;
   Enlarge(x, y);
  end;
end;

procedure Result;
var
 f: Text;
 i, j, x, y, c, nextx, nexty, d: Integer;
 nStep: LongInt;
begin
 nStep := 0;
 for i := 1 to k do nStep := nStep + Fx[i] + Fy[i];
 Assign(f, OutputFile); Rewrite(f);
 if noSolution then
  begin
   Writeln(f, -1); Close(f); Exit;
  end;
 Writeln(f, nStep);
 for i := 1 to k do
  begin
   j := matchX[i]; BFS(i, j);
   x := xS[j]; y := yS[j];
   repeat
    c := Board^[x, y];
    for d := 1 to 8 do
     begin
      nextx := x + dx[d]; nexty := y + dy[d];
      if (Map^[nextx, nexty] <> 'C') and (Board^[nextx, nexty] = c - 1) then
       Break;
     end;
    Writeln(f, x, ' ', y, ' ', nextx, ' ', nexty);
    x := nextx; y := nexty;
   until (x = xD[i]) and (y = yD[i]);
  end;
 Close(f);
end;

procedure AskTest;
var
 S: Word;
 p: Pointer;
 f1, f2: file;
begin
 TextAttr := 7; Writeln;
 Caption('Knights  ');
 Msg(40, 4, 'Input?', 'From file: HORSES.IN '#8);
 ch := ReadKey;
 Writeln(ch);
 InputFile := InputFile + ch;
end;

procedure Halt;
begin
 {$I-}
 Close(f); if IOResult = 0 then;
 {$I+}
 if Keypressed then Readkey;
 Color := 47;
 MSG(40, 3, 'Danh gia', '        Diem = ' + Chr(p + Ord('0')) + '        ');
 ReadKey;
 Default;
 TextAttr := 7;
 Clrscr;
 System.Halt;
end;

function Find(x, y: Integer): Integer;
var
 i: Integer;
begin
 for i := 1 to k do
  if (xS[i] = x) and (yS[i] = y) then
   begin
    Find := i; Exit;
   end;
 Find := 0;
end;

function Check(x1, y1, x2, y2: Integer): Integer;
var
 d: Integer;
begin
 if Map^[x2, y2] = 'C' then Check := 1
 else
  begin
   for d := 1 to 8 do
    if (x1 + dx[d] = x2) and (y1 + dy[d] = y2) then
     begin
      Check := 0;
      Exit;
     end;
   Check := 2;
  end;
end;

procedure Test;
var
 c, s1, s2: LongInt;
 i, e, x1, y1, x2, y2, m: Integer;
begin
 p := 0;
 Color := 113;
 FlatFrame(3, 7, 78, 23, 'Checking Result');
 Assign(f, OutputFile); Reset(f);
 Readln(f, s1);
 Close(f);
 Assign(f, YourFile); Reset(f);
 Readln(f, s2);
 Writeln('Dong 1: ');
 Writeln(' + Ket qua dung: ', s1);
 Writeln(' + Ket qua HS  : ', s2);
 if s1 = s2 then
  begin
   Writeln('* Chinh xac!'); Inc(p);
   if s1 = -1 then Inc(p);
  end
 else Writeln('* So nuoc di sai');
 Writeln;
 if s2 = -1 then Halt;
 Writeln('Cac dong tiep: Kiem tra nuoc di:');
 c := 0;
 while not SeekEof(f) do
  begin
   Inc(c); 
   Readln(f, x1, y1, x2, y2);
   if (c mod 9876 = 0) or SeekEof(f) then Write(#13, 'Step: ', c:10);
   m := Find(x1, y1);
   if m = 0 then
    begin
     Writeln;
     Writeln('* Error!, khong co ma trong o (', x1, ', ', y1, ')');
     Halt;
    end;
   e := Check(x1, y1, x2, y2);
   if e <> 0 then Writeln;
   case e of
    1: Writeln('* Error!, di vao o cam hoac ra ngoai ban co');
    2: Writeln('* Error!, di sai luat: (', x1, ',', y1, ')->(', x2, ',', y2, ')');
   end;
   if e <> 0 then Halt;
   xS[m] := x2; yS[m] := y2;
  end;
 Writeln;
 Writeln('* Cac nuoc di dung luat!');
 Writeln;
 Writeln('Kiem tra vi tri tap ket');
 for i := 1 to k do Map^[xS[i], yS[i]] := 'M';
 for i := 1 to k do
  if Map^[xD[i], yD[i]] <> 'M' then
   begin
    Writeln('* Error! Vi tri (', xD[i], ', ', yD[i], ') chua co quan');
    Halt;
   end;
 Writeln('* Chinh xac!');
 Inc(p);
 Halt;
end;

begin
 AskTest;
 Caption('   Knights Moving Tester   ');
 MSG(40, 13, 'Please wait!', '   Solving problem...   ');
 Enter;
 Init;
 GetShortestPaths;
 HungarianInit;
 Solve;
 Result;
 Test;
 Destroy;
end.

6
C.C..S
...SD.
..C...
..SC..
CC.SDD
C....D
