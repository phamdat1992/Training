{$M 65520,0,655360}
program Chords;
const
  InputFile  = 'CHORDS.INP';
  OutputFile = 'CHORDS.OUT';
  max = 10000; {n khong qua 5000}
  maxV = 10000;
type
  TColor = (clRed, clBlue);
  TPoint = record
    x: Integer;
    y: ShortInt;
  end;
  TList = array[1..max] of TPoint;
  TIndex = array[1..max] of Integer;
var
  XY: TList;
  Index: TIndex;
  Color: array[1..max] of TColor;
  n, m: Integer;

procedure Enter;
var
  f: Text;
  ch: Char;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n); m := n shl 1;
  for i := 1 to m do
    begin
      Readln(f, ch, XY[i].x, XY[i].y);
      Color[i] := TColor(ch = 'B');
    end;
  Close(f);
end;

procedure Sort;
type
  TCount = array[-10000..10000] of Integer;
var
  i, v, t, add: Integer;
  Count: ^TCount;
begin
  New(Count);
  FillChar(Count^, SizeOf(Count^), 0);
  for i := 1 to m do
    if XY[i].y < 0 then Inc(Count^[xy[i].x]);
  for v := -maxV + 1 to maxV do
    Count^[v] := Count^[v - 1] + Count^[v];
  add := Count^[maxV];
  for i := 1 to m do
    if XY[i].y < 0 then
      begin
        t := XY[i].x;
        Index[Count^[t]] := i;
        Dec(Count^[t]);
      end;
  FillChar(Count^, SizeOf(Count^), 0);
  for i := 1 to m do
    if XY[i].y > 0 then Inc(Count^[xy[i].x]);
  for v := maxV - 1 downto -maxV do
    Count^[v] := Count^[v + 1] + Count^[v];
  for i := 1 to m do
    if XY[i].y > 0 then
      begin
        t := XY[i].x;
        Index[Count^[t] + add] := i;
        Dec(Count^[t]);
      end;
  Dispose(Count);
end;

procedure Result;
var
  f: Text;
  Stack: array[1..max] of Integer;
  i, nStack, SourceI: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  nStack := 0;
  for i := 1 to m do
    begin
      SourceI := Index[i];
      if (nStack = 0) or (Color[SourceI] = Color[Stack[nStack]]) then
        begin
          Inc(nStack);
          Stack[nStack] := SourceI;
        end
      else
        begin
          Writeln(f, SourceI, ' ', Stack[nStack]);
          Dec(nStack);
        end;
    end;
  Close(f);
end;

begin
  Enter;
  Sort;
  Result;
end.
