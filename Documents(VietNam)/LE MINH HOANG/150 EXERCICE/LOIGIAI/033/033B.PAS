program Stagnant_Water;
uses crt;
const
 InputFile  = 'WATER.IN4';
 OutputFile = 'WATER.OUT';
 max = 100;
 dx: array[1..4] of ShortInt = (1, -1, 0, 0);
 dy: array[1..4] of ShortInt = (0, 0, 1, -1);
type
 TLayer = array[0..max, 0..max] of Byte;
var
 H: array[1..max, 1..max] of Word;
 Layer: TLayer;
 Stack: array[1..max * max, 1..2] of Byte;
 nStack: Word;
 m, n: Byte;
 Sum: LongInt;
 Height: Word;
 Time: LongInt absolute 0:$46C;
 OldTime: LongInt;

procedure Enter;
var
 f: Text;
 i, j: Byte;
begin
 Assign(f, InputFile); Reset(f);
 Height := 0;
 Readln(f, m, n);
 for i := 1 to m do
  for j := 1 to n do
   begin
    Read(f, H[i, j]);
    if H[i, j] > Height then Height := H[i, j];
   end;
 Close(f);
end;

procedure Init;
begin
 FillChar(Layer, SizeOf(Layer), 255);
end;

procedure GetLayer(Index: Word);
var
 i, j: Byte;
begin
 for i := 1 to m do
  for j := 1 to n do
   if H[i, j] >= Index then Layer[i, j] := 1
   else Layer[i, j] := 0;
end;

procedure Push(X, Y: Byte);
begin
 Inc(nStack);
 Stack[nStack, 1] := X;
 Stack[nStack, 2] := Y;
end;

procedure Pop(var X, Y: Byte);
begin
 X := Stack[nStack, 1];
 Y := Stack[nStack, 2];
 Dec(nStack);
end;

procedure InitStack;
var
 x, y: Byte;
begin
 nStack := 0;
 for x := 1 to m do
  begin
   if Layer[x, 1] = 0 then
    begin
     Layer[x, 1] := 2; Push(x, 1);
    end;
   if Layer[x, n] = 0 then
    begin
     Layer[x, n] := 2; Push(x, n);
    end;
  end;
 for y := 1 to n do
  begin
   if Layer[1, y] = 0 then
    begin
     Layer[1, y] := 2; Push(1, y);
    end;
   if Layer[m, y] = 0 then
    begin
     Layer[m, y] := 2; Push(m, y);
    end;
  end;
end;

function Count: Word;
var
 x, y, d, x0, y0: Byte;
 OK: Boolean;
 S: Word;
begin
 InitStack;
 while nStack <> 0 do
  begin
   Pop(x, y);
   for d := 1 to 4 do
    begin
     x0 := x + dx[d];
     y0 := y + dy[d];
     if Layer[x0, y0] = 0 then
      begin
       Layer[x0, y0] := 2;
       Push(x0, y0);
      end;
    end;
  end;
 S := 0;
 for x := 1 to m do
  for y := 1 to n do
   if Layer[x, y] = 0 then Inc(S);
 Count := S;
end;

procedure Process;
var
 LayerIndex: Word;
begin
 Sum := 0;
 for LayerIndex := 1 to Height do
  begin
   GetLayer(LayerIndex);
   Sum := Sum + Count;
  end;
end;

procedure Result;
var
 f: Text;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, Sum);
 Close(f);
end;

begin
 Clrscr;
 OldTime := Time;
 Enter;
 Init;
 Process;
 Result;
 Writeln((Time - OldTime)/18.2 :1:2, ' s');
end.
