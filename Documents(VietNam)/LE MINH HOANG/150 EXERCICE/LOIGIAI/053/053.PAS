program TheExplorer;
uses crt, graph;
const
 InputFile  = 'MAP.INP';
 OutputFile = 'MAP.OUT';
 max = 5001;
 dx: array[1..4] of ShortInt = (1, 0, 0, -1);
 dy: array[1..4] of ShortInt = (0, -1, 1, 0);
 Dirs: String = 'ESNW';
 Bit: array[1..4] of Byte = (1, 2, 4, 8);

type
 TNB = array[1..max, 1..4] of Integer;
 PNB = ^TNB;
var
 x, y: array[1..max] of Integer;
 CellDir: array[1..max] of Integer;
 NB: PNB;
 Queue: array[1..max] of Integer;
 Trace: array[1..max] of ShortInt;
 n, EndP: Integer;
 First, Last: Integer;
 gd, gm: Integer;

procedure ReadData;
var
 f: Text;
 d: Byte;
 c: Char;
begin
 FillChar(CellDir, SizeOf(CellDir), 0);
 Assign(f, InputFile); Reset(f);
 n := 1;
 X[1] := 0; Y[1] := 0;
 while not SeekEoln(f)do
  begin
   Inc(n);
   Read(f, c);
   d := Pos(c, Dirs);
   x[n] := x[n - 1] + dx[d];
   y[n] := y[n - 1] + dy[d];
   CellDir[n - 1] := CellDir[n - 1] or Bit[d];
   CellDir[n] := CellDir[n] or Bit[5 - d];
  end;
 Close(f);
end;

procedure Refine;
var
 i, j: Integer;
begin
 for i := 1 to n do
  if CellDir[i] <> 0 then
   for j := i + 1 to n do
    if (x[i] = x[j]) and (y[i] = y[j]) then
     begin
      CellDir[i] := CellDir[i] or CellDir[j];
      CellDir[j] := 0;
     end;
end;

procedure Init;
var
 i, j, NewX, NewY: Integer;
 d: Byte;
begin
 New(NB);
 FillChar(NB^, SizeOf(NB^), 0);
 for i := 1 to n do
  for d := 1 to 4 do
   if CellDir[i] and Bit[d] <> 0 then
    begin
     NewX := x[i] + dx[d]; NewY := y[i] + dy[d];
     for j := i + 1 to n do
      if (CellDir[j] <> 0) and (x[j] = NewX) and (y[j] = NewY) then
       begin
        NB^[i, d] := j;
        NB^[j, 5 - d] := i;
        Break;
       end;
    end;
 First := 0;
 Last := 0;
 FillChar(Trace, SizeOf(Trace), 0);
end;

procedure Push(k: Integer);
begin
 Inc(Last);
 Queue[Last] := k;
end;

function Pop: Integer;
begin
 Inc(First);
 Pop := Queue[First];
end;

procedure Solve;
var
 p: Integer;
 d: Byte;
begin
 for p := 1 to n do
  if (x[p] = 0) and (y[p] = 0) then Break;
 Trace[p] := -1;
 Push(p);
 repeat
  p := Pop;
  if (x[p] = x[n]) and (y[p] = y[n]) then
   begin
    EndP := P;
    Exit;
   end;
  for d := 1 to 4 do
   if (NB^[p, d] <> 0) and (Trace[NB^[p, d]] = 0) then
    begin
     Push(NB^[p, d]);
     Trace[NB^[p, d]] := 5 - d;
    end;
 until False;
end;

procedure Result;
var
 f: Text;
 k: Integer;
 d: Byte;
begin
 Assign(f, OutputFile); Rewrite(f);
 k := EndP;
 while (x[k] <> 0) or (y[k] <> 0) do
  begin
   d := Trace[k];
   Write(f, Dirs[d]);
   k := NB^[k, d];
  end;
 Close(f);
end;

procedure SelfTest;
const
 ds = 10;
 DelayT = 10;
var
 d, step: Integer;
 c: Char;
 f: Text;
 x, y, Size: Integer;
 p: Pointer;
begin
 gd := 0;
 InitGraph(gd, gm, 'D:\Dayhoc');
 Bar(0, 0, 4, 4);
 Size := ImageSize(0, 0, 4, 4);
 GetMem(p, Size); GetImage(0, 0, 4, 4, p^);
 ClearDevice;
 SetBKColor(14);
 SetTextStyle(1, 0, 4);
 SetUserCharSize(2, 1, 4, 1);
 SetTextJustify(1, 1);
 SetColor(11);
 OuttextXY(320, 240, 'THE EXPLORERS');
 X := 320; Y := 240;
 MoveTo(X, Y);
 SetColor(1);
 SetFillStyle(1, 0);
 PieSlice(X, Y, 0, 360, 3);
 PutImage(X - 2, Y - 2, P^, XORPUT);
 Assign(f, InputFile); Reset(f);
 while not SeekEoln(f) do {Go out}
  begin
   Read(f, c);
   d := Pos(c, Dirs);
   PutImage(X - 2, Y - 2, P^, XORPUT);
   X := X + DX[d] * ds; Y := Y - dy[d] * ds;
   LineTo(X, Y);
   PutImage(X - 2, Y - 2, P^, XORPUT);
   Delay(DelayT);
  end;
 PutImage(X - 2, Y - 2, P^, XORPUT);
 PieSlice(GetX, GetY, 0, 360, 3);
 PutImage(X - 2, Y - 2, P^, XORPUT);
 Delay(1000);
 SetColor(12);
 SetLineStyle(0, 0, 3);
 Assign(f, OutputFile); Reset(f); {Come back}
 while not SeekEoln(f) do
  begin
   Read(f, c);
   d := Pos(c, Dirs);
   PutImage(X - 2, Y - 2, P^, XORPUT);
   X := X + DX[d] * ds; Y := Y - dy[d] * ds;
   LineTo(X, Y);
   PutImage(X - 2, Y - 2, P^, XORPUT);
   Delay(DelayT);
  end;
 PutImage(X - 2, Y - 2, P^, XORPUT);
 Readln;
 CloseGraph;
end;

begin
 ReadData;
 Refine;
 Init;
 Solve;
 Result;
 SelfTest;
end.
EEEENNNWWWSSSSSSSEEEEENNNNNWW
