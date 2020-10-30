{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program Exhibition;
uses crt;
const
 dx: array[1..4] of ShortInt = (0, 1, -1, 0);
 dy: array[1..4] of ShortInt = (1, 0, 0, -1);
 max = 36;
 InputFile  = 'TL.INP';
 OutputFile = 'TL.OUT';
type
 TMap = array[0..max + 1, 0..max + 1] of Char;
 TBoard = array[1..max, 1.. max] of Byte;
var
 Map: TMap;
 Trace: array[1..max, 1..max, 0..max - 1] of Byte;
 PathX, PathY: array[1..max * max] of Byte;
 m, n, EndX, EndY, EndC, nPath: Byte;
 Current, Next: TBoard;
 Art: Char;
 ArtCount: Word;
 Video: array[1..50, 1..80, 1..2] of Byte absolute $B800:0; {chi chay duoc tren VGA}
 Time: LongInt absolute 0:$46C;
 STime: LongInt;

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

procedure Init;
var
 i: Byte;
begin
 FillChar(Trace, SizeOf(Trace), 0);
 FillChar(Current, SizeOf(Current), $FF);
 for i := 1 to m do
  if Map[i, 1] = Art then
   begin
    Current[i, 1] := 0;
    Trace[i, 1, 0] := $FF;
   end
  else
   begin
    Current[i, 1] := 1;
    Trace[i, 1, 1] := $FF;
   end;
end;

function Min(a, b: Byte): Byte;
begin
 if a > b then Min := b else Min := a;
end;

procedure Print(var c: Tboard);
var
 i, j: byte;
begin
 exit;
 for i := 1 to m do
  begin
   for j := 1 to n do Write(c[i, j]:4);
   writeln;
  end;
 writeln;
end;

procedure BreadthFirstSearch;
var
 px, py, NewX, NewY, NewC, MinCut, d: Byte;
 k: Word;
 Stop: Boolean;
begin
 if ArtCount > n then MinCut := n
 else MinCut := ArtCount;
 for k := 2 to ArtCount do
  begin
   Stop := True;
   Next := Current;
   for px := 1 to m do
    for py := 1 to n do
     if Current[px, py] < MinCut then
      for d := 1 to 4 do
       begin
        NewX := px + dx[d]; NewY := py + dy[d];
        if Map[NewX, NewY] <> '*' then
         begin
          if Map[NewX, NewY] = Art then NewC := Current[px, py]
          else  NewC := Current[px, py] + 1;
          if Next[NewX, NewY] > NewC then
           begin
            Next[NewX, NewY] := NewC;
            Trace[NewX, NewY, Next[NewX, NewY]] := d;
            Stop := False;
           end;
          if (NewY = n) and (Next[NewX, NewY] < MinCut) then
           begin
            EndX := NewX; EndY := NewY; EndC := Next[NewX, NewY];
            MinCut := EndC;
           end;
         end;
       end;
   if Stop then Break;
   Current := Next;
  end;
end;

procedure TracePath;
var
 d: Byte;
begin
 nPath := 0;
 repeat
  Inc(nPath);
  PathX[nPath] := EndX; PathY[nPath] := EndY;
  d := Trace[EndX, EndY, EndC];
  if d = $FF then Exit;
  if Map[EndX, EndY] <> Art then Dec(EndC);
  EndX := EndX - dx[d]; EndY := EndY - dy[d];
 until False;
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
 Writeln(f, EndC);
 TracePath;
 for i := 1 to nPath do
  Map[PathX[i], PathY[i]] :=  LowCase(Map[PathX[i], PathY[i]]);
 for i := 1 to nPath do
  begin
   if Map[PathX[i], PathY[i]] <> LowCase(Art) then
    begin
     FindArt(X, Y);
     Writeln(f, PathX[i], ' ', PathY[i], ' ', X, ' ', Y);
     Map[X, Y] := LowCase(Map[X, Y]);
    end;
  end;
 Writeln(f, nPath);
 for i := nPath downto 1 do
  Writeln(F, PathX[i], ' ', PathY[i]);
 Close(f);
end;

procedure VisualDisplay(sx, sy: Integer; Out: String);
var
 f: Text;
 i, j, k, x1, y1, x2, y2: Integer;
 ch: Char;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, m, n); Readln(f, Art);
 for i := sx + 1 to sx + m do
  begin
   for j := sy + 1 to sy + n do
    begin
     if Odd(i + j) then Video[i, j, 2] := 120 else Video[i, j, 2] := 49;
     Read(f, ch);
     if ch = Art then Video[i, j, 1] := Byte(ch);
    end;
   Readln(f);
  end;
 Close(f);
 Assign(f, Out); Reset(f);
 Readln(f, k);
 GotoXy(sy + 1, sx + m + 2); Writeln('Doi ', k, ' phong');
 for i := 1 to k do
  begin
   Readln(f, x1, y1, x2, y2);
   x1 := x1 + sx; x2 := x2 + sx;
   y1 := y1 + sy; y2 := y2 + sy;
   Video[x1, y1, 2] := 30;
   Video[x2, y2, 2] := 30;
  end;
 Readln(f, k);
 GotoXy(sy + 1, sx + m + 3); Writeln('Di  ', k, ' phong');
 for i := 1 to k do
  begin
   Readln(f, x1, y1);
   x1 := x1 + sx; y1 := y1 + sy;
   if Odd(x1 + y1) then Video[x1, y1, 2] := 78
   else Video[x1, y1, 2] := 94;
  end;
 Close(f);
end;

begin
 STime := Time;
 Enter;
 Init;
 BreadthFirstSearch;
 Writeln('Thoi gian: ', (Time - STime) /18.2:1:4, ' (s)');
 readln;
{ PrintResult;}
 TextMode(C80 + 256);
 FillChar(Video, SizeOf(Video), 0);
 TextAttr := 15;

 VisualDisplay((50 - m) div 2, (80 - n) div 2, OutputFile);
 Readln;
 TextMode(C80);
end.
20 20
I
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOIIIIIIIIIIIIIIOOO
OOOIOOOOOOOOOOOOOOOO
OOOIOOOOOOOOOOOOOOOO
OOOIIIIIIIIOOOOOOOOO
OOOOOOOOOOIOOOOOOOOO
OOOOOOOIIIIOOOOOOOOO
OOOOOOOIOOOOOOOOOOOO
OOOOOOOIIIOOOOOOOOOO
OOOOOOOOOIOOOOOOOOOO
OOOOIIIIIIOOOOOOOOOO
OOOOIOOOOOOOOOOOOOOO
OOOOIIIOOOOOOOOOOOOO
OOOOOOIOOOOOOOOOOOOO
OOIIIIIOOOOOOOOOOOOO
OOIOOOOOOOOOOOOOOOOO
OOIIOOOOOOOOOOOOOOOO
OOOIOOOOOOOOOOOOOOOO
IIIIOOOOOOOOOOOOOOOO

20 20
I
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOIOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOIIIIIIIII
OOOOOOOOOOOIOOOOOOOO
IIIIIIIOIIIIIIOOOOOO
OOOOOOOOOOOOOIIIIIII
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
OOOOOOOOOOOOOOOOOOOO
